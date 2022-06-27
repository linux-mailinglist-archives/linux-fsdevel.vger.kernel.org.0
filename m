Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F037B55C1A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbiF0TRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiF0TRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:17:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA0658B
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 12:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C08BCE1999
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jun 2022 19:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52F4C3411D;
        Mon, 27 Jun 2022 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656357432;
        bh=tFetw5NCVLOiu/AWHrIJlhVVxr2cmD5N31YmOV3PpTM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AGed8b1hdAqqS6EIjtSzDJOQ/MPLHNcCzIrxD4jKw+4ca5v9z/or4ot0PEcVFhMvV
         cAuSKDPHJC1XAxzT09tCHBgPdqsTvEziUaajt5JgLvrhugFqk84PRSUFFz09oUAqcQ
         HeVtsOFeYBh/z/qs1e6YzhePO9SbYe1g6NLNhjlJLxCdpY0tKfsnsISfvT0gg88vmI
         AHnSk1BNSDw83NNrf2k6sfFxm3OL/5x/7Eaaz5kKiYX5vIIqaXoXZNxFNEeJusEmZE
         ScBLVLeQvb1tUQilUZ/akJYZZKN5Y3suJZw030fJBKABsXRPn998A/WNxQShXYjsUj
         K51BfSXBtjykQ==
Message-ID: <2e5f03a41758b2bfd6e9577b9f7bf46dc0fa2c55.camel@kernel.org>
Subject: Re: [PATCH 13/44] splice: stop abusing iov_iter_advance() to flush
 a pipe
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Jun 2022 15:17:10 -0400
In-Reply-To: <20220622041552.737754-13-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-13-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-22 at 05:15 +0100, Al Viro wrote:
> Use pipe_discard_from() explicitly in generic_file_read_iter(); don't bot=
her
> with rather non-obvious use of iov_iter_advance() in there.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/splice.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/splice.c b/fs/splice.c
> index 047b79db8eb5..6645b30ec990 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -301,11 +301,9 @@ ssize_t generic_file_splice_read(struct file *in, lo=
ff_t *ppos,
>  {
>  	struct iov_iter to;
>  	struct kiocb kiocb;
> -	unsigned int i_head;
>  	int ret;
> =20
>  	iov_iter_pipe(&to, READ, pipe, len);
> -	i_head =3D to.head;
>  	init_sync_kiocb(&kiocb, in);
>  	kiocb.ki_pos =3D *ppos;
>  	ret =3D call_read_iter(in, &kiocb, &to);
> @@ -313,9 +311,8 @@ ssize_t generic_file_splice_read(struct file *in, lof=
f_t *ppos,
>  		*ppos =3D kiocb.ki_pos;
>  		file_accessed(in);
>  	} else if (ret < 0) {
> -		to.head =3D i_head;
> -		to.iov_offset =3D 0;
> -		iov_iter_advance(&to, 0); /* to free what was emitted */
> +		/* free what was emitted */
> +		pipe_discard_from(pipe, to.start_head);
>  		/*
>  		 * callers of ->splice_read() expect -EAGAIN on
>  		 * "can't put anything in there", rather than -EFAULT.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
