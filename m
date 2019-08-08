Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1885C42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 09:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbfHHH7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 03:59:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40677 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbfHHH7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:59:53 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so57852422oth.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 00:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHKc1nqV6r+sye72Gbcul5qu7ivZjMnQlJDhy7guy84=;
        b=mrmN30NhEd/uZgu0zAl+0kceZr/J43smGXIg9vXI1Lok0HWnnwx982nSjFpxNLf6E0
         g28drzGSgUQ6ICnQW+oNsJcXHLa8nVVHG5UF2zDnTxiHQ1JJscJwr6pfA6xEFiOXaw/+
         p6dLbK8Q1v4D2ugdTGUqSBc7z6fwui2ipe7DP0pjdPv6TtnHZrW0T5YO6hFCK+HEBbfw
         RACXK5X/XNxmjnSIQevrdnFcMwFDyNCtGt0QrYbPyJGlBbd1AV0LqQlSqRZHGlcnLzZ5
         VxmaSbLR3RRS9kJciJoea849IRcoaU3xM/fe2S/3SyhLe4TLAflsHN9Ypk59+f+o6GqT
         FdzQ==
X-Gm-Message-State: APjAAAXginEm2D2f4TuIsYbtNMKrQ9rEE8q6k4QgTqs9+2jymusO+OYx
        wYf0Uc3siGcQSzo5AeXiSHxrOEQVUqydz19eMXCnOOT0ob8=
X-Google-Smtp-Source: APXvYqzo1ASOcZyBInSR+hD3Aad0gC0HonCxDXa/g6l1dqbWRagMtLJFx/QpUURx8i6UxazoEheDYa6IZ6Vh82C3ZI8=
X-Received: by 2002:a9d:4c17:: with SMTP id l23mr10823891otf.367.1565251192452;
 Thu, 08 Aug 2019 00:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190801140243.24080-1-omosnace@redhat.com> <20190801160910.GW1131@ZenIV.linux.org.uk>
In-Reply-To: <20190801160910.GW1131@ZenIV.linux.org.uk>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 8 Aug 2019 09:59:41 +0200
Message-ID: <CAFqZXNs5igF_G8=EA+bD-JRorS6xeuCiXQr5vweaJFYNwEVKZA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 1, 2019 at 6:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Aug 01, 2019 at 04:02:39PM +0200, Ondrej Mosnacek wrote:
> > After hours and hours of getting familiar with dcache and debugging,
> > I think I finally found a solution that works and hopefully stands a
> > chance of being committed.
> >
> > The series still doesn't address the lack of atomicity of the policy
> > reload transition, but this is part of a wider problem and can be
> > resolved later. Let's fix at least the userspace-triggered lockup
> > first.
>
> I don't think this is the right approach.  Consider the related problem:
> what happens if somebody has mounted something upon a selinuxfs file?
> That is the hard part here, and AFAICS your variant doesn't help it
> at all...

But that's another independent problem and it's not even fixed in
debugfs, which for now I'm treating as the baseline as I don't know of
any other filesystem that needs to remove its own directory trees in a
similar way.

I get that you don't want me to add a new function to the dcache API
that isn't bulletproof (and what I wrote here is apparently still far
from it), but you also previously said that I shouldn't open-code this
stuff in selinuxfs.c... I don't think I have the wits to write a
common function that handles all the possible issues, but I still want
to fix at least this one scenario (dcache_readdir() vs.
sel_remove_entries()).

Is there some way I could do this without getting a NACK from you? For
example, I thought of taking what is now debugfs_remove[_recursive]()
out of debugfs into, say, fs/libfs.c (providing some optional callback
to allow debugfs to do its __debugfs_file_removed() business) and use
this function(s) from both debugfs and selinuxfs. This way we could
later fix the leftover mount issue in one place and both filesystems
would (hopefully) immediately benefit from it. Would that be a
feasible way forward?

Thanks,
-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
