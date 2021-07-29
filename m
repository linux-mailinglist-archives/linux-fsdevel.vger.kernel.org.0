Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909813D9CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 06:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhG2E7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 00:59:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhG2E7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 00:59:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80C5422372;
        Thu, 29 Jul 2021 04:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627534741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LN0AGtLQbaCW/YF78ot6nD4sfri/rbkOHMPxF1T0A8=;
        b=bqWy6eItAXTgCTka8yK34nUwl0/UZ/MrHh6+xIm92dYRak8EVlxsIfhHy5JC52rDodU4Et
        cs8ARZTWjNWlcS18SvD1Io/lEcPJp9AJm0OSa5B9mEZaudvBjAqRCTPSfmgT6lyJD6qdgT
        MoQ63BDpy+q0c6/vH6x2PW31UsmRWuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627534741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LN0AGtLQbaCW/YF78ot6nD4sfri/rbkOHMPxF1T0A8=;
        b=git8nnpPIaot5rpgWIZxkDSMYw8xLPoLk3/BOSjf9KMNlp/VFxFmWUF10BAiPLNY4agGv4
        1WhFHBr8B4zAzpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EEB913ADD;
        Thu, 29 Jul 2021 04:58:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YbqRFpM1AmH4OAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 29 Jul 2021 04:58:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Goldwyn Rodrigues" <rgoldwyn@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs: reduce pointers while using file_ra_state_init()
In-reply-to: <20210726164647.brx3l2ykwv3zz7vr@fiona>
References: <20210726164647.brx3l2ykwv3zz7vr@fiona>
Date:   Thu, 29 Jul 2021 14:58:56 +1000
Message-id: <162753473650.21659.5563242071693885551@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Jul 2021, Goldwyn Rodrigues wrote:
> Simplification.
> 
> file_ra_state_init() take struct address_space *, just to use inode
> pointer by dereferencing from mapping->host.
> 
> The callers also derive mapping either by file->f_mapping, or
> even file->f_mapping->host->i_mapping.
> 
> Change file_ra_state_init() to accept struct inode * to reduce pointer
> dereferencing, both in the callee and the caller.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
....

> diff --git a/mm/readahead.c b/mm/readahead.c
> index d589f147f4c2..3541941df5e7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -31,9 +31,9 @@
>   * memset *ra to zero.
>   */
>  void
> -file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
> +file_ra_state_init(struct file_ra_state *ra, struct inode *inode)
>  {
> -	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
> +	ra->ra_pages = inode_to_bdi(inode)->ra_pages;
>  	ra->prev_pos = -1;

I think this patch can be made OK by adding:

  if (unlikely(inode->i_mapping != &inode->i_data))
	inode = inode->i_mapping->host;

The "unlikely" is mostly for documentation.
Loading "inode->i_mapping" is nearly free as that cache line needs to be
loaded to get i_sb, which inode_to_bdi() needs.  Calculating &->i_data
is trivial.  So this adds minimal cost, and preserves correctness.

NeilBrown


>  }
>  EXPORT_SYMBOL_GPL(file_ra_state_init);
> -- 
> 2.32.0
> 
> 
> -- 
> Goldwyn
> 
> 
