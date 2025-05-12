Return-Path: <linux-fsdevel+bounces-48703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67298AB3021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8327C3A4985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62689254B11;
	Mon, 12 May 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NUdfBMgf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88D1B0409
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747032906; cv=none; b=CGoffr4NKILN4MmH2Fi7KVmZRfS1aIXUpgK7kWDmqPjPEGEyW9WM51Lz3L03hjkLWh0/WYS8GHzjvknalGgv0eZYXlp37HSkaHwWxcZ9B6XMkIEnVjt6nCp4uGeqypda0JmhbUWw2CoQY0/sDw2wgf/CMsLqmmuVT6LYeV4JQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747032906; c=relaxed/simple;
	bh=6IVJOCu4G6FOFgbNBeN1z1zvG5MAPs3qdDS6njuvv2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1SVbjuE4tqDLNbNDl/60dzV5moLRtQiBsCE+CVChC22XWBhbOe3ianePmdu96Zp7IwesFdQbXMkAu1MoLn2cWxLhVl6jnDpkoQjP8ayv/q43LIM1Mpz4LSpSVK/nNVCpGmf5wdInIATv4WJVhwub6kSW+wSc2ay9cxRc1OnyGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NUdfBMgf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4769b16d4fbso22149651cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747032903; x=1747637703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6IVJOCu4G6FOFgbNBeN1z1zvG5MAPs3qdDS6njuvv2E=;
        b=NUdfBMgfNakJbmIjyCVXcsjFFRfPblBq3gpA1BJoexiINy3BXAX+rgYk3hPjV/nmOq
         rbDPuC615JOwArdktW6KwRUtsocYjBs1WY8vs907PFCnXPfZ7gHDGV+rQ0c6VMY6ox/R
         e4vrfKIHI3GpMdbekVJl8bLoFJTHt6bf0sLEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747032903; x=1747637703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6IVJOCu4G6FOFgbNBeN1z1zvG5MAPs3qdDS6njuvv2E=;
        b=wKNY5BgiBkyWvlbIUpaHNjAhoPKV/Ue/iXkOi9qAeOyv5U4drEo8BMxlgsNhBesG99
         rGDwHzysg8+Q501y/nxe6ZPiLQYmBzw0JY4scvpuQgUMVMTOCrH3rIyn1O0XbWpzgBfX
         Zls2c/fePuLos0z6ZjjPKjJNOvgx5J9qb17ynes06ud84dGFTjWJEmHXFgSgjwQEHjX6
         kL05lrBBXVOSuS1LllWHzZqNCno/odkwU+TY44KmGZhFdY5GCicQbeOq1SgVBm0AHlnp
         NEq9y96NKSV/cUCxenJw3Kta1yZ8SF+3U/ate7kIBabLKyJ7GTm496u5VAbQG6ewgkAz
         8xwA==
X-Forwarded-Encrypted: i=1; AJvYcCV7e6IG3Kd9FdXKdechyoLoQGGVXYL7AX01kzsUCIgqmkT1TpGgn9+EwFMV8Vu3uolcKO6gvvSoFbyVzZJv@vger.kernel.org
X-Gm-Message-State: AOJu0YxiC3yC9BA/7xpy7iwvTTBMDPe2vJ6VOTRJutHD5cUw3WiFz+zG
	CQgfDpDlLP48r/NpTvnuGIG3eOsk28Of26GHCk5HN3ykdTH7U/T4RXrja2yfSutLvSPS1WqkqRu
	u/tm0Tn2GuNqtAHiUwvCD/FtRhzP1NL1XnWn5ww==
X-Gm-Gg: ASbGncvYeRTRfB2NoMJ64BadsjB0R1KLsg+KA/veHOi9sTFaoBeQQNjXlNyp8VCDZ42
	B/fEuPKITOMsx1QJ8DOpeSIo6lIKTOcCSG1CksHM9nuGD469qotz/l63KufkMxlnXQDIfLesmh2
	wol2admUrOh7v/Cx9TLlDCiA67yTcDB5i0YfqX2pANZt8cGA==
X-Google-Smtp-Source: AGHT+IG98ZamC/T5baoB3zZX2nAzAST1wIcODI9NyEeFS8+OHJHpGTVcVAVuGpVBW0W22bDVSInjxKumR35tgcQjFTs=
X-Received: by 2002:ac8:7d51:0:b0:477:5d31:9c3f with SMTP id
 d75a77b69052e-494527d4685mr212493061cf.42.1747032903049; Sun, 11 May 2025
 23:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511084859.1788484-3-chenlinxuan@uniontech.com>
In-Reply-To: <20250511084859.1788484-3-chenlinxuan@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 May 2025 08:54:52 +0200
X-Gm-Features: AX0GCFszN6ImaT0QVnL7Dcrp2g5QJ13gSl_ygXKLhPPtb46d-8dQph4VoVYGgyE
Message-ID: <CAJfpegtJ423afKvQaai8EeFrP4soep6LrA3jZg4A1oth3Fi2gg@mail.gmail.com>
Subject: Re: [PATCH v4] fs: fuse: add more information to fdinfo
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 11 May 2025 at 10:50, Chen Linxuan <chenlinxuan@uniontech.com> wrote:
>
> This commit add fuse connection device id to
> fdinfo of opened fuse files.

What I meant is adding this to fuse_dev_operations.

Thanks,
Miklos

