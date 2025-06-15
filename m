Return-Path: <linux-fsdevel+bounces-51689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645C1ADA289
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A91890103
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27325D21B;
	Sun, 15 Jun 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Oy5SFZ+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWSEs4jV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFDEEB2;
	Sun, 15 Jun 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750004178; cv=none; b=dM0dTeSobdAlqZWVJ6cdwxA/5cY/UWwsU8aa4mzlWgWNnRG3KsnazrjIH038GCPDfDYs349BeROWedkrSqkjOrm+LomsV7h+YO02w9bjGdYxI4qEduo1CsgySxsEfGgzcif9ILAKR6C87vtQW86/OX4cbD40Oc8nliRtRbbGnw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750004178; c=relaxed/simple;
	bh=InoQ/Zajt0WdEBRxH++rk9HI2C4T6N37UHQvurnLwgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iza4lFK+lf+0uwTuehXiA6kma8d7J+Y1sxi3C3ZwNtruWAyVAt8TaqeEsjaOyoanTEMaja/Mgojd9NKBh7sQudbUi/daf8xYVt6Uv8lfaCTrFKWpo9vuzkFWgBRSJSI+iUxjyvfPKPUm7IJxn+HipOfymZKc26ZkVmmBeQ4WiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Oy5SFZ+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWSEs4jV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7854211401CB;
	Sun, 15 Jun 2025 12:16:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 15 Jun 2025 12:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750004175;
	 x=1750090575; bh=45dfx5bcEej0GfBrNIui2bDjUf+Es1RKO/wNnw3tb/Q=; b=
	Oy5SFZ+tyvvqT1WmJExY/KFHtXWfZvM6gm4zhwiEUP00B3gN/H9erN6tkTHyF2qv
	Tmm4qspZe99/9ZMBkgZmOo3fw2ohj4Pw0S3aBE/Ni/WVuwPQGjuYCrMJ1oe0USzy
	UixxPz6LNNPj3w9y2R8cgWxkMA1+hcf3ADFOz0GTIUw30tQunNlI/Rggzo+LJvT6
	eXrFIhWTT3XIgJmuBgS0H/xPrh8wZOK2EQX1u3bavrdUWNpM7dzNBe/4XN10quhm
	WDcwo6CRgXww5OvF4/p7f7VCLjVw0JUCblFGwiyTVIQfON5qxpkLp/fMzHc1PzmA
	x5+xj2tzMargQnlOPvB4tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750004175; x=
	1750090575; bh=45dfx5bcEej0GfBrNIui2bDjUf+Es1RKO/wNnw3tb/Q=; b=U
	WSEs4jV0oNVS7yyn1LalJZGe8b5TZM4RrZyJHrysSiNBuHg5kx+kQqtFmpADMGk6
	I1/JRqowaVDlbe83NOYjVX/+v/bGJ0VXYfqMIkKUWz/GvXlANoOV68InvYNiF6Yg
	i7g4sQwBazb6JT8QfAknh1wQvcsmXIlxbGAs2kzPv9vOdE5mB4oHBxnvjVs+eLoo
	1Npko0yEez+EgJhZZpOiom+bG6U9KriWvraKb97WCeGOnA+BIwXi8YqnFXCqRNX/
	4mPH030gNPj6DRe2xvTL72OBzbwLWSRUOY5RUsl51q4m0OtIv6/kbwDB7p1emsFw
	FSk/pctEynSYxeWpoIqUA==
X-ME-Sender: <xms:zvFOaAFDBs2O4ssBLYh0U4DZsF4vKhXsGXsycl_VaK48cM_gW2EaMg>
    <xme:zvFOaJWJv9YbO178ta0yLPOSwcmRgCERnNjO0BHAhDZa6hQAfhOAnaR-sjJzvyO8Y
    CXF-XXoq-NxvEremxc>
X-ME-Received: <xmr:zvFOaKLK5YeTyZOKpVzk1rab9pgB7jrRfuWHBfEBeUSFRL20QHXC8dbmyDgG_ZRW3iyw6_jR9rV270ROnMam_Pyv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpeefvdehleeutdfhlefgvedvgfeklefgleekgedtvdehvdfg
    tdefieelhfdutefgudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtph
    htthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhonhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoug
    hulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhs
    uggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z_FOaCE_IN_Sdn4lE60dnOqj8BUqAtsnQXhMR6nD1XAUg4ju1LIj5A>
    <xmx:z_FOaGVLIgYYATZFUB-BcuEkZnH3qaF_Xr_I7quddJDsz3mH55FR5w>
    <xmx:z_FOaFN0WQT2cfLrwEaUw9F5Wj0qCORI2WImGpBocmchmrBa0N9aNw>
    <xmx:z_FOaN2quuFK_isNrK050FPs2ju2ScexTeHFG8Stx2NU0L2-AbDBTA>
    <xmx:z_FOaExy0pC2Kp_GPsDsf_gzdZRE5Y0X8m5rKYacHAYBk7h5VNJQ8w9Q>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 12:16:14 -0400 (EDT)
Message-ID: <8ed0bfcd-aefa-44bd-86b6-e12583779187@maowtm.org>
Date: Sun, 15 Jun 2025 17:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/landlock: Add tests for access through
 disconnected paths
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 19:25, Tingmao Wang wrote:
> This adds a test for the edge case discussed in [1], and in addition also
> test rename operations when the operands are through disconnected paths,
> as that go through a separate code path in Landlock.
> [..]

Slightly improve comments a bit...

(Another edit to add test for linkat to follow)

---
 tools/testing/selftests/landlock/fs_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index d042a742a1c5..53b167dbd39c 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4779,7 +4779,7 @@ TEST_F_FORK(layout1_bind, reparent_cross_mount)
 
 /*
  * Make sure access to file through a disconnected path works as expected.
- * This test uses s4d1 as the move target.
+ * This test moves s1d3 to s4d1.
  */
 TEST_F_FORK(layout1_bind, path_disconnected)
 {
@@ -4866,9 +4866,9 @@ TEST_F_FORK(layout1_bind, path_disconnected)
 }
 
 /*
- * Test that we can rename to make files disconnected, and rename it back,
- * under landlock.  This test uses s4d2 as the move target, so that we can
- * have a rule allowing refers on the move target's immediate parent.
+ * Test that renameat with disconnected paths works under landlock.  This
+ * test moves s1d3 to s4d2, so that we can have a rule allowing refers on
+ * the move target's immediate parent.
  */
 TEST_F_FORK(layout1_bind, path_disconnected_rename)
 {
@@ -4998,7 +4998,7 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	ASSERT_EQ(0,
 		  renameat(bind_s1d3_fd, file1_name, bind_s1d3_fd, file2_name))
 	{
-		TH_LOG("Failed to rename %s to %s through disconnected %s: %s",
+		TH_LOG("Failed to rename %s to %s within disconnected %s: %s",
 		       file1_name, file2_name, bind_dir_s1d3, strerror(errno));
 	}
 	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file2_name, O_RDONLY));

-- 
2.49.0



