Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D953E21E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiFFHhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiFFHhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:37:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7584924F1B;
        Mon,  6 Jun 2022 00:37:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C1831F390;
        Mon,  6 Jun 2022 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654501059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nyo7mFRwTaKeHK83OFLmqqb5+OhN6a5HfrVNoOD8vPU=;
        b=0tkSIz0QzZosMinaVpAHB3cIiMl5/bzKZOHXNwCLyQrkOvkBjLmIqijqxT+XIuuYF5OEhG
        GqhbgtZ0mQoQWRdvkUQ/m8uBQrHAuHhIoBaI6WCFmp7JMbcKFeJ2K5n8wFEepm2YRsUU3A
        7/6d9avqElVwR5864Al8rRJ2H6gwMeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654501059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nyo7mFRwTaKeHK83OFLmqqb5+OhN6a5HfrVNoOD8vPU=;
        b=jKZsMXv59W2p3fdsVKC+QF6V78vcNcCodArofFlXUfJ/DqBou78NivzpqYviBeIeBfYDnP
        pTce7kKzx4KNTmCA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 071AC2C141;
        Mon,  6 Jun 2022 07:37:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B4CD4A0633; Mon,  6 Jun 2022 09:37:38 +0200 (CEST)
Date:   Mon, 6 Jun 2022 09:37:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: generic_quota_read
Message-ID: <20220606073738.oqcdn4hxl5jpkntr@quack3.lan>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-8-willy@infradead.org>
 <YpBlF2xbfL2yY98n@infradead.org>
 <YpodTd+YN/FtiaP3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpodTd+YN/FtiaP3@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-06-22 15:40:13, Matthew Wilcox wrote:
> On Thu, May 26, 2022 at 10:43:51PM -0700, Christoph Hellwig wrote:
> > >  static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
> > > +			      size_t len, loff_t pos)
> >
> > And this whole helper is generic now.  It might be worth to move it
> > into fs/quota/dquot.c as generic_quota_read.
> 
> I've been working on that this week.  Unfortunately, you have to convert
> both quota_read and quota_write at the same time, it turns out.  At
> least ext4_quota_write() uses the bdev's inode's page cache to back
> the buffer_heads, so quota_read() and quota_write() are incoherent
> with each other:
> 
> 00017 gqr: mapping:00000000ee19acfb index:0x1 pos:0x1470 len:0x30
> 00017 4qw: mapping:000000007f9a811e index:0x18405 pos:0x1440 len:0x30

Yes, reads and writes have to use the same cache. Otherwise bad things
happen...

> I don't know if there's a way around this.  Can't really use
> read_mapping_folio() on the bdev's inode in generic_quota_read() -- the
> blocks for a given page might be fragmented on disk.  I don't know
> if there's a way to tell ext4_bread() to use the inode's page cache
> instead of the bdev's.

There's no way for ext4_bread() to read from inode's page cache. And that
is deliberate - ext4_bread() is used for filesystem metadata (and quota is
treated as filesystem metadata) and we use bdev page cache for all the
metadata.

> And if we did that, would it even work as being part of a transaction?

In principle it could work because we would then treat quota as journalled
data and jbd2 supports that. But honestly, special-casing quota as
journalled data IMHO brings more hassle on the write side than it can save
by sharing some code on the read side.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
