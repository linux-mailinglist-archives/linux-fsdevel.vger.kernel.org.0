Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16F73F4C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjF0GrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjF0Gqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:46:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442BB11B
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N1oSFwqUhmYz4eDcfKGE70CUsyp7TGBHK7B6scG3Ul0=; b=rD3YCF2ZdNWpubRMsYNDKg+P6L
        OMZOrsYVi5Nw4Y+Lfnn5tEHZCQ5T1Ww2YxvAEyNrMyLnrBUz0jTwFf1WEfZQDScUHq8nM9xHLT0F1
        QJ5M7f/C5LsEok6aTyiEzc6kVMLRCyI6mldg0uH8S6PFC2rv+GOdOG0Fun4rwH2HtqatJ+9wTAlhT
        AQ7VRIGFIeJTBCuF/IR+1zpkrh4yfc3xgcQ0BjjEvwoFPGOLe9uuoEBKtkXnLSeJGjCnlrl0oJhum
        6izhdVQ/gRyl3VYOh9ZdtijoSeYJ7rH6jFMg++NRCLtnBtOOHG6v6JYpDaxlcca+zFnAONOP2kYks
        U/hGXD0g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE2Qx-00CCoi-1f;
        Tue, 27 Jun 2023 06:44:15 +0000
Date:   Mon, 26 Jun 2023 23:44:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org, Chuck Lever <chuck.lever@oracle.com>,
        jlayton@redhat.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] libfs: Add directory operations for stable offsets
Message-ID: <ZJqFP8W1JmWZ0FHy@infradead.org>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> + * @dir: parent directory to be initialized
> + *
> + */
> +void stable_offset_init(struct inode *dir)
> +{
> +	xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
> +	dir->i_next_offset = 0;
> +}
> +EXPORT_SYMBOL(stable_offset_init);

If this is exported I'd much prefer a EXPORT_SYMBOL_GPL.  But the only
user so far is shmfs, which can't be modular anyway, so I think we can
drop the exports.

> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -96,6 +96,7 @@ struct dentry {
>  	struct super_block *d_sb;	/* The root of the dentry tree */
>  	unsigned long d_time;		/* used by d_revalidate */
>  	void *d_fsdata;			/* fs-specific data */
> +	u32 d_offset;			/* directory offset in parent */
>  
>  	union {
>  		struct list_head d_lru;		/* LRU list */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 133f0640fb24..3fc2c04ed8ff 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -719,6 +719,10 @@ struct inode {
>  #endif
>  
>  	void			*i_private; /* fs or device private pointer */
> +
> +	/* simplefs stable directory offset tracking */
> +	struct xarray		i_doff_map;
> +	u32			i_next_offset;

We can't just increase the size of the dentry and inode for everyone
for something that doesn't make any sense for normal file systems.
This needs to move out into structures allocated by the file system
and embedded into or used as the private dentry/inode data.

> +extern void stable_offset_init(struct inode *dir);
> +extern int stable_offset_add(struct inode *dir, struct dentry *dentry);
> +extern void stable_offset_remove(struct inode *dir, struct dentry *dentry);
> +extern void stable_offset_destroy(struct inode *dir);

Please drop all the pointless externs for function prototypes.
