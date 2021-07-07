Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71333BE6CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 13:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGGLDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 07:03:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53206 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhGGLDl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:03:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42D88220A9;
        Wed,  7 Jul 2021 11:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625655660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ThdkegO6OD+QtZGzvDhNi0tqQQng2bLgOAuF61PJbnk=;
        b=mQS8mhGcVkV6xpZh81nxcm3iTaH0RuMIrrJsUryc8nMnBW0DbrgA28nrGpxMlN1hRYLHPL
        2gcEbTxaaGvp6FnC2ekra56ALT2gIK5nB7ofwQpI0SUYSIdK5V9XC2IDfXVz2hvYDKWBat
        2dSBpfSaQ9ywicDH7JE/1Iu4luLhxl4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F3AFF13998;
        Wed,  7 Jul 2021 11:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id UISLOGuJ5WAQXgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 07 Jul 2021 11:00:59 +0000
Subject: Re: [PATCH v2 7/8] 9p: migrate from sync_inode to
 filemap_fdatawrite_wbc
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org
References: <cover.1624974951.git.josef@toxicpanda.com>
 <16ad65c145645b0ade200b45ecbf1b14f3e8c1c0.1624974951.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b5fe9373-2ad1-7ba7-7e9a-cdf2e0c84433@suse.com>
Date:   Wed, 7 Jul 2021 14:00:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <16ad65c145645b0ade200b45ecbf1b14f3e8c1c0.1624974951.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 29.06.21 г. 16:59, Josef Bacik wrote:
> We're going to remove sync_inode, so migrate to filemap_fdatawrite_wbc
> instead.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/9p/vfs_file.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 59c32c9b799f..6b64e8391f30 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -625,12 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
>  	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
>  
>  	inode = file_inode(vma->vm_file);
> -
> -	if (!mapping_can_writeback(inode->i_mapping))
> -		wbc.nr_to_write = 0;
> -
> -	might_sleep();

Not a 9p expert but we are losing the might_sleep check and
do_writepages can sleep due to cond_resched or congestion_wait

> -	sync_inode(inode, &wbc);
> +	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
>  }
>  
>  
> 
