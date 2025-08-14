Return-Path: <linux-fsdevel+bounces-57838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33ACB25B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AA3566840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2611823183C;
	Thu, 14 Aug 2025 05:49:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59622D4DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150544; cv=none; b=HRYx+498lS9xxHOWsmUiyjm/iZDm1T23wks39CLdKwqS2ukmm/DN2Cn+L4qWbz9iVrSumOqMJKD7bmTe4bUnGuATo4ZVGd+iozCAluEQusG7WOVralghqivHVAGbucydw5ra6bE1iD+Dgw6t6IfXgHfvA5jzlI9W+r8ZCQ+LHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150544; c=relaxed/simple;
	bh=5c4tsAbrUCPzNd0BA/l/beypy1l+JGENmNIxWBabzkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJYWOqsk7bToaEIiPGsVw45/LVrHoFjQRZhz2VSd381dN1k5uETiiNEvjP8V8UpySofpFVBVxLnBeMiRr/NsP/PRjpPYZo2pDQOm2u1FuAMB3ws+WazigDhakojFpASmF9iLPzteMYJxCMtZ0MJitM8f7vUw1jCBuuZFzcBL/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8793621B2B;
	Thu, 14 Aug 2025 05:48:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB07F13479;
	Thu, 14 Aug 2025 05:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mP7AIMV4nWiEYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 14 Aug 2025 05:48:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 7/7] gen_init_cpio: add -a <data_align> as reflink optimization
Date: Thu, 14 Aug 2025 15:18:05 +1000
Message-ID: <20250814054818.7266-8-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>
References: <20250814054818.7266-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8793621B2B
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

As described in buffer-format.rst, the existing initramfs.c extraction
logic works fine if the cpio filename field is padded out with trailing
zeros, with a caveat that the padded namesize can't exceed PATH_MAX.

Add filename zero-padding logic to gen_init_cpio, which can be triggered
via the new -a <data_align> parameter. Performance and storage
utilization is improved for Btrfs and XFS workloads, as copy_file_range
can reflink the entire source file into a filesystem block-size aligned
destination offset within the cpio archive.

Btrfs benchmarks run on 6.15.8-1-default (Tumbleweed) x86_64 host:
  > truncate --size=2G /tmp/backing.img
  > /sbin/mkfs.btrfs /tmp/backing.img
  ...
  Sector size:        4096        (CPU page size: 4096)
  ...
  > sudo mount /tmp/backing.img mnt
  > sudo chown $USER mnt
  > cd mnt
  mnt> dd if=/dev/urandom of=foo bs=1M count=20 && cat foo >/dev/null
  ...
  mnt> echo "file /foo foo 0755 0 0" > list
  mnt> perf stat -r 10 gen_init_cpio -o unaligned_btrfs list
  ...
            0.023496 +- 0.000472 seconds time elapsed  ( +-  2.01% )

  mnt> perf stat -r 10 gen_init_cpio -o aligned_btrfs -a 4096 list
  ...
           0.0010010 +- 0.0000565 seconds time elapsed  ( +-  5.65% )

  mnt> /sbin/xfs_io -c "fiemap -v" unaligned_btrfs
  unaligned_btrfs:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..40967]:      695040..736007   40968   0x1
  mnt> /sbin/xfs_io -c "fiemap -v" aligned_btrfs
  aligned_btrfs:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..7]:          26768..26775         8   0x0
     1: [8..40967]:      269056..310015   40960 0x2000
     2: [40968..40975]:  26776..26783         8   0x1
  mnt> /sbin/btrfs fi du unaligned_btrfs aligned_btrfs
       Total   Exclusive  Set shared  Filename
    20.00MiB    20.00MiB       0.00B  unaligned_btrfs
    20.01MiB     8.00KiB    20.00MiB  aligned_btrfs

XFS benchmarks run on same host:
  > sudo umount mnt && rm /tmp/backing.img
  > truncate --size=2G /tmp/backing.img
  > /sbin/mkfs.xfs /tmp/backing.img
  ...
           =                       reflink=1    ...
  data     =                       bsize=4096   blocks=524288, imaxpct=25
  ...
  > sudo mount /tmp/backing.img mnt
  > sudo chown $USER mnt
  > cd mnt
  mnt> dd if=/dev/urandom of=foo bs=1M count=20 && cat foo >/dev/null
  ...
  mnt> echo "file /foo foo 0755 0 0" > list
  mnt> perf stat -r 10 gen_init_cpio -o unaligned_xfs list
  ...
            0.011069 +- 0.000469 seconds time elapsed  ( +-  4.24% )

  mnt> perf stat -r 10 gen_init_cpio -o aligned_xfs -a 4096 list
  ...
            0.001273 +- 0.000288 seconds time elapsed  ( +- 22.60% )

  mnt> /sbin/xfs_io -c "fiemap -v" unaligned_xfs
   unaligned_xfs:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..40967]:      106176..147143   40968   0x0
     1: [40968..65023]:  147144..171199   24056 0x801
  mnt> /sbin/xfs_io -c "fiemap -v" aligned_xfs
   aligned_xfs:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..7]:          120..127             8   0x0
     1: [8..40967]:      192..41151       40960 0x2000
     2: [40968..40975]:  236728..236735       8   0x0
     3: [40976..106495]: 236736..302255   65520 0x801

