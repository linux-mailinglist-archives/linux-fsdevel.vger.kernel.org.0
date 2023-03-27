Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BBC6CB20B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 00:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjC0W5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjC0W5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:57:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB02D66
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 15:57:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id le6so9914716plb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679957858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82lYB0lL4CS5tmQd94rDNpT+aJMD6MYBqshPk8Qqj/0=;
        b=jpcqIXsNMu8I6iiqe8Iz+8wGJU/f0+9F87Jnrmlte5fQ6NhbUbhxPudAr+ZJ/iA/ux
         2qtNcVsjHrd2x+re6naJja5LwnoxLL1U0E7Fhmipi7oswBmnUduEC+2cBhCCr+uzw+FV
         kfSTGXPY1+fcSz9oS7knRfKKN+S0QAxvsRsku8/iy1a9BGaUGrdTQyx0RqTkJYavNa0l
         HtyTGCDr5tV8W6dPC7rsH9k5VlSKdThV9HLGiGT+oJzztmy8gv0u1XY6wWBMwFoID3Ur
         po6gwsrvXv5i1I2lbOiN5k+w66FYT9JQeEJMg8QJJ9AYZ4POkAD4m1KiDX8dvgJDKiEd
         oITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82lYB0lL4CS5tmQd94rDNpT+aJMD6MYBqshPk8Qqj/0=;
        b=6+isMhdASVfw+kOVugEGIJBeKB7VC6md24b4Qpy/8ohVIojKM5imlcy0VLO207MRZp
         lgSBLCaHyr4HM6BEWuDsU1BK3ev67PAlHzljzxCbIA+1V8Tm2BhrtC8R/oLiyu0eOZxO
         12CPSkDN6nRSEUFIoRJGk4SbAbLWYQaca+bXTW3kChxGEa1o3XXvRaCa+DY1PtDMhlre
         DJgxWiPcsJckvWF78gaEwxHnukH3RqHRSjoRSlxiRd7Z5ZKMHd9perUuOBBOytK9fwEf
         Mtf1u3dSuSTOoLbxdPC372PiWu3VriDeAWRKHbZ2l5xvPL9lXeiaW7tFdpduKB3P4XaY
         /n6g==
X-Gm-Message-State: AAQBX9d1qG6UnHy8fJ6ign7nnnD/UJdInBwXz+vJp+eZl68z9wxcjzom
        Jd7qynqFAJSouk0ESTp1AEJtL8yi9DDTIF/oSpM=
X-Google-Smtp-Source: AKy350awFcQ+e4+7yj7VCKplHwm7TW5pVIJRYciytY6OpPH6Dmej17dcFVDXOdqKwWtU+KtE2cU/6A==
X-Received: by 2002:a17:902:db0e:b0:1a1:bff4:49e9 with SMTP id m14-20020a170902db0e00b001a1bff449e9mr17033852plx.23.1679957858452;
        Mon, 27 Mar 2023 15:57:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id b17-20020a631b51000000b004e28be19d1csm18571013pgm.32.2023.03.27.15.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:57:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pgvmQ-00DwrY-Vf; Tue, 28 Mar 2023 09:57:34 +1100
Date:   Tue, 28 Mar 2023 09:57:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] xfs: Remove xfs_filemap_map_pages() wrapper
Message-ID: <20230327225734.GA3223426@dread.disaster.area>
References: <20230327174515.1811532-1-willy@infradead.org>
 <20230327174515.1811532-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327174515.1811532-2-willy@infradead.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:45:13PM +0100, Matthew Wilcox (Oracle) wrote:
> XFS doesn't actually need to be holding the XFS_MMAPLOCK_SHARED to do
> this.  filemap_map_pages() cannot bring new folios into the page cache
> and the folio lock is taken during filemap_map_pages() which provides
> sufficient protection against a truncation or hole punch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/xfs/xfs_file.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 863289aaa441..aede746541f8 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1389,25 +1389,10 @@ xfs_filemap_pfn_mkwrite(
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
>  }
>  
> -static vm_fault_t
> -xfs_filemap_map_pages(
> -	struct vm_fault		*vmf,
> -	pgoff_t			start_pgoff,
> -	pgoff_t			end_pgoff)
> -{
> -	struct inode		*inode = file_inode(vmf->vma->vm_file);
> -	vm_fault_t ret;
> -
> -	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
> -	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	return ret;
> -}
> -
>  static const struct vm_operations_struct xfs_file_vm_ops = {
>  	.fault		= xfs_filemap_fault,
>  	.huge_fault	= xfs_filemap_huge_fault,
> -	.map_pages	= xfs_filemap_map_pages,
> +	.map_pages	= filemap_map_pages,
>  	.page_mkwrite	= xfs_filemap_page_mkwrite,
>  	.pfn_mkwrite	= xfs_filemap_pfn_mkwrite,
>  };
> -- 
> 2.39.2

Looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
