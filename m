Return-Path: <linux-fsdevel+bounces-71485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10270CC4BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 18:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB9BE30690E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B2334C09;
	Tue, 16 Dec 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EUwOlzwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69832EA75E;
	Tue, 16 Dec 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906590; cv=none; b=q3QfMdxmK2zT7TeV+gPPu0AuLC0KBEKvmE+DtGSZHaD6nDQWsGznzWiHycBLJ3IKg+t0Vz+PgwEC40onVGKpSb2buzHUyNZZ+xjV7WvdjcmbkP/DOINMc71K3Bm1t/oOj1Cz8ywMJhE8kMyJqI4Y9v4pKErV9amOd/4aUlTlJU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906590; c=relaxed/simple;
	bh=Ey2Rn3gotBG53wIdE0ArTmJMrB/UTxoNDLJ5CmlUS/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrG7Ylpgn1WmpaohbjQ23soWbHRG7OgkRlvUtcMTDFmiVhDniSeP0xv5oz4ZhQUkJwzG72LYQzb5577at5cwG2wNiN5YZmsyuxYK/1mm3E8PUWazJBJ5p9AEvgZGPZcHyVx5s91s4+PR8V1xr3U7q20paWXQeL/vbQOPgQmcL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EUwOlzwJ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MvqD1lCTVXUJNMqv16zr6wGoF2MI4z8z1UEk6qRQycw=; b=EUwOlzwJnbhy+tcz3PbIPg9xaH
	xp9xjJozjmZQElDPeeuSJfRUSOC00QDiqJsDJ8oxQmv8jkkeWfiFmbFwpCJBt8zWjelU3IfU9ZjYc
	2/YVGjQAdvsV3lYOfCX/gVNlAQKHh/zRTzLVw3Xr1/h0CF9wpnaNU6iU7pDaU6CriB4K4ujvGWV45
	eXxC38ih0TQE2uUr2uuU18JsSYuHKIr81odJnEtWyv9Qi2bdLImlx3npm8/XHeZEQRCh5LszX3XMO
	uRskVfqkpCJDNm5atK1mUrvq7YacQtSG9tP/Ix12sxbrO6trst2vQlj6s1BgujJ7sltp6XWMV11EJ
	PXI9d9BA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVYy8-00DUND-SU; Tue, 16 Dec 2025 18:36:16 +0100
From: Luis Henriques <luis@igalia.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com,  bschubert@ddn.com,  djwong@kernel.org,
  hbirthelmer@ddn.com,  kchen@ddn.com,  kernel-dev@igalia.com,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  mharvey@jumptrading.com,  miklos@szeredi.hu
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
In-Reply-To: <CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
	(Askar Safin's message of "Tue, 16 Dec 2025 03:33:36 +0300")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251214170224.2574100-1-safinaskar@gmail.com>
	<87cy4g2bih.fsf@wotan.olymp>
	<CAPnZJGBtHf3p=R+0uxNuK42s5wteMi01Fs+0yhW3gUDMF0PC6w@mail.gmail.com>
Date: Tue, 16 Dec 2025 17:36:16 +0000
Message-ID: <87v7i6ba7j.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16 2025, Askar Safin wrote:

> On Mon, Dec 15, 2025 at 3:08=E2=80=AFPM Luis Henriques <luis@igalia.com> =
wrote:
>> No, this won't fix that.  This patchset is just an attempt to be a step
>> closer to be able to restart a FUSE server.  But other things will be
>> needed (including changes in the user-space server).
>
> So, fix for fuse+suspend is planned?

To be honest, I really don't know.  I haven't looked closely into that
issue (time is scarce) but I'm not sure if the real problem you're
reporting in your link is a kernel issue or a problem in the user-space
implementation.  Have you tried to report it upstream (to the sshfs
maintainers)?

Cheers,
--=20
Lu=C3=ADs

