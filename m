Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2D6E3184
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 15:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjDONOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDONOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 09:14:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310A4C26;
        Sat, 15 Apr 2023 06:14:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC481FDC5;
        Sat, 15 Apr 2023 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681564474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5k/RbS3a6kwtihmho3Q3mrYWrzOBkRjuXgoZbNNYHI=;
        b=XYysb9Th9C57KmHRUhQg/Xw5Cm563xxANOV4YkugAv5E/0rianuE7RlkMAwnZ3FJNh3eXK
        NU++4s6YOZQlHwlxkk5kDfpndBq7aR6cCqQL1Q3IipQZsSHsstNov6m9Zw9uPaXOmmGAhr
        mj2WAUhPhJUEiTCl2TYnAK3XicOnm+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681564474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5k/RbS3a6kwtihmho3Q3mrYWrzOBkRjuXgoZbNNYHI=;
        b=S9v6bvc+eOJnhTovvE0tORWGe0nwUU7lfI9G+gDVn7mpKhy/QksaiuRZlHsoVMZzgKOuO/
        tXVhupyvXQKqxoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CD7B1390E;
        Sat, 15 Apr 2023 13:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IfMcBTqjOmRIDgAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 15 Apr 2023 13:14:34 +0000
Message-ID: <31765c8c-e895-4207-2b8c-39f6c7c83ece@suse.de>
Date:   Sat, 15 Apr 2023 15:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/4] convert create_page_buffers to create_folio_buffers
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gost.dev@samsung.com
References: <CGME20230414110825eucas1p1ed4d16627889ef8542dfa31b1183063d@eucas1p1.samsung.com>
 <20230414110821.21548-1-p.raghav@samsung.com>
 <1e68a118-d177-a218-5139-c8f13793dbbf@suse.de>
 <ZDn3XPMA024t+C1x@bombadil.infradead.org>
 <ZDoMmtcwNTINAu3N@casper.infradead.org>
 <ZDoZCJHQXhVE2KZu@bombadil.infradead.org>
 <ZDodlnm2nvYxbvR4@casper.infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZDodlnm2nvYxbvR4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/23 05:44, Matthew Wilcox wrote:
> On Fri, Apr 14, 2023 at 08:24:56PM -0700, Luis Chamberlain wrote:
>> I thought of that but I saw that the loop that assigns the arr only
>> pegs a bh if we don't "continue" for certain conditions, which made me
>> believe that we only wanted to keep on the array as non-null items which
>> meet the initial loop's criteria. If that is not accurate then yes,
>> the simplication is nice!
> 
> Uh, right.  A little bit more carefully this time ... how does this
> look?
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 5e67e21b350a..dff671079b02 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2282,7 +2282,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   {
>   	struct inode *inode = folio->mapping->host;
>   	sector_t iblock, lblock;
> -	struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
> +	struct buffer_head *bh, *head;
>   	unsigned int blocksize, bbits;
>   	int nr, i;
>   	int fully_mapped = 1;
> @@ -2335,7 +2335,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   			if (buffer_uptodate(bh))
>   				continue;
>   		}
> -		arr[nr++] = bh;
> +		nr++;
>   	} while (i++, iblock++, (bh = bh->b_this_page) != head);
>   
>   	if (fully_mapped)
> @@ -2352,25 +2352,29 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>   		return 0;
>   	}
>   
> -	/* Stage two: lock the buffers */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> +	/*
> +	 * Stage two: lock the buffers.  Recheck the uptodate flag under
> +	 * the lock in case somebody else brought it uptodate first.
> +	 */
> +	bh = head;
> +	do {
> +		if (buffer_uptodate(bh))
> +			continue;
>   		lock_buffer(bh);
> +		if (buffer_uptodate(bh)) {
> +			unlock_buffer(bh);
> +			continue;
> +		}
>   		mark_buffer_async_read(bh);
> -	}
> +	} while ((bh = bh->b_this_page) != head);
>   
> -	/*
> -	 * Stage 3: start the IO.  Check for uptodateness
> -	 * inside the buffer lock in case another process reading
> -	 * the underlying blockdev brought it uptodate (the sct fix).
> -	 */
> -	for (i = 0; i < nr; i++) {
> -		bh = arr[i];
> -		if (buffer_uptodate(bh))
> -			end_buffer_async_read(bh, 1);
> -		else
> +	/* Stage 3: start the IO */
> +	bh = head;
> +	do {
> +		if (buffer_async_read(bh))
>   			submit_bh(REQ_OP_READ, bh);
> -	}
> +	} while ((bh = bh->b_this_page) != head);
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(block_read_full_folio);
> 
> 
> I do wonder how much it's worth doing this vs switching to non-BH methods.
> I appreciate that's a lot of work still.

That's what I've been wondering, too.

I would _vastly_ prefer to switch over to iomap; however, the blasted
sb_bread() is getting in the way. Currently iomap only runs on entire
pages / folios, but a lot of (older) filesystems insist on doing 512
byte I/O. While this seem logical (seeing that 512 bytes is the
default, and, in most cases, the only supported sector size) question
is whether _we_ from the linux side need to do that.
We _could_ upgrade to always do full page I/O; there's a good
chance we'll be using the entire page anyway eventually.
And with storage bandwidth getting larger and larger we might even
get a performance boost there.

And it would save us having to implement sub-page I/O for iomap.

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

