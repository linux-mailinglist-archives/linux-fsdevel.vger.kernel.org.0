Return-Path: <linux-fsdevel+bounces-46285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EDA8612B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B6B3B9254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 15:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F21FBEA6;
	Fri, 11 Apr 2025 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b="YtgEwGQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pub.sortix.org (pub.sortix.org [88.99.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91D1F418D;
	Fri, 11 Apr 2025 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383614; cv=none; b=MbymljBcbuCCo9BB2atkxlF/o5+WDcA4T4zOVSWMSe43aNHQTOvsm/1+ZfXsEfkdI/mgF1Y4GLxItx5Y12CvhiRfJJtLevDOiekfqaTm9LtV+Exz24qQwziFzdPP9IZJlq3GUaY7mWz9kfB7zvtGalurl//2uQ5IxrW9Um7Pw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383614; c=relaxed/simple;
	bh=VPNLtC2XszoizTSw8VO2x421UjLkb77QCBbGwfVDW/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbBd6c154eBPfYhJxp+izcW52A+lLDSEInxnD1kO+hpOTOFMaRLNQj/vXd3qRlte2t6XlCJWBaH9sxNzF9YtCqP+aM2GdCbcbU9eu9BXm/PQXZiinRkXrGsBAXovWV1fGS6sgXKv4jTR64uiD/ximxrlxQdHkc4/cSkyULSb4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxsi.org; spf=pass smtp.mailfrom=maxsi.org; dkim=pass (2048-bit key) header.d=maxsi.org header.i=@maxsi.org header.b=YtgEwGQv; arc=none smtp.client-ip=88.99.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxsi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxsi.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=maxsi.org; s=default;
	t=1744383104; bh=VPNLtC2XszoizTSw8VO2x421UjLkb77QCBbGwfVDW/0=;
	h=From:To:Cc:Subject:Date:From;
	b=YtgEwGQvbFCF+jh19TvAqd8Wew+DsuWa+yj4DGLaRiGRpJ+d2iyd7UfOL/+tZntUF
	 ilNzMs+opihf3eYzXjU8T2Vy3OWGdQO5WCMC3jueyJWytjwOJXxcVsToYuFKVGKb1w
	 QWf8vvYmPuTKSUh9gIy2W7NaoOSeQ8jK94UrtASoKI08Yh97NIvvbabwA/dih4DHv0
	 OyVs0yy+PYT12rq+S+WONLxar8PBy6eqzW+HBuF/ZznC7SIqk0i/920oghMx1wJtey
	 AomGdvbfZ029pEa5hcM278RFl8ismfZ3O0EEhUfAoCQ/mVOyue9B4KR/ekanMw2i44
	 J8IaXXhYjFq2w==
Received: from sortie-pc1.bbsyd.net (unknown [85.203.218.26])
	by pub.sortix.org (Postfix) with ESMTPSA id 10FB322610B4;
	Fri, 11 Apr 2025 16:51:44 +0200 (CEST)
From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Schmitt <scdbackup@gmx.net>,
	Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH] isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry
Date: Fri, 11 Apr 2025 16:50:21 +0200
Message-ID: <20250411145022.2292255-1-sortie@maxsi.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change implements the Rock Ridge TF entry LONG_FORM bit, which uses
the ISO 9660 17-byte date format (up to year 9999, with 10ms precision)
instead of the 7-byte date format (up to year 2155, with 1s precision).

Previously the LONG_FORM bit was ignored; and isofs would entirely
misinterpret the date as the wrong format, resulting in garbage
timestamps on the filesystem.

The Y2038 issue in iso_date() is fixed by returning a struct timespec64
instead of an int.

parse_rock_ridge_inode_internal() is fixed so it does proper bounds
checks of the TF entry timestamps.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
I tested this change by making two .isos:

* A normal .iso with Rock Ridge TF without LONG_FORM made with xorriso
* A long-form .iso with Rock Ridge TF LONG_FORM made with a patched xorriso

Each containing these test files:

-rw-rw-r-- 1 root root       0 Apr 11 16:20 Y2025
-rw-rw-r-- 1 root root       0 Jun  1  2038 Y2038
-rw-rw-r-- 1 root root       0 Jun  1  2155 Y2155
-rw-rw-r-- 1 root root       0 Jun  1  2156 Y2156

