Return-Path: <linux-fsdevel+bounces-32016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A3F99F40A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 19:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F0D2829D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D41FAEE8;
	Tue, 15 Oct 2024 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="vIMATPEG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B395B1B21AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013394; cv=none; b=r9tZjlwsKFxa80zCt/mqEtET4ifw/siF/09a4NrgdfKyY5aOqJGxkDbtLJBTxJctL2dHpQrbW4jGjkV4r8Sm4XZFMbwJUMakCV+tdt/EJwhWVNV5DbrTMcEVmOTN7a0lDMOi068kbFg5l3+BWtSVMg0+rPX9ppp7J+iX0W0sAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013394; c=relaxed/simple;
	bh=V3QjOGhb8ddh8CmfYKLKjHLpGhy3rwxZp3/nQdcF1aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/yL/5otG788i2S3ZalPdbAq9XAPKjDe2fl/zIkBKpDPx+XJJYqFDMvjoPBClMUQBzW/U91eJzuUNIpOibzh6Z9yiDrrTK4URu2re7uRSYuudUTSLf2df++vDA5VPtQssPQR9EzybiVKcZQq0VdFUF6J7x4U4c+o3R5/8b3QosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=vIMATPEG; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XSh1M0BBHz9sXk;
	Tue, 15 Oct 2024 19:29:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729013383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3QjOGhb8ddh8CmfYKLKjHLpGhy3rwxZp3/nQdcF1aE=;
	b=vIMATPEGnk0ujaOk/y8GaGICjiyJtHV4spV6vzRcp+ehgYbLvGfAOP8na6vCKmN8uUeV0z
	KmhGOTu2WAb6SFnIsGhuBFLC8A9P9PIcpks4bb7gclNL/RkXU5X3zDSqOFTqnhEXeTamC4
	w3ZF+fa7/+pIoVdJpImy23SnQR6Gi+8YwOZ+5P42RA2Sr3yQDlu2pn1Cc9yFrg30s26g8j
	SvdP5ocTnPegh6pk3HN71+dAmmwtqGgFWhMFnNJFFPyH4NcD/tGaFguuc5+ffXDZyWQrEL
	NmyiLXiT5VIe76QqQh0muoaVDlOZUM/5gVMSyK3jK6SasYUiYmhoJuJS3va3Gg==
Message-ID: <77da1ded-184c-4c94-b1fb-902bf239dc64@pankajraghav.com>
Date: Tue, 15 Oct 2024 22:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v14] mm: don't set readahead flag on a folio when
 lookahead_size > nr_to_read
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20241015164106.465253-1-kernel@pankajraghav.com>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20241015164106.465253-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Oops. This is v1 not v14.

--
Pankaj

