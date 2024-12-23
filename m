Return-Path: <linux-fsdevel+bounces-38068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E79FB4C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E1B165D6D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5061C5CD3;
	Mon, 23 Dec 2024 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SrGQmPe8";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SrGQmPe8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6E18A921;
	Mon, 23 Dec 2024 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734983076; cv=none; b=KHKw3gDcovhPtYXgBs5Q+IOrNRSMzkyTqeAW62xEtDo5vwbn28/PHwDjzYpO+375CzDv45wne0/jAlQDzojfTBUWQ8J6iNqbl3tPkVm+sFaKrcwS1vL9btSRH1VHj7w7uaUFvtOwbCsbAVnhDlTRfQg0YoOiHFVTX0TsEBzMLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734983076; c=relaxed/simple;
	bh=B9BsagpsZq2fM2WiY+fdvsxFY6Y9uTFmcEpzfCzQ4BI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezOj49fPKEJdU2Y/f4ba/4wuQGesCK0RSlUoxtR2tzpKuLUWsFUlb9vY2vly+TxVmGnBDTPPt9BpUosQTRxlciGvex4CMBHvX+i3qW3COpjKR0yliqHZ+QBWrEcB/PVL6vG4qZhv0FSu+aannmw2nIFGDXDWdUaEVB9/Up615zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SrGQmPe8; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=SrGQmPe8; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734983073;
	bh=B9BsagpsZq2fM2WiY+fdvsxFY6Y9uTFmcEpzfCzQ4BI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SrGQmPe8vzRx0B6f0KfdPsmJ3R269EKP5dHjpSmURLb8oACeLqRBcvgck3Fc4BKya
	 AiCXz+2WyxeiUVVIj66y63NuENpyhzxOWEV1eG3A3DPPE5d6NFfHSFlcFbSMlG4khA
	 Fzd87AsOw6uGa7tovBhPg5QBb5ZckBJ7q1MoM/og=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7B8151286640;
	Mon, 23 Dec 2024 14:44:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HHsdfa577Jef; Mon, 23 Dec 2024 14:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1734983073;
	bh=B9BsagpsZq2fM2WiY+fdvsxFY6Y9uTFmcEpzfCzQ4BI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=SrGQmPe8vzRx0B6f0KfdPsmJ3R269EKP5dHjpSmURLb8oACeLqRBcvgck3Fc4BKya
	 AiCXz+2WyxeiUVVIj66y63NuENpyhzxOWEV1eG3A3DPPE5d6NFfHSFlcFbSMlG4khA
	 Fzd87AsOw6uGa7tovBhPg5QBb5ZckBJ7q1MoM/og=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B539C128648F;
	Mon, 23 Dec 2024 14:44:32 -0500 (EST)
Message-ID: <4dc43ef3a62867b2873f89ef4164c330deba3e10.camel@HansenPartnership.com>
Subject: Re: [PATCH 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <christian@brauner.io>, Lennart Poettering <mzxreary@0pointer.de>
Date: Mon, 23 Dec 2024 14:44:31 -0500
In-Reply-To: <20241222-anmut-liegt-fe3ab4c1fee5@brauner>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
	 <20241210170224.19159-7-James.Bottomley@HansenPartnership.com>
	 <6e09c8a812a85cb96a75391abcc48bee3b2824e9.camel@HansenPartnership.com>
	 <20241222-anmut-liegt-fe3ab4c1fee5@brauner>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Sun, 2024-12-22 at 11:12 +0100, Christian Brauner wrote:
> > Do the fs people have a preference? The cursor mark is simpler to
> > implement but depends on internal libfs.c magic. The actor hijack
> > is at least something that already exists, so would be less prone
> > to breaking due to internal changes.
> 
> I think making this filesystem specific is better than plumbing this
> into dcache_readdir().

Neither would require changes to libfs.c: the dcache_readdir already
does the ignore cursor behaviour; the code in efivarfs would just set
the cursor flag to take advantage of it.

However, on further consideration I think making the zero size entries
not show up in the directory listing doesn't really help anything: they
still have to be found on lookup (otherwise nothing mediates a same
variable create race) which means an open by name from userspace will
still get hold of one.  The good news is that after this change they
should only show up fleetingly instead of hanging around until the next
reboot, so the chances of anyone hitting a problem is much smaller.

Regards,

James



