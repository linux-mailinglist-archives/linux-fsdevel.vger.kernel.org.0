Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2273F7D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjF0Iwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 04:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjF0Iwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66071BCF
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 01:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A3961073
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 08:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4D8C433C8;
        Tue, 27 Jun 2023 08:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687855945;
        bh=NZREHs/eWgJeGiYoVnm+2I8Iio0OR38JfhH6RcTJdAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev5JtU8KRW3Zv+UO2Gj8Mc02CjJMEolTkpysPlyy3ez2lrOEOhmAv5pyyDpN2/cLi
         CYMc0E9bUID0GwU3xEtt04mXfiXZcQjOC5IR3e3Xg1XAKYxnVPkCMwwmwkwEn4eFG3
         YJXJvXbjTh8pxRKio6J8XbqjcKS/UA0QDqdE2wQZXe44so9kEUVNwj3uD/2pCW47CQ
         DxUQYGZwJysocEgJj4Tj7fNYmc5lrasFOgts7BnSzm2iNfSMae6TZTqpRrn6jt7keb
         NpLCZWVusjoH03nPzLvYWVDAjYOH3B8o+6xUQ+tOCgA/59xUhBH4P69FM9ktVAc/sf
         RIZdOMLFJYhMg==
Date:   Tue, 27 Jun 2023 10:52:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Chuck Lever <cel@kernel.org>, viro@zeniv.linux.org.uk,
        hughd@google.com, akpm@linux-foundation.org,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] libfs: Add directory operations for stable offsets
Message-ID: <20230627-drastisch-wiegt-8d2aba4e5a0d@brauner>
References: <168780354647.2142.537463116658872680.stgit@manet.1015granger.net>
 <168780368739.2142.1909222585425739373.stgit@manet.1015granger.net>
 <ZJqFP8W1JmWZ0FHy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJqFP8W1JmWZ0FHy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:44:15PM -0700, Christoph Hellwig wrote:
> > + * @dir: parent directory to be initialized
> > + *
> > + */
> > +void stable_offset_init(struct inode *dir)
> > +{
> > +	xa_init_flags(&dir->i_doff_map, XA_FLAGS_ALLOC1);
> > +	dir->i_next_offset = 0;
> > +}
> > +EXPORT_SYMBOL(stable_offset_init);
> 
> If this is exported I'd much prefer a EXPORT_SYMBOL_GPL.  But the only
> user so far is shmfs, which can't be modular anyway, so I think we can
> drop the exports.
> 
> > --- a/include/linux/dcache.h
> > +++ b/include/linux/dcache.h
> > @@ -96,6 +96,7 @@ struct dentry {
> >  	struct super_block *d_sb;	/* The root of the dentry tree */
> >  	unsigned long d_time;		/* used by d_revalidate */
> >  	void *d_fsdata;			/* fs-specific data */
> > +	u32 d_offset;			/* directory offset in parent */
> >  
> >  	union {
> >  		struct list_head d_lru;		/* LRU list */
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 133f0640fb24..3fc2c04ed8ff 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -719,6 +719,10 @@ struct inode {
> >  #endif
> >  
> >  	void			*i_private; /* fs or device private pointer */
> > +
> > +	/* simplefs stable directory offset tracking */
> > +	struct xarray		i_doff_map;
> > +	u32			i_next_offset;
> 
> We can't just increase the size of the dentry and inode for everyone
> for something that doesn't make any sense for normal file systems.
> This needs to move out into structures allocated by the file system
> and embedded into or used as the private dentry/inode data.

I agree. I prefer if this could be done on a per filesystem basis as
well. Especially since, this is currently only useful for a single
filesystem.

We've tried to be very conservative in increasing inode and dentry size
and we should continue with that.
