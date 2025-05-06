Return-Path: <linux-fsdevel+bounces-48305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0904AAD12A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC8F4623A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E521CA02;
	Tue,  6 May 2025 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="fnbmypdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53394B1E7D;
	Tue,  6 May 2025 22:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572040; cv=none; b=c4I+rZFC6WFHh2DJ2zT6QYL6MgXcgVUl5EPdd/K9He2tIVC/dB+/h/MCUV2KKkNFWti2/asyVoj6Ydlwh1XvkvTzYhgH4vRGp2vJU8GZWsQg/PPbCUXRZab3F+2f+86CfOX31MHY4CkkqkENvdjAuLUtozXxApuAvv0ez5mKrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572040; c=relaxed/simple;
	bh=er4g7lG0CcKCin37HBk7agxiSAD9+q75JnZ9b9QBRvQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=MIE2/mbUvqiH4nrM01a0gDwDNh/nkxtP6vwTWOd5f8+8kZw31JZrC7cUtTjM8oQCoRosu/fPe9vZPf/JCDdgOa254CyPTeu93kw5iQGxXMK6fCFZVFXrD4uiVK2AkW427z2EN1Z4yDMAdvj3MeEFG2qy0C+jj8inSh+ZUW0JtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=fnbmypdu; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <df978e3da9bec1a5e040448f6341b646@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1746572031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dlVv2Ar2VBYKs8dw3psHCdG2XqG4SWDL5qV2hHpRf0I=;
	b=fnbmypdu0Wl68qS2QKrPkyV/MfHS+kLHRyv8m1Sn291a7JIWt73Ket+MgJM1pMBr9Fcg60
	LchMvb7VZOTvfgI5wF4aeZDcZ9sWNDMxmf4pjFHVvsxts3U4Jh6qR1K0mI6wlFlBWZ5eEf
	Hta842SzPjJwxg/twtvihF2tzhVyQH5GexpGf4m4vN/tfqEOBsJ+la35ZjL79ecYGRcqoQ
	zkQ0tWu33KDKH07y2r0bhKMkWLteo4SsZRXLcQj0XmPWCiq+rfg+4yRcac8Go3xJBWaZHz
	SfRwITs45LELoxfukY3SOV1LWn5Kg74agNB8SfvQ2x2FIhaXtDKHId4YkyfqqA==
From: Paulo Alcantara <pc@manguebit.com>
To: Nicolas Baranger <nicolas.baranger@3xo.fr>
Cc: Christoph Hellwig <hch@infradead.org>, hch@lst.de, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Steve French
 <smfrench@gmail.com>, Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [netfs/cifs - Linux 6.14] loop on file cat + file copy when
 files are on CIFS share
In-Reply-To: <e0b7f4902af6c758b5cdb7c2b7892b43@manguebit.com>
References: <10bec2430ed4df68bde10ed95295d093@3xo.fr>
 <35940e6c0ed86fd94468e175061faeac@3xo.fr> <Z-Z95ePf3KQZ2MnB@infradead.org>
 <48685a06c2608b182df3b7a767520c1d@3xo.fr>
 <F89FD4A3-FE54-4DB2-BA08-3BCC8843C60E@manguebit.com>
 <5087f9cb3dc1487423de34725352f57c@3xo.fr>
 <f12973bcf533a40ca7d7ed78846a0a10@manguebit.com>
 <e63e7c7ec32e3014eb758fd6f8679f93@3xo.fr>
 <53697288e2891aea51061c54a2e42595@manguebit.com>
 <bb5f1ed84df1686aebdba5d60ab0e162@3xo.fr>
 <af401afc7e32d9c0eeb6b36da70d2488@3xo.fr>
 <a25811b8d4f245173f672bdfa8f81506@3xo.fr>
 <e0b7f4902af6c758b5cdb7c2b7892b43@manguebit.com>
Date: Tue, 06 May 2025 19:53:46 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Nicolas,

Could you try my cifs.dio branch [1] which contains the following fixes

	afea8b581c75 ("netfs: Fix wait/wake to be consistent about the waitqueue used")
	ae9f3deaa17a ("netfs: Fix the request's work item to not require a ref")
	b2a47dc3ead6 ("netfs: Fix setting of transferred bytes with short DIO reads")
        c59f7c9661b9 ("smb: client: ensure aligned IO sizes")

Let me know if you find any issues with it.  Thanks.

[1] https://git.manguebit.com/linux.git

