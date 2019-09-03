Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 976D6A66E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfICK4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 06:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbfICK4p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2200C055673;
        Tue,  3 Sep 2019 10:56:44 +0000 (UTC)
Received: from dhcp-12-115.nay.redhat.com (dhcp-12-115.nay.redhat.com [10.66.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D63060C83;
        Tue,  3 Sep 2019 10:56:38 +0000 (UTC)
From:   "Jianhong.Yin" <yin-jianhong@163.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     lsahlber@redhat.com, alexander198961@gmail.com,
        fengxiaoli0714@gmail.com, dchinner@redhat.com, sandeen@redhat.com,
        "Jianhong.Yin" <yin-jianhong@163.com>
Subject: [PATCH] xfsprogs: io/copy_range: cover corner case (fd_in == fd_out)
Date:   Tue,  3 Sep 2019 18:56:32 +0800
Message-Id: <20190903105632.11667-1-yin-jianhong@163.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 10:56:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Related bug:
  copy_file_range return "Invalid argument" when copy in the same file
  https://bugzilla.kernel.org/show_bug.cgi?id=202935

if argument of option -f is "-", use current file->fd as fd_in

Usage:
  xfs_io -c 'copy_range -f -' some_file

Signed-off-by: Jianhong Yin <yin-jianhong@163.com>
---
 io/copy_file_range.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/io/copy_file_range.c b/io/copy_file_range.c
index b7b9fd88..2dde8a31 100644
--- a/io/copy_file_range.c
+++ b/io/copy_file_range.c
@@ -28,6 +28,7 @@ copy_range_help(void)
                           at position 0\n\
  'copy_range -f 2' - copies all bytes from open file 2 into the current open file\n\
                           at position 0\n\
+ 'copy_range -f -' - copies all bytes from current open file append the current open file\n\
 "));
 }
 
@@ -114,11 +115,15 @@ copy_range_f(int argc, char **argv)
 			}
 			break;
 		case 'f':
-			src_file_nr = atoi(argv[1]);
-			if (src_file_nr < 0 || src_file_nr >= filecount) {
-				printf(_("file value %d is out of range (0-%d)\n"),
-					src_file_nr, filecount - 1);
-				return 0;
+			if (strcmp(argv[1], "-"))
+				src_file_nr = (file - &filetable[0]) / sizeof(fileio_t);
+			else {
+				src_file_nr = atoi(argv[1]);
+				if (src_file_nr < 0 || src_file_nr >= filecount) {
+					printf(_("file value %d is out of range (0-%d)\n"),
+						src_file_nr, filecount - 1);
+					return 0;
+				}
 			}
 			/* Expect no src_path arg */
 			src_path_arg = 0;
@@ -147,10 +152,14 @@ copy_range_f(int argc, char **argv)
 		}
 		len = sz;
 
-		ret = copy_dst_truncate();
-		if (ret < 0) {
-			ret = 1;
-			goto out;
+		if (fd != file->fd) {
+			ret = copy_dst_truncate();
+			if (ret < 0) {
+				ret = 1;
+				goto out;
+			}
+		} else {
+			dst = sz;
 		}
 	}
 
-- 
2.17.2

