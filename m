Return-Path: <linux-fsdevel+bounces-72235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F88CE9202
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE479303ADD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3C92641D8;
	Tue, 30 Dec 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv8HTK7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B724113D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767085304; cv=none; b=uqbp/fYosQV2FuY+J4LqxpXrQOrW0wXiOOEQaFTRJVBAAGLD5MgYpTpH1q2l8FYVD8wfj2KeCMW9OpRa9Nz5mOFHcHPgqQgC4RpL+H09dfejRsUFT4ADg2i3rrxgReMTqP9nZsizgIgzRfCKVujSf+WpGzopv59FqPchkpPo+Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767085304; c=relaxed/simple;
	bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGMJZ0OOWhiigChcCZnK+xSSVqMwoN+VWKygy/CNnmL1H9wJu7YZFFR06kvPntfXlYgZGRmnfjQZYyb+4037VIhqIveL14+nwXrGH+DYHH6Adcihvjdi99e5O0BcUkK8Wc/yjTPoh2m8sZPmKRFkwPwQjUW/YYJbFcMz/5cNlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv8HTK7q; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94240659ceaso2507666241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767085302; x=1767690102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=Uv8HTK7qjktLHc0cgnsvJu2893x2Vp/xh3BrR1bKSPPAg5OD7lUyCAnrm3OWA0NZpb
         ZjmeDdjD9ir2CC4hGefLDYxh8swzzFC4Qn4H5v9eI8KjUGps3FZfnS3goGEjwkSsl8cA
         bs6OE07/4xALgmS1S7OWI/GhqazPvMbWv5K2N0NzeOLCEcZBIGbVqkvbv+NOKmaVe48f
         gF+2BTADqvqU38oqu2fM7zZ1gnfbNTq7Mv8JC30WeCEcdVmadtw3UBXAtUcmZAEvhs6H
         2/NK3SZ+iVqNCmdYTap2UKvZPkemWukCYepYMmdJzrtm9BJAZhHrjp8G+pGxx6UIB19w
         UfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767085302; x=1767690102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b086kL5FRkW+7/ru6Zp9bQQk/SLFxpMvQf9iN+95lM=;
        b=As4XiYtjLt02mErPNidhax/7aZxvV7BxR5XOnwP4V2WzismR8s3Ag/jpXB4f8u7ofU
         lQx9rBLDyRO8BFMAIGYI9vUNP55VxJEd37utfsXi3SEnjXcyxwOsm00GZ9H9Tgiz/EAZ
         ApWt8215Ss73N6363/HI+/V8W2XZ7Z15NOVK+HWFqCiOCP39q+VzQ+Xz4w1x6Lv4pTKG
         aHNi883IYNKK2s08t/aMqVVn5t35HjPDt08ROcmpTlJ5ZpgrJ1zGrRb0fAyhaWYY+hZ8
         cPx0qUsOKmzlIw9vv7Cj1puf8TqTTu81mSzU/Y0salKlOZj21Fp/xwuH755iM32yAAWS
         2rkA==
X-Forwarded-Encrypted: i=1; AJvYcCWMTCG9x8Qk+o5m8zmpjA7zu+uYaTUiF6qUvK3170TMX0LqxbxAN2h4Ztznj8ty8f+BA5cvXOiHT3stJmSY@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAFx4i1Y9iJrvOUGEHb7KKK1RybxMU2dHRfquAT0JhHHatNjY
	hXL4Rc6T2sRrq5KwBjV7X6FgBS/LE7ZPwWa+gBNpB1ZzlxnJjY3kxc1Mq70yWT+rU8Zqgrl891v
	cwF4QfvfhLg5yx4oNVdvQ3yKevIjpKSw=
X-Gm-Gg: AY/fxX5ZAi0DhrUmSQ1nOQdoYjSfkyA/tTe7Fi0cZDXFZbFXp9MZwNy+tjwj5Phf0Td
	I2t76Q8twxMO6ylRs08hHxA7qRZeaLKR0WwENFbiqbBnNyDpLYE5VJ4qwn03DlHpxTH9WL+04gE
	bvCumoggBkBx19HFWcrUGWXIRjvAqfNq7iamYCt9EbnwXxo9QKcB1hULGadZxHRiuCVA35Q7mTX
	rJe1QgTL9wvwza+fBo8ZlY79/xcL2wfF7/QNeGmU9KfG/zKM2OC9nCCR0MNNyttk9G42vMx32i5
	MkEOPgd5KidhrkI671yOpn4AOoo=
X-Google-Smtp-Source: AGHT+IG2VVd2ulHKPqepblT/dcXUBuIzAvujT/19dGd3qTOe0K1RCNJYxzEAIxGbD6sVUVs0vdR/LkZE5bbIY8gLskw=
X-Received: by 2002:a05:6102:2b9b:b0:5e4:b9ff:3fae with SMTP id
 ada2fe7eead31-5eb1a6171f8mr8982040137.3.1767085301799; Tue, 30 Dec 2025
 01:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
In-Reply-To: <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 30 Dec 2025 12:01:30 +0300
X-Gm-Features: AQt7F2qmQ9Z-5a8F2Rg29NY-tgt0ZGYPV6trfPXjMIRVYLRN4aNMe6W6AAufCfY
Message-ID: <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think that even with the 2^N requirement the user still has to look
for boundaries.
1) NVMe disks may have NABO != 0 (atomic boundary offset). In this
case 2^N aligned writes won't work at all.
2) NABSPF is expressed in blocks in the NVMe spec and it's not
restricted to 2^N, it can be for example 3 (3*4096 = 12 KB). The spec
allows it. 2^N breaks this case too.
And the user also has to look for the maximum atomic write size
anyway, he can't just assume all writes are atomic out of the box,
regardless of the 2^N requirement.
So my idea is that the kernel's task is just to guarantee correctness
of atomic writes. It anyway can't provide the user with atomic writes
in all cases.

I see that xfstests also check 2^N and the check obviously failed with
my patch, should I submit a patch for xfstests first?

