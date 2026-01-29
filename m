Return-Path: <linux-fsdevel+bounces-75861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDaPGfNue2mMEgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:30:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC39B0F4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 714C830432FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEED2E9EAC;
	Thu, 29 Jan 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwVMTDnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4413770B;
	Thu, 29 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696908; cv=none; b=g1VV3JwnYPA3w+pO6T9gokJMaiNBK3pFyn5H5f76Z6FHctpPVSUPNmxHNnYFiNjaOlsoom1sXIUA5wvKirc/HlNgDLWSd2xdN6JfbmedbosKDQMj5mIz50HnIemt/xSglubO+QPisy+2wgwnSh6RTuwZMbILfQcl6ngdsC/XCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696908; c=relaxed/simple;
	bh=KgHzY9+wO6JrVGbNTG2Tc09t99YOOIkG6eSltd0kH5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ2FKDcB+weYHSb6dyywP9U80KzRQiiP9yuZk6h7Wmnn2ZUc7netINci+JxPkxzZgOg5fLv1ExqrUVKSk/PNeCEyNRlsikuGwdl14n+//86Abb16FXTyVwdRrKBCrl0JiO+Tc/IHV2X4oRY50Jyoft5RG3QMETSP0bjSMSQZul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwVMTDnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52238C4CEF7;
	Thu, 29 Jan 2026 14:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769696907;
	bh=KgHzY9+wO6JrVGbNTG2Tc09t99YOOIkG6eSltd0kH5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwVMTDnhvLGv6xjIlUy84aYonf4RYmQ+l9XFlfwLafTAgDfiQ13EnDLSWfAn011XL
	 Oz5krG/8A1TkCvJlfoot7yyacVxizpegBJ+KRCtTAfsvlVNVj3sZ6KObo6oCCEgMjA
	 XO40v89oyU4p2Kz+0bVb4oL4MhtfjjjDHO3dN7/8UKX30utBnYtT6tHk45M+tGD2fy
	 0uF1SzsnxBqCOzFbYj2lUHtcPTVUROVWnkae9jYlL8C/j3vRKMcXEBDlWlZzA1oS7l
	 Ps3XUM5EJCfeYQzSBq0vJotSSBKyRMGA1emluBf6ZwjbaI/OU7lAWB/Wn9x2dL7eyG
	 qaFs2neeMIr/w==
Date: Thu, 29 Jan 2026 15:28:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Zachary M. Raines" <zachary.raines@canonical.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Duplicated entries in /proc/<pid>/mountinfo
Message-ID: <20260129-geleckt-treuhand-4bb940acacd9@brauner>
References: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dmany5l6i6jw3fmu"
Content-Disposition: inline
In-Reply-To: <DG0B0GEW323Q.29Y4J0A0Q5DQ5@canonical.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75861-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAC39B0F4E
X-Rspamd-Action: no action


