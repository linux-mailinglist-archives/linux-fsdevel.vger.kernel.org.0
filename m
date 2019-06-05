Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D1360BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 18:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfFEQEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 12:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbfFEQEW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:04:22 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAE2F208C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2019 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559750661;
        bh=Lo7tnf9FZTNHvc1tqXK13IgOoz9XYJY+Hs7siRq6iN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YZNY4+GvVwuo8+BTate/LxNlrzU8IWP+qwjyuims/2o2QKNrEiCHm6B3HLq3ECe6e
         F7U5qQL2LfnCcvULKZ+uS3+SlVAQOtIToYK8SFt81rKsbj3R+xSTCi7h826D53Wb60
         j3nopY9tZcC05bLdxhJC0EJHK7p52huhC1fyCfGs=
Received: by mail-wm1-f46.google.com with SMTP id 22so2876645wmg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 09:04:21 -0700 (PDT)
X-Gm-Message-State: APjAAAVFX2BdDGfGuaelCQu7qFkWZ4DWvpnNRymCIFnX8S2JXMK/kUzs
        TZGuwDsq4tGhmU2iDd60PbW2EF9qqDBOlXNEZFMiOg==
X-Google-Smtp-Source: APXvYqwIrjshcVAwwMvKbnOgH9q2iZcxDjJCMHqdp2gUxGfHHyckcbZBVYnqcPYz05IGUFxNW8Satk5JOWG999hqATM=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr11012206wmj.79.1559750660137;
 Wed, 05 Jun 2019 09:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
 <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com>
 <20192.1559724094@warthog.procyon.org.uk> <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
In-Reply-To: <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Jun 2019 09:04:09 -0700
X-Gmail-Original-Message-ID: <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
Message-ID: <CALCETrVSBwHEm-1pgBXxth07PZ0XF6FD+7E25=WbiS7jxUe83A@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 5, 2019 at 7:51 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 6/5/2019 1:41 AM, David Howells wrote:
> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >> I will try to explain the problem once again. If process A
> >> sends a signal (writes information) to process B the kernel
> >> checks that either process A has the same UID as process B
> >> or that process A has privilege to override that policy.
> >> Process B is passive in this access control decision, while
> >> process A is active. In the event delivery case, process A
> >> does something (e.g. modifies a keyring) that generates an
> >> event, which is then sent to process B's event buffer.
> > I think this might be the core sticking point here.  It looks like two
> > different situations:
> >
> >  (1) A explicitly sends event to B (eg. signalling, sendmsg, etc.)
> >
> >  (2) A implicitly and unknowingly sends event to B as a side effect of some
> >      other action (eg. B has a watch for the event A did).
> >
> > The LSM treats them as the same: that is B must have MAC authorisation to send
> > a message to A.
>
> YES!
>
> Threat is about what you can do, not what you intend to do.
>
> And it would be really great if you put some thought into what
> a rational model would be for UID based controls, too.
>
> > But there are problems with not sending the event:
> >
> >  (1) B's internal state is then corrupt (or, at least, unknowingly invalid).
>
> Then B is a badly written program.

Either I'm misunderstanding you or I strongly disagree.  If B has
authority to detect a certain action, and A has authority to perform
that action, then refusing to notify B because B is somehow missing
some special authorization to be notified by A is nuts.  This is just
introducing incorrectness into the design in support of a
not-actually-helpful security idea.

If I can read /proc/self/mounts, I can detect changes to my mount
namespace.  Giving me a faster and nicer way to do this is fine, AS
LONG AS IT ACTUALLY WORKS.  "Works" means it needs to detect all
changes.
