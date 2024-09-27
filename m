Return-Path: <linux-fsdevel+bounces-30261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B72988814
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD89E1F22659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2B1C174D;
	Fri, 27 Sep 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Nb7KPdXZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9fjwLSM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39F1C1744;
	Fri, 27 Sep 2024 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450296; cv=none; b=WRVl4SSbopHVHOXqEmoEqCOUm/FGgOXJ8FQ3/FbJ7B/Xn1ek3O8br5eTj2irboeHZaC0OCQdSyH01TCTTNQp6vovjF0+ZBnB8Beh8WKoTWkp9h0Z1CiY6GZ+xYEJeJ1HXb25Dzd62qTNaPdMmfu6nSCuMOT2XPSnfVBlXKeNs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450296; c=relaxed/simple;
	bh=RXE4h0FEmJJq139bQEJcVL4bi6vRBpAMaWbMvnIb4K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EA0FvOC+s8sSM4CDL2f8sr0O0PM+q2aNEN19q8JOdw2hK/gd/uIF72O5Bg1kecTGKTbhODforLxvk77mcXUlfYg6hiG4Pq4AUHdXvlAHzVD2FBrVOhwTQnCjWYfehBhpRCN8COiZe1ytDUZb+yEqnrhDcsskC9c+7iyBcUeDkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=Nb7KPdXZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9fjwLSM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8A4C911401BF;
	Fri, 27 Sep 2024 11:18:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 27 Sep 2024 11:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1727450293; x=1727536693; bh=1M
	JeUQz3swau3AVK/0+TWO5a/QWf2ulbE3IH6vSxBJI=; b=Nb7KPdXZFSjhJ8Anh1
	SnJYc1wgl4ONE3Bmff2Ln0JZ7/YdBmmJYG0Wb4/dAqCb47tl8OwJ3Xkcu2SDK0H/
	imzCNbvglV4mmZxEvSVTG1dD2Gq6Bv9Txgsg0LP++zA49c5bR7jc1WsywbQ0C3dg
	jDMII71P92IPRmX7UICFCgZ5DPlYnvCWC/lLisk243eLJ1IpHW5S6fgrv22pVBjA
	Q0ISIMJwKPPYpEy0mgzXQrPJIqjRxYrZ+iHPKMNkNldNxWfxed0fy1z1n9FW9d7/
	LQh62B6yUsLY+AHGVutq0FIHq2Ia6cq9Zhnwew5Ihdpxz+tfy+Nr1d5S7K4HU9kr
	/ikw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727450293; x=1727536693; bh=1MJeUQz3swau3
	AVK/0+TWO5a/QWf2ulbE3IH6vSxBJI=; b=X9fjwLSM4GotMVLhkIxg+GhurN2z0
	Wh2y4OX/kg+W+c0mi7bz3XEDivZ496Otb7n3ooZUfatfZVOIMWV4BIWOH77FLkpl
	pGJK7lGi+uRhsGCU0dYqOgX933SzS0838T7lfnSRiENLXhfaK/iF9VWjbmaDc/ui
	Uk4Ye8MbrhDeKw+Lh6V6Rm7+u5/UIYBfcL8fA9SI59Ct6kR/batutbOZ2QRIEFfb
	lkBo7RJeC6KK+5SMpQN9sxuz4XePW//21H5uRyGBcBqhAiREGhmAPHyTj8Gvj8XX
	vatNHLYNn65CDcP6qY2WPMi8waXkZdInVR2aQPtLwIoDFFKBzsXh2/jtw==
X-ME-Sender: <xms:tMz2Zh8lLK3tS3RkyXhijK7LxeqE5BVR9e8n3eKQozFPqwjNQOsnYw>
    <xme:tMz2ZlvEr8eCuUT09VzhdDhbkYr2IofLHzonUjJtFhd1jmnrrC_vB318_IDl9Q0BT
    piMdzuu17Mify8PQcY>
X-ME-Received: <xmr:tMz2ZvC0hNWsyMdMg5DBH94wMXoldEuYrIoi9pNtd7m6VORLOzwJDOgPaIBD84y81KXthQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtledgkeeiucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:tMz2ZlcWNFatk9ru8y8mkxKVMDJS988goJtAc-aNkl6iuOAaW8FQ8w>
    <xmx:tMz2ZmNxt8YhS-4a8lz2Z3AVXUr39Ff7CVrnhxm8tuzOkPk-5YN31g>
    <xmx:tMz2ZnnVJE6a9HEmYBxuDJVhBN6Ogk2xnflveTS-ITTa7HZ_vkLGXg>
    <xmx:tMz2Zgsso4n5cJ85n7TBV18dvcicQs6BzFW9FSdOXpv7e84vFfSnIA>
    <xmx:tcz2ZgvEQ990Cayo0DUoc7UUf36zcyUCW25YzbWTT1JMbz0qeCKmmejo>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Sep 2024 11:18:10 -0400 (EDT)
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
Subject: [PATCH v2 1/2] exec: add a flag for "reasonable" execveat() comm
Date: Fri, 27 Sep 2024 09:17:45 -0600
Message-Id: <20240927151746.391931-1-tycho@tycho.pizza>
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


