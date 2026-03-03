Return-Path: <linux-fsdevel+bounces-79096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G42A74vpmkrLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 01:47:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AC1E75DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 01:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0271530259B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 00:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699F201113;
	Tue,  3 Mar 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxXt3PxY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3112CDA5;
	Tue,  3 Mar 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498452; cv=none; b=XWQCcspbBY/tbnyFaeOLkkBfNacMKxWQsCq7EXGO2PYOsnaZ2akQzEsUffP6snfptP/xy4rzoo27ucXgZ9Ziqqnzmgcwbca87yO+FElCP8LbpESy1tjo3DOsmbMuHXrFwT2Klb/dqlaaoniZX+tyEsUFK2gTh4N5wCyiuGBvrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498452; c=relaxed/simple;
	bh=NiAgvTZ9q/jszEbZykKZat8+RICbVID0Iz5hAtYVuEM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZK5x3tTHMMMlcxwXZq4iC2awJS50fE3PaOrfYgb+H1jSDEB+1H7TA2Lo7hthR4W5UF5/z9X5rvFG0v7BkVO2izX+pm+9kNprIfxU/GrvHraiq8IpkRPpvq+ZWjY0pLnRdQDLQZvmNPPH8nXEZ9eLcnPnxYHeXNw4cjxHDeiGQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxXt3PxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F96C19423;
	Tue,  3 Mar 2026 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772498452;
	bh=NiAgvTZ9q/jszEbZykKZat8+RICbVID0Iz5hAtYVuEM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cxXt3PxYBQTNDM6lv5Oo8yMDMSvg/gekLP9VXtxkYXY8DVMa6uKUu8PUrEgUTF9JN
	 dB8Vsuf7k/K7tLiVKsSna1J6HlRU5GI9kdzRxJpAvnaPn+s+i27bIw6HivQsOs+Iki
	 bR7wwWR7tHPlDu8LyLb/n4uyF9n/7F/RdeSfHa8Ai1/w9cwWxwgWngipaeguPsgRxU
	 dDZJ+L2OdTBwF6PCPGOK3QeuZ0lC57eTxhv5XquA5+qfS3wwr6SF1Ipw2td7WTntRP
	 vl4PvgRuwYo3JIWMbpFf2h1SO/QeX6lvOj+oZvx64dCt3relh4LtFLeJ42r/Y9c5FE
	 KM4eI5SVOHU5Q==
Date: Mon, 02 Mar 2026 16:40:52 -0800
Subject: [PATCH 1/1] generic: test fsnotify filesystem error reporting
From: "Darrick J. Wong" <djwong@kernel.org>
To: zlang@redhat.com, djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, gabriel@krisman.be,
 amir73il@gmail.com, jack@suse.cz, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <177249785472.483405.1160086113668716052.stgit@frogsfrogsfrogs>
In-Reply-To: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
References: <177249785452.483405.17984642662799629787.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0E5AC1E75DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lst.de,krisman.be,gmail.com,suse.cz];
	TAGGED_FROM(0.00)[bounces-79096-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,popattr.py:url,scaleread.sh:url,btrfs_crc32c_forged_name.py:url]
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Test the fsnotify filesystem error reporting.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 src/Makefile           |    2 
 src/fs-monitor.c       |  155 +++++++++++++++++++++++++++++++++
 tests/generic/1838     |  228 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1838.out |   20 ++++
 4 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 src/fs-monitor.c
 create mode 100755 tests/generic/1838
 create mode 100644 tests/generic/1838.out


diff --git a/src/Makefile b/src/Makefile
index 577d816ae859b6..1c761da0ccff20 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
 	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
