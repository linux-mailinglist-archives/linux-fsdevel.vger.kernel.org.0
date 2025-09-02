Return-Path: <linux-fsdevel+bounces-60006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6637FB40C28
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284C0564501
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA783451DC;
	Tue,  2 Sep 2025 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLq91yAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF32D5C91;
	Tue,  2 Sep 2025 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834542; cv=none; b=XBKODpf/umJDWwE39fjzn3BwikF07mIOv/02zYVAU6ixD+wb4gqUfHJTjFbOZhxDpZoimvceYNC2gdZQAJmdK8VOshxSlTnSECkUUN3GBsBvFxMHeBKA/G7F41mWyrKq/cz4o3DE/daloG8xm/4wxt65o7qCaiflLGV7QhauIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834542; c=relaxed/simple;
	bh=1uLg6SM9wHlwTxLAk9Pnfh6IsjgG4vNt80irmefYE98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV8lyR6XaI2kHOxPajrsrerbPeQAo56tTIdTdTytTNs8yuUM5HmcqrT87rtuvxDbbD0imzf74oCeTL8Ww4Hhy2h020npf5LpNjJh4s1gwIgxDgqkqmeEenIZxMYPNx0mv9Z5fJBGRoeyfJvWKhV5fh12d5Zf6PtE21IsVoLbrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLq91yAf; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b38d4de61aso6079301cf.0;
        Tue, 02 Sep 2025 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756834540; x=1757439340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG0pcCMckkzUES3yrYvToWpEQ8sbV1Ta4J6lC1FGxwI=;
        b=JLq91yAfLI8hEQy5Fw8JXBqj3Z3mjZDpa7TKnHVc+AIVDiGnNxx9gRpWCoF3Rw9+Bh
         wtwCnZvJ4VzAWWlIeggIMTnYjOT7ZG8+bG3ZMangsDay3sS2LJFhH5k4v1YgtV8YZABm
         fTdmq4MzrAvYN0WongUdCEd1g0v87Tov1H5zhpFNZ1EkgokQlvxHC5p1YlFkO1XyeN03
         LNVkttC/WVIIyqm6QoqaQChkbMKBcMhQexAAHgfTnxM8NsTxKUYal1ysdSYRHpdXDcY2
         3N0viAFdnku8S1s+7bgNJaBYivhgq/L0OE98+c4d9hSYToMjoCMz5G6JrvmzrZ9wij8O
         xYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834540; x=1757439340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG0pcCMckkzUES3yrYvToWpEQ8sbV1Ta4J6lC1FGxwI=;
        b=SsK8HGTSufh7XcRWd8JpnGgtHwDa4iNp2U/b0f40r8+qNZcmXhFTcP9rNGdAQglImK
         toAJ0NWFi3u1d83sG1vIZxeRty1BTEUKjMl9Q1ENLjZj4td3yjHii6aoizccBloHMbxg
         vxBj24RfQECgXPjAzhenXu9B3AkmG6w+LEx5SrmCQWUmGV2D81PVbhpDWio9x3ENC6II
         DrXxoJTu/DvE3u7rlCOmcHW+NfxZ/q4bkurudSlk5hgrOcZ4O4aQcJo7nDxi3tLZ4+b8
         Qp0knQmgem+HiPsbHsaUEkNC9FQrZ9HqHfblNfscsDf9o1RshPrtxaaTC8EsM4CRXZbn
         +a8g==
X-Forwarded-Encrypted: i=1; AJvYcCVSHigRQttVkOdIJaYtu3TxpWJkmFJO32H5sMefDqEJ8pYIWdL6r/IKBRY81EYHrRa2dMiPR4orHpyI9FAM@vger.kernel.org, AJvYcCW1AQYSfUBCHRWb2PnFjqE+e76W39S3btELZg/65nxpoPJZ002nvOBaErwlBjKau1c4p3JsS9CSY5bEEt0k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/842Fdb6wVcCdOkYkZK5rZ5mgBj/3LOkRZk5QM5A0BCcxVx/
	Y+ssekn4EKMlNoPXblU3DPn/FU00sjjYhp5mNHXgVWmKfmwGkZsh6KSLDb1nLy4CpuMCnWy5/u1
	7ym9kOfGdJW2vPVCErM8Nn/JeVgMbN1MS3uRbIww=
