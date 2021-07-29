Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABB53DA75E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhG2PTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 11:19:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41160 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbhG2PTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:19:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82455223D8;
        Thu, 29 Jul 2021 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627571967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsaQkyOJ/y7V50td67hCyqP/I5uN0MeHxA5G783O9yE=;
        b=CjhqW4EUd1qPgP5ufMskNy1R612Ch3agnha0+rygg9phpVOQhqXL8aIAxj8DKMLwxNuDFE
        QEghiUhQEBzk8hOH5/25u78dHY5FsR9bzztKdhmMkjGs2ZGMj2Bbie4BBfc7zqdeujqf1j
        AQQWPsY9nswd7wXxDkWmXsfSENeBmBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627571967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsaQkyOJ/y7V50td67hCyqP/I5uN0MeHxA5G783O9yE=;
        b=tOEqG2bKX9LUvTE7tcCQ58PCI+kVcuKh59fF3R9MEOYY1Rv4TylqN+/ht8W6KFS1OZWtVh
        KnZtrCvtOfoZNGBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 16B3913738;
        Thu, 29 Jul 2021 15:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id xWBDMv7GAmHHKwAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Thu, 29 Jul 2021 15:19:26 +0000
Date:   Thu, 29 Jul 2021 10:19:24 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
Message-ID: <20210729151924.ncwwsz6x6jknyk6t@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
 <162753473650.21659.5563242071693885551@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162753473650.21659.5563242071693885551@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14:58 29/07, NeilBrown wrote:
> On Tue, 27 Jul 2021, Goldwyn Rodrigues wrote:
> > Simplification.
> > 
> > file_ra_state_init() take struct address_space *, just to use inode
> > pointer by dereferencing from mapping->host.
> > 
> > The callers also derive mapping either by file->f_mapping, or
> > even file->f_mapping->host->i_mapping.
> > 
> > Change file_ra_state_init() to accept struct inode * to reduce pointer
> > dereferencing, both in the callee and the caller.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> ....
> 
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index d589f147f4c2..3541941df5e7 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -31,9 +31,9 @@
> >   * memset *ra to zero.
> >   */
> >  void
> > -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> > +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
> >  {
> > -	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> > +	ra->ra_pages = inode_to_bdi(inode)->ra_pages;
> >  	ra->prev_pos = -1;
> 
> I think this patch can be made OK by adding:
> 
>   if (unlikely(inode->i_mapping != &inode->i_data))
> 	inode = inode->i_mapping->host;
> 
> The "unlikely" is mostly for documentation.
> Loading "inode->i_mapping" is nearly free as that cache line needs to be
> loaded to get i_sb, which inode_to_bdi() needs.  Calculating &->i_data
> is trivial.  So this adds minimal cost, and preserves correctness.
> 

Thanks Neil. Coda seems to be the only filesystem to manipulate
inode->i_mapping to support the mmap() operation and eventually resets
it back on release().

Not sure if this hack should be put in just for coda, or just leave the
function prototype as it is to accept address_space *. I will send out
another patch to see what others feel about it.


-- 
Goldwyn