-	rw_hint
+	rw_hint fs-monitor
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/src/fs-monitor.c b/src/fs-monitor.c
new file mode 100644
index 00000000000000..fef596a3966933
--- /dev/null
+++ b/src/fs-monitor.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021, Collabora Ltd.
+ */
+
+#include <errno.h>
+#include <err.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/fanotify.h>
+#include <sys/types.h>
+#include <unistd.h>
+#ifndef __GLIBC__
+#include <asm-generic/int-ll64.h>
+#endif
+
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif
+
+#ifndef FILEID_INO32_GEN
+#define FILEID_INO32_GEN	1
+#endif
+
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
+static void print_fh(struct file_handle *fh)
+{
+	int i;
+	uint32_t *h = (uint32_t *) fh->f_handle;
+
+	printf("\tfh: ");
+	for (i = 0; i < fh->handle_bytes; i++)
+		printf("%hhx", fh->f_handle[i]);
+	printf("\n");
+
+	printf("\tdecoded fh: ");
+	if (fh->handle_type == FILEID_INO32_GEN)
+		printf("inode=%u gen=%u\n", h[0], h[1]);
+	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
+		printf("Type %d (Superblock error)\n", fh->handle_type);
+	else
+		printf("Type %d (Unknown)\n", fh->handle_type);
+
+}
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buffer;
+	struct fanotify_event_info_header *info;
+	struct fanotify_event_info_error *err;
+	struct fanotify_event_info_fid *fid;
+	int off;
+
+	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
+
+		if (event->mask != FAN_FS_ERROR) {
+			printf("unexpected FAN MARK: %llx\n",
+							(unsigned long long)event->mask);
+			goto next_event;
+		}
+
+		if (event->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			goto next_event;
+		}
+
+		printf("FAN_FS_ERROR (len=%d)\n", event->event_len);
+
+		for (off = sizeof(*event) ; off < event->event_len;
+		     off += info->len) {
+			info = (struct fanotify_event_info_header *)
+				((char *) event + off);
+
+			switch (info->info_type) {
+			case FAN_EVENT_INFO_TYPE_ERROR:
+				err = (struct fanotify_event_info_error *) info;
+
+				printf("\tGeneric Error Record: len=%d\n",
+				       err->hdr.len);
+				printf("\terror: %d\n", err->error);
+				printf("\terror_count: %d\n", err->error_count);
+				break;
+
+			case FAN_EVENT_INFO_TYPE_FID:
+				fid = (struct fanotify_event_info_fid *) info;
+
+				printf("\tfsid: %x%x\n",
+#if defined(__GLIBC__)
+				       fid->fsid.val[0], fid->fsid.val[1]);
+#else
+				       fid->fsid.__val[0], fid->fsid.__val[1]);
+#endif
+				print_fh((struct file_handle *) &fid->handle);
+				break;
+
+			default:
+				printf("\tUnknown info type=%d len=%d:\n",
+				       info->info_type, info->len);
+			}
+		}
+next_event:
+		printf("---\n\n");
+		fflush(stdout);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+
+	char buffer[BUFSIZ];
+
+	if (argc < 2) {
+		printf("Missing path argument\n");
+		return 1;
+	}
+
+	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
+	if (fd < 0) {
+		perror("fanotify_init");
+		errx(1, "fanotify_init");
+	}
+
+	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
+			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
+		perror("fanotify_mark");
+		errx(1, "fanotify_mark");
+	}
+
+	printf("fanotify active\n");
+	fflush(stdout);
+
+	while (1) {
+		int n = read(fd, buffer, BUFSIZ);
+
+		if (n < 0)
+			errx(1, "read");
+
+		handle_notifications(buffer, n);
+	}
+
+	return 0;
+}
diff --git a/tests/generic/1838 b/tests/generic/1838
new file mode 100755
index 00000000000000..087851ddcbdb44
--- /dev/null
+++ b/tests/generic/1838
@@ -0,0 +1,228 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 1838
+#
+# Check that fsnotify can report file IO errors.
+
+. ./common/preamble
+_begin_fstest auto quick eio selfhealing
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	test -n "$fsmonitor_pid" && kill -TERM $fsmonitor_pid
+	rm -f $tmp.*
+	_dmerror_cleanup
+}
+
+# Import common functions.
+. ./common/fuzzy
+. ./common/filter
+. ./common/dmerror
+. ./common/systemd
+
+case "$FSTYP" in
+xfs)
+	# added as a part of xfs health monitoring
+	_require_xfs_io_command healthmon
+	# no out of place writes
+	_require_no_xfs_always_cow
+	;;
+ext4)
+	# added at the same time as uevents
+	modprobe fs-$FSTYP
+	test -e /sys/fs/ext4/features/uevents || \
+		_notrun "$FSTYP does not support fsnotify ioerrors"
+	;;
+*)
+	_notrun "$FSTYP does not support fsnotify ioerrors"
+	;;
+esac
+
+_require_scratch
+_require_dm_target error
+_require_test_program fs-monitor
+_require_xfs_io_command "fiemap"
+_require_odirect
+
+# fsnotify only gives us a file handle, the error number, and the number of
+# times it was seen in between event deliveries.   The handle is mostly useless
+# since we have no generic way to map that to a file path.  Therefore we can
+# only coalesce all the I/O errors into one report.
+filter_fsnotify_errors() {
+	_filter_scratch | \
+		grep -E '(FAN_FS_ERROR|Generic Error Record|error: 5)' | \
+		sed -e "s/len=[0-9]*/len=XXX/g" | \
+		sort | \
+		uniq
+}
+
+_scratch_mkfs >> $seqres.full
+
+#
+# The dm-error map added by this test doesn't work on zoned devices because
+# table sizes need to be aligned to the zone size, and even for zoned on
+# conventional this test will get confused because of the internal RT device.
+#
+# That check requires a mounted file system, so do a dummy mount before setting
+# up DM.
+#
+_scratch_mount
+test $FSTYP = xfs && _require_xfs_scratch_non_zoned
+_scratch_unmount
+
+_dmerror_init
+_dmerror_mount >> $seqres.full 2>&1
+
+test $FSTYP = xfs && _xfs_force_bdev data $SCRATCH_MNT
+
+# Write a file with 4 file blocks worth of data, figure out the LBA to target
+victim=$SCRATCH_MNT/a
+file_blksz=$(_get_file_block_size $SCRATCH_MNT)
+$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c "fsync" $victim >> $seqres.full
+
+awk_len_prog='{print $4}'
+bmap_str="$($XFS_IO_PROG -c "fiemap -v" $victim | grep "^[[:space:]]*0:")"
+echo "$bmap_str" >> $seqres.full
+
+phys="$(echo "$bmap_str" | $AWK_PROG '{print $3}')"
+len="$(echo "$bmap_str" | $AWK_PROG "$awk_len_prog")"
+
+fs_blksz=$(_get_block_size $SCRATCH_MNT)
+echo "file_blksz:$file_blksz:fs_blksz:$fs_blksz" >> $seqres.full
+kernel_sectors_per_fs_block=$((fs_blksz / 512))
+
+# Did we get at least 4 fs blocks worth of extent?
+min_len_sectors=$(( 4 * kernel_sectors_per_fs_block ))
+test "$len" -lt $min_len_sectors && \
+	_fail "could not format a long enough extent on an empty fs??"
+
+phys_start=$(echo "$phys" | sed -e 's/\.\..*//g')
+
+echo "$phys:$len:$fs_blksz:$phys_start" >> $seqres.full
+echo "victim file:" >> $seqres.full
+od -tx1 -Ad -c $victim >> $seqres.full
+
+# Set the dmerror table so that all IO will pass through.
+_dmerror_reset_table
+
+cat >> $seqres.full << ENDL
+dmerror before:
+$DMERROR_TABLE
+$DMERROR_RTTABLE
+<end table>
+ENDL
+
+# All sector numbers that we feed to the kernel must be in units of 512b, but
+# they also must be aligned to the device's logical block size.
+logical_block_size=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+kernel_sectors_per_device_lba=$((logical_block_size / 512))
+
+# Mark as bad one of the device LBAs in the middle of the extent.  Target the
+# second LBA of the third block of the four-block file extent that we allocated
+# earlier, but without overflowing into the fourth file block.
+bad_sector=$(( phys_start + (2 * kernel_sectors_per_fs_block) ))
+bad_len=$kernel_sectors_per_device_lba
+if (( kernel_sectors_per_device_lba < kernel_sectors_per_fs_block )); then
+	bad_sector=$((bad_sector + kernel_sectors_per_device_lba))
+fi
+if (( (bad_sector % kernel_sectors_per_device_lba) != 0)); then
+	echo "bad_sector $bad_sector not congruent with device logical block size $logical_block_size"
+fi
+
+# Remount to flush the page cache, start fsnotify, and make the LBA bad
+_dmerror_unmount
+_dmerror_mount
+
+$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor &
+fsmonitor_pid=$!
+sleep 1
+
+_dmerror_mark_range_bad $bad_sector $bad_len
+
+cat >> $seqres.full << ENDL
+dmerror after marking bad:
+$DMERROR_TABLE
+$DMERROR_RTTABLE
+<end table>
+ENDL
+
+_dmerror_load_error_table
+
+# See if buffered reads pick it up
+echo "Try buffered read"
+$XFS_IO_PROG -c "pread 0 $((4 * file_blksz))" $victim >> $seqres.full
+
+# See if directio reads pick it up
+echo "Try directio read"
+$XFS_IO_PROG -d -c "pread 0 $((4 * file_blksz))" $victim >> $seqres.full
+
+# See if directio writes pick it up
+echo "Try directio write"
+$XFS_IO_PROG -d -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c fsync $victim >> $seqres.full
+
+# See if buffered writes pick it up
+echo "Try buffered write"
+$XFS_IO_PROG -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c fsync $victim >> $seqres.full
+
+# Now mark the bad range good so that unmount won't fail due to IO errors.
+echo "Fix device"
+_dmerror_mark_range_good $bad_sector $bad_len
+_dmerror_load_error_table
+
+cat >> $seqres.full << ENDL
+dmerror after marking good:
+$DMERROR_TABLE
+$DMERROR_RTTABLE
+<end table>
+ENDL
+
+# Unmount filesystem to start fresh
+echo "Kill fsnotify"
+_dmerror_unmount
+sleep 1
+kill -TERM $fsmonitor_pid
+unset fsmonitor_pid
+echo fsnotify log >> $seqres.full
+cat $tmp.fsmonitor >> $seqres.full
+cat $tmp.fsmonitor | filter_fsnotify_errors
+
+# Start fsnotify again so that can verify that the errors don't persist after
+# we flip back to the good dm table.
+echo "Remount and restart fsnotify"
+_dmerror_mount
+$here/src/fs-monitor $SCRATCH_MNT > $tmp.fsmonitor &
+fsmonitor_pid=$!
+sleep 1
+
+# See if buffered reads pick it up
+echo "Try buffered read again"
+$XFS_IO_PROG -c "pread 0 $((4 * file_blksz))" $victim >> $seqres.full
+
+# See if directio reads pick it up
+echo "Try directio read again"
+$XFS_IO_PROG -d -c "pread 0 $((4 * file_blksz))" $victim >> $seqres.full
+
+# See if directio writes pick it up
+echo "Try directio write again"
+$XFS_IO_PROG -d -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c fsync $victim >> $seqres.full
+
+# See if buffered writes pick it up
+echo "Try buffered write again"
+$XFS_IO_PROG -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c fsync $victim >> $seqres.full
+
+# Unmount fs and kill fsnotify, then wait for it to finish
+echo "Kill fsnotify again"
+_dmerror_unmount
+sleep 1
+kill -TERM $fsmonitor_pid
+unset fsmonitor_pid
+cat $tmp.fsmonitor >> $seqres.full
+cat $tmp.fsmonitor | filter_fsnotify_errors
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/1838.out b/tests/generic/1838.out
new file mode 100644
index 00000000000000..adae590fe0b2ea
--- /dev/null
+++ b/tests/generic/1838.out
@@ -0,0 +1,20 @@
+QA output created by 1838
+Try buffered read
+pread: Input/output error
+Try directio read
+pread: Input/output error
+Try directio write
+pwrite: Input/output error
+Try buffered write
+fsync: Input/output error
+Fix device
+Kill fsnotify
+	Generic Error Record: len=XXX
+	error: 5
+FAN_FS_ERROR (len=XXX)
+Remount and restart fsnotify
+Try buffered read again
+Try directio read again
+Try directio write again
+Try buffered write again
+Kill fsnotify again


