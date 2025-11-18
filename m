Return-Path: <linux-fsdevel+bounces-68919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CDEC6845C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF231357827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8562FBE15;
	Tue, 18 Nov 2025 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HucALDsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0932C21CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763455735; cv=none; b=OJpIDzJpv4Az/M5luLdUVD2q/j8VHru7ppr0PfAkr5K/NCoyN5O2F5D+Whj+qqFB9IaONllWxlM+XW4A5pYxOryN4se02AxPJbNSpFvG5OIrNdAGeS83T79MavXWqmUTH+I7RSkbV9UMi67jMA8n21cegMJWnaRFunBCp4hl7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763455735; c=relaxed/simple;
	bh=lagXMWS3882gD77TfIvdfuJ9HpPqYFGoGZOYL/yzLTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cuMeVqtXzZ6WJjEV1tI+78gUT7UIA3EM5As4RK4gXpeFGAe2C2QiruoGOGFrK2jWY66d6Q5qs4U4TtNxUN12PcTLfUQU/aY4Ft938/5k8MHZyCeL+fQ3nFoOvPvmkzMih9h0Xg4pO4tUz75UnhTuVanwm4D4HwcvuEuhvPJRD9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HucALDsH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343ff854297so5808326a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763455734; x=1764060534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUYq7IoA5uCzgMA9WHHDRFbgr9c326zbLHdsYZOVWvg=;
        b=HucALDsH7NA7ERNFwhpedWPNpf4zADLk9MZh01iWZY65JYwuw87lAG5qfMbyxMXMAH
         L3sQzKHcRB3eLlaMe0oN5F7qBnSoSTuCmYmjjmTKSVG9yiblnWttE+ITwNvmjMYtb5mQ
         bx8N2KhJzMNGs5Dyo8zda7idwn+/OIttzXowK1OyItQsVp3XT1V6AL9i+KonyZa2Swsf
         745ppNnDuU4Qj4g1OKelvwL3WbVMwCchfnM271Num6i4sz0Nvp2vhDEFLZiU2dDNrQ8c
         mrN5TLa3thuqBpCL0r3eLWXUc8JiXmEVblHpZcY/q2zC6p+XgdYJ+mKSnHjsK6wpqwCM
         vF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763455734; x=1764060534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUYq7IoA5uCzgMA9WHHDRFbgr9c326zbLHdsYZOVWvg=;
        b=Zy8qNzaqTq9e/LKPfXWh81XsqUBSt/78TQ6APLt/qDdW4ctz1NeRz2ZXJmdhgfg05J
         DYLUwohBB1Ukf9a4HB5l663SNm8kPxWc0UnY4hpK/dkKyDH0HfCU6QDJTb3n+VAgXxHc
         ACXO3rwcA5swQBB90Bt+GI1zj8g71qfDutiTzpEIdW11dM+GVQXBZ+23Hdk0XsH+wcDx
         +Kn0BNlTuCgXUlHG5JJv/mu/F7RF0KA0ouEPeMI7Ho4ELKmI68WeNkWWNR7h1ozNgIR7
         vHQOQNYZseMqCwc2JBdBwrkKQOdUOJwGGlFv83s/Gz/mERlgZAzsRtAWLesGio2SB+uR
         dU3w==
X-Gm-Message-State: AOJu0YxJ6BOGM+9iq62sIr80II5v/9pqJtJA8zQcMBGFkYyJR9k2eYS1
	RMqOEOJfKubJoHEujE99W+vuEun68Y127LstQaI1l8kW1eCZ7h6A5b4e
X-Gm-Gg: ASbGnctuLLLKhmO7pQ5Z0kSfdt2iW5EEWJrpJeLK2P166x7Mu+GPtUvdzJL2uhUTP/h
	QuCqRU6QV446950vUCOC3tP9Bj8TvrRRYSSE/Xw8VPl0WdetgafJe83lrBnz7uW2iYEb6nzFMe6
	VMD4TXxueY4PAZyoitsXaXiNf/wzEf969nF3MwIdIv+/iUHjTMDdDwjZ8dahxUzYxLSYfDFoNPa
	meH8jBlCUNYjeYuueIg+4H+ul33RWT7E+fymVUQaW/k9sL+dKdpvNGlMmPeZQ2XfulzCRIvZh4g
	v8sztOC/gIFGD8cdsuSv9ds1Kl1x7zxAwr/Fk09J+oJ1ddC3B1paFwRCeDQt2GRL4xBEv8MMGX+
	RooR8nty44FK60nEGgHetPYI0npBDcIb1eFyDed7jhxpVlIylV9IE3qtHKTioPsR6haHMrZMoLH
	Ih
X-Google-Smtp-Source: AGHT+IEqOc2uvlBVIut3c7uValD6RRVcta8QkRuMyLU166Ivb2PrkRdlK2cjhiFJPj5OmzV7ggvbLw==
X-Received: by 2002:a17:90a:c110:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-343fa6326ebmr17444420a91.18.1763455733580;
        Tue, 18 Nov 2025 00:48:53 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b01d934csm964041a91.1.2025.11.18.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:48:53 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	criu@lists.linux.dev,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v6 0/2] statmount: accept fd as a parameter
