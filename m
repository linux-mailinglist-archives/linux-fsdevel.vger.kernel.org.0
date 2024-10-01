Return-Path: <linux-fsdevel+bounces-30508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2495098BEC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916381F22223
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8C1C7B6C;
	Tue,  1 Oct 2024 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="gN5z/a/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHVl+I89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447951C6F70;
	Tue,  1 Oct 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791173; cv=none; b=QWgrExISf8FTtu8DdQ4HLMGQITUCR+UBB27RMti2054kbbfxShYeoE5JY3OxpWeMaWXGFpa/RCMseKTzFdnN66XqLN7ZLC39amMxVNU2rf+yCk8wOhCausBSusmrx40dTHRObOf4g4QCIHMY9MwdgXuwCNe+K7uhkaJUK3lRT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791173; c=relaxed/simple;
	bh=Au412/fFbpquOp/lmA/1fVR4HYznA9tZpqoVa2f6kL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpfHx4Q2Yis2TvNrwZE0J0MzjOBOgkIzNVJ2rSRu76/xOXforipdJn3CSgefQ1DgL0by6q2YeDgL61/pasMwLD3ha8FM+7w3JTb7F1PRgyiICMwh+IqvbpXBWYPkfTbt4htd4byxnijd60IL97Y+7JzM3iFYG5OzoawLBCjG5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=gN5z/a/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHVl+I89; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60FD011413C3;
	Tue,  1 Oct 2024 09:59:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 09:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727791170; x=
	1727877570; bh=jcSby7W+5uYeteUvGb/mYaE5eneel7efJMsI4xZNg/Q=; b=g
	N5z/a/iyRdao1WtZNXNECk6YIAmT7yLSEGJP3YhwYvDJKvJYZ0XhzasPsCbSVXPk
	0dD7JBoaOs980RnGLrtTZ/18RTNe29uptwG35eF6lHIrr/EAB09lv9Ydlxr4srNH
	XSFIusvwFwD6oIPJmniPtL4vY2VRDDGDipfJYyOAKHZcK/aKWg8pQ5GMMB7VuVKx
	xGzEBetglynBN3Hcppu0M6gzFIv/NXqHQLu3WsWT5VdZRtJkkTpGHMfyw6l8uY0O
	NV3IohKYhg0U5I0dMfOss7TFczldK/NN5i+UUzzh8jQjt7VfyUVs4m+FPs0oHe1U
	7ms9+TEa5R0jRbUyqAOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727791170; x=
	1727877570; bh=jcSby7W+5uYeteUvGb/mYaE5eneel7efJMsI4xZNg/Q=; b=A
	HVl+I89YBj4SHx7zwYhyOy7tAg9w5f5A9DTKUEqiD5WauZOKPX9tMPT9bZ7xx6Zu
	Aw80Iy3SKIDkaall/OlIQr4ViRM7376x1B0LVXr5DX9BMSMbSsbm2fj6/QbsuV8s
	LWMIbwc4BF5TGu0ajlUO8CFMw90PWNb8mNQH6wzw5j6moVjf6+kB5qQkHu3g3cus
	EImZvX4QIZgA/ezV1zhd0LXuxPxvqrtga+WAwLqpYTBM3/h5RQafN5otyLm7N2oQ
	yrHOoNBRO3OF3pk6tOEM9UXox1hFrahkb16Ll3bW8cbKOCaUB0frDkoz0+Nv2Zgc
	lKpr/aDbdrOr7/vKTi2Ag==
X-ME-Sender: <xms:QQD8ZqWbDk82-avuQbk40sqIKjPMB7fV-brHKe6ta1QFGyLp5hmHgQ>
    <xme:QQD8ZmmfIKOkS4YKVJ2cG6hsfwi_jvjcYCphqShMTZSD20eo2wuyT1Is0GB0I-35t
    CvuADBNn49wZsleXcQ>
X-ME-Received: <xmr:QQD8ZuaNSL7u00nDc3uibjFWZ354cI5FzaVkNKyeB5Qg4y6ywy32daQyESy5VI-Qv6QJEPT9yiN9KMJt1yNboNpZ_y_zIRnQJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepvdegffehledvleejvdethffgieefveevhfei
    gefffffgheeguedtieektdeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiiirgdpnhgspghrtghp
    thhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnh
    hivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepvg
    gsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehkvggvsheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:QgD8ZhV7TL1IOVGojztA0cmrDmIYw4eRPUzMD2KhDj3XJWv-QgNMdQ>
    <xmx:QgD8ZkkKxTmeeQTqNSekYUW3i0bIEjCi14nuqOn15iFkfmjoDrBc-Q>
    <xmx:QgD8ZmeTVeqGTL-qxXRWgAQcVHqRAs9ujBxyJbD_3ahfsz-_kSd_6g>
    <xmx:QgD8ZmHeb1BiFUrnIXEMUAP9O9rPmdsEO_dnWjv4maRBn8Skfv5hGg>
    <xmx:QgD8ZudNI9Q_IJm1z-mDjEBt-oJZaTFSn_fxo3jux-kZPKrKszzg9lOZ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 09:59:28 -0400 (EDT)
From: Tycho Andersen <tycho@tycho.pizza>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH v3 2/2] selftests/exec: add a test to enforce execveat()'s comm
Date: Tue,  1 Oct 2024 07:49:45 -0600
Message-Id: <20241001134945.798662-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001134945.798662-1-tycho@tycho.pizza>
References: <20241001134945.798662-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

We want to ensure that /proc/self/comm stays useful for execveat() callers.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 tools/testing/selftests/exec/execveat.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 071e03532cba..091029f4ca9b 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -419,6 +419,9 @@ int main(int argc, char **argv)
 	if (argc >= 2) {
 		/* If we are invoked with an argument, don't run tests. */
 		const char *in_test = getenv("IN_TEST");
+		/* TASK_COMM_LEN == 16 */
+		char buf[32];
+		int fd;
 
 		if (verbose) {
 			ksft_print_msg("invoked with:\n");
@@ -432,6 +435,28 @@ int main(int argc, char **argv)
 			return 1;
 		}
 
+		fd = open("/proc/self/comm", O_RDONLY);
+		if (fd < 0) {
+			perror("open comm");
+			return 1;
+		}
+
+		if (read(fd, buf, sizeof(buf)) < 0) {
+			close(fd);
+			perror("read comm");
+			return 1;
+		}
+		close(fd);
+
+		/*
+		 * /proc/self/comm should fail to convert to an integer, i.e.
+		 * atoi() should return 0.
+		 */
+		if (atoi(buf) != 0) {
+			ksft_print_msg("bad /proc/self/comm: %s", buf);
+			return 1;
+		}
+
 		/* Use the final argument as an exit code. */
 		rc = atoi(argv[argc - 1]);
 		exit(rc);
-- 
2.34.1


