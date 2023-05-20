Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74BD70A6AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjETJVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjETJVS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 05:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DDB103;
        Sat, 20 May 2023 02:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F03BA61155;
        Sat, 20 May 2023 09:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005DDC433EF;
        Sat, 20 May 2023 09:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684574476;
        bh=1sk3KywmldKzQSQt90JNPQOI5X1ZWPtE36C3dU9orHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYWLBFhTwx1fR7Cz/5zG9pwLY+6U2pv9KX0owdf1450WutM3cJyiNdY4rcV1Aawm2
         p72IcCpaimXVM4z+BiA0BX8BUYnw9tENkwNqpcid6Zpq3trS1XZavJi2ifTXO04UA2
         XpphECjMHAyUP3W1Z2d6eJZ7evjMRFXuvBLcmsvxy96Q30fXTwvMLzYyqix16yi0zI
         jhVuGGD5CnY5nU0uBgfUYqmOUnJda4b5xIIl5FvnuB67fZxVL/UirSpknicVuJKsOS
         dW4ifc4rYuoJayLJuvSKpFr74JYHfUW95tBipXt3wXPh/Vtd3L+WO+YKZ1Ls0cgIFp
         tVmYwsuyzQwvg==
Date:   Sat, 20 May 2023 11:21:08 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v21 02/30] splice: Make filemap_splice_read() check
 s_maxbytes
Message-ID: <20230520-abzweigen-jurymitglied-600e651d784b@brauner>
References: <20230520000049.2226926-1-dhowells@redhat.com>
 <20230520000049.2226926-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230520000049.2226926-3-dhowells@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 20, 2023 at 01:00:21AM +0100, David Howells wrote:
> Make filemap_splice_read() check s_maxbytes analogously to filemap_read().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Steve French <stfrench@microsoft.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: David Hildenbrand <david@redhat.com>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: linux-mm@kvack.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  mm/filemap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a2006936a6ae..0fcb0b80c2e2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2887,6 +2887,9 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  	bool writably_mapped;
>  	int i, error = 0;
>  
> +	if (unlikely(*ppos >= in->f_mapping->host->i_sb->s_maxbytes))

Pointer deref galore
Reviewed-by: Christian Brauner <brauner@kernel.org>
