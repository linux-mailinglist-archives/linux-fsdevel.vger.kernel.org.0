Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8EB22F5FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgG0RDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 13:03:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56132 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgG0RDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:03:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGhCP5077272;
        Mon, 27 Jul 2020 17:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=P/3elD8YdvsiVdf2i288xCJTu+wr4zknX8/P6Cp077g=;
 b=NrvwWQqv1q559vr/YBsf0ZN/buPKnYUD/hsr8sCxcSmGujTbKM5N4rE5JCntF+3l/+9V
 XHT6ui7C2ZDho2rpiA5Ny5NxcILBwBIHG+jd+SiJXdlaQBVst0HNh4OuVcqTV4XxWJZk
 RqxMhMwjUwzrJhkoYmn481XYfUqCfeBr3OyfhMn7o8lK2JOM7bLv7wMkuKrD6dhSayAK
 Wo4dWA4+v1j86v+yJLXXjZLBNPuaoH4PtAZ3TScGc71HrFiY2qLHCOHGAGEsdO2CNA7r
 tDgFY/MUdRruzAOTw0wOxabd5jl8iTB7Cdhtk2ChBIZWRyZROiDh0VKKem3mlnyboHG1 ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1j2rux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgWHd055648;
        Mon, 27 Jul 2020 17:02:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 32hu5r9f9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:02:11 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06RGuWGf111604;
        Mon, 27 Jul 2020 17:02:10 GMT
Received: from ca-qasparc-x86-2.us.oracle.com (ca-qasparc-x86-2.us.oracle.com [10.147.24.103])
        by userp3020.oracle.com with ESMTP id 32hu5r9f7r-2;
        Mon, 27 Jul 2020 17:02:10 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
Subject: [RFC PATCH 1/5] elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
Date:   Mon, 27 Jul 2020 10:11:23 -0700
Message-Id: <1595869887-23307-2-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=2 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf
executable mappings") reverted back to using MAP_FIXED to map elf load
segments because it was found that the load segments in some binaries
overlap and can cause MAP_FIXED_NOREPLACE to fail.  The original intent
of MAP_FIXED_NOREPLACE was to prevent the silent clobbering of an
existing mapping (e.g. the stack) by the elf image.  To achieve this,
expand on the logic used when loading ET_DYN binaries which calculates a
total size for the image when the first segment is mapped, maps the
entire image, and then unmaps the remainder before remaining segments
are mapped.  Apply this to ET_EXEC binaries as well as ET_DYN binaries
as is done now, and for both ET_EXEC and ET_DYN+INTERP use
MAP_FIXED_NOREPLACE for the initial total size mapping and MAP_FIXED for
remaining mappings.  For ET_DYN w/out INTERP, continue to map at a
system-selected address in the mmap region.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/binfmt_elf.c | 112 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a..6445a6dbdb1d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1046,58 +1046,25 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * If we are loading ET_EXEC or we have already performed
-		 * the ET_DYN load_addr calculations, proceed normally.
+		 * Map remaining segments with MAP_FIXED once the first
+		 * total size mapping has been done.
 		 */
-		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
+		if (load_addr_set) {
 			elf_flags |= MAP_FIXED;
-		} else if (elf_ex->e_type == ET_DYN) {
-			/*
-			 * This logic is run once for the first LOAD Program
-			 * Header for ET_DYN binaries to calculate the
-			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
-			 *
-			 * There are effectively two types of ET_DYN
-			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
-			 * and loaders (ET_DYN without INTERP, since they
-			 * _are_ the ELF interpreter). The loaders must
-			 * be loaded away from programs since the program
-			 * may otherwise collide with the loader (especially
-			 * for ET_EXEC which does not have a randomized
-			 * position). For example to handle invocations of
-			 * "./ld.so someprog" to test out a new version of
-			 * the loader, the subsequent program that the
-			 * loader loads must avoid the loader itself, so
-			 * they cannot share the same load range. Sufficient
-			 * room for the brk must be allocated with the
-			 * loader as well, since brk must be available with
-			 * the loader.
-			 *
-			 * Therefore, programs are loaded offset from
-			 * ELF_ET_DYN_BASE and loaders are loaded into the
-			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
-			 */
-			if (interpreter) {
-				load_bias = ELF_ET_DYN_BASE;
-				if (current->flags & PF_RANDOMIZE)
-					load_bias += arch_mmap_rnd();
-				elf_flags |= MAP_FIXED;
-			} else
-				load_bias = 0;
-
+		} else {
 			/*
-			 * Since load_bias is used for all subsequent loading
-			 * calculations, we must lower it by the first vaddr
-			 * so that the remaining calculations based on the
-			 * ELF vaddrs will be correctly offset. The result
-			 * is then page aligned.
+			 * To ensure loading does not continue if an ELF
+			 * LOAD segment overlaps an existing mapping (e.g.
+			 * the stack), for the first LOAD Program Header
+			 * calculate the the entire size of the ELF mapping
+			 * and map it with MAP_FIXED_NOREPLACE. On success,
+			 * the remainder will be unmapped and subsequent
+			 * LOAD segments mapped with MAP_FIXED rather than
+			 * MAP_FIXED_NOREPLACE because some binaries may
+			 * have overlapping segments that would cause the
+			 * mmap to fail.
 			 */
-			load_bias = ELF_PAGESTART(load_bias - vaddr);
+			elf_flags |= MAP_FIXED_NOREPLACE;
 
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
@@ -1105,6 +1072,55 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				retval = -EINVAL;
 				goto out_free_dentry;
 			}
+
+			if (elf_ex->e_type == ET_DYN) {
+				/*
+				 * This logic is run once for the first LOAD
+				 * Program Header for ET_DYN binaries to
+				 * calculate the randomization (load_bias) for
+				 * all the LOAD Program Headers.
+				 *
+				 * There are effectively two types of ET_DYN
+				 * binaries: programs (i.e. PIE: ET_DYN with
+				 * INTERP) and loaders (ET_DYN without INTERP,
+				 * since they _are_ the ELF interpreter). The
+				 * loaders must be loaded away from programs
+				 * since the program may otherwise collide with
+				 * the loader (especially for ET_EXEC which does
+				 * not have a randomized position). For example
+				 * to handle invocations of "./ld.so someprog"
+				 * to test out a new version of the loader, the
+				 * subsequent program that the loader loads must
+				 * avoid the loader itself, so they cannot share
+				 * the same load range. Sufficient room for the
+				 * brk must be allocated with the loader as
+				 * well, since brk must be available with the
+				 * loader.
+				 *
+				 * Therefore, programs are loaded offset from
+				 * ELF_ET_DYN_BASE and loaders are loaded into
+				 * the independently randomized mmap region
+				 * (0 load_bias without MAP_FIXED*).
+				 */
+				if (interpreter) {
+					load_bias = ELF_ET_DYN_BASE;
+					if (current->flags & PF_RANDOMIZE)
+						load_bias += arch_mmap_rnd();
+				} else {
+					load_bias = 0;
+					elf_flags &= ~MAP_FIXED_NOREPLACE;
+				}
+
+				/*
+				 * Since load_bias is used for all subsequent
+				 * loading calculations, we must lower it by
+				 * the first vaddr so that the remaining
+				 * calculations based on the ELF vaddrs will
+				 * be correctly offset. The result is then
+				 * page aligned.
+				 */
+				load_bias = ELF_PAGESTART(load_bias - vaddr);
+			}
 		}
 
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
-- 
1.8.3.1

