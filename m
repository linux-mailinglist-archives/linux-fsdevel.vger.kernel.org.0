Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB3B681D85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjA3V4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjA3V4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:56:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76249552
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:56:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id m13so1216825plx.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl8P3w0rE5L7Ogt46rcei8jC6qEP/DfTlUbSmYUyd+o=;
        b=Rj/ipKzMFUSVabRiLICivz9oGG2syse+qmUy3spxZI3tDU7f35SwBiLmTsuq6tJEO4
         DJDsX0nAbIXQEpbBQcG72B7Cjn/hC4uWCghy3O9bAXnyrNeBsTsHSxPCnpDfxD5XWYGp
         uSEy11Ufdgo5U5p55gx6Xt8EgJxHVu5Km0N6FR9++7S3jHJ0c3SZXm8snEth7XN6RGRq
         Eu4ZaAyv6VCBFcvbq8AzYYe1zmp7sDySu02bZigVLINqxVsRyN+4XK9wWh+CUEvp7GaG
         Aw9wMuOlIgO+nz65uAZinAHWiB2tzop6SNQpQ2ndtBqNTZq1w7WfZBU4BFlUiCB8q+Em
         DS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tl8P3w0rE5L7Ogt46rcei8jC6qEP/DfTlUbSmYUyd+o=;
        b=TcvHx2zRctsjdFs3DceV40y28en7+OEiibFJOve1kde2TdmZvE+3e71LLELU+sWzqE
         6yVFZOtr0USZtdcNvlwXs1zlS3813SZj47X1NiGwg5Y0nsv3pvyGzFZcNd+cgnIFfBE+
         WoYv/XageGKdCDbnSMpnTZEFVZX3qrggiKQRJkoGhckXMyLa6NZumG9TerEbxwv4oJec
         GMgods2ZWjqSXOVZZYd8s2BBcvRjM7G87JVy/uCoCymxCrcUajhpQieW8ojmPnw3qtsI
         k1VvAQOq2VQJ+9FzGW/Xdsf2LexqXUkx8gppl9GppxW9B276c1rRHPygPLwnDZ2gCuYy
         rJPA==
X-Gm-Message-State: AO0yUKX+VDTggX12vcq9EMx5m1POKj/X7cIDMdnTn20frXgkrSLQggUu
        JNIxpmGiYk914fxh98aEI6Rx0A==
X-Google-Smtp-Source: AK7set/wT57T3wzCWhkpohNLzTc34k9SJ1xcCWt6vb934DhonVvIxLQnQ/8m9zSWLO5kxOba8QbNIQ==
X-Received: by 2002:a17:902:d2ce:b0:194:ce30:1a94 with SMTP id n14-20020a170902d2ce00b00194ce301a94mr11704452plc.1.1675115787657;
        Mon, 30 Jan 2023 13:56:27 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b00194bf875ed8sm2295910plf.139.2023.01.30.13.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:56:27 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pMc8V-009Ra6-50; Tue, 31 Jan 2023 08:56:23 +1100
Date:   Tue, 31 Jan 2023 08:56:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 2/3] iomap: Change uptodate variable name to state
Message-ID: <20230130215623.GP360264@dread.disaster.area>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf30b7bfb03ef368e6e744b3c63af3dbfa11304d.1675093524.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:44:12PM +0530, Ritesh Harjani (IBM) wrote:
> This patch just changes the struct iomap_page uptodate & uptodate_lock
> member names to state and state_lock to better reflect their purpose for
> the upcoming patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e9c85fcf7a1f..faee2852db8f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -25,13 +25,13 @@
>  
>  /*
>   * Structure allocated for each folio when block size < folio size
> - * to track sub-folio uptodate status and I/O completions.
> + * to track sub-folio uptodate state and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_bytes_pending;
>  	atomic_t		write_bytes_pending;
> -	spinlock_t		uptodate_lock;
> -	unsigned long		uptodate[];
> +	spinlock_t		state_lock;
> +	unsigned long		state[];

I don't realy like this change, nor the followup in the next patch
that puts two different state bits somewhere inside a single bitmap.

>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> @@ -58,12 +58,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
>  	else
>  		gfp = GFP_NOFS | __GFP_NOFAIL;
>  
> -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
>  		      gfp);
>  	if (iop) {
> -		spin_lock_init(&iop->uptodate_lock);
> +		spin_lock_init(&iop->state_lock);
>  		if (folio_test_uptodate(folio))
> -			bitmap_fill(iop->uptodate, nr_blocks);
> +			bitmap_fill(iop->state, nr_blocks);

This is the reason I don't like it - we lose the self-documenting
aspect of the code. bitmap_fill(iop->uptodate, nr_blocks) is
obviously correct, the new version isn't because "state" has no
obvious meaning, and it only gets worse in the next patch where
state is changed to have a magic "2 * nr_blocks" length and multiple
state bits per block.

Having an obvious setup where there are two bitmaps, one for dirty
and one for uptodate, and the same bit in each bitmap corresponds to
the state for that sub-block region, it is easy to see that the code
is operating on the correct bit, to look at the bitmap and see what
bits are set, to compare uptodate and dirty bitmaps side by side,
etc. It's a much easier setup to read, code correctly, analyse and
debug than putting multiple state bits in the same bitmap array at
different indexes.

If you are trying to keep this down to a single allocation by using
a single bitmap of undefined length, then change the declaration and
the structure size calculation away from using array notation and
instead just use pointers to the individual bitmap regions within
the allocated region.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
