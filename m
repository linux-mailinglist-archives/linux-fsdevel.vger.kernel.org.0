Return-Path: <linux-fsdevel+bounces-71955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC0CD8340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413333058E40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421632F39C1;
	Tue, 23 Dec 2025 05:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/39yZPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19AD23C4FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468313; cv=none; b=WDErzS3/SHW+lmp0BUXmrFUiZ/cvQi7EoI6JlUucJvNIgX07pikZg8JMff8eLpT8jvyIQL+Hb13PS+Ke05ohU97ovBQQzr8/Cl3VLFc7HCoW5edIlzryrsFsyb0o6YRWEU+NMcqS95RKME/Q52kifANU+bXSZZ4fLdtjS6leDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468313; c=relaxed/simple;
	bh=zTV5Fl6uJEq6bikfRl+2GZKAfKdgBpPPlmOrmzDQ1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpwCRtqu2dKmc6HVqG6bP5Kec4xqk7He0ajvg84Ayi1ZBYDyOl5Jgy5cSyRHYh+DryP9+PP6mkvrnV0e5ZiDxTDTV9G19l9SiGNFoXoT1fKZRyVX3snP8C2SUChejFaB6WaijuT2/mHdioja2ebA1J/JmqW1+lrto6fhLeMbA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/39yZPJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so4198153b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468311; x=1767073111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=k/39yZPJRd/lUcRJkV7mXQEWc1+ntOQZ3mgr8kFI765nq8VXzciXpYKgKPQG/tmkAM
         owjPUkIe3CFME/oQ1dh1e+schfxGr1GebTc60fpUHpvMD21xSXHx1R6rHRmQnGi7e77b
         K8gWq0Odf6lE5z7xabI1OfkODM0SiBVhCyDtkdpfiQCqP28IV5iuZ3X2EFOvRV2Gg7UZ
         OwnNQdnzXvu1PxMtIuBAX2FJOYDAFMzk3ZDVkCoSbErCXRMukkSvcsMp9nWx55EwuwEJ
         7Pdlo1cgbWzgOgds7F9Lpvihye3j+92iv8K2QF0XqTlcbb/5O/MwGRalD5ldn/b0XsSo
         WZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468311; x=1767073111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=fIK1cOK1rgxP/bjPGs1oCo3JAoR7omG74+0PK1/7bFmv6hOHjfu+eAKasK7ErBe4sz
         a42o2pjBlbQ3+223/bZqnLM2+0l7E//pSKorjKeT64bAZLjrSabubaTLsQJ2mFV0Jjnc
         1IY9Sz/BEyiYmPls60tEj7bR2w4Pi4OVAXUSDw/ZPdmg3PA02i8Ucjtjvsbr5ghV2g26
         3jI4qYbUrtXmVW4KeakfRb79Uz7SYE6z5WNmU1DWby0Qlnd19OjIW9Bz35JM7L0cZdsk
         TaS0gXMmw2Haunl+1qT0+2WWcJ8Jr/bN0L+cKo/CDFhC7zhhLVFVAJWQl6ngxZiijwXh
         ZAXg==
X-Forwarded-Encrypted: i=1; AJvYcCVPf2BUAnq6zFx4NmqflJPM0GpIKyy0fH2J2yGdLKlY3hUpied88EXSmenPvU62up5f1jB/0ROORHZG9Hug@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF6vaLbBL/S+L1RlV3QTFS/ThQKpYRoCl/pfaXDpfja0sCMTD
	vv/4Vu8e6oKbiSe9zHjqBJeme4OOZ8Fytj+uuNS4rZzC0k2ku5KIihd3
X-Gm-Gg: AY/fxX6vwGZkqOOjYyhGYdnH+CFI+RpRaynT64Jk5kCpxO3UxVdewrtnX9vPfUkfWxS
	vzT/Jh5pX17PlyY9IDFg+3gXgmVEsP0sJsesXAg15n1cdPBmRzGlzTlbhx4BQGkxna6fRhHi5qR
	/ll8W12UU3CFSUoKyZuen2Mliuucz5M9TL1Uqtam3RV7LTCzIoCZoshhvY5I6RNq0R7dvt+Y5Wq
	yPFB5Hdh575CS7c9avdSIbJ6csz5z0J2cKNWQeK8euz6EroW8MrlGDT8GNSYoa21g8xfKujS0dy
	WzN0lU3rHeGPu+Bv9hn3iN6e6EtccGgBuQQPcVlTMpVxHooLRRSWukqN0Z/cmoqNNq9vWMwpXEH
	+4sUumVY1FGyFVijflQg+HifAT5e6jr+7BOsMmqtXIC3r/Ae6k0iBAbk+y1AjoqNcaM2Pt9pNN7
	fNaKQ3RHXQwAZNKOccdx1Mr/690bhT9pmy+QEd1IMeOYLgdvZcHAduvo3P1ETcfSnA1WZn60vkk
	ok=
X-Google-Smtp-Source: AGHT+IFwAZOrVWcdz0GU+cDO+t7ewKrgjzgkHtOiGD0/poJQvRMMxSdMeBecD46MhF4AsSDjM1RyIA==
X-Received: by 2002:a05:7022:799:b0:119:e56b:957e with SMTP id a92af1059eb24-121722ac244mr18354800c88.3.1766468311123;
        Mon, 22 Dec 2025 21:38:31 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm56187439c88.16.2025.12.22.21.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:38:30 -0800 (PST)
Message-ID: <37febb65-038e-47a7-9a5b-3b4c2773994f@gmail.com>
Date: Mon, 22 Dec 2025 21:38:29 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] fs: add support for non-blocking timestamp updates
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-9-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Currently file_update_time_flags unconditionally returns -EAGAIN if any
> timestamp needs to be updated and IOCB_NOWAIT is passed.  This makes
> non-blocking direct writes impossible on file systems with granular
> enough timestamps.
>
> Add a S_NOWAIT to ask for timestamps to not block, and return -EAGAIN in
> all methods for now.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



