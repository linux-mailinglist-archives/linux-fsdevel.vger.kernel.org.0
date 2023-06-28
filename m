Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28791741BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 00:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF1WYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 18:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF1WYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:24:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61472134;
        Wed, 28 Jun 2023 15:23:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fba545d743so582095e9.0;
        Wed, 28 Jun 2023 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687991037; x=1690583037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJSQ2cbgDZSmh5RuRHhUwD3ZZOJfvX+ur0GE22ML6KI=;
        b=IAeB7RM8oKj2Ma9uUqLnb4e119QOYrBBnvem6Foysew6wIo0xM+jtRjyw3BgfHN2SF
         sNQCmPf+wiZmuzA6RfcHIPX88vaQeB934RdAQnkv4fKAnRUpcjhEzwDdCrWVT4yw+qwl
         uRYefMOSDeFVnLZBnjtJYoFORQKCJOKMKAwmRe2TqKIoyVrrxURlmFz4rN3GyvrKUVKE
         BFttYYRZ6gYSsg64oNGnxVb62HJNTx5TjK0YZihM843Kgo+5R/MeOzhfmZ3Jqrwmi0U7
         ngRGb1gK8eNmZP9Nmk4z4Ur7PWnrcuyRaX9Yd3UMIo95hG70sujIu7cpW8JH/khb/Mjm
         zFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687991037; x=1690583037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJSQ2cbgDZSmh5RuRHhUwD3ZZOJfvX+ur0GE22ML6KI=;
        b=YF4wkPkk6HmpOfkZQV2JPMBJKyXlPlGRiF6lxCrxrEmcPUp1dpl+rjc/YSaS3Vh76s
         tY8+IUAkFkpSawqsmS6d6PJpqfKJeBDu0RY/WYEtdiQorMcRv+wjFJYw61rX3TIPvt5E
         EkMtoDmhF6hTzR4W2mkYAInv3x9tk+TPi8cHoHF16KvoPnSgBWAkGtEnCjIgvrm4Pbcg
         OFT30IXpZoFlxS7uOf0aTX7L+8WDK6SalQq0OeIzdTn02i5CSjzL87wSkt3i8qvzUXYM
         BtpVW85eExgYptAqTCQkBmXnhyBabAf2fuxQyqlHBt8yZplVcwZEaIfdVGe8il/OGTsX
         xHpw==
X-Gm-Message-State: AC+VfDw/Huab8irpNYi7BQB5puHMiCtELeCYS9r76/AOgq1dkohy/xnu
        B6CbDazpogY9EooO2BliX/yl+iL595g=
X-Google-Smtp-Source: ACHHUZ5kOHdlPw1OGXW6fZxr/hv7DLmJTCXyIxcloHSLI27O6GzkGcfxQJToG70wWFjyiRiIYkmZng==
X-Received: by 2002:a7b:c5d7:0:b0:3f8:c70e:7ed1 with SMTP id n23-20020a7bc5d7000000b003f8c70e7ed1mr31957944wmk.20.1687991036884;
        Wed, 28 Jun 2023 15:23:56 -0700 (PDT)
Received: from suse.localnet (host-87-3-108-126.retail.telecomitalia.it. [87.3.108.126])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d6611000000b003140fff4f75sm1983877wru.17.2023.06.28.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:23:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Date:   Thu, 29 Jun 2023 00:23:54 +0200
Message-ID: <6924669.18pcnM708K@suse>
In-Reply-To: <ZJxqmEVKoxxftfXM@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com> <ZJxqmEVKoxxftfXM@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 28 giugno 2023 19:15:04 CEST Matthew Wilcox wrote:
> Here's a more comprehensive read_folio patch.  It's not at all
> efficient, but then if we wanted an efficient vboxsf, we'd implement
> vboxsf_readahead() and actually do an async call with deferred setting
> of the uptodate flag.
> I can consult with anyone who wants to do all
> this work.

Interesting...
=20
> I haven't even compiled this, just trying to show the direction this
> should take.
>=20
> diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
> index 2307f8037efc..f1af9a7bd3d8 100644
> --- a/fs/vboxsf/file.c
> +++ b/fs/vboxsf/file.c
> @@ -227,26 +227,31 @@ const struct inode_operations vboxsf_reg_iops =3D {
>=20
>  static int vboxsf_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct page *page =3D &folio->page;
>  	struct vboxsf_handle *sf_handle =3D file->private_data;
> -	loff_t off =3D page_offset(page);
> -	u32 nread =3D PAGE_SIZE;
> -	u8 *buf;
> +	loff_t pos =3D folio_pos(folio);
> +	size_t offset =3D 0;
>  	int err;
>=20
> -	buf =3D kmap(page);
> +	do {

Please let me understand why you are calling vboxsf_read() in a loop, a=20
PAGE_SIZE at a time.

I have had only few minutes (whereas I'd need more time) to look at this co=
de.

If I understand the current code it reads a single page at offset zero of a=
=20
folio and then memset() with zeros from &buf[nread] up to the end of the pa=
ge.=20
Then it seems that this function currently assume that the folio doesn't ne=
ed=20
to be read until "offset < folio_size(folio)" becomes false.

Does it imply that the folio is always one page sized? Doesn't it? I'm sure=
ly=20
missing some basics... =20

> +		u8 *buf =3D kmap_local_folio(folio, offset);
> +		u32 nread =3D PAGE_SIZE;
>=20
> -	err =3D vboxsf_read(sf_handle->root, sf_handle->handle, off, &nread,=20
buf);
> -	if (err =3D=3D 0) {
> -		memset(&buf[nread], 0, PAGE_SIZE - nread);
> -		flush_dcache_page(page);
> -		SetPageUptodate(page);
> -	} else {
> -		SetPageError(page);
> -	}
> +		err =3D vboxsf_read(sf_handle->root, sf_handle->handle, pos,
> +				&nread, buf);
> +		if (nread < PAGE_SIZE)
> +			memset(&buf[nread], 0, PAGE_SIZE - nread);
> +		kunmap_local(buf);
> +		if (err)
> +			break;
> +		offset +=3D PAGE_SIZE;
> +		pos +=3D PAGE_SIZE;
> +	} while (offset < folio_size(folio);
>=20
> -	kunmap(page);
> -	unlock_page(page);
> +	if (!err) {
> +		flush_dcache_folio(folio);
> +		folio_mark_uptodate(folio);
> +	}
> +	folio_unlock(folio);

Shouldn't we call folio_lock() to lock the folio to be able to unlock with=
=20
folio_unlock()?
=20
If so, I can't find any neither a folio_lock() or a page_lock() in this=20
filesystem.=20

Again sorry for not understanding, can you please explain it?

>  	return err;
>  }

Thanks,

=46abio


