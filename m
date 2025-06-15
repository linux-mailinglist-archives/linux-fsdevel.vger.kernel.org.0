Return-Path: <linux-fsdevel+bounces-51690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C0ADA296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F4E188DA63
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988127A90F;
	Sun, 15 Jun 2025 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="d1q0yOrV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6tymls/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437E76026;
	Sun, 15 Jun 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750005333; cv=none; b=rp7PeV6pPt0JuKFjQZ8MDkLNDv4BYX/GE7Svwbe8OTLJEU0wlMH2CeZaRYuyvAA93IpmiMFHj9MCJzfnIfJ4rAPeKzGjF3XDGllel3pDI6HivuaVZN4+y775DhHjyG0hFzN6GiRLdo1g4lXhvDWVWDlYsyxRuf00gFmCI2cl5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750005333; c=relaxed/simple;
	bh=uK/BVh9z6JKLh3rJ8b0H7M/fpkQwfgfmkMk0nGKYTEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3CacaOwPxpbl5r1G9+E0PpN57gOxHl+Ab/DX/N86RNIGAIG/2YvZiXSGTAroRKeANJ/IeotoqO69uoGkqHSMSj7v99jGtFLoiA4Rl2bANTpUK8eYtcRglfCMHNKpWV0k23O9kro0BbSqjZDLIjFMV1JB0ASfdK5musn5irroGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=d1q0yOrV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6tymls/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4E71254019F;
	Sun, 15 Jun 2025 12:35:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 15 Jun 2025 12:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750005330;
	 x=1750091730; bh=1slA+sRL5WwLQq+BNIDDbtOC9/ye5OKhLgBJm3pMF6Y=; b=
	d1q0yOrVJO0mIH6BJS9/cD+r97CBegL3+oQexqp8a/qydauSZ3SFHsY5R12qnVia
	GbpLtSKxuv0Y+Q5UAqm3SrIZzTQycNXDTg6mcGI2v9OOVPTH8nyaaEK+FIlug9vm
	/eGqbBvX2rYCGQRUsxCecpm8monX9C7Wx+tyjFGRAtXRyPSZss6h9LHcIjEMOnwi
	qUKPjXkDkPSxSpSV+3rqIxHRJwY/XOZj1tIIsWMn6MT/ZvpQcGlOjTvmvA+G+HZd
	bUfZpNayRfHTT5ApHwuPBHIgqjxkbdNDt+gek4/Ku4EE282zQT9d4XysnP/74W3Y
	/UFp6csmWFlLWL9pEuFtmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750005330; x=
	1750091730; bh=1slA+sRL5WwLQq+BNIDDbtOC9/ye5OKhLgBJm3pMF6Y=; b=J
	6tymls/KNt7jeZz9g+ghRIKq5KMzlVmkHyKjBWpCLfE8gtFSqr1OsLZKi0dLLI52
	eQjk9sXsJ/arvmG4RnP+2iXUDrnk/nHiOCRF+l1I9emiu/57neGqx8gO6zGjLDzg
	tMop2AaR8MNkj4TjLOqer9I4SGOWhVpzxiS2/JLSsYUF7MgkneVN6mOEI0zssqJK
	tPd/ATfytxiFxoiGfEYqlZ3eGlfCnZpRhUvgbNlOIuwsXLzcUdbEbCSC+SD+masc
	fr7R/fGhUY6I7bJLPqCeEyhBGI/UdsrWVtrgQK/YA3fhmru6Lgy/V7vgd2rxTQp7
	kQH6zL8y1IFfGmZQxrZKA==
X-ME-Sender: <xms:UvZOaHGhezd52E9MNxqQ3Ih5-Fc2ap6inE2FonbbLamXkaWW3iIFxg>
    <xme:UvZOaEVf0cwjH3ZunK-RK3O9bYCVDTdtmjekBYOJOJQqLkukAQCA8QUi05arpWVue
    SrziXhCQr6H2G_LV7Y>
X-ME-Received: <xmr:UvZOaJLmufGwoz_YB7Um7-mKgH7-XYSuws9PvHRF-Sa2DiUtP9MHi8QdPiYc_JeXestszUXRzbU8Tnb0MZ8ZG3tY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvgedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:UvZOaFHEyWA9QWA9nUAk-_WjAQ72ZHpBwJOrhRPN-B1u9mS2IOuKWA>
    <xmx:UvZOaNUgOfG6MgbFm5zWsihw2l5Lh4DSWnzOeHmLgcBtnEPISnqvjA>
    <xmx:UvZOaAP1FITdS6aFTes-QRAKAyVfO6KZQcWw_-ET2WhGOgabraoxQA>
    <xmx:UvZOaM2VbvzPZPiiVn-P716_B8R6PA8kQwhBMAG2XJGfz5awaQFM6g>
    <xmx:UvZOaPyWo1hzbtwHX2YBSp4QeiLOoX4SYFzvqF_d7_gT5jJUwT36-98W>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Jun 2025 12:35:29 -0400 (EDT)
Message-ID: <3080e512-64b0-42cf-b379-8f52cfeff78a@maowtm.org>
Date: Sun, 15 Jun 2025 17:35:28 +0100
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

