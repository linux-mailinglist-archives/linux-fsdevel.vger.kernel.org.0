Return-Path: <linux-fsdevel+bounces-71328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9830ECBDBE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3956A304E56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD7322B6F;
	Mon, 15 Dec 2025 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XADgtCdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57932572C;
	Mon, 15 Dec 2025 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800513; cv=none; b=evhCyDc4nr5sAFpGpiZQ/1Ar5sYPWVqTvxI85xsm1esdedZCGgsgsXPnOUjlU4TB5uTGNht3DTcmTE3mmgud8ZYd+tcu01EqFRHukVUVgQlh2hez5jmNJK42IdV847Ien8DIlCCw/FF7IMuYd1c0FbijN6bi7V6B32K20XenRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800513; c=relaxed/simple;
	bh=yRIgCYQLVBD9z85rGTWt0O11vXVwSsdI3JIVMPGCLj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KS8/Gp2EE8CxRdsLuaHBT8KwfogTCB6xCmq3wVG3IacJJWxRlCMrgoM/FSBOTRXDGGw0pa12Ujv9VFDHdWk0NEBSGl2NoQJC6t+QEEeyA80eGNQFj8B9gDBgmZ6xDkVEtSVsrjYtLwwBq+sz1S7KdbQnBwNFUmYJZOLEB/sY7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XADgtCdH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kkzNJ++9ijF0dFCIoTbUbgAaxtby2iaPSTIICN2jk/0=; b=XADgtCdHLdX4TdEP/pBqhIuEWK
	8sOM48/IGbY4HCDktTGs8zd1Ap0H7CKD4HdXMUHyAbB4jtdyAOWyI0g1/wIK/4gHKuNI3Me1Th5kS
	vp8ZWmwU2jUMAaQ6561S6yHJV0dnSqlzYUKYLkcuwH3LDz1eiy4ARMMz2E/PwPKNvtbY6FYZJW6rX
	DFco4SgY4eyCKOI36w9LIeNxab0a/5mV4DMCz87/9QdMJuVaFJbyiFpNA27WBjLUOQQ9HADU2pMRB
	6wj2vkEi5iox3Pw5QumdgNJ9SYdUJbQklvTyvInqaPFGspUBR7nDC0QvzfLIHvK2uj0Ea+Jnol3gf
	vhXlUapQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vV7NH-00Cva3-0u; Mon, 15 Dec 2025 13:08:23 +0100
From: Luis Henriques <luis@igalia.com>
To: Askar Safin <safinaskar@gmail.com>
Cc: amir73il@gmail.com, bschubert@ddn.com, djwong@kernel.org,
 hbirthelmer@ddn.com, kchen@ddn.com, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mharvey@jumptrading.com, miklos@szeredi.hu
Subject: Re: [RFC PATCH v2 0/6] fuse: LOOKUP_HANDLE operation
In-Reply-To: <20251214170224.2574100-1-safinaskar@gmail.com>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251214170224.2574100-1-safinaskar@gmail.com>
Date: Mon, 15 Dec 2025 12:08:22 +0000
Message-ID: <87cy4g2bih.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14 2025, Askar Safin wrote:

> Luis Henriques <luis@igalia.com>:
>> As I mentioned in the v1 cover letter, I've been working on implementing=
 the
>> FUSE_LOOKUP_HANDLE operation.  As I also mentioned, this is being done in
>> the scope of a wider project, which is to be able to restart FUSE servers
>> without the need to unmount the file systems.  For context, here are the
>> links again: [0] [1].
>
> Will this fix long-standing fuse+suspend problem, described here
> https://lore.kernel.org/all/20250720205839.2919-1-safinaskar@zohomail.com=
/ ?

No, this won't fix that.  This patchset is just an attempt to be a step
closer to be able to restart a FUSE server.  But other things will be
needed (including changes in the user-space server).

Cheers,
--=20
Lu=C3=ADs


