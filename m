Return-Path: <linux-fsdevel+bounces-59337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BD2B37878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F63BB8D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 03:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392C30749E;
	Wed, 27 Aug 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwmiD6sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5871AB52D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756264402; cv=none; b=l21nUW2X9PiS41/oXmH+HI1l8aKbsrXSXuHb3P/wlUFKJbpExyhXxyNKmXU+TIaUP7eS5FfmbEu5HTGgPNZ+ZtO02d7yd2FC6Y7HWSRmY1HuTYu5xnxtaDrB4cJEfIDnX6vvG9GxHeEuo0EgF59bcFMjdj95mXfXNoBoWEWuccM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756264402; c=relaxed/simple;
	bh=aPLKW75+adg0/YV0HGh5cTV3gO1o8TBBS+Dc+9jK/G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEj+i1AVmeCbrEdOEifPQmaAvJxJYyqL/AMELPcSH0dGmVRhVchvRy2XoGSFyIgLp+ozuESnr21Y6pKqBoeQSOu18rtcz4jNcybaCtqlc+3BWxSQDVWDF6KSYIr0zf3eRewbFJ7PqM1wWsj+S1HJL2Y5J0063cvgwU3iKq+qDYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwmiD6sf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756264399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg12dc7FGsxg2cEXvFrtAlEITELVLt1bMnDwTAUgL2w=;
	b=cwmiD6sfBUA33Ct7hxvWi9HD7eKu2W5xjvMxagQnUmrjdwt65/2TTe0DJm5hTDRlP5fEBU
	bkN4LwIWEJ537O/YTYKH1WqfP4Q2csC7OcZy5IL0QW/CprHE4billG48+W8JyV5p9a2Wew
	+8A/oUG5nVkrKijcbpq/6bjDhjfcnvw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-V9reDnrXOIibVB6-E8xj4w-1; Tue, 26 Aug 2025 23:13:17 -0400
X-MC-Unique: V9reDnrXOIibVB6-E8xj4w-1
X-Mimecast-MFC-AGG-ID: V9reDnrXOIibVB6-E8xj4w_1756264395
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3365f8a094bso14633331fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 20:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756264395; x=1756869195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kg12dc7FGsxg2cEXvFrtAlEITELVLt1bMnDwTAUgL2w=;
        b=ANsPt5bjvmVdQ8SVlh3007meDHD1gdW2B+mUsU21GpUNbUomK/h4RFcPN+um8HUH4U
         2yOtZQu/TzHONJKzCBCLayJuChucHe9gQjTg/YIyw9nWqSUC9y5EJW3gvfcBHmZt8nmo
         kP2c3yibAeDZU67D0WYoMCFUY++mwD8PLaGQhLTV525uCN8m34ednK1jTVb5RxSIF+cO
         x/oFXXCD3L/aM+watCqrNBK4iU1xMBS0xQbO/30PJXmz6rrzP2fpvjdRBQSpWHrsIIkA
         aEJqmoPtO5UTcqJUinG9LfS3HBgtOJiDE0gC9uP5idt+gZze5tqHqz+g8boRY7q+XSr7
         lRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd+Y1D0CWocnaZTY+MvIAR2BcQbfusvTSXv44RFX/5GfA5nR4o5jy4bsBfDM4XC0bE0UeuyoaxEWNYOuAU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Tv0DrrP4mbtdtL41g79HxfQ2jf/4W40wiMurdxbhezHCNNFi
	lp7hrUrSgXeRN50ngXylJ0Es3ZUgTnxkFZAzrtSYO1cr7rXDL7IVR3a2Pgtykwe0glQCl8lbh8V
	m34eMPaQLCr0zgtl/EtuOFQVhCjFpJ1SyQlPKOdmsA/mnA9DTFEscfXA4PmqFIcdsZ9ot0pv/9u
	6aNmxaIfL6OQ1g1CXW/VoFgTykRzLWdrxxMzaIRSpDkA==
X-Gm-Gg: ASbGncucoxqZHdMvhSpMeCiIBsXq3/+QK/9e9IC7ZLjAql0oZDd7j3W8dZL/sKtlsnr
	GvPYt+Fw9Zlmjd6CuGViZzmbQ6xFFoU5A4J/41fDxbJw+cof8vv9b+aGFGdO4pq0FRVpTvRTGVL
	6DDLGgJbNjN2nluV+hIAmmIQ==
X-Received: by 2002:a2e:bc1c:0:b0:336:6739:bfb3 with SMTP id 38308e7fff4ca-3366739c241mr37467231fa.42.1756264395306;
        Tue, 26 Aug 2025 20:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwL9asrCb30GtiLU63tnVNtdXq6YLZHU/N4ALzSlaz37rXXjcT8tNliezQroDpGEELRyoE/R2PLgx6pJiOvlM=
X-Received: by 2002:a2e:bc1c:0:b0:336:6739:bfb3 with SMTP id
 38308e7fff4ca-3366739c241mr37467191fa.42.1756264394875; Tue, 26 Aug 2025
 20:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827025939.GA2209224@mit.edu>
In-Reply-To: <20250827025939.GA2209224@mit.edu>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 27 Aug 2025 11:13:02 +0800
X-Gm-Features: Ac12FXxyq0rlPWzcAsl2hibY4PT_vpCJFYSBtvC5vmWqeafX1BtyyM-a6hwPslY
Message-ID: <CAHj4cs8BWKXQfch8EXQVZLDD51uMg2yY9caOsb0b3n+uTXXaMQ@mail.gmail.com>
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Rajeev Mishra <rajeevm@hpe.com>, linux-block@vger.kernel.org, 
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, Yu Kuai <yukuai3@huawei.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Theodore

It should be fixed by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3Dd14469ed7c00314fe8957b2841bda329e4eaf4ab

On Wed, Aug 27, 2025 at 11:00=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrot=
e:
>
> Hi, I was testing 6.17-rc3, and I noticed a test failure in fstest
> generic/563[1], when testing both ext4 and xfs.  If you are using my
> test appliance[2], this can be trivially reproduced using:
>
>    kvm-xfstests -c ext4/4k generic/563
> or
>    kvm-xfstests -c xfs/4k generic/563
>
> [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/gen=
eric/563
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-q=
uickstart.md
>
> A git bisect pointed the problem at:
>
> commit 47b71abd58461a67cae71d2f2a9d44379e4e2fcf
> Author: Rajeev Mishra <rajeevm@hpe.com>
> Date:   Mon Aug 18 18:48:21 2025 +0000
>
>     loop: use vfs_getattr_nosec for accurate file size
>
>     Use vfs_getattr_nosec() in lo_calculate_size() for getting the file
>     size, rather than just read the cached inode size via i_size_read().
>     This provides better results than cached inode data, particularly for
>     network filesystems where metadata may be stale.
>
>     Signed-off-by: Rajeev Mishra <rajeevm@hpe.com>
>     Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>     Link: https://lore.kernel.org/r/20250818184821.115033-3-rajeevm@hpe.c=
om
>     [axboe: massage commit message]
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ... and indeed if I go to 6.17-rc3, and revert this commit,
> generic/563 starts passing again.
>
> Could you please take a look, and/or revert this change?  Many thanks!
>
>                                         - Ted
>


--=20
Best Regards,
  Yi Zhang


