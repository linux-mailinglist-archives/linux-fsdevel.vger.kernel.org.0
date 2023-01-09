Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2A6627B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 14:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbjAINuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 08:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbjAINth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:49:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A708D271BE
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673272133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvQQWSrgFrwfgP/nK/4g0KowjQbRVLSmpT5SVnvrh64=;
        b=eTjOqtARfyX2rGsDwnaEMnPk94nVzzQDBPMpUi22Ha1n2bgpihAN7Sr0z0RYYOOJ9F3CVh
        XL5y/Myn25fcuUxTREjlX89YCFwchTD73K40MREq9SfVGpvaFs+uRsuuf6AYo5UDxcpC/k
        J4N6k3VfBOKlc9NenT6GkvOQyNMs6uo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-tLXxldPSO764cXJzcCdL4A-1; Mon, 09 Jan 2023 08:48:52 -0500
X-MC-Unique: tLXxldPSO764cXJzcCdL4A-1
Received: by mail-qk1-f200.google.com with SMTP id r6-20020a05620a298600b007025c3760d4so6482767qkp.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 05:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvQQWSrgFrwfgP/nK/4g0KowjQbRVLSmpT5SVnvrh64=;
        b=cZxcaNdppxjyUEweh2qfLM1qV2Mx5yR9xfyYKfWKjZIiAw64hQZSOYJfqqSv4YAvaV
         GgdGbKV3fmiPoZYARrqdgUnqKL40q5R1on7sdODV3F06wKnki96T0e32+owmNCWxnvZi
         YPCbn4un+9YgBMstcpFDwI8UVd53Qf8aiUpfXoe+2w6J9/PJNdLI4AyO4l1UEiQry9Sl
         1X88S/dNHq9B102g561unuBjIj//o4EqTRb0qaW63rYfGgj0JQ6WNuMKu0GBBvGo3hiC
         5VcEI8jQWSMYPwJpbV1ohny1cw5jNkBPbrxTYolkwpTelQRCsAo2nlXG3P1BtEmFEPXc
         KKqA==
X-Gm-Message-State: AFqh2kprfOKYgEs9qXnBjGWpY35KAQ3v1jW26SFZlkNGuTmD7LBqkf7L
        AIdU3QL1ytiyw0cDpsfjoNCXyVPb574aHTKehLJhGQ7mfUCvdHgBq2HEvXK6KLkcGDeF9aMyIrj
        94FxQjT28sy3JbPtMBdznhXXZTQ==
X-Received: by 2002:ac8:4509:0:b0:3a8:162d:e977 with SMTP id q9-20020ac84509000000b003a8162de977mr91039458qtn.58.1673272131565;
        Mon, 09 Jan 2023 05:48:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBqYf6sR9hrOI8TK8PSKFDec2DU6T9YlCBq3DM5BjirOxhid+aIw2+3HKxNZhD/YmD4XYT3w==
X-Received: by 2002:ac8:4509:0:b0:3a8:162d:e977 with SMTP id q9-20020ac84509000000b003a8162de977mr91039437qtn.58.1673272131330;
        Mon, 09 Jan 2023 05:48:51 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id z2-20020ac86b82000000b003a5c6ad428asm4551847qts.92.2023.01.09.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 05:48:50 -0800 (PST)
Message-ID: <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
Subject: Re: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
From:   Jeff Layton <jlayton@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 08:48:49 -0500
In-Reply-To: <20230109051823.480289-3-willy@infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-3-willy@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> Convert both callers to use the "new" errseq infrastructure.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/filemap.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c4d4ace9cc70..48daedc224d9 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -355,16 +355,6 @@ int filemap_check_errors(struct address_space *mappi=
ng)
>  }
>  EXPORT_SYMBOL(filemap_check_errors);
> =20
> -static int filemap_check_and_keep_errors(struct address_space *mapping)
> -{
> -	/* Check for outstanding write errors */
> -	if (test_bit(AS_EIO, &mapping->flags))
> -		return -EIO;
> -	if (test_bit(AS_ENOSPC, &mapping->flags))
> -		return -ENOSPC;
> -	return 0;
> -}
> -
>  /**
>   * filemap_fdatawrite_wbc - start writeback on mapping dirty pages in ra=
nge
>   * @mapping:	address space structure to write
> @@ -567,8 +557,10 @@ EXPORT_SYMBOL(filemap_fdatawait_range);
>  int filemap_fdatawait_range_keep_errors(struct address_space *mapping,
>  		loff_t start_byte, loff_t end_byte)
>  {
> +	errseq_t since =3D filemap_sample_wb_err(mapping);
> +
>  	__filemap_fdatawait_range(mapping, start_byte, end_byte);
> -	return filemap_check_and_keep_errors(mapping);
> +	return filemap_check_wb_err(mapping, since);
>  }
>  EXPORT_SYMBOL(filemap_fdatawait_range_keep_errors);

I looked at making this sort of change across the board alongside the
original wb_err patches, but I backed off at the time.

With the above patch, this function will no longer report a writeback
error that occurs before the sample. Given that writeback can happen at
any time, that seemed like it might be an undesirable change, and I
didn't follow through.

It is true that the existing flag-based code may miss errors too, if
multiple tasks are test_and_clear'ing the bits, but I think the above is
even more likely to happen, esp. under memory pressure.

To do this right, we probably need to look at these callers and have
them track a long-term errseq_t "since" value before they ever dirty the
pages, and then continually check-and-advance vs. that.

For instance, the main caller of the above function is jbd2. Would it be
reasonable to add in a new errseq_t value to the jnode for tracking
errors?

> =20
> @@ -613,8 +605,10 @@ EXPORT_SYMBOL(file_fdatawait_range);
>   */
>  int filemap_fdatawait_keep_errors(struct address_space *mapping)
>  {
> +	errseq_t since =3D filemap_sample_wb_err(mapping);
> +
>  	__filemap_fdatawait_range(mapping, 0, LLONG_MAX);
> -	return filemap_check_and_keep_errors(mapping);
> +	return filemap_check_wb_err(mapping, since);
>  }
>  EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
> =20

--=20
Jeff Layton <jlayton@redhat.com>

