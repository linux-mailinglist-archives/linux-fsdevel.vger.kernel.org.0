Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6204937FA5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 17:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhEMPOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 11:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234295AbhEMPOc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 11:14:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F95610A7;
        Thu, 13 May 2021 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620918802;
        bh=41qb467358PVWANG8SIzcwNL37SGfMDJteXHTiVFBmk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Qx2rlVZSXYR2TxqHlZxJ1qDYqorMs4V3rrBSNXmrDaFr5uI2z94F7FU+eielXHQ6w
         2qVIDsLxAF96kf3b4BGAB48Nbtg0iPtdpMEemoAitO+/0QNgy1DqDkFsldKm2iFG34
         +aGB6I+7cJL3h/SyZxWRbhI8FV4FwxZEEkAQTWEi8d9fSYWV9qxXuKce3QsXLcxvUP
         lBV8m6hEDtLxxc5bQ7/tgghDpTOj9AAuS3EZHS1bAJo29OIZBY9Kwi7BYJQop8iqGL
         fjMc+CK+tp7BY+ZZXOfaCc1pPRse2na0vsFEWjbQvB4PbRz5/bLXYsCspK9njJAwts
         5R80Xhp0QuCUg==
Message-ID: <f820202cc50d6869a5ef1f4deabed4b4c75db9b6.camel@kernel.org>
Subject: Re: [PATCH] netfs: Pass flags through to
 grab_cache_page_write_begin()
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, willy@infradead.org
Cc:     linux-mm@kvack.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date:   Thu, 13 May 2021 11:13:20 -0400
In-Reply-To: <162090295383.3165945.13595101698295243662.stgit@warthog.procyon.org.uk>
References: <162090295383.3165945.13595101698295243662.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-13 at 11:49 +0100, David Howells wrote:
> In netfs_write_begin(), pass the AOP flags through to
> grab_cache_page_write_begin() so that a request to use GFP_NOFS is honoured.
> 
> Fixes: e1b1240c1ff5 ("netfs: Add write_begin helper")
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-mm@kvack.org
> cc: linux-cachefs@redhat.com
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> cc: ceph-devel@vger.kernel.org
> cc: v9fs-developer@lists.sourceforge.net
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  fs/netfs/read_helper.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
> index 193841d03de0..725614625ed4 100644
> --- a/fs/netfs/read_helper.c
> +++ b/fs/netfs/read_helper.c
> @@ -1068,7 +1068,7 @@ int netfs_write_begin(struct file *file, struct address_space *mapping,
>  	DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
>  
>  retry:
> -	page = grab_cache_page_write_begin(mapping, index, 0);
> +	page = grab_cache_page_write_begin(mapping, index, flags);
>  	if (!page)
>  		return -ENOMEM;
>  
> 
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>

