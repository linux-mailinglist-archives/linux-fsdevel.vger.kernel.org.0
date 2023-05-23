Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2115370D6B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbjEWIIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjEWIID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 04:08:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79610DD;
        Tue, 23 May 2023 01:07:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6C852041A;
        Tue, 23 May 2023 08:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684829222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sO7kzFwmptuNxnDGut8ORslGVd/fsxgDQH0NmJ023YI=;
        b=r1KUvnNOrg4jCn2j2nvm3IGqQZdkSp91G7kLEGLkmgGJxcV8LFfdWxsw3jH1pqVU0QACXc
        sg/cbM6M6BTU0IyAfyUvgrVCJvEYSkQ9JsPC5/+DWNStD9q/zy8r5eIfeQCFYeGmvV+g2F
        uYa+9vaGVp8XTheLDDOw7szQBHtG8yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684829222;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sO7kzFwmptuNxnDGut8ORslGVd/fsxgDQH0NmJ023YI=;
        b=Aev85FbgF9zoffR/wHco7E5dzx62A6HSGGXEjWrm9VODge+o7OMOQ5BCtrVNDzXW1XNCcY
        OdpS27+W46HrysDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ADE113A10;
        Tue, 23 May 2023 08:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pZfHJSZ0bGQgMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 23 May 2023 08:07:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16D74A075D; Tue, 23 May 2023 10:07:02 +0200 (CEST)
Date:   Tue, 23 May 2023 10:07:02 +0200
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
        John Hubbard <jhubbard@nvidia.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v21 1/6] iomap: Don't get an reference on ZERO_PAGE for
 direct I/O block zeroing
Message-ID: <20230523080702.vo5n3vanhc5kxcen@quack3>
References: <20230522205744.2825689-1-dhowells@redhat.com>
 <20230522205744.2825689-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522205744.2825689-2-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-05-23 21:57:39, David Howells wrote:
> ZERO_PAGE can't go away, no need to hold an extra reference.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: linux-fsdevel@vger.kernel.org

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/direct-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 019cc87d0fb3..66a9f10e3207 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -203,7 +203,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  	bio->bi_private = dio;
>  	bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -	get_page(page);
> +	bio_set_flag(bio, BIO_NO_PAGE_REF);
>  	__bio_add_page(bio, page, len, 0);
>  	iomap_dio_submit_bio(iter, dio, bio, pos);
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
