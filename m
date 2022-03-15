Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6B4D9D82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349180AbiCOOaZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349168AbiCOOaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1851454FA5;
        Tue, 15 Mar 2022 07:29:08 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FEBntF025147;
        Tue, 15 Mar 2022 14:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Gp5DiJeUrH8zW1k2ACTM5dIm57d7tSl3Rc4KMsW70y4=;
 b=Z5nLS2BM5wGVTrDAFhHoL4PbntbnaobbnomJnxS+4QbvymHYasRku6ZXCYp8mTX5gXuk
 l550+0vo5fqrlDUfEcbZo1yQBGN3LxtjnfFnQqyhF7PSEM/TZUMSfVc4ydgp/0uCN4XG
 CSVb1uGsl28Px1KHJO+33wyLQ3dojUrwfNaeIcJmJFDXNSEc+nSvJDj3OF5e+DtON40n
 GGCrh74HgdFPZ5oLGvioPzuxGP9OxnA1O/LAWFaOzXM8RmLMBZNZkGIJ/+I7rv5Z6hNn
 bnZjBAMs3XEFVwaFuw2dxqTQm2MSZjxoBn6PToo77jfikEu6GGOpuVIhMY6rgyHWX6iA VA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3etvbm8eqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:08 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22FERUJG015197;
        Tue, 15 Mar 2022 14:29:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3erk58nu10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 14:29:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22FET4Bk45875638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 14:29:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E758AA4060;
        Tue, 15 Mar 2022 14:29:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B99A405C;
        Tue, 15 Mar 2022 14:29:03 +0000 (GMT)
Received: from localhost (unknown [9.43.32.151])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Mar 2022 14:29:02 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 0/4] generic: Add some tests around journal replay/recoveryloop
Date:   Tue, 15 Mar 2022 19:58:55 +0530
Message-Id: <cover.1647342932.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kYFfgd5CwRRV6r-FWWWeEJFZD0GNw14T
X-Proofpoint-ORIG-GUID: kYFfgd5CwRRV6r-FWWWeEJFZD0GNw14T
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=924
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Sending v2 with tests/ext4/ converted to tests/generic/
(although I had not received any review comments on v1).
It seems all of the tests which I had sent in v1 are not ext4 specific anyways.
So in v2, I have made those into tests/generic/.

These are some of the tests which when tested with ext4 fast_commit feature
w/o kernel fixes, could cause tests failures and/or KASAN bug (generic/486).

I gave these tests a run with default xfs, btrfs and f2fs configs (along with
ext4). No surprises observed.

[v1]: https://lore.kernel.org/all/cover.1644070604.git.riteshh@linux.ibm.com/

Ritesh Harjani (4):
  generic/468: Add another falloc test entry
  common/punch: Add block_size argument to _filter_fiemap_**
  generic/676: Add a new shutdown recovery test
  generic/677: Add a test to check unwritten extents tracking

 common/punch          | 12 +++++---
 tests/generic/468     |  4 +++
 tests/generic/468.out |  2 ++
 tests/generic/676     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/676.out |  7 +++++
 tests/generic/677     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/generic/677.out |  6 ++++
 7 files changed, 162 insertions(+), 5 deletions(-)
 create mode 100755 tests/generic/676
 create mode 100644 tests/generic/676.out
 create mode 100755 tests/generic/677
 create mode 100644 tests/generic/677.out

--
2.31.1