The normal Rock Ridge .iso was made with xorriso, and a long form .iso was
made with a custom xorriso patched to output Rock Ridge TF LONG_FORM.

On Linux master mounting an iso without LONG_FORM:

-r--r--r--  1 root root       0 Apr 11 16:20 Y2025
-r--r--r--  1 root root       0 Apr 25  1902 Y2038
-r--r--r--  1 root root       0 Apr 24  2019 Y2155
-r--r--r--  1 root root       0 Nov 24  2019 Y2156

(Y2025 is correct; Y2038, Y2155, and Y2156 are garbage)

On Linux master mounting an iso with LONG_FORM:

-r--r--r--  1 root root       0 Jan 25  1954 Y2025
-r--r--r--  1 root root       0 Jan 26  1954 Y2038
-r--r--r--  1 root root       0 Feb 28  1954 Y2155
-r--r--r--  1 root root       0 Feb 28  1954 Y2156

(All timestamps are garbage)

With this patch, mounting an iso without LONG_FORM:

-r--r--r--  1 root root       0 Apr 11 16:20 Y2025
-r--r--r--  1 root root       0 Jun  1  2038 Y2038
-r--r--r--  1 root root       0 Jun  1  2155 Y2155
-r--r--r--  1 root root       0 Jan  1  2156 Y2156

(Y2025, Y2038, and Y2155 are correct;
 Y2156 was correctly truncated by xorriso)

With this patch, mounting an iso with LONG_FORM:

-r--r--r--  1 root root       0 Apr 11 16:20 Y2025
-r--r--r--  1 root root       0 Jun  1  2038 Y2038
-r--r--r--  1 root root       0 Jun  1  2155 Y2155
-r--r--r--  1 root root       0 Jun  1  2156 Y2156

(All timestamps are correct)
---
 fs/isofs/inode.c |  7 +++++--
 fs/isofs/isofs.h |  4 +++-
 fs/isofs/rock.c  | 40 ++++++++++++++++++++++-----------------
 fs/isofs/rock.h  |  6 +-----
 fs/isofs/util.c  | 49 +++++++++++++++++++++++++++++++-----------------
 5 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 47038e660812..d5da9817df9b 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1275,6 +1275,7 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 	unsigned long offset;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 	int ret = -EIO;
+	struct timespec64 ts;
 
 	block = ei->i_iget5_block;
 	bh = sb_bread(inode->i_sb, block);
@@ -1387,8 +1388,10 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 			inode->i_ino, de->flags[-high_sierra]);
 	}
 #endif
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_set_ctime(inode, iso_date(de->date, high_sierra), 0)));
+	ts = iso_date(de->date, high_sierra ? ISO_DATE_HIGH_SIERRA : 0);
+	inode_set_ctime_to_ts(inode, ts);
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
 
 	ei->i_first_extent = (isonum_733(de->extent) +
 			isonum_711(de->ext_attr_length));
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 2d55207c9a99..506555837533 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -106,7 +106,9 @@ static inline unsigned int isonum_733(u8 *p)
 	/* Ignore bigendian datum due to broken mastering programs */
 	return get_unaligned_le32(p);
 }
-extern int iso_date(u8 *, int);
+#define ISO_DATE_HIGH_SIERRA (1 << 0)
+#define ISO_DATE_LONG_FORM (1 << 1)
+struct timespec64 iso_date(u8 *p, int flags);
 
 struct inode;		/* To make gcc happy */
 
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index dbf911126e61..576498245b9d 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -412,7 +412,12 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				}
 			}
 			break;
