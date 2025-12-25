Return-Path: <linux-fsdevel+bounces-72078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE61CDD3A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 03:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C1E83027DBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFD26B2DA;
	Thu, 25 Dec 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLSLhUZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6870A26158B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629924; cv=none; b=XwGeGewV5Pbr5Sjx8TvpivzxUXiGheiVgjobu14ArzAvwGghTwhWq5ghg/e9UL29Xgm/MgvSKb9TsXhopuxk67+3BbXMDhFS3u1OLe8MhsqIKi1v1iB1olV35lJKJuIRjN/wunv/ATxTYiBvFcSsRHSBstJklWUw2765S8QKOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629924; c=relaxed/simple;
	bh=5EaNLw1boL4NTSFqkjWQO37ac4uVeFn2YLzmCInRw00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDYaSOHyjcph7PLVO1PoGIsG0pXhUXSH69c+BEsg7b4XDPPxgYZ+szad+wcrTReqool3f0RLr84tOIHuLDtoNBlNDKVbHj6O/a1TT9HYQr/JRS27A5kDky/+DzGimHPF4TXK1mlPvm3f+1ptV0guWkMqr6iNYt8y9rBHKxwPLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLSLhUZU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso7251141b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 18:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766629923; x=1767234723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5EaNLw1boL4NTSFqkjWQO37ac4uVeFn2YLzmCInRw00=;
        b=bLSLhUZUMoU1LLFzL1MJWNidUb2UYEm78SHYYw1v511JemuBq579L7XXtnqUScYYMz
         IpTuyiUOjxlsl8T9iMnjIZa6Y1P5Wk1EIlQ0I0UwVnu/rG8y3hLqjIvGe95eh/pmz9Lu
         eSP9SWNJIGabq9hwWKaLucn2zbuWTgHp+QHY7H+pvrTDNfcfhk5aeqVoiIgDAea2tc0k
         5wrt+Y+WBT8JIrDX2pYk4hE7UzRNR8ErpF14qUHiQmzPBslz4AtWACXgaX+pf4k8WFrR
         I20rUTrh2B8Ix4yGFthFhqlsJWH9MX7QzYS3WwXHD/Y87WW5H2CX9v3Dvh/XZh3TcSEF
         xg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766629923; x=1767234723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EaNLw1boL4NTSFqkjWQO37ac4uVeFn2YLzmCInRw00=;
        b=ZMXK8SMEoDo4JBwttNoSp9WMjOLxymxvbsSt5RfsJZxEdxyBM3HGEUNzpXDO72Usz1
         XWwwGmKXCaW8TYtkF1w6LgSvkC8yPjJR0WYCb8vbes1vvrNqW7FBG8JN2RwWlaVI8RJx
         euDDYsuiSYIbT1ZLLYH28MsxoIavjwam9pdEuRRSo+CTQTO2Lvz8HlbSo/8pB1G1XI4b
         ByGsTMBG6sFdBivRDCxnGK3f4e0rlq8GQpiyJu36euXMgLS4wEQT7OBrMfqoIBvUdCog
         R4gPo1PjdH13+bLHZ9os9VCbr4CUJnfbgpGJlPkPEhLWl/X3tZnqSO41zXVikHYJVizM
         Z0og==
X-Forwarded-Encrypted: i=1; AJvYcCWhUeJgx/brLp28XOBqsvGEexuKHSWAJmN3qQWOIqopia2skvf5z09nMl2/O2fWzh6tESAWGStJfRhACFgM@vger.kernel.org
X-Gm-Message-State: AOJu0YyP83kWX5rBrWng59Xy7z+t7CcQ76ibcmj9GLwF9HS0FuBYKz31
	+eve6pW2n2ygNUe5Q0pzzdpCSNm89kVOdQRSmr38NJof0EYAg7adjSWo
X-Gm-Gg: AY/fxX4WvIwQgRk0NQM54XabGx3ewmOe+sX/msWDAg+GaSSSML0ZgF9yVhyNKs1+nc4
	kATPDEZdR+jpGgE4iiK8E6xNxXzWcBJk1llzwPJCSPq851L+fm4d+rDelj6Xz4nBLTQK11f234b
	eJG+P+YbQPBVAtCw/josLAe5/esa4U6Ia3DuiSGepQtgG4pjz9w0YnuNevs8hwAfKXl2o1c2dtW
	HqwaxWBpGeNQpg2nXnGLOAt/d8CzsiV3/coi1J8sCdMnhRPH51Zg5QdN23xydwU1Hh8QlpkOPXW
	/vW2pToxiHPx+JtbbcdKeLgwhmWO+3X3r624tkRMxZx4ZhJjIAlQSiYlPhtO2TvTxfYUpFt/Ps9
	EoOo6zzMb62aNgHi4MLt5ShoHqGgOciH8mhdJO5BfrGhpB9U/1lIEZjO7bG29ItD03/WgRrh2gw
	3Che75UVelaLC6ZG8=
X-Google-Smtp-Source: AGHT+IFaAgjsjhbjP/2eNNWM2vKEcw9ztrlb2nWETH7wQ+R43iiJ+Ge/5ySFA+EHIh0MPD21EXvClw==
X-Received: by 2002:a05:6a21:338d:b0:35e:1a80:448 with SMTP id adf61e73a8af0-376aa6f8156mr20021417637.49.1766629922535;
        Wed, 24 Dec 2025 18:32:02 -0800 (PST)
Received: from [192.168.1.12] ([223.185.40.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e589b0csm18265829b3a.56.2025.12.24.18.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 18:32:02 -0800 (PST)
Message-ID: <9e96db0db0fd45908c78fbc0f79fd6931300c324.camel@gmail.com>
Subject: Re:  [PATCH] hfsplus: fix missing hfs_bnode_get() in
 hfs_bnode_create()
From: Shardul Bankar <shardulsb08@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "zippel@linux-m68k.org"
	 <zippel@linux-m68k.org>, "glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"frank.li@vivo.com"
	 <frank.li@vivo.com>
Cc: "akpm@osdl.org" <akpm@osdl.org>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 25 Dec 2025 08:01:58 +0530
In-Reply-To: <966687093123e00c166afabc0a9de87e0ba844d5.camel@mpiricsoftware.com>
References: <20251213233215.368558-1-shardul.b@mpiricsoftware.com>
	 <e38cd77f31c4aba62f412d61024183be34db5558.camel@ibm.com>
	 <a817a3a65e5a0fe33dbdf1322f4909c3ff1edfcc.camel@mpiricsoftware.com>
	 <1e0095625a71cca2ff25c2946fd6532c28cfd1b0.camel@ibm.com>
	 <966687093123e00c166afabc0a9de87e0ba844d5.camel@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-24 at 17:30 +0530, Shardul Bankar wrote:
>=20
> I=E2=80=99ll send the updated series shortly.
>=20

I=E2=80=99ve posted this as a v2 series in a new thread.
Link:
https://lore.kernel.org/all/20251224151347.1861896-1-shardul.b@mpiricsoftwa=
re.com/

Thanks,
Shardul

