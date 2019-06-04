Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916F93519F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFDVGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 17:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfFDVGL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 17:06:11 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 021282075B
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2019 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559682370;
        bh=i3+PKArC81hAWWLFbR8rIjiNLUgLS1GNbVkf2UNoyBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bKqwlkPKaQ3IQwvOCkKHXE+fzBVNdDjtVlr7a+sbKhSCUKTUtA8ntH7W5HPaRk3cF
         FQ95lopQQpPwX8nBCY+csk1ilQnGCG2HV2qZbusup4nVUZEXUnUw+k5ieoz+YRTMhC
         UEVU/VuriAEepnLf0S6xfYHwCp4+ginYnqC93Jyk=
Received: by mail-wr1-f45.google.com with SMTP id n9so4853348wru.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2019 14:06:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXsrebM5tXl8jyO1UsfUxtjqJi14hSgFmFBmTgJTy/Ai1YZdqfc
        83ZrWBsrizmqf0AZ8ERvu0hJcRmvZga0myTnkoABeg==
X-Google-Smtp-Source: APXvYqwWaDkUBAO/FzwIxCec9v2ublxvSErwSTWwGJ6KpgtnfA1WSa5Vuqk8r+3SOqT0lD87wjaVufgUU2gqVCXk69c=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr4033435wru.265.1559682368626;
 Tue, 04 Jun 2019 14:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk>
 <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
In-Reply-To: <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 14:05:57 -0700
X-Gmail-Original-Message-ID: <CALCETrWFBA8H0RiZPikLtEi8xg-cqJLtQgnU2CGTuwByrHN7Dw@mail.gmail.com>
Message-ID: <CALCETrWFBA8H0RiZPikLtEi8xg-cqJLtQgnU2CGTuwByrHN7Dw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/8] Mount, FS, Block and Keyrings notifications [ver #2]
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Jun 4, 2019 at 1:31 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> n 6/4/2019 10:43 AM, Andy Lutomirski wrote:
> > On Tue, Jun 4, 2019 at 9:35 AM David Howells <dhowells@redhat.com> wrote:
> >>
> >> Hi Al,
> >>
> >> Here's a set of patches to add a general variable-length notification queue
> >> concept and to add sources of events for:
> > I asked before and didn't see a response, so I'll ask again.  Why are
> > you paying any attention at all to the creds that generate an event?
> > It seems like the resulting security model will be vary hard to
> > understand and probably buggy.  Can't you define a sensible model in
> > which only the listener creds matter?
>
> We've spent the last 18 months reeling from the implications
> of what can happen when one process has the ability to snoop
> on another. Introducing yet another mechanism that is trivial
> to exploit is a very bad idea.

If you're talking about Spectre, etc, this is IMO entirely irrelevant.
Among other things, setting these watches can and should require some
degree of privilege.

>
> I will try to explain the problem once again. If process A
> sends a signal (writes information) to process B the kernel
> checks that either process A has the same UID as process B
> or that process A has privilege to override that policy.
> Process B is passive in this access control decision, while
> process A is active.

Are you stating what you see to be a requirement?

> Process A must have write access
> (defined by some policy) to process B's event buffer.

No, stop right here.  Process B is monitoring some aspect of the
system.  Process A is doing something.  Process B should need
permission to monitor whatever it's monitoring, and process A should
have permission to do whatever it's doing.  I don't think it makes
sense to try to ascribe an identity to the actor doing some action to
decide to omit it from the watch -- this has all kinds of correctness
issues.

If you're writing a policy and you don't like letting process B spy on
processes doing various things, then disallow that type of spying.

> To
> implement such a policy requires A's credential,

You may not design a new mechanism that looks at the credential in a
context where looking at a credential is invalid unless you have some
very strong justification for why all of the known reasons that it's a
bad idea don't apply to what you're doing.

So, without a much stronger justification, NAK.