-		case SIG('T', 'F'):
+		case SIG('T', 'F'): {
+			int flags, size, slen;
+
+			flags = rr->u.TF.flags & TF_LONG_FORM ? ISO_DATE_LONG_FORM : 0;
+			size = rr->u.TF.flags & TF_LONG_FORM ? 17 : 7;
+			slen = rr->len - 5;
 			/*
 			 * Some RRIP writers incorrectly place ctime in the
 			 * TF_CREATE field. Try to handle this correctly for
@@ -420,27 +425,28 @@ parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 			 */
 			/* Rock ridge never appears on a High Sierra disk */
 			cnt = 0;
-			if (rr->u.TF.flags & TF_CREATE) {
-				inode_set_ctime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_CREATE) && size <= slen) {
+				inode_set_ctime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_MODIFY) {
-				inode_set_mtime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_MODIFY) && size <= slen) {
+				inode_set_mtime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_ACCESS) {
-				inode_set_atime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_ACCESS) && size <= slen) {
+				inode_set_atime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
-			if (rr->u.TF.flags & TF_ATTRIBUTES) {
-				inode_set_ctime(inode,
-						iso_date(rr->u.TF.times[cnt++].time, 0),
-						0);
+			if ((rr->u.TF.flags & TF_ATTRIBUTES) && size <= slen) {
+				inode_set_ctime_to_ts(inode,
+						iso_date(rr->u.TF.data + size * cnt++, flags));
+				slen -= size;
 			}
 			break;
+		}
 		case SIG('S', 'L'):
 			{
 				int slen;
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index 7755e587f778..c0856fa9bb6a 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -65,13 +65,9 @@ struct RR_PL_s {
 	__u8 location[8];
 };
 
-struct stamp {
-	__u8 time[7];		/* actually 6 unsigned, 1 signed */
-} __attribute__ ((packed));
-
 struct RR_TF_s {
 	__u8 flags;
-	struct stamp times[];	/* Variable number of these beasts */
+	__u8 data[];
 } __attribute__ ((packed));
 
 /* Linux-specific extension for transparent decompression */
diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index e88dba721661..42f479da0b28 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -16,29 +16,44 @@
  * to GMT.  Thus  we should always be correct.
  */
 
-int iso_date(u8 *p, int flag)
+struct timespec64 iso_date(u8 *p, int flags)
 {
 	int year, month, day, hour, minute, second, tz;
-	int crtime;
+	struct timespec64 ts;
+
+	if (flags & ISO_DATE_LONG_FORM) {
+		year = (p[0] - '0') * 1000 +
+		       (p[1] - '0') * 100 +
+		       (p[2] - '0') * 10 +
+		       (p[3] - '0') - 1900;
+		month = ((p[4] - '0') * 10 + (p[5] - '0'));
+		day = ((p[6] - '0') * 10 + (p[7] - '0'));
+		hour = ((p[8] - '0') * 10 + (p[9] - '0'));
+		minute = ((p[10] - '0') * 10 + (p[11] - '0'));
+		second = ((p[12] - '0') * 10 + (p[13] - '0'));
+		ts.tv_nsec = ((p[14] - '0') * 10 + (p[15] - '0')) * 10000000;
+		tz = p[16];
+	} else {
+		year = p[0];
+		month = p[1];
+		day = p[2];
+		hour = p[3];
+		minute = p[4];
+		second = p[5];
+		ts.tv_nsec = 0;
+		/* High sierra has no time zone */
+		tz = flags & ISO_DATE_HIGH_SIERRA ? 0 : p[6];
+	}
 
-	year = p[0];
-	month = p[1];
-	day = p[2];
-	hour = p[3];
-	minute = p[4];
-	second = p[5];
-	if (flag == 0) tz = p[6]; /* High sierra has no time zone */
-	else tz = 0;
-	
 	if (year < 0) {
-		crtime = 0;
+		ts.tv_sec = 0;
 	} else {
-		crtime = mktime64(year+1900, month, day, hour, minute, second);
+		ts.tv_sec = mktime64(year+1900, month, day, hour, minute, second);
 
 		/* sign extend */
 		if (tz & 0x80)
 			tz |= (-1 << 8);
-		
+
 		/* 
 		 * The timezone offset is unreliable on some disks,
 		 * so we make a sanity check.  In no case is it ever
@@ -65,7 +80,7 @@ int iso_date(u8 *p, int flag)
 		 * for pointing out the sign error.
 		 */
 		if (-52 <= tz && tz <= 52)
-			crtime -= tz * 15 * 60;
+			ts.tv_sec -= tz * 15 * 60;
 	}
-	return crtime;
-}		
+	return ts;
+}
-- 
2.47.2


