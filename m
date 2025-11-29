Return-Path: <linux-fsdevel+bounces-70208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDDAC93AE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503C83A89CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178D275AE4;
	Sat, 29 Nov 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg9v7Ok3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395D264F81
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407713; cv=none; b=HBIPScpGGaWT4evshjR0kxLqXvVJBzpk/SJ39Am7ogPDHyJ8p+129RfQhq+eapPIN82FwfYycB2seB3DaEBKzY5JyA+1zxM7GG0gNnhvxsuLeHHUXlA+PX4JEN/UbNFehFpDsypWUHau6sF9yhPXnyYMptj064UGUB6vcRwC9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407713; c=relaxed/simple;
	bh=pgcx3ngXjyLfVIMGgjFCoFd4kCXfwxRmHCPjPsuQ154=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uNGlt5jQf09BObXGE6N+AD0OITUkmIFlg1NXYjEMcAFBo0KLqoDd00vdhPV20TimHlcIQrgnSF3scG6KULCOGH4Bxegvp1QZoqSDghRFeI2ClPH71PFNGrTlU48nZ3AxliHK9eoek/M9tO4yKOe2beNqBhqjOpp7bqySVrkAYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg9v7Ok3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso2087591b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 01:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764407711; x=1765012511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7McoraGzT7ft4cOd5uMMqzYD9akwWmQ1zJslTjyMrRg=;
        b=Qg9v7Ok3JDm88yyPJHdbwb1kPfhozb5ASM3itevKygBY//I0ISDDdJh8DaqurUnQni
         HV8axaX5+AT/ZH/J1Q0Lh/JGpG4SAbKNg9KPfY4zXSX2g6S7mR9iVf1dp/gbPdYB9da9
         2o4TbfH5ea5hlSPs1psihD3vuVZOCegNVbbbYo37g4RrlYHaJ7wsnphSm834KMU+WAnn
         Em09AUu/munfZX5lE6QTEfkwN9EBxv6I9ri3La0WFKkwIdfUzff9zY6w/q2ftxIoSLoL
         QR3aoVzK379GWIuMD9Pjm7/11UZyETqDYn/zO1t5zPG8Q+8iP65g/djwuw+SbutnzKlT
         msGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764407711; x=1765012511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7McoraGzT7ft4cOd5uMMqzYD9akwWmQ1zJslTjyMrRg=;
        b=VWMUja4tu6NSLuxDU0PMUBmickDqv82cTfynSIZ6u/Q6l9Vhn3Mr75JKsWASW4AdjT
         dEZLDUPNTRTKpAH1wMflBXpvnVz4KXfpsCDbgmQ+4jXl+kK01eTkUYA4TuejsRzD77da
         ISQB8lshzpY1pyj7nArM83F1B/wATUos7tpOTTjolHEvNzHrph5/f8WnwLJGuWH3GbNs
         qKWgF5zGcNMcbUB4JquuXuDhK3M7WnABlXJKZn+lwTxjtmV9OMTlo85IIZlWnSrOMP/k
         VuwWee/Wv+6CD6h1c4EmN1gsZLf79ilyrQpTugj9YlsHHD3ulzsJWIm71rhdZRReM2ep
         GdKg==
X-Gm-Message-State: AOJu0YxB9IwF8TyXz7IiMer7mt1H3JRzbUhyAC1vuIXJp4qttcWMbbxh
	EoDd6pNUeKf0J4VA0AwSQiWX6ndNUeZTT3Xo+zayW9j2p3yjR3uHuCi1
X-Gm-Gg: ASbGnctmFnLEtDxg0WMkQgIIRiFwARzWrb4XwtclSzSnJzDzqqCo9RnTxGBasSht9OL
	Ipp3q6hLDyiXuVkz+hlaqvzVHnqHWLN/MsEEzuR0W4SpnTuMvrfGWkXaGemx77Uv8D0EvzpW7P1
	mkOlICbzzCm85sDo3mHp9P8yN+CIl/vF0GQQgd2qpCL6uClKUs/AzHo0qQCXqtS3Vl9zgW1hA9n
	+y+LfWUlW3IDOqsJgp+XrmSUOjGFDMkdp0p/rxwXvIBBumK83kBDfVFd76Lw6OdN43a27o9Bjk0
	GsswDvq79Hi4WfzGbADEtepi9xKdxAqSZHXUfLacvTOk8xx/l9jy//LqbBYNtaS6pws129N/1nj
	U4bD7x3/S2sGPPYMSEX2IJNUOR5YiEPGa4aQvwkuUWQkeViYOEn5bdrazzsghZ2Ut0cWCdiPKma
	uFX4EGMLM0NBRDFoSA0Qm6Kg==
X-Google-Smtp-Source: AGHT+IHRggrtJjCz3r4/B4Ms7F3IdMI1ozOO7ePbM2mx3pzpr/8CuNAAHtPqxkceHn3Pt0+C0BkbHA==
X-Received: by 2002:a05:6a00:2389:b0:7aa:bd80:f4db with SMTP id d2e1a72fcca58-7ca8740ec4cmr17210906b3a.5.1764407710531;
        Sat, 29 Nov 2025 01:15:10 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm7300563b3a.41.2025.11.29.01.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:15:09 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v7 0/3] statmount: accept fd as a parameter
