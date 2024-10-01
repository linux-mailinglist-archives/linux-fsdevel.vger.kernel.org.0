Return-Path: <linux-fsdevel+bounces-30507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2598BEC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F168D1F21B70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FE1C6F78;
	Tue,  1 Oct 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="pssqwj07";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjjWVV9R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50C1C68A1;
	Tue,  1 Oct 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791171; cv=none; b=JlN5CKNdHn6Xg3PFpl763z3ZEFa+IbpX/8QbYwaKlWCT1yb5KiCQird/Yu3mgJ9ApaBb2bzbaFsD6k/jUi3l7iIY9Im8mEtxDXtasP9XCypdQnH697+KqlQGLwH42sq4ALdfwFREdAthYuulIak2BVCXcSJU2zlKv8J1wTrgBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791171; c=relaxed/simple;
	bh=0UEGwQrnuwdQ+67p8ySa8SKC+0rmZBGpAGQroLblmg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NMqmsgxaQNt+6IslGgjuMRFiut0URfim0TH3D1Sk76RjerGxxzPdGrW8DqcrqhTGpO+AHH5+3t8JhodmVywdUpj5U87/3WH+1kGwsUm9MWe2LIAeacd5DHA21lN1s1ET/7JpvNhfI6bJNn+VzuoRzfFagEUcRYjAeixNYXC9gRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=pssqwj07; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjjWVV9R; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DFD5C11413D4;
	Tue,  1 Oct 2024 09:59:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 01 Oct 2024 09:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727791168; x=1727877568; bh=un
	WHvxzfAjnkbvBw6nviBvkFZdeAWYaudeSrxpKDykw=; b=pssqwj0736RHy3+h8m
	0rW29eeT5N3DbwuJBw1egM7Jjjc8JjdGG8vx1Ms7Xx5MkG1syA6O9bdMbu/Qy0jX
	YoXPpYjN+3JYkz8KMeorIj7ZoWYCzowGHmHbSPvqjQzUGlzFg6ZFfc08BALSydfd
	mUrDSvLBkxlMhz3JfZPGnsDAgWjIEFag5S3c4XRoCuY0W8V8T8uywY1ULsUf+enq
	kjUDG8D62/rDZCa4+RCTfGB19a0RoW457RICZH5hXv5vpbihyFiv5p4kwYWGULFv
	aSEtHAX6VFjv64CpnrSVnM/Im5rL+Fa50fRFZYn8ejVNPZK7zjnSUa2pef7tFDS2
	OXrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727791168; x=1727877568; bh=unWHvxzfAjnkb
	vBw6nviBvkFZdeAWYaudeSrxpKDykw=; b=QjjWVV9RrX987qwDX3uubrLJfXsqg
	DP4OQoVXPMPQzhVneNE0+/RCGI4dXokMK9466jOOOn7cIT9rm0te+0pFqHQJ1fkF
	WJQsqt18bSPcVRtTmJ3vWLet3AOXl1uTfvNxi4800LKxThOasWAWqZgMSe42GMt3
	LOeJ+8aTU1G5uZxc5ExrkcClBoSTMsaFUVSyO/K5mnkZR6MQybrtdsTwrp6qe1Kg
	XveebKSycxyaOwqFUoKd+aKvemAZnzWIUoSj3eggaOb2vEF/UX0n9aiTCYJDTsdI
	17+41DpSmVpt8nGn0JeNzilo4B50h/gmHPpUxFmKwOTzZI39WERZTe2Lw==
X-ME-Sender: <xms:QAD8Zg6MfDgM8RKKJQfRTDu8hK23pJ3jMS6zIpkNjZ2gaNUpkHUCBQ>
    <xme:QAD8Zh5SunuYpukaGU6DDeZM9ex4AMKWpqPG3oGKNTQxeNHrPULyBb-h7sa3byY2l
    _Kl9fjaHMXollYIxz0>
X-ME-Received: <xmr:QAD8ZvdCJMOy1zVxPa9tASWXqVlqSZV1ULJwtXKf33p7_YgRZj35XsDMqt6ZJYvRRMPsJAGInYXTpbsTt4KgZVWW9ecW81fuLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpih
    iiiigrqeenucggtffrrghtthgvrhhnpeeuueeujeffffekheevvdeiudffgfdtteevuddv
    tefhgeduffehuddvjeffhffgueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohes
    thihtghhohdrphhiiiiirgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtg
    hksehsuhhsvgdrtgiipdhrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdr
    tghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    shgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QAD8ZlLZMd0DrqP9iecJ3VAUHVlY6vL_32Ul8_AsIXlG9mCOkOpOjg>
    <xmx:QAD8ZkL4VKc_ydC7jyfiwKs9i2f2AO4jQWZySzZIiI1nA7U266m35Q>
    <xmx:QAD8Zmyc9y8G_taLraY2SRj6MYhVVw9ICQuIu76hg9R1PNS9J5zRqA>
    <xmx:QAD8ZoIzJDFxGhYxIlsT3Bxi8Rno3se5m7u4OdoCwxAcLuc2Wpke4w>
    <xmx:QAD8ZnYcjlMmziycfrI3g1Ca2nBIk0K6j83Tr_-RNZarqPBg4NAIGZ3V>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 09:59:27 -0400 (EDT)
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
	Tycho Andersen <tandersen@netflix.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v3 1/2] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Tue,  1 Oct 2024 07:49:44 -0600
Message-Id: <20241001134945.798662-1-tycho@tycho.pizza>
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
---
 fs/exec.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index dad402d55681..9520359a8dcc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1416,7 +1416,18 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If fdpath was set, execveat() made up a path that will
+	 * probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->fdpath) {
+		BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
+		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
+	} else {
+		__set_task_comm(me, kbasename(bprm->filename), true);
+	}
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */

base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
-- 
2.34.1


