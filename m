Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5DABC95FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 02:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfJCApJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 20:45:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfJCApJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 304318980FB;
        Thu,  3 Oct 2019 00:45:09 +0000 (UTC)
Received: from mail (ovpn-120-134.rdu2.redhat.com [10.10.120.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30AF060BE0;
        Thu,  3 Oct 2019 00:45:06 +0000 (UTC)
Date:   Wed, 2 Oct 2019 20:45:05 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Message-ID: <20191003004505.GE13922@redhat.com>
References: <20190806053859.2374-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806053859.2374-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 03 Oct 2019 00:45:09 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Aug 06, 2019 at 01:38:59PM +0800, Wei Yang wrote:
> Finally new_flags equals old vm_flags *OR* vm_flags.
> 
> It is not necessary to mask them first.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index ccbdbd62f0d8..653d8f7c453c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  			start = vma->vm_start;
>  		vma_end = min(end, vma->vm_end);
>  
> -		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
> +		new_flags = vma->vm_flags | vm_flags;
>  		prev = vma_merge(mm, prev, start, vma_end, new_flags,
>  				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
>  				 vma_policy(vma),

And then how do you clear the flags after the above?

It must be possible to clear the flags (from
UFFDIO_REGISTER_MODE_MISSING|UFFDIO_REGISTER_MODE_WP to only one set
or invert).

We have no WP support upstream yet, so maybe that's why it looks
superfluous in practice, but in theory it isn't because it would then
need to be reversed by Peter's (CC'ed) -wp patchset.

The register code has already the right placeholder to support -wp and
so it's better not to break them.

I would recommend reviewing the uffd-wp support and working on testing
the uffd-wp code instead of changing the above.

Thanks,
Andrea