X-Gm-Gg: ASbGncsVfsnXX8SGdubvZFIPJJWJeVMZd0n6MwwP0IKJ9rkmHzDcVqPNFpEMOdJKbcw
	j9XIaR0SgLn6XwhwjrfquASW8BebKvVahMyeAK+Fq/5wiWbucP2C4/LQ+qzGdcjTOjkucD9bkfP
	OSr1eNSnLMyHCJFksRP8UsH7dkAYG7ZlOBn+J04R1sFwjWh7/3QHDsl3iQRZ8n7A3wyZEXMwt/G
	QcwUkcHknpIEze/Keo=
X-Google-Smtp-Source: AGHT+IG83V/zpXA2LNw6WlNDJn5VcyW5hi8V6Q+G9WrYOi37x53Lapvip0WRRyvLqA7+oV/XtTfQq6ZAFsgQk6qimNU=
X-Received: by 2002:a05:620a:4115:b0:7e3:28f3:899 with SMTP id
 af79cd13be357-7ff2a83664emr1174226385a.39.1756834539886; Tue, 02 Sep 2025
 10:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902152234.35173-1-luis@igalia.com>
In-Reply-To: <20250902152234.35173-1-luis@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 2 Sep 2025 10:35:28 -0700
X-Gm-Features: Ac12FXyISaaJnIQM-rrlp7Ll8kx0SjB1vsLRPo2Pbt_WB46evREAEd8XUxTC3Tw
Message-ID: <CAJnrk1awtqnSQS0F+TNTuQdLDsAAkArjbu1L=5L1Eoe0fGf31A@mail.gmail.com>
Subject: Re: [PATCH] fuse: remove WARN_ON_ONCE() from fuse_iomap_writeback_{range,submit}()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 8:22=E2=80=AFAM Luis Henriques <luis@igalia.com> wro=
te:
>
> The usage of WARN_ON_ONCE doesn't seem to be necessary in these functions=
.
> All fuse_iomap_writeback_submit() call sites already ensure that wpc->wb_=
ctx
> contains a valid fuse_fill_wb_data.

Hi Luis,

Maybe I'm misunderstanding the purpose of WARN()s and when they should
be added, but I thought its main purpose is to guarantee that the
assumptions you're relying on are correct, even if that can be
logically deduced in the code. That's how I see it being used in other
parts of the fuse and non-fuse codebase. For instance, to take one
example, in the main fuse dev.c code, there's a WARN_ON in
fuse_request_queue_background() that the request has the FR_BACKGROUND
bit set. All call sites already ensure that the FR_BACKGROUND bit is
set when they send it as a background request. I don't feel strongly
about whether we decide to remove the WARN or not, but it would be
useful to know as a guiding principle when WARNs should be added vs
when they should not.

Thanks,
Joanne

>
> Function fuse_iomap_writeback_range() also seems to always be called with=
 a
> valid value.  But even if this wasn't the case, there would be a crash
> before this WARN_ON_ONCE() because ->wpa is being accessed before it.
>

I agree, for the fuse_iomap_writeback_range() case, it would be more
useful if "wpa =3D data->wpa" was moved below that warn.

> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> As I'm saying above, I _think_ there's no need for these WARN_ON_ONCE().
> However, if I'm wrong and they are required, I believe there's a need for
> a different patch (I can send one) to actually prevent a kernel crash.
>
>  fs/fuse/file.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 5525a4520b0f..fac52f9fb333 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2142,8 +2142,6 @@ static ssize_t fuse_iomap_writeback_range(struct io=
map_writepage_ctx *wpc,
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         loff_t offset =3D offset_in_folio(folio, pos);
>
> -       WARN_ON_ONCE(!data);
> -
>         if (!data->ff) {
>                 data->ff =3D fuse_write_file_get(fi);
>                 if (!data->ff)
> @@ -2182,8 +2180,6 @@ static int fuse_iomap_writeback_submit(struct iomap=
_writepage_ctx *wpc,
>  {
>         struct fuse_fill_wb_data *data =3D wpc->wb_ctx;
>
> -       WARN_ON_ONCE(!data);
> -
>         if (data->wpa) {
>                 WARN_ON(!data->wpa->ia.ap.num_folios);
>                 fuse_writepages_send(wpc->inode, data);

