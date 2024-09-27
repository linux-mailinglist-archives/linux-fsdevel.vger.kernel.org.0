Return-Path: <linux-fsdevel+bounces-30262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CDD988817
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EF81C20FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CF21C1AA1;
	Fri, 27 Sep 2024 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="OaGgv9nY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjUy+z71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC41411E0;
	Fri, 27 Sep 2024 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450298; cv=none; b=kIrOL6N6Ck4JwvLHl+sQ3Z8Iv/neAd5lfe3syWtzb3Q+27brgTHLrBFQIUjSReW2l+ROPZm32K1wCuRyPUgLWAl6fpmydJSQ6cqwtW/lqnqyWL1LctFvhH8hlO/phQGuKMCvkggmHUYbIWeHI7g22Rvzd1MdFMrqOfRozL8xUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450298; c=relaxed/simple;
	bh=Au412/fFbpquOp/lmA/1fVR4HYznA9tZpqoVa2f6kL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUfaYHgQ6EayQGiib3iZFioIKU5cc5jGwwBHw4qNmhwuHqpFD9r9uljFOEkMcBoAhnZ6uPYgE/eGubJBckp3Y5ZvhEaL7UleNzKRyjw9dLov/6vfxxIsOUVOs9dsqmap+XxETC/XrURYBtYX4+XRKSEreu+t/fkAt+0Sl059wCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=OaGgv9nY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjUy+z71; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BF56813802B2;
	Fri, 27 Sep 2024 11:18:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 27 Sep 2024 11:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727450295; x=
	1727536695; bh=jcSby7W+5uYeteUvGb/mYaE5eneel7efJMsI4xZNg/Q=; b=O
	aGgv9nY/gvXmka7uEIvUyI2bcReYcLIrGXiC2EXnWt+6t/+3/pSz2aOwRahK5NGN
	S4w1LpVVLX0+T9WDe2cmujPbqbp7OfhaW9cZKw6wolwdr0KLQCU2J8X6l74GP3zP
	b71pzfbKjFsjrH0HS8yg/Buznwjlxmdg/d1W5IIHCXyjR9OgOBHq25HjgGtauHzG
	SbhTRjnAvrw8GMzHNAqjlCjcIkVu0U/+dSnoMbD1yILpYlZ6xaAJR5vu68+1Pklm
	iF2sJLkKIzeBZ37xp2MTlzV7Fwfg9GMIrAEq/t/WHbSsOkDjC25tReJRJPLMjeyf
	FqnT2H6YnE0aHR9ZPM11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727450295; x=
	1727536695; bh=jcSby7W+5uYeteUvGb/mYaE5eneel7efJMsI4xZNg/Q=; b=A
	jUy+z71oFyvq3G7NnTwpUPU9yVnmsM+V82bXRSyZUmqLXVa06AI4PYxNoge9NSFv
	MLrGAGndjUbPvblZBY6zscQfYm1qMXdPet6kSlYanG7OAvsIMUlfBkkuVixdkbl3
	tgkNxetvMtqk/LqG/NL0kmW62+voaWY0ZvZ6bP/bH80rZ+ASXo2WXGWhyHg4IgFU
	jKlIjoBkz6TJmPTZRFetKfZB6oVn6YGlzbxUvVOAnesgTGcOV7xq+MEILp+xBiVH
	qwNTNCiQGeer/Pq5C4t6sPLL0m2l/jRGdHoPNTcG9OLXOsFyUCaBj7k/Upg36h1j
	zsYSMyvxT3PUF0n0z3IyA==
X-ME-Sender: <xms:t8z2ZsMPbYRGneU6RmeB3Iv60fjN5ScCVEuw07reEi5UG-1IUZygmQ>
    <xme:t8z2Zi8EU0jwGRji3Pg3tiGqbyWfbVB_VfN_2IL5o_mgxVCFRUrXwrtqX6SSy5Ejm
    x2ZGFZr0NrUpKqy7JM>
X-ME-Received: <xmr:t8z2ZjRaz_VkZPPa-TigCr1y0XzwRu7zYXbQ6rvJrv2QIs2vcrpbxIZ3yaVMESZY7EuYmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgkeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:t8z2ZkuMJ3mb6j0Zg6OTn1vk8onkfZQ88D4FOLMQamzI8Reb3NCePg>
    <xmx:t8z2ZkfiSbncT3x4VYeGsFv2jvgJOKF3iI_jpsuTSgUYTNuyonMeaA>
    <xmx:t8z2Zo2-G_IUcqWPqHsz2_gQfllhFhqJeQ-EW7mHzvtznfPNoPXb9g>
    <xmx:t8z2Zo9hnGX1GiG2tDMsGzKdrwCg7HauSwTXnFFm6jqD27RtL5KK4w>
    <xmx:t8z2Zo2OAieCbFF6JSSCu-F0t5K-z3TbwE05FYch6oxsNrg6rjXfFtcU>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 11:18:13 -0400 (EDT)
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
Subject: [PATCH v2 2/2] selftests/exec: add a test to enforce execveat()'s comm
Date: Fri, 27 Sep 2024 09:17:46 -0600
Message-Id: <20240927151746.391931-2-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240927151746.391931-1-tycho@tycho.pizza>
References: <20240927151746.391931-1-tycho@tycho.pizza>
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


