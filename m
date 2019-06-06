Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF88B37AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 19:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfFFRSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 13:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfFFRSb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:18:31 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39F621019
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2019 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559841509;
        bh=xfZRqQoeex0rjsT5lia2MuMyCOHqkbEMbiBprno0lnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b2pabAOmyH+40Z8/KMs9sxFxXfW6WVNP4I/jMoE5zdAfCxRimo+cpZPUoWMpqR4jP
         3QHygZqwEwEw8TbLImWAKKvU4l1/1o6zRVX5eSKtjrWbf0KXyrVhpDeLWRc2R8F7jn
         04PKR0XBvb84vfTaQdBLKCFJiktoY17ZK7wFsypc=
Received: by mail-wr1-f47.google.com with SMTP id d18so3258583wrs.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 10:18:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVjD84+inlR2OOEzKpGs2XfCZH5nyLPaa9Wqgm8Kfez2R00vVGs
        54VT6Tr+3ATKT0u/9R9YzciGw6VWUHCEujiinNphoQ==
X-Google-Smtp-Source: APXvYqz+L9VkEoyCu7JqdY0NTE0bD0Q2wBWq/mFsrPsDQ5iRojaTQMSztaXWiT2/0eqKCThtuSRumT2MYYGwvQLWLIQ=
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr3348178wrt.343.1559841507169;
 Thu, 06 Jun 2019 10:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <155981413016.17513.10540579988392555403.stgit@warthog.procyon.org.uk>
 <176F8189-3BE9-4B8C-A4D5-8915436338FB@amacapital.net> <11031.1559833574@warthog.procyon.org.uk>
In-Reply-To: <11031.1559833574@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 6 Jun 2019 10:18:16 -0700
X-Gmail-Original-Message-ID: <CALCETrUukxNNhbBAifxz1EADzLOvYKoh9oqqZFJteU+MMhh1ig@mail.gmail.com>
Message-ID: <CALCETrUukxNNhbBAifxz1EADzLOvYKoh9oqqZFJteU+MMhh1ig@mail.gmail.com>
Subject: Re: [PATCH 01/10] security: Override creds in __fput() with last
 fputter's creds [ver #3]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 6, 2019 at 8:06 AM David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@amacapital.net> wrote:
>
> > > So that the LSM can see the credentials of the last process to do an fput()
> > > on a file object when the file object is being dismantled, do the following
> > > steps:
> > >
> >
> > I still maintain that this is a giant design error.
>
> Yes, I know.  This was primarily a post so that Greg could play with the USB
> notifications stuff I added.  The LSM support isn't resolved and is unchanged.
>
> > Can someone at least come up with a single valid use case that isn't
> > entirely full of bugs?
>
> "Entirely full of bugs"?

I can say "hey, I have this policy that the person who triggered an
event needs such-and-such permission, otherwise the event gets
suppressed".  But this isn't a full use case, and it's buggy.  It's
not a full use case because I haven't specified what my actual goal is
and why this particular policy achieves my goals.  And it's entirely
full of bugs because, as this patch so nicely illustrates, it's not
well defined who triggered the event.  For example, if I exec a setuid
process, who triggers the close?  What if I send the fd to systemd
over a socket and immediately close my copy before systemd gets (and
ignores) the message?  Or if I send it to Wayland, or to any other
process?

A file is closed when everyone is done with it.  Trying to figure out
who the last intentional user of the file was seems little better than
random guessing.  Defining a security policy based on it seems like a
poor idea.

>
> How would you propose I deal with Casey's requirement?  I'm getting the
> feeling you're going to nak it if I try to fulfil that and he's going to nak
> it if I don't.
>

Casey, I think you need to state your requirement in a way that's well
defined, and I think you need to make a compelling case that your
requirement is indeed worth dictating the design of parts of the
kernel outside LSM.
