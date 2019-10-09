Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B8D0621
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 05:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJIDvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 23:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfJIDvv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 23:51:51 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0CBB81F31
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 03:51:50 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id r7so866676pfg.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2019 20:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v6zthWMaXxy16Sz5/Jfq7PYKQr7G+zzByXErJdXa1H4=;
        b=eGb8CrGSG2y2fG4IsmJ71RI2Ewnl2LkkoPQ5waWDt5S2xYqdlIYhS3SCGbGgggv/kA
         mUn1AT++iwxBnLxCjY9oZfLaFJOmCp+fZHzHw0XpF8CNUb2DyrejDb6NIaby02Tf136O
         pFDaPyZK4FAXyf7P4f/tdwRWVfqsIGCRENEDCaJLcjL48940/aOcMkqIgSCX+zhMMW6W
         rTciIkS6z18eqYOQvxqJmOEo2gAXD4CRbwQ1B0wc7TJRBbAPKZofDDpQWZuPwVjZLmoU
         4v1oVoOUAxrvYAMsWqR0duZMR77FfwRtTC5rdFe/nHPPGape8v7r8NeMyNWWGBm+l5Lp
         t6Fw==
X-Gm-Message-State: APjAAAV2Ri5/sZRXT7wz4zbDd9At4byVYD91xg77AfoB9iMth6a/Eu4H
        0Uff3NqZLE+4l0djxeIDqN2Y4HOyT1qHR7H27kNzqVPkl0FbUJDM4r5TPL7Z4hPruX5Mhg/qioG
        0Xkl6xnmXi9eAQsLvAhQ6fD2zlQ==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr1554979pjq.13.1570593110336;
        Tue, 08 Oct 2019 20:51:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxoesHOy2Ihhkj1080nk6QezDay6UcvY1O5/cwED5wOEVCNZkMAHBTRY0QCZpVQq1c1wqcLBA==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr1554908pjq.13.1570593109202;
        Tue, 08 Oct 2019 20:51:49 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 207sm616720pfu.129.2019.10.08.20.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 20:51:48 -0700 (PDT)
Date:   Wed, 9 Oct 2019 11:51:37 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Message-ID: <20191009035137.GE10750@xz-x1>
References: <20190806053859.2374-1-richardw.yang@linux.intel.com>
 <20191003004505.GE13922@redhat.com>
 <20191004224640.GC32588@richard>
 <20191004232834.GP13922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191004232834.GP13922@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:28:34PM -0400, Andrea Arcangeli wrote:
> On Sat, Oct 05, 2019 at 06:46:40AM +0800, Wei Yang wrote:
> > On Wed, Oct 02, 2019 at 08:45:05PM -0400, Andrea Arcangeli wrote:
> > >Hello,
> > >
> > >On Tue, Aug 06, 2019 at 01:38:59PM +0800, Wei Yang wrote:
> > >> Finally new_flags equals old vm_flags *OR* vm_flags.
> > >> 
> > >> It is not necessary to mask them first.
> > >> 
> > >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > >> ---
> > >>  fs/userfaultfd.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >> 
> > >> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > >> index ccbdbd62f0d8..653d8f7c453c 100644
> > >> --- a/fs/userfaultfd.c
> > >> +++ b/fs/userfaultfd.c
> > >> @@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
> > >>  			start = vma->vm_start;
> > >>  		vma_end = min(end, vma->vm_end);
> > >>  
> > >> -		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
> > >> +		new_flags = vma->vm_flags | vm_flags;
> > >>  		prev = vma_merge(mm, prev, start, vma_end, new_flags,
> > >>  				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
> > >>  				 vma_policy(vma),
> > >
> > >And then how do you clear the flags after the above?
> > >
> > >It must be possible to clear the flags (from
> > >UFFDIO_REGISTER_MODE_MISSING|UFFDIO_REGISTER_MODE_WP to only one set
> > >or invert).
> > >
> > >We have no WP support upstream yet, so maybe that's why it looks
> > >superfluous in practice, but in theory it isn't because it would then
> > >need to be reversed by Peter's (CC'ed) -wp patchset.
> > >
> > >The register code has already the right placeholder to support -wp and
> > >so it's better not to break them.
> > >
> > >I would recommend reviewing the uffd-wp support and working on testing
> > >the uffd-wp code instead of changing the above.
> > >
> > 
> > Sorry, I don't get your point. This change is valid to me even from arithmetic
> > point of view.
> > 
> >     vm_flags == VM_UFFD_MISSING | VM_UFFD_WP
> > 
> > The effect of current code is clear these two bits then add them. This equals
> > to just add these two bits.
> > 
> > I am not sure which part I lost.
> 
> The cleaned removed the "& ~" and that was enough to quickly tell the
> cleaned up version was wrong.
> 
> What I should have noticed right away as well is that the code was
> already wrong, sorry. That code doesn't require a noop code cleanup,
> it requires a fix and the "& ~" needs to stay.
> 
> This isn't going to make any difference upstream until the uffd-wp
> support is merged so it is enough to queue it in Peter's queue, or you
> can merge it independently.

IMHO it's good to have it as independent patch so at least it won't
confuse another reader of the master branch.  But just in case, I've
also queued it in my local tree of uffd-wp.

Thanks,

-- 
Peter Xu
