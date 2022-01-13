Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA08D48D0E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 04:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiAMD1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 22:27:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232062AbiAMD0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:26:52 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D2Een9009015;
        Thu, 13 Jan 2022 03:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=knrZoOq0zPyYTCmlCIGKZ4ymCs9R2rtgHkXfvszrbbY=;
 b=PjkBWD5S7MBO2jaAC3mu/sQHtnspnjQ1WUkEsEnA6T0UOb/nT1Qczk7sMR0nvUlyqEV/
 TBcsEZeSLUBDIt2Lyib2hdxggFEBQVZ4D6U+ZRjqS0neAoEwnmduFVZ5xXe1dYGFyQF0
 iDxPn4k4l8mkFuS3zQmoTuVycgAL/vFXbAEsC9PV0xfJfcURsy+zMg96POuVcAH6Tw9W
 5yGkPJrVK7+1UpVqK9zXj85Mr/ks6+ehXb6vGx7+HU9rdBSYuAUDc4Uoobsej0N0WkIu
 ma5qt608D52zHsM+s6drl9d87yOWaRAIhbYuNuB6F87DFVos1iGPy84Jd+it8WcUOEu3 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj79pvggw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:47 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20D3QlfJ005873;
        Thu, 13 Jan 2022 03:26:47 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dj79pvggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20D3DEWQ015912;
        Thu, 13 Jan 2022 03:26:45 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3df289gnh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 03:26:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20D3HcwO48038260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 03:17:38 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B7C4A405F;
        Thu, 13 Jan 2022 03:26:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C0DA4062;
        Thu, 13 Jan 2022 03:26:42 +0000 (GMT)
Received: from localhost (unknown [9.43.54.234])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 03:26:42 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 4/6] jbd2: Cleanup unused functions declarations from jbd2.h
Date:   Thu, 13 Jan 2022 08:56:27 +0530
Message-Id: <bd827c4a3a5b369fe4391b5fc929a00a08af8184.1642044249.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642044249.git.riteshh@linux.ibm.com>
References: <cover.1642044249.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hJNr0Rx5-unfd71RponBhDI4xXD08JnS
X-Proofpoint-GUID: 6zUxCYaqJvUyB-zMshQ6O-VX_Bj9gIOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_01,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=618 impostorscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130013
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During code review found no references of few of these below function
declarations. This patch cleans those up from jbd2.h

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 include/linux/jbd2.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index fd933c45281a..f76598265896 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1419,9 +1419,7 @@ extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
 extern bool __jbd2_journal_refile_buffer(struct journal_head *);
 extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
 extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
-extern void __journal_free_buffer(struct journal_head *bh);
 extern void jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
-extern void __journal_clean_data_list(transaction_t *transaction);
 static inline void jbd2_file_log_bh(struct list_head *head, struct buffer_head *bh)
 {
 	list_add_tail(&bh->b_assoc_buffers, head);
@@ -1486,9 +1484,6 @@ extern int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 					      struct buffer_head **bh_out,
 					      sector_t blocknr);
 
-/* Transaction locking */
-extern void		__wait_on_journal (journal_t *);
-
 /* Transaction cache support */
 extern void jbd2_journal_destroy_transaction_cache(void);
 extern int __init jbd2_journal_init_transaction_cache(void);
@@ -1774,8 +1769,6 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
 #define BJ_Reserved	4	/* Buffer is reserved for access by journal */
 #define BJ_Types	5
 
-extern int jbd_blocks_per_page(struct inode *inode);
-
 /* JBD uses a CRC32 checksum */
 #define JBD_MAX_CHECKSUM_SIZE 4
 
-- 
2.31.1

