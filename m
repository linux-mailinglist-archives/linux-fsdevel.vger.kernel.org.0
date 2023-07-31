Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC687699D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 16:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjGaOnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjGaOnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:43:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A511B;
        Mon, 31 Jul 2023 07:43:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F960221A9;
        Mon, 31 Jul 2023 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690814596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHAs68zjSb3lJSJ8IpnrzhOZGjTCvtIoG1i1YUV6/0I=;
        b=TSdo/HjwCNkE9dhlYNJTi5h1dQVd8QaUW5Lj6n1S3rx/MqsaLRwAGzYk2MEw4aTm38i6eU
        i2w2DUN3PyjTSBjjW9odU5k4/blCbHWfKEY68Ygb8G9Hlm4g37OZmUH1cRFYPcq6iZILde
        nJMlyRxqF0RXY57yKKOGMRP3iQAffCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690814596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHAs68zjSb3lJSJ8IpnrzhOZGjTCvtIoG1i1YUV6/0I=;
        b=wuNTcxu/Z5OIt2w6gTzHInsFGy7oEj4xVWs/6KobbCq9poTgUMgFso4YByO6H50QF3G8ls
        JzqycqZYvzqRTzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EC90133F7;
        Mon, 31 Jul 2023 14:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MOfNIoTIx2RIXwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 14:43:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2CC22A069C; Mon, 31 Jul 2023 16:43:16 +0200 (CEST)
Date:   Mon, 31 Jul 2023 16:43:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/7] jbd2: Use a folio in
 jbd2_journal_write_metadata_buffer()
Message-ID: <20230731144316.dft4li5saphuy6jx@quack3>
References: <20230713035512.4139457-1-willy@infradead.org>
 <20230713035512.4139457-7-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713035512.4139457-7-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 13-07-23 04:55:11, Matthew Wilcox (Oracle) wrote:
> The primary goal here is removing the use of set_bh_page().
> Take the opportunity to switch from kmap_atomic() to kmap_local().
> This simplifies the function as the offset is already added to
> the pointer.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/jbd2/journal.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index fbce16fedaa4..1b5a45ab62b0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -341,7 +341,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	int do_escape = 0;
>  	char *mapped_data;
>  	struct buffer_head *new_bh;
> -	struct page *new_page;
> +	struct folio *new_folio;
>  	unsigned int new_offset;
>  	struct buffer_head *bh_in = jh2bh(jh_in);
>  	journal_t *journal = transaction->t_journal;
> @@ -370,14 +370,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 */
>  	if (jh_in->b_frozen_data) {
>  		done_copy_out = 1;
> -		new_page = virt_to_page(jh_in->b_frozen_data);
> -		new_offset = offset_in_page(jh_in->b_frozen_data);
> +		new_folio = virt_to_folio(jh_in->b_frozen_data);
> +		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  	} else {
> -		new_page = jh2bh(jh_in)->b_page;
> -		new_offset = offset_in_page(jh2bh(jh_in)->b_data);
> +		new_folio = jh2bh(jh_in)->b_folio;
> +		new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
>  	}
>  
> -	mapped_data = kmap_atomic(new_page);
> +	mapped_data = kmap_local_folio(new_folio, new_offset);
>  	/*
>  	 * Fire data frozen trigger if data already wasn't frozen.  Do this
>  	 * before checking for escaping, as the trigger may modify the magic
> @@ -385,18 +385,17 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 * data in the buffer.
>  	 */
>  	if (!done_copy_out)
> -		jbd2_buffer_frozen_trigger(jh_in, mapped_data + new_offset,
> +		jbd2_buffer_frozen_trigger(jh_in, mapped_data,
>  					   jh_in->b_triggers);
>  
>  	/*
>  	 * Check for escaping
>  	 */
> -	if (*((__be32 *)(mapped_data + new_offset)) ==
> -				cpu_to_be32(JBD2_MAGIC_NUMBER)) {
> +	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
>  		need_copy_out = 1;
>  		do_escape = 1;
>  	}
> -	kunmap_atomic(mapped_data);
> +	kunmap_local(mapped_data);
>  
>  	/*
>  	 * Do we need to do a data copy?
> @@ -417,12 +416,10 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		}
>  
>  		jh_in->b_frozen_data = tmp;
> -		mapped_data = kmap_atomic(new_page);
> -		memcpy(tmp, mapped_data + new_offset, bh_in->b_size);
> -		kunmap_atomic(mapped_data);
> +		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
>  
> -		new_page = virt_to_page(tmp);
> -		new_offset = offset_in_page(tmp);
> +		new_folio = virt_to_folio(tmp);
> +		new_offset = offset_in_folio(new_folio, tmp);
>  		done_copy_out = 1;
>  
>  		/*
> @@ -438,12 +435,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 * copying, we can finally do so.
>  	 */
>  	if (do_escape) {
> -		mapped_data = kmap_atomic(new_page);
> -		*((unsigned int *)(mapped_data + new_offset)) = 0;
> -		kunmap_atomic(mapped_data);
> +		mapped_data = kmap_local_folio(new_folio, new_offset);
> +		*((unsigned int *)mapped_data) = 0;
> +		kunmap_local(mapped_data);
>  	}
>  
> -	set_bh_page(new_bh, new_page, new_offset);
> +	folio_set_bh(new_bh, new_folio, new_offset);
>  	new_bh->b_size = bh_in->b_size;
>  	new_bh->b_bdev = journal->j_dev;
>  	new_bh->b_blocknr = blocknr;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
