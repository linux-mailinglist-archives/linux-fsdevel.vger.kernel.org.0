Return-Path: <linux-fsdevel+bounces-17417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289EC8AD360
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A972B1F21968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9C1153BED;
	Mon, 22 Apr 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="QoPznNJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMd37McH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C416146A6A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713807626; cv=none; b=Cdvwijs1MqgBRKyCynjvPTEz9eLp4zY8weDku7CwBNHq6mX5fAAlq4nVZkRl9Bukhmg3BFIwv8l13jef5FbCurbIzaX7HVUw+Hzh1GF4QzXKFiqLHzqV8CPYmBFtagyWiswrWgSK/jehIg8IWlhi6ynI7m1u5Fc+U48MgZzu5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713807626; c=relaxed/simple;
	bh=SlBPIMWnFBLO1HjZ+Ruxx/RAF59Rb+bSk6Sc0fppX5Y=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=qzd6eVd2tP8jZ73x3V0v2If+ig0pIb2qznIsSsxPpdz3saML4W5V5yLpVBJxnBJf2YCrWvHb8hZazmMZLTHqZXhTPrEwt+OgmlHJ58HX39u3JufEmLXjRh/NjTrxHljp3S6om0UZfPqhppo9fYlkYLjO7HINX4KsMMM9HVk4COw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=QoPznNJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMd37McH; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1EA1018000F4;
	Mon, 22 Apr 2024 13:40:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Apr 2024 13:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1713807622; x=1713894022; bh=qcpNDP0iDp
	t92iVVCaFgSI9XjRCkoTNfttQZqNP3Qzw=; b=QoPznNJ34iZ6VL4nzip75x+qIN
	JhWofI+xZv56uQn2oPI0vUAcyQgF1jBCM4EiQEKSorO+K/OWfqyb5/HTtjTu7wXB
	sD3FsEf4IBoggLZXnteHovgvKFUDsvoKyKmQBno6LjEuuxJJx49s4bCeL+H1Gvog
	QC3knZPvonekAToErPrZLgo7CjTQr5UAvg5ylVACCUFgU0C2AE10RYYKVo4v/NzU
	n2iblxljZl5fL4EKKLyaxhMOufrD9rHJqscHz65J8jdBo8kDzsWSlYjYMap/hdfQ
	cZDG6LGxiBnKdMNFHGnshx0drGd0EOuxqw1xQzihMzFf9zvvse7jabAfOGfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713807622; x=1713894022; bh=qcpNDP0iDpt92iVVCaFgSI9XjRCk
	oTNfttQZqNP3Qzw=; b=HMd37McHRuCcnnMmOWRUSuiLOSvajMRzbuk5WWKOAkWp
	ci/8IOXRpRLTsB4mK0MUgA1x+odGV9lBI8QyzXozqCTfqkQBvBEk7/I9aoF9YMba
	p7AbY4/SWTihfiLB4NOaWT3sZOr0HSwGCfzVxEjc5+zS10zDOdRQbt7U94wPR1pF
	AoW531VOy7WlNSsSBsvL55Bip5ajL4BoXDX698+2HTZEDvm2NnYHI6vaJo4VQwUM
	7oPrXshoX+tC/gEWvdkj+4twxa8rbjOUI4YeKgA+2MKnlyaPhoD/VS/Z5tQ+k0Nc
	r7Xhte9lYmdt6HTj06rDWH/hC/vLS8Ww7glcukkkAA==
X-ME-Sender: <xms:BqEmZjlMKypyKFMpalL5R2Yz1LK7dWx0ulQb3jzHTBI_vYyr7Tor5w>
    <xme:BqEmZm3GbNWQ3kBL1_mvxNceyf6oaTOSUWL94R_HDKuJQJSJTYtgsgGwD4G4CQa8C
    savRyfCs-2Wws-g>
X-ME-Received: <xmr:BqEmZprCcgM7OEOEin0k0SY3zfBWGBW3RCU70vzbkJ9GMB6gR7Jvsfv6caVhdfEZwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfhvffutgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrd
    hfmheqnecuggftrfgrthhtvghrnhephfetgfefueeltddvuefhiedvleekvddvhfeuteff
    jeegteetvdegteeuieevjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:BqEmZrmjjsk7rP2Wc3kwJhpWdg1z7G20aDTEFL4DAUR3GLa4H2S2mg>
    <xmx:BqEmZh2wo5HoyLOVMdzVVZs_yyuJgY1-itin3zqe7Hn2qXTPCkCdFg>
    <xmx:BqEmZqumjhRiQ-lwOvhi6B0n_2FEtEZ-pCD5UpE26KYmgz6jqf697A>
    <xmx:BqEmZlUqvEzpBZ1UD0kYa3t5O_arx-MkU02d81u6GruPbztQBfvE5w>
    <xmx:BqEmZqwWR3GmET-84MX5aFj0Hqn_Ww2OyZV4KJt2eZoYP47tQrqxFljb>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 13:40:21 -0400 (EDT)
Message-ID: <b923f900-3e09-4c6e-a199-05053376d7c2@fastmail.fm>
Date: Mon, 22 Apr 2024 19:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Bernd Schubert <bernd.schubert@fastmail.fm>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: fuse: Avoid fuse_file_args null pointer dereference
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The test for NULL was done for the member of union fuse_file_args,
but not for fuse_file_args itself.

Fixes: e26ee4efbc796 ("fuse: allocate ff->release_args only if release is needed")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>

---
I'm currently going through all the recent patches again and noticed
in code review. I guess this falls through testing, because we don't
run xfstests that have !fc->no_opendir || !fc->no_open.

Note: Untested except that it compiles.

Note2: Our IT just broke sendmail, I'm quickly sending through thunderbird,
I hope doesn't change the patch format.

  fs/fuse/file.c |    7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce4157640..0ff865457ea6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -102,7 +102,8 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
  static void fuse_file_put(struct fuse_file *ff, bool sync)
  {
  	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_release_args *ra = &ff->args->release_args;
+		struct fuse_release_args *ra =
+			ff->args ? &ff->args->release_args : NULL;
  		struct fuse_args *args = (ra ? &ra->args : NULL);
  
  		if (ra && ra->inode)
@@ -292,7 +293,7 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
  				 unsigned int flags, int opcode, bool sync)
  {
  	struct fuse_conn *fc = ff->fm->fc;
-	struct fuse_release_args *ra = &ff->args->release_args;
+	struct fuse_release_args *ra = ff->args ? &ff->args->release_args : NULL;
  
  	if (fuse_file_passthrough(ff))
  		fuse_passthrough_release(ff, fuse_inode_backing(fi));
@@ -337,7 +338,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
  		       unsigned int open_flags, fl_owner_t id, bool isdir)
  {
  	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_release_args *ra = &ff->args->release_args;
+	struct fuse_release_args *ra = ff->args ? &ff->args->release_args : NULL;
  	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
  
  	fuse_prepare_release(fi, ff, open_flags, opcode, false);