The alignment is best-effort; a stderr message is printed if alignment
can't be achieved due to PATH_MAX overrun, with fallback to non-padded
filename. This allows it to still be useful for opportunistic alignment,
e.g. on aarch64 Btrfs with 64K block-size. Alignment failure messages
provide an indicator that reordering of the cpio-manifest may be
beneficial.

Archive read performance for reflinked initramfs images may suffer due
to the effects of fragmentation, particularly on spinning disks. To
mitigate excessive fragmentation, files with lengths less than
data_align aren't padded.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 usr/gen_init_cpio.c | 50 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/usr/gen_init_cpio.c b/usr/gen_init_cpio.c
index 40f4cbd95844e..75bf95d327171 100644
--- a/usr/gen_init_cpio.c
+++ b/usr/gen_init_cpio.c
@@ -28,13 +28,15 @@
 #define CPIO_TRAILER "TRAILER!!!"
 #define padlen(_off, _align) (((_align) - ((_off) & ((_align) - 1))) % (_align))
 
-static char padding[512];
+/* zero-padding the filename field for data alignment is limited by PATH_MAX */
+static char padding[PATH_MAX];
 static unsigned int offset;
 static unsigned int ino = 721;
 static time_t default_mtime;
 static bool do_file_mtime;
 static bool do_csum = false;
 static int outfd = STDOUT_FILENO;
+static unsigned int dalign;
 
 struct file_handler {
 	const char *type;
@@ -359,7 +361,7 @@ static int cpio_mkfile(const char *name, const char *location,
 	int file, retval, len;
 	int rc = -1;
 	time_t mtime;
-	int namesize;
+	int namesize, namepadlen;
 	unsigned int i;
 	uint32_t csum = 0;
 	ssize_t this_read;
@@ -407,14 +409,27 @@ static int cpio_mkfile(const char *name, const char *location,
 	}
 
 	size = 0;
+	namepadlen = 0;
 	for (i = 1; i <= nlinks; i++) {
-		/* data goes on last link */
-		if (i == nlinks)
-			size = buf.st_size;
-
 		if (name[0] == '/')
 			name++;
 		namesize = strlen(name) + 1;
+
+		/* data goes on last link, after any alignment padding */
+		if (i == nlinks)
+			size = buf.st_size;
+
+		if (dalign && size > dalign) {
+			namepadlen = padlen(offset + CPIO_HDR_LEN + namesize,
+					    dalign);
+			if (namesize + namepadlen > PATH_MAX) {
+				fprintf(stderr,
+					"%s: best-effort alignment %u missed\n",
+					name, dalign);
+				namepadlen = 0;
+			}
+		}
+
 		len = dprintf(outfd, "%s%08X%08X%08lX%08lX%08X%08lX"
 		       "%08lX%08X%08X%08X%08X%08X%08X",
 			do_csum ? "070702" : "070701", /* magic */
@@ -429,13 +444,13 @@ static int cpio_mkfile(const char *name, const char *location,
 			1,			/* minor */
 			0,			/* rmajor */
 			0,			/* rminor */
-			namesize,		/* namesize */
+			namesize + namepadlen,	/* namesize */
 			size ? csum : 0);	/* chksum */
 		offset += len;
 
 		if (len != CPIO_HDR_LEN
 		 || push_buf(name, namesize) < 0
-		 || push_pad(padlen(offset, 4)) < 0)
+		 || push_pad(namepadlen ? namepadlen : padlen(offset, 4)) < 0)
 			goto error;
 
 		if (size) {
@@ -552,8 +567,7 @@ static int cpio_mkfile_line(const char *line)
 static void usage(const char *prog)
 {
 	fprintf(stderr, "Usage:\n"
-		"\t%s [-t <timestamp>] [-c] [-o <output_path>] <cpio_list>\n"
-		"\n"
+		"\t%s [-t <timestamp>] [-c] [-o <output_path>] [-a <data_align>] <cpio_list>\n\n"
 		"<cpio_list> is a file containing newline separated entries that\n"
 		"describe the files to be included in the initramfs archive:\n"
 		"\n"
@@ -590,7 +604,10 @@ static void usage(const char *prog)
 		"The default is to use the current time for all files, but\n"
 		"preserve modification time for regular files.\n"
 		"-c: calculate and store 32-bit checksums for file data.\n"
-		"<output_path>: write cpio to this file instead of stdout\n",
+		"<output_path>: write cpio to this file instead of stdout\n"
+		"<data_align>: attempt to align file data by zero-padding the\n"
+		"filename field up to data_align. Must be a multiple of 4.\n"
+		"Alignment is best-effort; PATH_MAX limits filename padding.\n",
 		prog);
 }
 
@@ -632,7 +649,7 @@ int main (int argc, char *argv[])
 
 	default_mtime = time(NULL);
 	while (1) {
-		int opt = getopt(argc, argv, "t:cho:");
+		int opt = getopt(argc, argv, "t:cho:a:");
 		char *invalid;
 
 		if (opt == -1)
@@ -661,6 +678,15 @@ int main (int argc, char *argv[])
 				exit(1);
 			}
 			break;
+		case 'a':
+			dalign = strtoul(optarg, &invalid, 10);
+			if (!*optarg || *invalid || (dalign & 3)) {
+				fprintf(stderr, "Invalid data_align: %s\n",
+						optarg);
+				usage(argv[0]);
+				exit(1);
+			}
+			break;
 		case 'h':
 		case '?':
 			usage(argv[0]);
-- 
2.43.0