Date: Sat, 29 Nov 2025 14:41:19 +0530
Message-ID: <20251129091455.757724-1-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Changes from v6 [2] to v7:
* Add kselftests for STATMOUNT_BY_FD flag.

* Instead of renaming mnt_id_req.mnt_ns_fd to mnt_id_req.fd introduce a
union so struct mnt_id_req looks like this:

    struct mnt_id_req {
            __u32 size;
            union {
                    __u32 mnt_ns_fd;
                    __u32 mnt_fd;
            };
            __u64 mnt_id;
            __u64 param;
            __u64 mnt_ns_id;
    };

* In case of STATMOUNT_BY_FD grab mnt_ns inside of do_statmount(),
since we get mnt_ns from mnt, which should happen under namespace lock.

* Remove the modifications made to grab_requested_mnt_ns, those were
never needed.

Changes from v5 [3] to v6:
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

Changes from v4 [4] to v5:
Check only for s->root.mnt to be NULL instead of checking for both
s->root.mnt and s->root.dentry (I did not find a case where only one of
them would be NULL).

* Only allow system root (CAP_SYS_ADMIN in init_user_ns) to call
statmount() on fd's on "unmounted" mounts. We (mostly Pavel) spent some
time thinking about how our previous approach (of checking the opener's
file credentials) caused problems.

Please take a look at the linked pictures they describe everything more
clearly.

Case 1: A fd is on a normal mount (Link to Picture: [5])
Consider, a situation where we have two processes P1 and P2 and a file
F1. F1 is opened on mount ns M1 by P1. P1 is nested inside user
namespace U1 and U2. P2 is also in U1. P2 is also in a pid namespace and
mount namespace separate from M1.

P1 sends F1 to P2 (using a unix socket). But, P2 is unable to call
statmount() on F1 because since it is a separate pid and mount
namespace. This is good and expected.

Case 2: A fd is on a "unmounted" mount (Link to Picture: [6])
Consider a similar situation as Case 1. But now F1 is on a mounted that
has been "unmounted". Now, since we used openers credentials to check
for permissions P2 ends up having the ability call statmount() and get
mount info for this "unmounted" mount.

Hence, It is better to restrict the ability to call statmount() on fds
on "unmounted" mounts to system root only (There could also be other
cases than the one described above).

Changes from v3 [7] to v4:
* Change the string returned when there is no mountpoint to be
"[unmounted]" instead of "[detached]".
* Remove the new DEFINE_FREE put_file and use the one already present in
include/linux/file.h (fput) [8].
* Inside listmount consistently pass 0 in flags to copy_mnt_id_req and
prepare_klistmount()->grab_requested_mnt_ns() and remove flags from the
prepare_klistmount prototype.
* If STATMOUNT_BY_FD is set, check for mnt_ns_id == 0 && mnt_id == 0.

Changes from v2 [9] to v3:
* Rename STATMOUNT_FD flag to STATMOUNT_BY_FD.
* Fixed UAF bug caused by the reference to fd_mount being bound by scope
of CLASS(fd_raw, f)(kreq.fd) by using fget_raw instead.
* Reused @spare parameter in mnt_id_req instead of adding new fields to
the struct.

Changes from v1 [10] to v2:
v1 of this patchset, took a different approach and introduced a new
umount_mnt_ns, to which "unmounted" mounts would be moved to (instead of
their namespace being NULL) thus allowing them to be still available via
statmount.

Introducing umount_mnt_ns complicated namespace locking and modified
performance sensitive code [11] and it was agreed upon that fd-based
statmount would be better.

This code is also available on github [12].

[1]: https://github.com/checkpoint-restore/criu/pull/2754
[2]: https://lore.kernel.org/all/20251118084836.2114503-1-b.sachdev1904@gmail.com/
[3]: https://lore.kernel.org/criu/20251109053921.1320977-2-b.sachdev1904@gmail.com/T/#u
[4]: https://lore.kernel.org/all/20251029052037.506273-2-b.sachdev1904@gmail.com/
[5]: https://github.com/bsach64/linux/blob/statmount-fd-v5/fd_on_normal_mount.png
[6]: https://github.com/bsach64/linux/blob/statmount-fd-v5/file_on_unmounted_mount.png
[7]: https://lore.kernel.org/all/20251024181443.786363-1-b.sachdev1904@gmail.com/
[8]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/file.h#n97
[9]: https://lore.kernel.org/linux-fsdevel/20251011124753.1820802-1-b.sachdev1904@gmail.com/
[10]: https://lore.kernel.org/linux-fsdevel/20251002125422.203598-1-b.sachdev1904@gmail.com/
[11]: https://lore.kernel.org/linux-fsdevel/7e4d9eb5-6dde-4c59-8ee3-358233f082d0@virtuozzo.com/
[12]: https://github.com/bsach64/linux/tree/statmount-fd-v7

Bhavik Sachdev (3):
  statmount: permission check should return EPERM
  statmount: accept fd as a parameter
  selftests: statmount: tests for STATMOUNT_BY_FD

 fs/namespace.c                                | 102 ++++---
 include/uapi/linux/mount.h                    |  10 +-
 .../filesystems/statmount/statmount.h         |  15 +-
 .../filesystems/statmount/statmount_test.c    | 261 +++++++++++++++++-
 .../filesystems/statmount/statmount_test_ns.c | 101 ++++++-
 5 files changed, 430 insertions(+), 59 deletions(-)

-- 
2.52.0


