Return-Path: <linux-fsdevel+bounces-60217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB87BB42C03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F915832FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 21:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E52EBB92;
	Wed,  3 Sep 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ol70bpOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37A1A7264;
	Wed,  3 Sep 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935391; cv=none; b=fZ8NGwEhEY3a30P7fayjOsLC2G7ONeFXGxU0Wi7ljE/ZAbfBZglOaJKWVuJhkI7rjFAm8fZ8tOIqdBkOUioVAji1a8d6G/oY+KKIKZSjgzYYxIXg1yap4RYwN9d6ZI9v+sJI+wroEu0vykkHEOp0xtF07XfAoOWmtyy00P0fKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935391; c=relaxed/simple;
	bh=FQRiATk851DE+sQx8K9vrHHe8Nv+hN4a0iHa6RunT5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bOKHGOmdeey5ir+wUc6dKWu8Dx3yC6IcfaM++zB0yP+cJ65ESiiK+jZkBwSKI6rU5bOUlLktjd4Wh0LdUV43BadoGF2gcDFdwUe7QgxSsBhphCdJd14I66cNFGFQZ8QKhDQ17kLwtQd4fPm1EYW0FUzKP2OV6RYWEv8v53lBf1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ol70bpOK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1FCA940AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1756935389; bh=eV1vHge7txHRhdDG6zovkldYQtjRUoiVkp6bm2mfYN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ol70bpOKujxFnwZVq7Q/1s1OzTO33ELJboyfyGWxWkZlzWSo8XIp3QLiKcTR1F0K7
	 mWEA47jtPd27LMz4YoCYIYe6ubzNSDDlQLGN411bR5d5k9UH7oDZpLs7pCJskp5fJQ
	 BZgKuXkYIWDKt2a1zdcevDIsqdgg5WdNxgkgNbm41bFz4hFjU8/U0c6PzN8gNTBNWm
	 LoI4cp3dVyPBNFOd/Chu3rGyp3RyXj7RUOE5Tl6vh5irFcPqeQbr2WcgNm0sltrFgU
	 KYQrguBAWX3fjype7GXwvf/HSwsdnHKa41KNsR3S8HV9FGXY+meUWnVfppy8lZ7bOW
	 SvMF3Vlf7jEwg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1FCA940AE3;
	Wed,  3 Sep 2025 21:36:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ranganath V N <vnranganath.20@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 brauner@kernel.org, djwong@kernel.org, pbonzini@redhat.com,
 laurent.pinchart@ideasonboard.com, vnranganath.20@gmail.com,
 devicetree@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix spelling mistakes
In-Reply-To: <20250902193822.6349-1-vnranganath.20@gmail.com>
References: <20250902193822.6349-1-vnranganath.20@gmail.com>
Date: Wed, 03 Sep 2025 15:36:28 -0600
Message-ID: <871ponqkv7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ranganath V N <vnranganath.20@gmail.com> writes:

> Corrected a few spelling mistakes to improve the readability.
>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
>  Documentation/filesystems/iomap/operations.rst           | 2 +-
>  Documentation/virt/kvm/review-checklist.rst              | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

