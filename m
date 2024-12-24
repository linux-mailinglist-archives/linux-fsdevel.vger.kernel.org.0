Return-Path: <linux-fsdevel+bounces-38102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E5D9FBF72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CC418854E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F321D63E1;
	Tue, 24 Dec 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ctMnb0ep";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SZTJ1lKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910C4C80;
	Tue, 24 Dec 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052948; cv=none; b=RBs/sF8zWeMT4Z+w4hRBHDlk4vMSC2tYzBy/jcA9qQBsybMDInqtRZijcw9Yax+PjaHt4z5yAZ7C8W9eplQEXnUVwVskGtuTyo6zm6mJtvDRO3cll+L0U38tN0hQTeCKcPSwPiQXWppIoUfKaeSTutq3BGsxaV/SLmhr7CdAZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052948; c=relaxed/simple;
	bh=m2IbEsVbJt2+tpFLXZd50VVxImL7PyJAbDeT4NmeizQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ev0h9c6zXOiMDqwwLYdl9l5VQZ85pFaHytf4vi25yIvHf+yu/QcpbTeMsr9ynoJuW+OTk8RY44d6eMtQYnpsXhLI1jJx4x3uu4papsNM4MLWCeweSZT2ilHRE3MGDdn/F3SyMx/3FcEwnyynwps7bYTaIYILuscsWVtqOIqs0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ctMnb0ep; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SZTJ1lKU; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735052945;
	bh=m2IbEsVbJt2+tpFLXZd50VVxImL7PyJAbDeT4NmeizQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ctMnb0ep58iZIHwTH0tIhxEbOJxmXIFG/Lt1hdrt4nwsHM8++XKn5UFOAJknYaxy0
	 6/UhdqvsyaVJa9T1rWHS5wdFa0buACmUnJgH333ABnVg6vkgdsvpg7cE0AWwr/NmRA
	 OBpzMsJUdYGBvnguE8QGG2uq95hbkjeTK/JbP7Go=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2F3DA12807A6;
	Tue, 24 Dec 2024 10:09:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id yY2jynytn77X; Tue, 24 Dec 2024 10:09:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1735052944;
	bh=m2IbEsVbJt2+tpFLXZd50VVxImL7PyJAbDeT4NmeizQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SZTJ1lKUwU3MCvQGIPCxtAztMPeaLzEzK64djujPHaMW8120Wbn039RsgTa9u1+w1
	 xfowjox1QXHqP8o2d2w3cbToF5DCk1T2QPwWypJOCheemIDK5QRtvgHx1EM21q9B4k
	 ftodSfo8KEfilFIriCm11l8dnj/mpFWmICFciOWY=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0A7FB1280659;
	Tue, 24 Dec 2024 10:09:03 -0500 (EST)
Message-ID: <03f765e9fa9cceeded1a02e12ddec68a0743233f.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr
	 <jk@ozlabs.org>
Date: Tue, 24 Dec 2024 10:09:01 -0500
In-Reply-To: <25eadec2e46a5f0d452fd1b3d4902f67aeb39360.camel@HansenPartnership.com>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <20241211-krabben-tresor-9f9c504e5bd7@brauner>
	 <049209daadc928ecbf3bdb17d80634fa55842263.camel@HansenPartnership.com>
	 <f9690563fe9d7ae4db31dd37650777e02580b332.camel@HansenPartnership.com>
	 <20241223200513.GO1977892@ZenIV>
	 <72a3f304b895084a1da0a8a326690a57fce541b7.camel@HansenPartnership.com>
	 <20241223231218.GQ1977892@ZenIV>
	 <41df6ecc304101b688f4b23040859d6b21ed15d8.camel@HansenPartnership.com>
	 <20241224044414.GR1977892@ZenIV>
	 <25eadec2e46a5f0d452fd1b3d4902f67aeb39360.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-24 at 08:07 -0500, James Bottomley wrote:
[...]

> On the other hand the most intuitive thing would be to remove zero
> length files on last close, not first, so if you have a thought on
> how to do that easily, I'm all ears.

I could do this by adding an open_count to the i_private data struct
efivar_entry and reimplementing simple_open as an efivarfs specific
open that increments this count and decrementing it in ->release(). 
That's still somewhat adding "more convoluted crap", though ...

Regards,

James


