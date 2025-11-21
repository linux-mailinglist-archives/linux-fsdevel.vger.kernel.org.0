Return-Path: <linux-fsdevel+bounces-69377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD3C79208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2162934F526
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A53431EF;
	Fri, 21 Nov 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QFUx4fh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A92343D9B
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730190; cv=none; b=eehbB+EoIHbBS68mw0ek3dMPsg8zooJDKqae0cDy5Pm1un/6Q/eCzYHpYfUcVQr2nMuAOlCOXjaBcYZePqHmNE+hx53mda67g2hw35mehIaiwqLziS8fztJEwu37KvfsVyO4WvCDKeIX9xLjT9gxUCYa5TNOPtovypjY+zfjIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730190; c=relaxed/simple;
	bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOFeznWRWlcAbjXL23UoKIg6HdzNNf3Wab3OqV7NCJ0C7ijiwa0n8y3KVVjgYnmHQO6v5HYCj4JLe6A3o8+YWi3NCu1ZO2wjiD+byJ0ZCY5s00Rv8ugfUMx2TVy8W9J5/Q+0pysQaxhDLsiZFxBGP08JXZSXx4fYmL3bw3XWQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QFUx4fh4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so12347205e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763730186; x=1764334986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
        b=QFUx4fh4YCD5UE1/uehzPoKxMW0qLKeaDtTAwwXWN7f5V9z+KakJ2nGk+Rj+3Nfmip
         V6OqdGFZN070ieMOEg6rzUpNhLQ/axXXp0F5H6tns5+UWOruK8XjnwrG8ZRwiwQGDTMd
         yW29K1l3bJ9WdI44Z1MwR/tXr4jyVKh7oJTBm34OcQvsSzvC48fU5hvjKPm0dLwihXbp
         AqwWaO4x9ImsyFBAGzu45Jb5UkjrtbI4GcoMhiIa2iC0S0suUo+bWvP6t0W5PtrJhJWL
         8uR4f6zMRbWn4J1AiPFqtrle07yecLBaTUTnjY4JTFsBXwMzQ+qJF+R/repYvRpYIDzU
         c4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730186; x=1764334986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE8inZJACUTjbhJ7R5bdkx+O4GyPgbuPgpvQX5rm+4A=;
        b=SC1qC+Pt6KJpQY2RcWEPoDn+1VbtWZwHFXo47+3zXBNsb7rz7dvwW+cz1HyAhWDn3H
         Iy0+4KEXVtARXTDBc8YjZlb4cwDz+Jp4bmpIuPG0Tq667YjrpAq9SCTj1Xcro7eMgM2v
         z1J48bjPWmWjpCrirULkr/aep4Mg0/x6586dlatsIA6rCn0WNKn6UcIlITr76Sz5WPkO
         7VHkbkezNF2D88AQfEXDL6W7GBV6d+ltUSjE+42un5WKiXNUVLaOVpJjXBEiysXD/W0q
         0seowbtne9FBGFnnJA+j7Cg5a9HHgelx527aLC3hW1b+7DO8QUOYCU0UHvC3FJpq7dS0
         egyA==
X-Forwarded-Encrypted: i=1; AJvYcCUZpbIeDSlqQ4UTqZqcd5mwFWz+G4nhQN9ZNDazZQWh5v8s9H48exSQ9JZJO2HziRKIorlF9V3UF3GSA1DP@vger.kernel.org
X-Gm-Message-State: AOJu0YyxH1zNZYNvR1mlBjgRyahU5i+AQ8czNLZoocgaP+dIECgsrwUT
	e36wSKyLMWdYSRr/BNg8QN1vQRZHzHprTJ91lpj4Rp1nSIP40v7y4geequVKsMtmBHWyjnp2VeV
	DNcIvO7ZEj/uGEJ9rhFPTW8sJYNLft6HAKxnozxn+jQ==
X-Gm-Gg: ASbGncvanjo5cD2hlll9XyAnVYCKRfzUbAOrbKiUuQ5gTrC/qCQ2yJeuofNc9/UypdA
	nA2lm2OG4pP/hlnN8+Bwa+Xle/Lxy1pSveZAvX3BRgoxp3Nyc/w3p21S+V0VK5OfwbVcqt+yJia
	JGWJA+nI0HXPbukcRsAYfLqVkCM1yt3fFe3Fhjsyb9SXo8M0Yv/ala6ieSvX91n1qGyPp3ygmVr
	K8KyE9Yc2KQO2M/gjiJMhEKcVobzgpXiIBJ552lFJg1WaFTaDMLvnFcsTG5WyDsCqoVPg5f8blV
	DUtrfkeKpL+wwZxebHmyKDgBhCKadRBvsII9KCNUw/Tf+6L4H0d/SyDEIiET4UjFA3n7AseswNb
	E62Y=
X-Google-Smtp-Source: AGHT+IFKvlzMGUOsQjurJJO1/ddu129s8U6J9Qzr1L7YObQFc0ULUukUbdKdK6XW7KVAHd+E0Lj6QT3HD9PKGyA2iIw=
X-Received: by 2002:a05:600c:4e8e:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-477c0180d42mr21139625e9.10.1763730185944; Fri, 21 Nov 2025
 05:03:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
In-Reply-To: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Nov 2025 14:02:54 +0100
X-Gm-Features: AWmQ_bmlrTSQRB-IyIJw_d7QEyrSrCi1L10PR-iyaSdF9L9qt__gjWsRdUJNCmQ
Message-ID: <CAPjX3Ffrs28a6wC3PvtXpPy5Hw9pOmGYqchpg7WRtTwdDo1mgg@mail.gmail.com>
Subject: Re: Questions about encryption and (possibly weak) checksum
To: Qu Wenruo <wqu@suse.com>
Cc: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 22:58, Qu Wenruo <wqu@suse.com> wrote:
> Hi,
>
> Recently Daniel is reviving the fscrypt support for btrfs, and one thing
> caught my attention, related the sequence of encryption and checksum.
>
> What is the preferred order between encryption and (possibly weak) checksum?
>
> The original patchset implies checksum-then-encrypt, which follows what
> ext4 is doing when both verity and fscrypt are involved.

If by "the original patchset" you mean the few latest btrfs encryption
support iterations sent by Josef a couple years back then you may have
misunderstood the implementation. The design is precisely taking
checksum of the encrypted data which is exactly the right thing to do.
And I'm not touching that part at all. You can check it out when I'll
post the next iteration (or check the v5 on ML archive).

But I'm happy you care :-)

--nX

> But on the other hand, btrfs' default checksum (CRC32C) is definitely
> not a cryptography level HMAC, it's mostly for btrfs to detect incorrect
> content from the storage and switch to another mirror.
>
> Furthermore, for compression, btrfs follows the idea of
> compress-then-checksum, thus to me the idea of encrypt-then-checksum
> looks more straightforward, and easier to implement.
>
> Finally, the btrfs checksum itself is not encrypted (at least for now),
> meaning the checksum is exposed for any one to modify as long as they
> understand how to re-calculate the checksum of the metadata.
>
>
> So my question here is:
>
> - Is there any preferred sequence between encryption and checksum?
>
> - Will a weak checksum (CRC32C) introduce any extra attack vector?
>
> Thanks,
> Qu