Date: Tue, 18 Nov 2025 14:16:40 +0530
Message-ID: <20251118084836.2114503-1-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to add support for checkpoint/restoring file descriptors
open on these "unmounted" mounts to CRIU (Checkpoint/Restore in
Userspace) [1].

Currently, we have no way to get mount info for these "unmounted" mounts
since they do appear in /proc/<pid>/mountinfo and statmount does not
work on them, since they do not belong to any mount namespace.

This patch helps us by providing a way to get mountinfo for these
"unmounted" mounts by using a fd on the mount.

Changes from v5 [2] to v6:
* Instead of returning "[unmounted]" as the mount point for "unmounted"
mounts, we unset the STATMOUNT_MNT_POINT flag in statmount.mask.

* Instead of returning 0 as the mnt_ns_id for "unmounted" mounts, we
unset the STATMOUNT_MNT_NS_ID flag in statmount.mask.

* Added comment in `do_statmount` clarifying that the caller sets s->mnt
in case of STATMOUNT_BY_FD.

* In `do_statmount` move the mnt_ns_id and mnt_ns_empty() check just
before lookup_mnt_in_ns().

* We took another look at the capability checks for getting information
for "unmounted" mounts using an fd and decided to remove them for the
following reasons:

  - All fs related information is available via fstatfs() without any
    capability check.

  - Mount information is also available via /proc/pid/mountinfo (without
    any capability check).

  - Given that we have access to a fd on the mount which tells us that
    we had access to the mount at some point (or someone that had access
    gave us the fd). So, we should be able to access mount info.

Changes from v4 [3] to v5:
Check only for s->root.mnt to be NULL instead of checking for both
s->root.mnt and s->root.dentry (I did not find a case where only one of
them would be NULL).

* Only allow system root (CAP_SYS_ADMIN in init_user_ns) to call
statmount() on fd's on "unmounted" mounts. We (mostly Pavel) spent some
time thinking about how our previous approach (of checking the opener's
file credentials) caused problems.

Please take a look at the linked pictures they describe everything more
clearly.

Case 1: A fd is on a normal mount (Link to Picture: [4])
Consider, a situation where we have two processes P1 and P2 and a file
F1. F1 is opened on mount ns M1 by P1. P1 is nested inside user
namespace U1 and U2. P2 is also in U1. P2 is also in a pid namespace and
mount namespace separate from M1.

P1 sends F1 to P2 (using a unix socket). But, P2 is unable to call
statmount() on F1 because since it is a separate pid and mount
namespace. This is good and expected.

Case 2: A fd is on a "unmounted" mount (Link to Picture: [5])
Consider a similar situation as Case 1. But now F1 is on a mounted that
has been "unmounted". Now, since we used openers credentials to check
for permissions P2 ends up having the ability call statmount() and get
mount info for this "unmounted" mount.

Hence, It is better to restrict the ability to call statmount() on fds
on "unmounted" mounts to system root only (There could also be other
cases than the one described above).

Changes from v3 [6] to v4:
* Change the string returned when there is no mountpoint to be
"[unmounted]" instead of "[detached]".
* Remove the new DEFINE_FREE put_file and use the one already present in
include/linux/file.h (fput) [7].
* Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
prepare_klistmount prototype.
* If STATMOUNT_BY_FD is set, check for mnt_ns_id == 0 && mnt_id == 0.

Changes from v2 [8] to v3:
* Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
* Fixed UAF bug caused by the reference to fd_mount being bound by scope
of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
* Reused @spare parameter in mnt_id_req instead of adding new fields to
the struct.

Changes from v1 [9] to v2:
v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount.

Introducing umount_mnt_ns complicated namespace locking and modified
performance sensitive code [10] and it was agreed upon that fd-based
statmount would be better.

This code is also available on github [11].

[1]: https://github.com/checkpoint-restore/criu/pull/2754
[2]: https://lore.kernel.org/criu/20251109053921.1320977-2-b.sachdev1904@gmail.com/T/#u
[3]: https://lore.kernel.org/all/20251029052037.506273-2-b.sachdev1904@gmail.com/
[4]: https://github.com/bsach64/linux/blob/statmount-fd-v5/fd_on_normal_mount.png
[5]: https://github.com/bsach64/linux/blob/statmount-fd-v5/file_on_unmounted_mount.png
[6]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gmail.com/
[7]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/file.h#n97
[8]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
[9]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
[10]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
[11]: https://github.com/bsach64/linux/tree/statmount-fd-v6

Bhavik Sachdev (2):
  statmount: permission check should return EPERM
  statmount: accept fd as a parameter

 fs/namespace.c             | 99 ++++++++++++++++++++++++++------------
 include/uapi/linux/mount.h |  7 ++-
 2 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.51.1


