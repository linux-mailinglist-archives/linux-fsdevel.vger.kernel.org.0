Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4853ACC1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfFJBvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jun 2019 21:51:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50881 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729703AbfFJBvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jun 2019 21:51:54 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5A1pjIR002876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 9 Jun 2019 21:51:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C99A2420481; Sun,  9 Jun 2019 21:51:45 -0400 (EDT)
Date:   Sun, 9 Jun 2019 21:51:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/8] mm/fs: don't allow writes to immutable files
Message-ID: <20190610015145.GB3266@mit.edu>
References: <155552786671.20411.6442426840435740050.stgit@magnolia>
 <155552787330.20411.11893581890744963309.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155552787330.20411.11893581890744963309.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:04:33PM -0700, Darrick J. Wong wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index ab650c21bccd..dfd5eba278d6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2149,6 +2149,9 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>  
>  	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
>  
> +	if (vmf->vma->vm_file && IS_IMMUTABLE(file_inode(vmf->vma->vm_file)))
> +		return VM_FAULT_SIGBUS;
> +
>  	ret = vmf->vma->vm_ops->page_mkwrite(vmf);
>  	/* Restore original flags so that caller is not surprised */
>  	vmf->flags = old_flags;

Shouldn't this check be moved before the modification of vmf->flags?
It looks like do_page_mkwrite() isn't supposed to be returning with
vmf->flags modified, lest "the caller gets surprised".

	   	     	       	      	   - Ted