--dmany5l6i6jw3fmu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Jan 28, 2026 at 08:49:12AM -0600, Zachary M. Raines wrote:
> Greetings,
> 
> When mounting and unmounting many filesystems, /proc/<pid>/mountinfo sometimes
> contains entries which are duplicated many times.
> 
> Summary
> =======
> 
> Sometimes on a system that is mounting and unmounting filesystems frequently,
> for example running lots of docker containers, the size of /proc/1/mountinfo,
> can become very large -- 100s, to 1000s of entries or more -- with the vast
> majority being a single entry duplicated many times.
> 
> This causes other problems on the system, due to systemd parsing the mount table
> whenever it changes, and eating up a lot of memory, for example [1]. Waiting
> long enough there are rare events where the length of mountinfo can go into the
> millions of lines and lead to OOM and kernel panics.
> 
> Running the reproducers below, I pretty reliably see an Ubuntu virtual machine
> kernel panic due to lack of memory within about 24hrs.
> 
> Versions
> ========
> 
> Bisecting the kernel git history, I was able to track the issue back to
> '2eea9ce4310d8 mounts: keep list of mounts in an rbtree' [2].
> 
> I've tested on 6.19-rc7 in a virtual machine and the issue is still present
> there. /proc/version:
> 
> Linux version 6.19.0-rc7+ (ubuntu@kernel-builder) (gcc (Ubuntu 15.2.0-4ubuntu4)
> 15.2.0, GNU ld (GNU Binutils for Ubuntu) 2.45) #8 SMP PREEMPT_DYNAMIC Tue Jan 27
> 22:33:35 UTC 2026
> 
> running on Ubuntu 25.10
> 
> Reproducer
> ==========
> 
> The problem can be reproduced by mounting and then unmounting tmpfs in a loop
> and in a seperate process reading /proc/1/mountinfo and checking for duplicates.
> 
> I used the following scripts:
> 
> 1. Mounts and unmounts tmpfs
> 
> #!/bin/bash
> counter=0
> while true; do
>     unique_name="tmpfs_$$_$counter"
>    	mkdir -p "/tmp/$unique_name"
>    	sudo mount -t tmpfs "$unique_name" "/tmp/$unique_name"
>    	sudo umount "/tmp/$unique_name"
>    	rmdir "/tmp/$unique_name"
>    	((counter++))
>    	sleep 0.1
> done
> 
> 2. Reads `/prod/1/mountinfo` and checks for duplicates
> 
> #!/bin/bash
> THRESHOLD=75
> echo "Starting monitoring at $(date)"
> while true; do
>     # Get mountinfo entries and count total
>     mountinfo="$(cat /proc/1/mountinfo)"
>     mountinfo_count=$(echo "$mountinfo" | wc -l)
> 
>     if ((mountinfo_count > THRESHOLD)); then
>         echo "$(date): Mount count ($mountinfo_count) exceeds threshold ($THRESHOLD)"
> 
>         # Find and log duplicate mount points with their counts
>         duplicates=$(echo "$mountinfo" | sort | uniq -cd)
> 
>         if [[ -n "$duplicates" ]]; then
>             echo "Duplicate mounts :"
>             echo "$duplicates"
>         fi
>         echo "====="
>         echo "$mountinfo"
>         echo "---"
>     fi
> 
>     sleep 0.1
> done
> 
> Typically, within 5-10 minutes duplicates can be observed, often including
> hundreds or thousands of copies of the same mount point -- although the number
> can rarely spike to much higher values. Given a long enough uptime, I've
> observed up to 1.4 million duplicates at a time.
> 
> The duplication in mountinfo is very intermittent. `cat /proc/1/mountinfo` 100ms
> later shows no duplication.
> 
> Additional diagnostics
> ======================
> 
> While running the script (2.) above, I also ran the following bpftrace script
> 
> 3. Trace vfs_mounts as by `cat /proc/1/mountinfo`
> 
> #!/usr/bin/env bpftrace
> 
> fentry:show_mountinfo / comm == "cat"/ {
>     @mnts[args->mnt] = count();
> }
> 
> tracepoint:sched:sched_process_exit / comm == "cat"/ {
>     for ($mnt : @mnts) {
>         if ($mnt.1 > 1) {
>             printf("Duplicate mount %p\n", $mnt.0);
>             @dups[$mnt.0] = $mnt.1;
>         }
>     }
>     clear(@mnts);
> }
> 
> and observed that a single mount struct was reached multiple times -- perhaps
> unsurprisingly exactly the same number as there were duplicates detected by
> the above script.
> 
> Typical outputs of script (2.) and the bpftrace script above are
> 
> Starting monitoring at Tue Jan 27 20:48:13 UTC 2026
> Tue Jan 27 20:50:43 UTC 2026: Mount count (696) exceeds threshold (75)
> Duplicate mounts :
>   /proc/sys/fs/binfmt_misc: 2 occurrences
>   /tmp/tmpfs_856614_41491: 666 occurrences
> 
> and
> 
> @dups[0xffff88e5fb9f10a0]: 666

Thanks for the report. So it's a bit unfortunate that you're showing
duplication by source path. That's not as useful as that can
legitimately happen. So the better test would be to see whether you get
any duplicated unique mount ids, i.e., whether the same
mnt->mnt_id_unique appears multiple times. Because that's a bug for
sure.

I suspect the issue is real though. I'm appending a patch as a proposed
fix. Can you test that and report back, please? I'm traveling tomorrow
so might take a little.

--dmany5l6i6jw3fmu
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-namespace-fix-proc-mount-iteration.patch"

From 26907be24e631329ba963d66196fe4f5d0863388 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Jan 2026 14:52:22 +0100
Subject: [PATCH] namespace: fix proc mount iteration

The m->index isn't updated when m->show() overflows and retains its
value before the current mount causing a restart to start at the same
value. If that happens in short order to due a quickly expanding mount
table this would cause the same mount to be shown again and again.

Ensure that *pos always equals the mount id of the mount that was
returned by start/next. On restart after overflow mnt_find_id_at(*pos)
finds the exact mount. This should avoid duplicates, avoid skips and
should handle concurrent modification just fine.

Cc: <stable@vger.kernel.org>
Fixed: 2eea9ce4310d8 ("mounts: keep list of mounts in an rbtree")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..ad35f8c961ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1537,23 +1537,33 @@ static struct mount *mnt_find_id_at_reverse(struct mnt_namespace *ns, u64 mnt_id
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_mounts *p = m->private;
+	struct mount *mnt;
 
 	down_read(&namespace_sem);
 
-	return mnt_find_id_at(p->ns, *pos);
+	mnt = mnt_find_id_at(p->ns, *pos);
+	if (mnt)
+		*pos = mnt->mnt_id_unique;
+	return mnt;
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct mount *next = NULL, *mnt = v;
+	struct mount *mnt = v;
 	struct rb_node *node = rb_next(&mnt->mnt_node);
 
-	++*pos;
 	if (node) {
-		next = node_to_mount(node);
+		struct mount *next = node_to_mount(node);
 		*pos = next->mnt_id_unique;
+		return next;
 	}
-	return next;
+
+	/*
+	 * No more mounts. Set pos past current mount's ID so that if
+	 * iteration restarts, mnt_find_id_at() returns NULL.
+	 */
+	*pos = mnt->mnt_id_unique + 1;
+	return NULL;
 }
 
 static void m_stop(struct seq_file *m, void *v)
-- 
2.47.3


--dmany5l6i6jw3fmu--

