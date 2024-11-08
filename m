Return-Path: <linux-fsdevel+bounces-34007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1F9C1A53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C5A2830FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3BF1E261A;
	Fri,  8 Nov 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QdvK4eBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324111BD9D8;
	Fri,  8 Nov 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061211; cv=none; b=TbsR/XA3JPuCKs6zlwgFMdQKOK6cQRlScL0RFEdRxObR201T9DmA6M1p8BC+bQZYAclbrAWzhHWWh4+6Na3MI7sJ7IQBUpKALThgL1mBMZLAkMgsVuvsWgA+EzvUnYQgq5MGLZ+OOVy36VD7xNhkS3HMK4GjNS64tNuyGS4Fs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061211; c=relaxed/simple;
	bh=QoTtG6Ai0dqQgYeIuTUuuhxNMAeYXv2Qgan5Z+4OMlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B+0anIim8PyfmdvyyTurPLlt88W+bzUXu2BgcutvQ1a8za9dkBnXImbJlLmiDJCuwYVnLsXrKRNCAOgsS0Z0K3TgyG5POT5f63nupphPSUiLxveiexbDfhbHX4+CUKpt59sZfyoH2SOYGBO0YS9+O9xGzUq1cbKIvfQT+DRT1Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=QdvK4eBz; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 1C9B862CB8;
	Fri,  8 Nov 2024 13:13:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a8d:0:640:b3b5:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id A27FA60987;
	Fri,  8 Nov 2024 13:13:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id fDgEj2Kl8a60-lUvfKmeO;
	Fri, 08 Nov 2024 13:13:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731060823; bh=5nSxMyQsS8Grhp7PFZ+C63x38M6gX900k7jTb0/BF2w=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=QdvK4eBz245FIh5lbjVpZM95XDpvC7YvBO8qx9fHsNlfg0ZBoHqoVr6X4ETAu4nr4
	 gVk3+2nTy/2UQLN/vHJMP2V95CaLMZA87zpZeIk0tCng+g6pSyi5aCdexX4jsU6xQI
	 Yk4RzitRGYsX5PLyWmKCHGjqdYaZzvOHiL6sDlwI=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Eric Biederman <ebiederm@xmission.com>,
	Andy Lutomirski <luto@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Jens Axboe <axboe@kernel.dk>,
	Oleg Nesterov <oleg@redhat.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] implement PROCFS_SET_GROUPS ioctl
Date: Fri,  8 Nov 2024 13:13:37 +0300
Message-ID: <20241108101339.1560116-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2: define set_current_groups() for !CONFIG_MULTIUSER
  addressing a test robot-reported failure.

This patch set implements the PROCFS_SET_GROUPS ioctl that allows
to set the group list from the fd referring to /proc/<pid>/status.
It consists of 2 patches: a small preparatory patch and an implementation
itself. The very detailed explanation of usage, security considerations
and implementation details are documented in the commit log of the
second patch. Brief summary below.

The problem:
If you use suid/sgid bits to switch to a less-privileged (home-less)
user, then the group list can't be changed, effectively nullifying
any supposed restrictions. As such, suid/sgid to non-root creds is
currently practically useless.

Previous solutions:
https://www.spinics.net/lists/kernel/msg5383847.html
This solution allows to restrict the groups from group list.
It failed to get any attention for probably being too ad-hoc.
https://lore.kernel.org/all/0895c1f268bc0b01cc6c8ed4607d7c3953f49728.1416041823.git.josh@xxxxxxxxxxxxxxxx/
This solution from Josh Tripplett was considered insecure.

New proposal:
Given that /proc/<pid>/status file carries the cred info including the
group list, it seems natural to use that file to transfer and apply the
group list within. The trusted entity should permit such operation and
send the needed group info to client via SCM_RIGHTS. Client can check
the received info by reading from fd. If he is satisfied, he can use
the new ioctl to try to set the group list from the received status file.
Kernel does all the needed security and sanity checks, and either returns
an error or applies the group list. For more details and security
considerations please refer to the commit message of the second patch.
As the result, given that the process did the suid/sgid-assisted switch,
it can obtain the correct group info that matches his new credentials.
None of the previous proposals allowed to get the right group info:
it was either cleared or "restricted" but never correct. This proposal
aims to amend all of the previous short-comings with the hope to make
the suid/sgid-assisted switches useful for dropping access rights.

Usage example:
I put the user-space usage example here:
https://github.com/stsp/cred_test
`tst.sh` script sets the needed permissions and runs server and client.
Client does the suid/sgid-assisted identity switch and asks the server
for the new group info. Server grants the needed group info based on
client's credentials (using SO_PEERCRED) and client executes `id`
command to show the result.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Aleksa Sarai <cyphar@cyphar.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Jeff Layton <jlayton@kernel.org>
CC: John Johansen <john.johansen@canonical.com>
CC: Chengming Zhou <chengming.zhou@linux.dev>
CC: Casey Schaufler <casey@schaufler-ca.com>
CC: Adrian Ratiu <adrian.ratiu@collabora.com>
CC: Felix Moessbauer <felix.moessbauer@siemens.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Oleg Nesterov <oleg@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org

Stas Sergeev (2):
  procfs: avoid some usages of seq_file private data
  procfs: implement PROCFS_SET_GROUPS ioctl

 fs/proc/base.c          | 148 +++++++++++++++++++++++++++++++++++++---
 include/linux/cred.h    |   4 ++
 include/uapi/linux/fs.h |   2 +
 3 files changed, 146 insertions(+), 8 deletions(-)

-- 
2.47.0


