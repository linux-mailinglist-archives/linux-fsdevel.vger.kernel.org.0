Return-Path: <linux-fsdevel+bounces-52275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF6AE107B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 02:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5C4174D46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94441AAC9;
	Fri, 20 Jun 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZnMK5G+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF0AD24
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750380699; cv=none; b=nvSjOx4FmFvvCpgch61Co4j4lmAgh7LCNi3K9ojHkSCTxjltZtItcep9ABSP/gP5OXzm6sp7e3zgV7RvAtYZci6BLrrETQBFg0KjxP4Y32XKTzOV/fblhHamoEyRWq/ZHthQqvzuf0MYkwAdZdzKzsuTSRtzHrSHyM45ZiVYjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750380699; c=relaxed/simple;
	bh=XBfHEcK0mWjYsnnj8nv9sCwT1bjoUaVhc1XilYY5l2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITlT0A1F9Tbx5F5kQXRRKUP/kujdKMAF0CqQyU5XhVDWd0tf3kZO4GZUHKLAwUtrRUR9AuDJpna7Lzc34CiJBeTch4Zhxt2/16t7bHcZFrcBN5TlGYTagDFak5IZSyg5hFASDLY8f+V5nE41Ir6TEkLt1FHnQckHfonEszM44/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZnMK5G+A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade58ef47c0so271793166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750380695; x=1750985495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amCKKTK7Xfm9vaiLtnNoWf+4gB9P6Ypa7zFByBfugqE=;
        b=ZnMK5G+A+WEyalYQwt6JJpcaXysCvoia/8R/4lxRVhmsdzlQe4pnji9hPimg0B92b5
         cs8Vd8ETAyI8J8gPskDBALJ8qYGeuC4Zp7NFB/rw/e9W5Z23TFRM4rnTmeiH2IkKtXXc
         e07+0f1vbS4EE1B6U8dRGaXIiJahM6TLHAmDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750380695; x=1750985495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amCKKTK7Xfm9vaiLtnNoWf+4gB9P6Ypa7zFByBfugqE=;
        b=BAxnRe6dvQggofAa7/IhsaQ3jYCsUM2yG8BAnPRbS1gyy0dNal6YfCgBF7GkFZz326
         hi7cJ8lsRLjZom9MBehTB6HLIxVZlJp66B6AZcvYHbw0mpftkDooQOs589MC5+884DGv
         zO4tWInYptxIdcpT17n4P6irnZAMhrP8A3HsP/zdc9M1KGh8KjTwEOMpM2xcnhEsVvPc
         SEZnr5oHgA/mHcDdqntVEqMNBGnldiKiQ2o3kF8S7h8QQi3Z+ac3IxhVUsCNQQ6/v8lO
         0ucr3SLvQC4c1/8pCnvKou+WSvbqkcbjjT9m3Xa+ZrJg536LjJWw+4d3Bz5ZVcH9Ibls
         bfuA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ukW1zpu9/CZgUKWL3hZXdxLeE+LRXNYlVCvLcaOIjBrjGSFCZ+byi74XET8Xre8CkPx101hWNn1mJQho@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04yCOqnoJgBBF4s56XyfeiIWO3djCOJ1fw7MinfqVrIQ/VtUq
	y7O/3bj9ff7q6EwsaQLknh7XENi7PyJjjnucHOUtNiWSRdMnhLa0wwr1cVj3YVR54CySVr9tUi5
	8sVait04=
X-Gm-Gg: ASbGnctInfl+9R75c9tKzalwoSqZdKTJZTIKcw8k/JS3zzwi21pJZYJw9NfW43PFEAp
	9sgGYLKaKfPw8dDvF6ny19sbvEBReCANajEkugkaiSjHmEQ+Uzh7cif6nQLbQ+LXn/uECaotjIi
	dckXhCHnykUq8N4tl+t2biDqH71Cw86c1HVedFkUF4h1EyjDfuCJwEUm/zIb7qhu06SwH9JE2v6
	P8UGOlkxDvZEO3Aqz9cykvhJVeHNOXgZmKDtQ1Ws3aDPsUTZTwqXoPvxMyv+ueXGcwunV8fMbSp
	M+Y5muLrpwmFDyVJi6w7pma9l2v8XLng+L2XSK+8GbAj+zvuH9vUqG/vs7dUJF7tZrB+smhgD90
	qxUiYnU49wqF7ug6asd4lP9cG1s+PsgB5ZxK6
X-Google-Smtp-Source: AGHT+IFxyvGdOX1UCB+hzpT6RAUNYOUmgfps6eTbVlSB8Tut2bOX8bdOkrc7DRKuQIDk2kI1ISFL2g==
X-Received: by 2002:a17:907:968f:b0:ade:3413:8792 with SMTP id a640c23a62f3a-ae05ae1f695mr42500066b.8.1750380695284;
        Thu, 19 Jun 2025 17:51:35 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4c84sm72430366b.67.2025.06.19.17.51.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 17:51:34 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae04ce9153aso153487766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 17:51:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXopOoB7baoZNRp6cW9zEduRoIb6DkU+LgO15eqmn6lcYBzipHPwvB9349fkOsGLwlN03UBGqLHJ7AvgSM@vger.kernel.org
X-Received: by 2002:a17:907:3cd4:b0:ad8:93f6:6637 with SMTP id
 a640c23a62f3a-ae05aff9d00mr27360766b.21.1750380693794; Thu, 19 Jun 2025
 17:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
In-Reply-To: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Jun 2025 17:51:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2ae794_MyuW1XJAR64RDkDLUsRHvSemuWAkO6T45=YA@mail.gmail.com>
X-Gm-Features: AX0GCFuhpreW8drYXdBOfJBDTA2DYta__fpckLTs4pxLGozxz1PdEwH2JifGeHE
Message-ID: <CAHk-=wi2ae794_MyuW1XJAR64RDkDLUsRHvSemuWAkO6T45=YA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 16:06, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> - New option: journal_rewind
>
>   This lets the entire filesystem be reset to an earlier point in time.
>
>   Note that this is only a disaster recovery tool, and right now there
>   are major caveats to using it (discards should be disabled, in
>   particular), but it successfully restored the filesystem of one of the
>   users who was bit by the subvolume deletion bug and didn't have
>   backups. I'll likely be making some changes to the discard path in the
>   future to make this a reliable recovery tool.

You seem to have forgotten what the point of the merge window was again.

We don't start adding new features just because you found other bugs.

I remain steadfastly convinced that anybody who uses bcachefs is
expecting it to be experimental. They had better.

Make the -rc fixes be pure fixes.

                Linus

