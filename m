Return-Path: <linux-fsdevel+bounces-55718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F39B0E3B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFD11896C93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FA283C90;
	Tue, 22 Jul 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="aY1pLO3f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7121516E
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210284; cv=none; b=aQNnqM5W+qPc7zJOBjWb03UrZj0loc6ymCXMM8Cka2Anv1zSnFiezZyRICFBAJVJ2j8ZhN2UY74wzH/bRqrww++d7goRrk1GFMhuUF/T2+oepcoSyy3yWA3d0vD+iz6Romxxs2YCxxXq3do46qtwqWXocVcu21Vr5kKi6kCjLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210284; c=relaxed/simple;
	bh=WK8DYN602+GcVD91EGUlyWjmHfpP2vQ62Fan2FjfyBU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=biqccoeKMMvoxkLVdaIZHnvpD6/q7emSn+Nz9XT22CHGtc9B//xY1MwNYliQoOrFKGIAndwcpxEl15cWUjHI+ld5XkO9vuhHHq2rBXCleNe0fb5bkI7MKc8gCDCBPEH55awGwUM2rhPJRkmoTAStCC9Lo6mSjq1JFfje9rIUIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=aY1pLO3f; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e8dbdb68923so691792276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753210281; x=1753815081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WK8DYN602+GcVD91EGUlyWjmHfpP2vQ62Fan2FjfyBU=;
        b=aY1pLO3f0yIPzNJUCAyoM8QreVvTR1QXy+hiD834uLe79hc971OW6QCi/y7/nlezdF
         wQpQVgYOpFMcAk07FU6gr9Hb9dw4q94UmSI4/bwxZxfUS1I3Hm+TMffyH+tXqxyFpM4w
         GpUBT99jt9pPBhHzPm+FxPQjFdoQLph2lCITFTIbA9XoAi+PenHZ3V2We38eeoJQxCdm
         GXtYwHO+eBmdni0830E4Fn82Qs2zcCWLx2pzmVC8U8gBLFt8/13ExomcX5Qzu+fA0PNz
         EfRWFfZMMGcVeGOfGFn6DdvNHkG7aDZQXd/C0gJ6m3Z0lGEb8aMKX5FpQI8Lio7iTJmE
         NGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210281; x=1753815081;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WK8DYN602+GcVD91EGUlyWjmHfpP2vQ62Fan2FjfyBU=;
        b=Y9CQWAVpi0kXb5kqOz5LV3BPE5PfV0OZlRzfdziLMetlFwsJrakORkROuJJkPzfYIM
         2aIPdoqABaJacxPVXbm4vCOIpDoPaqKgVltjnKgncuagjVxawQzsPQl/SAb7xwrb055v
         ZtEm+v64lwyTSxNAmZwFkg3rx+1hEs4PpHATCHAj4nj07v8JgqOv1s3ZXivTtKXGCyAA
         JgjDtHOFtzwFAVrHpkwAS2YZVamhgb6aDm+x9HhlevFJf+dpc4XABEW1MQnffFPAVYdz
         nexTXWEKExE73LnFhfhv44jl+TpLbTpPEVI7zS/RlcbvOI9D2roOlU8iF0OyNVvDDmaX
         +bSg==
X-Gm-Message-State: AOJu0YxuMqlZdpqdCrz0FHTqdgNVw34SgFbqKzJxJbQsCZMbtlscqANe
	NfWBcvV77xu5r2nBIfKRQ01jS9/76Fgl4gejoM8ke28r2sm8UOsz4xgSALR5OfzC3UIUcQxqvbM
	+H1mP
X-Gm-Gg: ASbGncuudzAaEYk2RUSk2bGKKqF2oItsBBPBVWpDYOcs4q3BPjvWT8JD7exaCMj55Bn
	8hQx5Gl4rguST4ZspRm63n4EYPLlRHcsD26AOy3EecVQUNIqGKi0oImdW1Sf1w1bgQcszQ4z4GO
	OC3iDANMQwwV7P3N3C5O7KEtMjh9dTh9qrqqS2kvrC7wYxWFD8r0AKP5axIiC14sHN7jLYcgpDX
	LcU4txAgx4PCPqdrVELcHKhVNa2T8cpZX7qkHX5/Fx1AhyLf5CykcvNsMJD6nvy7WsBSszIF0+X
	WEsb0olXKmqzHZfVWKlRLNBEXc0K9ip2oofux3VbTrn6cS5LDKpucJOlCh0CeVNTqyezjuj2AY9
	pMYkCcYGTR4qGzMfdR80FS8qX37q+DDFJQ6SUYYLDmv5XLwkNj/aZslyShqrGHEjCwVZuog==
X-Google-Smtp-Source: AGHT+IFratboz2BjZXyZLG+NvQJuMYJbryhm/xSoaYQ94OrdhP0SHzFyHmacfQC/3iA06ofvst830w==
X-Received: by 2002:a05:6902:620a:b0:e8d:7b84:cb46 with SMTP id 3f1490d57ef6-e8dc59c5239mr406470276.32.1753210280679;
        Tue, 22 Jul 2025 11:51:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83? ([2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc0eb6dsm3455584276.6.2025.07.22.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:51:19 -0700 (PDT)
Message-ID: <efd70965b87382c7172495b161bfef7cfdffb431.camel@dubeyko.com>
Subject: Re: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 11:51:18 -0700
In-Reply-To: <20250722071347.1076367-1-frank.li@vivo.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 01:13 -0600, Yangtao Li wrote:
> [BUG]
> $ sudo ./check generic/003
> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfsplus
> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 graphic 6.8.0-58-g=
eneric #60~22.04.1-
> Ubuntu
> MKFS_OPTIONS=C2=A0 -- /dev/loop29
> MOUNT_OPTIONS -- /dev/loop29 /mnt/scratch
>=20
> generic/003=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch
> =C2=A0=C2=A0=C2=A0 --- tests/generic/003.out=C2=A0=C2=A0 2025-04-27 08:49=
:39.876945323 -0600
> =C2=A0=C2=A0=C2=A0 +++ /home/graphic/fs/xfstests-dev/results//generic/003=
.out.bad
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 003
> =C2=A0=C2=A0=C2=A0 +ERROR: change time has not been updated after changin=
g file1
> =C2=A0=C2=A0=C2=A0=C2=A0 Silence is golden
> =C2=A0=C2=A0=C2=A0 ...
>=20
> Ran: generic/003
> Failures: generic/003
> Failed 1 of 1 tests
>=20
> [CAUSE]
> change time has not been updated after changing file1
>=20
> [FIX]
> Update file ctime after rename in hfsplus_rename().
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Tested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---
> =C2=A0fs/hfsplus/dir.c | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>=20

Probably, it was not very good idea to combine the HFS+ patch with HFS
patches, because I cannot take this one without others. :)

Also, from my point of view, the patchset requires a cover letter.
Otherwise, it looks slightly unusual. :)

Thanks,
Slava.


