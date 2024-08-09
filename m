Return-Path: <linux-fsdevel+bounces-25521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0DB94D0A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185181C20AB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B69194A54;
	Fri,  9 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m86Usfxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598A1E49B;
	Fri,  9 Aug 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208271; cv=none; b=KgjlvXxkjZUq1pWb2E+1wpcRfowNGqYFsy/659o81/NV0MGQOEcPJxajWHVJQGHaZqBWEevTGaL2wO9S2FC2M/0aJLabshl3DFdhiwDHUhSYNLnBiW02gXMS+/6kahGHzW7uqhWpQ4hiyPhSEl0t0el9VsX1fgF4P1lV+XXEMS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208271; c=relaxed/simple;
	bh=CSzrMbctYEFVQs0E1fYsqkStZxcqns6W/2LbFmj9A0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJmoJvjeUUESXx3Xmve5m9HYMFizeRj5OSt4AO2qLi+w47bKNJ2tkLzp0bobbqWfFBzHIB+CMgdtmIR8Qfj2MgN9qJhLjd+lL8No1xRb95r1B02KcAWHmhZdTwf+4HZdXcoQqBuMVRqW7DPSU3iYS+GoSkNGLI5P4OH1Sdhvzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m86Usfxf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB52DC4AF0B;
	Fri,  9 Aug 2024 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723208271;
	bh=CSzrMbctYEFVQs0E1fYsqkStZxcqns6W/2LbFmj9A0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m86Usfxfu45xyMut71grXQ9Uc0q9aINLWZTt6pIwRmCrWfUYwghzM2K4lWW0f0SNa
	 tiDyffWDUTOI/IUKWJKmKncUT7G6AkiHLruGieprdlQhXUXwjNIwLSuXgXkBEU3D+D
	 cqyZIZ1OXPERtdRRyTJ8krPHJK4Hpkz0mgQH9dMXiCvESdnFmOmKDvVwOmR5hrGiJv
	 Rw3zoTKyB6iZBPYm6Y7utUWkKim81Nqzg19vJFfH028Fes3t6dRCzS+i5EK6cjvJQH
	 cySpyPRIOiWlOf/t+OiN/MKw9sZv43Cfc9IbYWfmzmqBtILZfsG5XuylXXuW+4aiDe
	 oeJESTbdrBTPQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db12a2f530so1387664b6e.1;
        Fri, 09 Aug 2024 05:57:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRm5Gf89MKW4t9NJ87fWJ64dT4jk0rce6s0AjjeykQnXEupOX0DFTs0NahytC2vm5TBTHmJUS4ruCUkofzY0eXhrlFesMGxzUpDhBR++oFAuhSnNCH77yhfdoaQi7bs+VFYqeHAcmU2pjV1w==
X-Gm-Message-State: AOJu0YzrbuAgM3HzYm4p2T6Lodsl4gpGAZuwaycmw6X5L6vQxMguDbN8
	Y2HpH6iwLZS/OY+oqnX53coGQ2S4DPHC7FCvHUmw4GRK10+u8humbIwHg+sRECYgoyAGDpqg4EH
	NOnp/RNVjMyTixAteVB0mYxCGOqk=
X-Google-Smtp-Source: AGHT+IGYqxsfc2RG1MLXSg/GJuChs5qgrITyVv4cIA7qDZkYsXBIRsCkZjI31n39x07FvJw+lG2LkQt5nXFGWd+Endk=
X-Received: by 2002:a05:6870:80cb:b0:261:1177:6a62 with SMTP id
 586e51a60fabf-26c62facf30mr1713316fac.49.1723208270274; Fri, 09 Aug 2024
 05:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808063648.255732-1-dongliang.cui@unisoc.com>
In-Reply-To: <20240808063648.255732-1-dongliang.cui@unisoc.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 9 Aug 2024 21:57:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8U1P_+WYfkPnO4JeTA=_V1ScrfkApJxi7F-iyOw9n-cw@mail.gmail.com>
Message-ID: <CAKYAXd8U1P_+WYfkPnO4JeTA=_V1ScrfkApJxi7F-iyOw9n-cw@mail.gmail.com>
Subject: Re: [PATCH v4] exfat: check disk status during buffer write
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, 
	ke.wang@unisoc.com, cuidongliang390@gmail.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 8=EC=9B=94 8=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 3:40, Do=
ngliang Cui <dongliang.cui@unisoc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> We found that when writing a large file through buffer write, if the
> disk is inaccessible, exFAT does not return an error normally, which
> leads to the writing process not stopping properly.
>
> To easily reproduce this issue, you can follow the steps below:
>
> 1. format a device to exFAT and then mount (with a full disk erase)
> 2. dd if=3D/dev/zero of=3D/exfat_mount/test.img bs=3D1M count=3D8192
> 3. eject the device
>
> You may find that the dd process does not stop immediately and may
> continue for a long time.
>
> The root cause of this issue is that during buffer write process,
> exFAT does not need to access the disk to look up directory entries
> or the FAT table (whereas FAT would do) every time data is written.
> Instead, exFAT simply marks the buffer as dirty and returns,
> delegating the writeback operation to the writeback process.
>
> If the disk cannot be accessed at this time, the error will only be
> returned to the writeback process, and the original process will not
> receive the error, so it cannot be returned to the user side.
>
> When the disk cannot be accessed normally, an error should be returned
> to stop the writing process.
>
> xfstests results:
>
> Apart from generic/622, all other shutdown-related cases can pass.
>
> generic/622 fails the test after the shutdown ioctl implementation, but
> when it's not implemented, this case will be skipped.
>
> This case designed to test the lazytime mount option, based on the test
> results, it appears that the atime and ctime of files cannot be
> synchronized to the disk through interfaces such as sync or fsync.
> It seems that it has little to do with the implementation of shutdown
> itself.
>
> If you need detailed information about generic/622, I can upload it.
>
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
You still haven't updated the patch subject and description with
shutdown support.
I've directly updated it and applied it to #dev.
Thanks for your patch:)

