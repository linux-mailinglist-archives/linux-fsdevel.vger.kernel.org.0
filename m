Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755FC70D6B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbjEWIIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjEWIIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:08:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA57A10C4;
        Tue, 23 May 2023 01:07:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B02AE2041B;
        Tue, 23 May 2023 08:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPLFgDqgchCj+WxSz7S33Rs9USHRK6Fp05KTuh/d+PM=;
        b=Z4vAnYfpZd9whMvSdMLNkPu3e2JuJ821xfwmgRmBvTWcRUXKygbcuYgjJmRBDx1KHKHODE
        HAkyjH0uf9drhTNgOPq4bnOQK8ApleKBIpxDWLNA9f7o4bHEKCqcU03IyW37dsb+MUlled
        AEKM5QT5CUCHBgxiZ/KCKLT20qdZt98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CPLFgDqgchCj+WxSz7S33Rs9USHRK6Fp05KTuh/d+PM=;
        b=oUMBAAD215L/gzPdDk7Sxt8yzui+yZaR7jMXH1fNAsaTSrLmz1L3BjWNWMj+Vs8QvNBfki
        OBQmXpeWF89YywCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E05513A10;
        Tue, 23 May 2023 08:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9BWLJjh0bGQ0MQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:07:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 43C4FA075D; Tue, 23 May 2023 10:07:20 +0200 (CEST)
Date:   Tue, 23 May 2023 10:07:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 2/6] block: Fix bio_flagged() so that gcc can better
 optimise it
Message-ID: <20230523080720.3eovz5wbwmpckhsm@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-3-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:40, David Howells wrote:
> Fix bio_flagged() so that multiple instances of it, such as:
> 
> 	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
> 	    bio_flagged(bio, BIO_PAGE_PINNED))
> 
> can be combined by the gcc optimiser into a single test in assembly
> (arguably, this is a compiler optimisation issue[1]).
> 
> The missed optimisation stems from bio_flagged() comparing the result of
> the bitwise-AND to zero.  This results in an out-of-line bio_release_page()
> being compiled to something like:
> 
>    <+0>:     mov    0x14(%rdi),%eax
>    <+3>:     test   $0x1,%al
>    <+5>:     jne    0xffffffff816dac53 <bio_release_pages+11>
>    <+7>:     test   $0x2,%al
>    <+9>:     je     0xffffffff816dac5c <bio_release_pages+20>
>    <+11>:    movzbl %sil,%esi
>    <+15>:    jmp    0xffffffff816daba1 <__bio_release_pages>
>    <+20>:    jmp    0xffffffff81d0b800 <__x86_return_thunk>
> 
> However, the test is superfluous as the return type is bool.  Removing it
> results in:
> 
>    <+0>:     testb  $0x3,0x14(%rdi)
>    <+4>:     je     0xffffffff816e4af4 <bio_release_pages+15>
>    <+6>:     movzbl %sil,%esi
>    <+10>:    jmp    0xffffffff816dab7c <__bio_release_pages>
>    <+15>:    jmp    0xffffffff81d0b7c0 <__x86_return_thunk>
> 
> instead.
> 
> Also, the MOVZBL instruction looks unnecessary[2] - I think it's just
> 're-booling' the mark_dirty parameter.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: linux-block@vger.kernel.org
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108370 [1]
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108371 [2]
> Link: https://lore.kernel.org/r/167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk/ # v6

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/bio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index b3e7529ff55e..7f53be035cf0 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -229,7 +229,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
>  
>  static inline bool bio_flagged(struct bio *bio, unsigned int bit)
>  {
> -	return (bio->bi_flags & (1U << bit)) != 0;
> +	return bio->bi_flags & (1U << bit);
>  }
>  
>  static inline void bio_set_flag(struct bio *bio, unsigned int bit)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
