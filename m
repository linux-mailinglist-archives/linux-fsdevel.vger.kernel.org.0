Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD77924DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjIEQAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354262AbjIEK2X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:28:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397E0DB;
        Tue,  5 Sep 2023 03:28:20 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385A8qF7009867;
        Tue, 5 Sep 2023 10:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uU2Kjcaqz2O8gsF9eeW+cu28CVHN/LMaD6vkk9CZ6b8=;
 b=g6WjpWic+e6PTvYdUE9Z2LlRBugle8LhXX0U2vWI7aV8o4XGtSMGTht46A82xUoyh/ft
 AahTafm2lP/IF6NLTgtFjiTnHSVRQzj7gFR3QWUX5s4MGHDT8Yz0H8RPCieMIsaQ6Q/M
 /lKXWOrzDDRdNHl0iY8TV3wvxO5Zb1AAhM7wqNTX4DaUrnjAbsuRTRgRO7mw39N4Lp+E
 NBCBf73On+i1f0eGitwhfBxNaoVLJoHWYdh6yQBakYbT1UQWVrM5bNg3RgsgId6347Gx
 NUm5Dgj6uFoOQqVkxzlQoqo+XWFCvo0xdGPT0EamJ+T2BVho/E+62duQUA2Oyet5tOZq MQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx1mrsaak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:28:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385A7bdJ006710;
        Tue, 5 Sep 2023 10:28:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvk9mh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:28:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385AS7DK46924144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 10:28:07 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAE5C20043;
        Tue,  5 Sep 2023 10:28:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7D4920040;
        Tue,  5 Sep 2023 10:28:04 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 10:28:04 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/1] ext4: Mark buffer new if it is unwritten to avoid stale data exposure
Date:   Tue,  5 Sep 2023 15:58:01 +0530
Message-Id: <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1693909504.git.ojaswin@linux.ibm.com>
References: <cover.1693909504.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 962oR0MvGJuTU-VT9Y9-VST0YFVHWbJm
X-Proofpoint-GUID: 962oR0MvGJuTU-VT9Y9-VST0YFVHWbJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

** Short Version **

In ext4 with dioread_nolock, we could have a scenario where the bh returned by
get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
never zero out the range of bh that is not under write, causing whatever stale
data is present in the folio at that time to be written out to disk. To fix this
mark the buffer as new in _ext4_get_block(), in case it is unwritten.

-----
** Long Version **

The issue mentioned above was resulting in two different bugs:

1. On block size < page size case in ext4, generic/269 was reliably
failing with dioread_nolock. The state of the write was as follows:

  * The write was extending i_size.
  * The last block of the file was fallocated and had an unwritten extent
  * We were near ENOSPC and hence we were switching to non-delayed alloc
    allocation.

In this case, the back trace that triggers the bug is as follows:

  ext4_da_write_begin()
    /* switch to nodelalloc due to low space */
    ext4_write_begin()
      ext4_should_dioread_nolock() // true since mount flags still have delalloc
      __block_write_begin(..., ext4_get_block_unwritten)
        __block_write_begin_int()
          for(each buffer head in page) {
            /* first iteration, this is bh1 which contains i_size */
            if (!buffer_mapped)
              get_block() /* returns bh with only UNWRITTEN and MAPPED */
            /* second iteration, bh2 */
              if (!buffer_mapped)
                get_block() /* we fail here, could be ENOSPC */
          }
          if (err)
            /*
             * this would zero out all new buffers and mark them uptodate.
             * Since bh1 was never marked new, we skip it here which causes
             * the bug later.
             */
            folio_zero_new_buffers();
      /* ext4_wrte_begin() error handling */
      ext4_truncate_failed_write()
        ext4_truncate()
          ext4_block_truncate_page()
            __ext4_block_zero_page_range()
              if(!buffer_uptodate())
                ext4_read_bh_lock()
                  ext4_read_bh() -> ... ext4_submit_bh_wbc()
                    BUG_ON(buffer_unwritten(bh)); /* !!! */

2. The second issue is stale data exposure with page size >= blocksize
with dioread_nolock. The conditions needed for it to happen are same as
the previous issue ie dioread_nolock around ENOSPC condition. The issue
is also similar where in __block_write_begin_int() when we call
ext4_get_block_unwritten() on the buffer_head and the underlying extent
is unwritten, we get an unwritten and mapped buffer head. Since it is
not new, we never zero out the partial range which is not under write,
thus writing stale data to disk. This can be easily observed with the
following reporducer:

 fallocate -l 4k testfile
 xfs_io -c "pwrite 2k 2k" testfile
 # hexdump output will have stale data in from byte 0 to 2k in testfile
 hexdump -C testfile

NOTE: To trigger this, we need dioread_nolock enabled and write
happening via ext4_write_begin(), which is usually used when we have -o
nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
alternate way to call ext4_write_begin() is to fill make sure dellayed
alloc switches to nodelalloc (ext4_da_write_begin() calls
ext4_write_begin()).  This will usually happen when FS is almost full
like the way generic/269 was triggering it in Issue 1 above. This might
make this issue harder to replicate hence for reliable replicate, I used
the below patch to temporarily allow dioread_nolock with nodelalloc and
then mount the disk with -o nodealloc,dioread_nolock. With this you can
hit the stale data issue 100% of times:

@@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
  if (ext4_should_journal_data(inode))
    return 0;
  /* temporary fix to prevent generic/422 test failures */
- if (!test_opt(inode->i_sb, DELALLOC))
-   return 0;
+ // if (!test_opt(inode->i_sb, DELALLOC))
+ //  return 0;
  return 1;
 }

-------

After applying this patch to mark buffer as NEW, both the above issues are
fixed.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6c490f05e2ba..a30bfec0b525 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -765,6 +765,10 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
 	if (ret > 0) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		ext4_update_bh_state(bh, map.m_flags);
+
+		if (buffer_unwritten(bh))
+			set_buffer_new(bh);
+
 		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
 		ret = 0;
 	} else if (ret == 0) {
-- 
2.31.1

