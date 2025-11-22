Return-Path: <linux-fsdevel+bounces-69475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F0C7CC9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF2358524
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206102F747A;
	Sat, 22 Nov 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="L3BeEm46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18F2561A7;
	Sat, 22 Nov 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763807025; cv=none; b=lHS0YmnmZoF6wbZIqQYjEdV/Fj9jHKRNDNcsPR9Y2rX3DTis6m0rwnSnQ6REdd9fopmn0r1xZ0B5P6yajECToMy/lMm8fBfeFYImp7yaxPxdYSMtu+PVGtqfk5pFndzShIHJNrKaq9cDrgaezEdjyvmwgvsVvqx6PkbmIMjl9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763807025; c=relaxed/simple;
	bh=So76H2NNRkV/fu/vtCVJDbtqT1j8EDwdQ8QtjmIWg9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmnwQMMBj+dENDEzbhXbtYoS42rPow0EjavIuTwel8m+a+HfcLFlcyw8W7uGrfSpPDE2sClWzxSOBeoBtLAB71dIISugBfox9uJc0r9rN3us4NE8ajwhk7dFvAh/y7/aQdhSIxFPayQBtLEsZRTflj2gCkp5OlyqAi5B3AEdHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=L3BeEm46; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K3ZYCNHjYKFZNPkBE9WkmswJgAwh1WIG2xhx5q5NWD0=; b=L3BeEm46zp4j8rY38+/ayUvI7Z
	wipaT7EHVzIfXWgngbMh/hqx7iDZgwWBdx+OgXyb//DDqkjEXa/gsSo6cB8lWk6fcQaaKo7bpVCLz
	wJMDDbWG+PosBGZg/i87LrTio0n/X6yh4rmGiceNQem02Y+v3WlDKCUg7HcbW8A48MDZIIRy7loEI
	OqhnhkeSiIsQyl9BbpyBOCn+oIGFPvkoLOGbLcK7n+4xfruZgdrZAgFJjJJeIz+BLRTGWfNL1ND1J
	tnDnYDFBtbe3s+h4ssij4/WMoIuUk33n60TwrDIO/2hwmfGKv4IdQrRsCJKQO5Vrzu3Td5hLnB0xB
	rB1hbkaA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMkmH-0040da-Jo; Sat, 22 Nov 2025 11:23:37 +0100
From: Luis Henriques <luis@igalia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] fuse: Uninitialized variable in fuse_epoch_work()
In-Reply-To: <aSCkt-DZR7A8U1y7@stanley.mountain> (Dan Carpenter's message of
	"Fri, 21 Nov 2025 20:43:19 +0300")
References: <aSBqUPeT2JCLDsGk@stanley.mountain> <873467mqz7.fsf@wotan.olymp>
	<aSCkt-DZR7A8U1y7@stanley.mountain>
Date: Sat, 22 Nov 2025 10:23:31 +0000
Message-ID: <87ms4ez7q4.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21 2025, Dan Carpenter wrote:

> On Fri, Nov 21, 2025 at 01:53:48PM +0000, Luis Henriques wrote:
>> On Fri, Nov 21 2025, Dan Carpenter wrote:
>>=20
>> > The "fm" pointer is either valid or uninitialized so checking for NULL
>> > doesn't work.  Check the "inode" pointer instead.
>>=20
>> Hmm?  Why do you say 'fm' isn't initialised?  That's what fuse_ilookup()
>> is doing, isn't it?
>>=20
>
> I just checked again on linux-next.  fuse_ilookup() only initializes
> *fm on the success path.  It's either uninitialized or valid.

Yikes! You're absolutely right, I'm sorry for replying without checking.

Feel free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>

Although I guess you're patch could also move the iput():

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 67e3340a443c..f2bac7b3a125 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -199,9 +199,8 @@ void fuse_epoch_work(struct work_struct *work)
 	down_read(&fc->killsb);
=20
 	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
-	iput(inode);
-
-	if (fm) {
+	if (inode) {
+		iput(inode);
 		/* Remove all possible active references to cached inodes */
 		shrink_dcache_sb(fm->sb);
 	} else

And thanks for your fix, Dan!

Cheers,
--=20
Lu=C3=ADs

