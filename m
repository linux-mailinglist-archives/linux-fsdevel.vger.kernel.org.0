Return-Path: <linux-fsdevel+bounces-33297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054B9B6DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 21:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202BF281B1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0711F12E0;
	Wed, 30 Oct 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="c6L15Xnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIBGCnWG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3347A19CC24;
	Wed, 30 Oct 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320708; cv=none; b=ZyCGAAvS1SrPVN1dIZ6pEwmz4aVFS9xRTMiJoS0EmY0h2Qw2V5m81AUTUkdskD3rbrunt1QV2Hu7rJhzKcjNvcXqGtb9zRk9xDf9z9Bco5tYkmR1ow3CqVRRb1u8oOEpMxPjp7MohdpCY1PEHxx+C1ZvsCX3arBJpPe8p5evTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320708; c=relaxed/simple;
	bh=XW+2yYnLSZA6VCwNVaMITfxJ2XyzVUU4uthSz2ozD0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y8wtXFDswSsvUksCs9oniSAJEbJJNvaZZihLEpvN4m0HGek1o3iasx1zddfJNTEA88ooK9DivX8Jg0qsVHTkX0Srl8fIfsMWRzyx1JZ/dBMfsTM6q7LrYe/p9gjMk4Oi5qfXS0dgqF8NsEmQ/BLXPVtWAcqp8wgUhLO/tuQq9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=c6L15Xnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIBGCnWG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB33E25400F2;
	Wed, 30 Oct 2024 16:38:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 30 Oct 2024 16:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1730320703; x=1730407103; bh=jP
	lW8lpVwjQjFu6EM0sMGNKdNqoUomEoUkzIuxowlG4=; b=c6L15XnnPdIx76gYls
	mLPF+Vj8HhekzJlPdwh00/LuPwaztVz5W6E3Zufy+9NAVbCq2Z34ALuRmg+yfkfQ
	CqbCs1vP4HxwOP+rviHSOW9P9vsyLWAUHg95cVoV6i4r5/WNaBradrCUROex6L0E
	uUW0yp3/O90QxV+uWh92Pdao1ZbtU8Qj75K5THQWjHka7OjxeefUFN9G8HaAAB0r
	x8G8w+G8KJZq4OFfdh8Ql2ZVpQhU84Q943CuA35v50+26eoaaAgCluJBubgM2nnj
	sotGQHnRDM+CrVOgtRpGNt60EuLZEzP0eFuq9+4OKgqjmKXlzjKUl1z+qaC519Wl
	cHEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730320703; x=1730407103; bh=jPlW8lpVwjQjFu6EM0sMGNKdNqoU
	omEoUkzIuxowlG4=; b=EIBGCnWGiWp0ccL6z7gBbF+e04ercRMGUfkF1/9JGyaa
	Uiw8TaJ7jL2hkapoSh9KUwRp9nH0+ygGKKBzIzfJ2BG63fuhBC13iOV7VuOVSbOK
	sgFlaxjJgeSRV6K1aFYJK2cA4kZv6Xi034lAshJ+1vg8Zg4m6EPto4WPxfouKckP
	kV8U5RtcvHJU80rZa6u1s0+3rBtPxDzdZlVEgBs8OsOZnEsqTv34iKgGuNEwX86t
	qHKni9IFOjvTUaJdhpgQRNHzROi6s7tImOQuO69Yq0LftkWjzu3A5M2lpnJIsdzo
	Y7T6HG6h6d1EyugTzfgP0dtrYy7Z6+SAaxHUKYSsaw==
X-ME-Sender: <xms:PpkiZ_3PTaznljJ4NcMyouFhsaEAvZNHHSH0OTe8l7l7gDQ3hto9wg>
    <xme:PpkiZ-H4MLHgM9eif5DevHAbwpDJ62xpW1HazYrZlb3M6gMNulILcFyw-aUNR_1Dr
    n2fvKIiz6iCU_npK2c>