Hi,

Since linkat also uses the separate refer check, and since it's not too
difficult given what we already have, I've made an edit to add tests for
linkat under disconnected paths as well.

Hopefully this helps better confirm that any fix we make does not change
existing user-facing behaviour (unless, of course, if we want to).

Tested with qemu as well as UML. Passes without panic_on_warn.

Signed-off-by: Tingmao Wang <m@maowtm.org>
---
 tools/testing/selftests/landlock/fs_test.c | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 53b167dbd39c..055f6de25d05 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -5031,6 +5031,124 @@ TEST_F_FORK(layout1_bind, path_disconnected_rename)
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
+/*
+ * Test that linkat with disconnected paths works under Landlock. This
+ * test moves s1d3 to s4d1.
+ */
+TEST_F_FORK(layout1_bind, path_disconnected_link)
+{
+	/* Ruleset to be applied after renaming s1d3 to s4d1 */
+	const struct rule layer1[] = {
+		{
+			.path = dir_s4d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd, bind_s1d3_fd;
+
+	/* Remove unneeded files created by layout1, otherwise we will EEXIST */
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	bind_s1d3_fd = open(bind_dir_s1d3, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, bind_s1d3_fd);
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY));
+
+	/* Make bind_s1d3_fd disconnected */
+	ASSERT_EQ(0, rename(dir_s1d3, dir_s4d1))
+	{
+		TH_LOG("Failed to rename %s to %s: %s", dir_s1d3, dir_s4d1,
+		       strerror(errno));
+	}
+	/* Need this later to test different parent link */
+	ASSERT_EQ(0, mkdir(dir_s4d2, 0755))
+	{
+		TH_LOG("Failed to create %s: %s", dir_s4d2, strerror(errno));
+	}
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_ALL, layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* disconnected to connected */
+	ASSERT_EQ(0, linkat(bind_s1d3_fd, file1_name, AT_FDCWD, file1_s2d2, 0))
+	{
+		TH_LOG("Failed to link %s to %s via disconnected %s: %s",
+		       file1_name, file1_s2d2, bind_dir_s1d3, strerror(errno));
+	}
+	/* Test that we can access via the new link */
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY))
+	{
+		TH_LOG("Failed to open newly linked %s: %s", file1_s2d2,
+		       strerror(errno));
+	}
+	/* As well as the old one */
+	ASSERT_EQ(0, test_open(file1_s4d1, O_RDONLY))
+	{
+		TH_LOG("Failed to open original %s: %s", file1_s4d1,
+		       strerror(errno));
+	}
+
+	/* connected to disconnected */
+	ASSERT_EQ(0, unlink(file1_s4d1));
+	ASSERT_EQ(0, linkat(AT_FDCWD, file1_s2d2, bind_s1d3_fd, file2_name, 0))
+	{
+		TH_LOG("Failed to link %s to %s via disconnected %s: %s",
+		       file1_s2d2, file2_name, bind_dir_s1d3, strerror(errno));
+	}
+	ASSERT_EQ(0, test_open(file2_s4d1, O_RDONLY));
+	ASSERT_EQ(0, unlink(file1_s2d2));
+
+	/* disconnected to disconnected (same parent) */
+	ASSERT_EQ(0,
+		  linkat(bind_s1d3_fd, file2_name, bind_s1d3_fd, file1_name, 0))
+	{
+		TH_LOG("Failed to link %s to %s within disconnected %s: %s",
+		       file2_name, file1_name, bind_dir_s1d3, strerror(errno));
+	}
+	ASSERT_EQ(0, test_open(file1_s4d1, O_RDONLY))
+	{
+		TH_LOG("Failed to open newly linked %s: %s", file1_s4d1,
+		       strerror(errno));
+	}
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, file1_name, O_RDONLY))
+	{
+		TH_LOG("Failed to open %s through newly created link under disconnected path: %s",
+		       file1_name, strerror(errno));
+	}
+	ASSERT_EQ(0, unlink(file2_s4d1));
+
+	/* disconnected to disconnected (different parent) */
+	ASSERT_EQ(0,
+		  linkat(bind_s1d3_fd, file1_name, bind_s1d3_fd, "s4d2/f1", 0))
+	{
+		TH_LOG("Failed to link %s to %s within disconnected %s: %s",
+		       file1_name, "s4d2/f1", bind_dir_s1d3, strerror(errno));
+	}
+	ASSERT_EQ(0, test_open(file1_s4d2, O_RDONLY))
+	{
+		TH_LOG("Failed to open %s after link: %s", file1_s4d2,
+		       strerror(errno));
+	}
+	ASSERT_EQ(0, test_open_rel(bind_s1d3_fd, "s4d2/f1", O_RDONLY))
+	{
+		TH_LOG("Failed to open %s through disconnected path after link: %s",
+		       "s4d2/f1", strerror(errno));
+	}
+}
+
 #define LOWER_BASE TMP_DIR "/lower"
 #define LOWER_DATA LOWER_BASE "/data"
 static const char lower_fl1[] = LOWER_DATA "/fl1";
-- 
2.49.0