X-ME-Received: <xmr:PpkiZ_51QPaZJRIxvgI4UjsnqimJ77CmGOvjoDGGTHEl0D-3Qjfxmj0zZ-fXcNFiFN4f2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepvfihtghhohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrph
    hiiiiirgeqnecuggftrfgrthhtvghrnhepueeuueejffffkeehvedviedufffgtdetvedu
    vdethfegudffheduvdejfffhgfeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhho
    sehthigthhhordhpihiiiigrpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrg
    gtkhesshhushgvrdgtiidprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhn
    rdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepiigs
    hihsiigvkhesihhnrdifrgifrdhplhdprhgtphhtthhopegthihphhgrrhestgihphhhrg
    hrrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:PpkiZ03dfxIsPXMPSLjeXWkiw-c9d6qo7UdRUNiYevuofml19dR2qw>
    <xmx:PpkiZyEshMZGLb_Bv9MZGjsdXP8am97A2qAW43VsYSzvXPQ635k7CQ>
    <xmx:PpkiZ18MPxNV_A_U-qpeLD5tZIggpxAtMkGUqZIwRE_DdsGmsfpOzw>
    <xmx:PpkiZ_kvJxMJItXGHZ4U66_INxKy4Boj7aupd32BJX3eTMd4KozXgg>
    <xmx:P5kiZ_cn4oUF2_tdWs4pniqwWD3SOPlESWACEEuJyBcGv9GZrXKcvtQ->
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 16:38:20 -0400 (EDT)
From: Tycho Andersen <tycho@tycho.pizza>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [PATCH 1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Wed, 30 Oct 2024 14:37:31 -0600
Message-Id: <20241030203732.248767-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

Zbigniew mentioned at Linux Plumber's that systemd is interested in
switching to execveat() for service execution, but can't, because the
contents of /proc/pid/comm are the file descriptor which was used,
instead of the path to the binary. This makes the output of tools like
top and ps useless, especially in a world where most fds are opened
CLOEXEC so the number is truly meaningless.

Change exec path to fix up /proc/pid/comm in the case where we have
allocated one of these synthetic paths in bprm_init(). This way the actual
exec machinery is unchanged, but cosmetically the comm looks reasonable to
admins investigating things.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
CC: Aleksa Sarai <cyphar@cyphar.com>
Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
---
v2: * drop the flag, everyone :)
    * change the rendered value to f_path.dentry->d_name.name instead of
      argv[0], Eric
v3: * fix up subject line, Eric
v4: * switch to no flag, always rewrite approach, with some cleanup
      suggested by Kees
---
 fs/exec.c               | 36 +++++++++++++++++++++++++++++++++++-
 include/linux/binfmts.h |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..3b559f598c74 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1347,7 +1347,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If argv0 was set, alloc_bprm() made up a path that will
+	 * probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->argv0)
+		__set_task_comm(me, kbasename(bprm->argv0), true);
+	else
+		__set_task_comm(me, kbasename(bprm->filename), true);
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1497,9 +1506,28 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
+	kfree(bprm->argv0);
 	kfree(bprm);
 }
 
+static int bprm_add_fixup_comm(struct linux_binprm *bprm,
+			       struct user_arg_ptr argv)
+{
+	const char __user *p = get_user_arg_ptr(argv, 0);
+
+	/*
+	 * If p == NULL, let's just fall back to fdpath.
+	 */
+	if (!p)
+		return 0;
+
+	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
+	if (bprm->argv0)
+		return 0;
+
+	return -EFAULT;
+}
+
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
 {
 	struct linux_binprm *bprm;
@@ -1906,6 +1934,12 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_ret;
 	}
 
+	if (unlikely(bprm->fdpath)) {
+		retval = bprm_add_fixup_comm(bprm, argv);
+		if (retval != 0)
+			goto out_free;
+	}
+
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval == 0)
 		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e6c00e860951..bab5121a746b 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -55,6 +55,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	const char *fdpath;	/* generated filename for execveat */
+	const char *argv0;	/* argv0 from execveat */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long loader, exec;

base-commit: c1e939a21eb111a6d6067b38e8e04b8809b64c4e
-- 
2.34.1


