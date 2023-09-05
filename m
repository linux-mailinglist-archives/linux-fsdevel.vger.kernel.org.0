Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC807924D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjIEP76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354261AbjIEK2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:28:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F1FDB;
        Tue,  5 Sep 2023 03:28:15 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385A87qV001076;
        Tue, 5 Sep 2023 10:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Oh40OS0X+fK3/Z/1pwq5gInvd9fxd3XwJwnbR8khFQM=;
 b=jz78yk6hEI7V5HkLYFIavH9SqreOkOYdpIVtl+XbdSsyVzBExQvEchfiqzXZzkgYUl2h
 1Gt6AKiDQ1s+ZWFGS+HyuWHCg8HhL5j/GQ+rn8oc/Wb/gwTBpnP8C8xUfk3I4+fp+Dj6
 ZOSwBlw9afLdoxd80mm5InAeQCqQea4ze2yYRGbUzh2HULaiAoWUb6B1rqjnUFIdcDm5
 ZoGT5Ys6TCP9bc4FtVqpDXshRZK3r/Ds8rPm9SigV38jEgUz5GgDMBz9HcBCTVzMgiQL
 Xc+2t5W1jj5LCYpzFQIRMWUvluSmCaBbrMzrXK3cTUxuIjpFdtu3M4JRu8Ksm8Cxo76z 2w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3swxyd59pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:28:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3858ohYY011121;
        Tue, 5 Sep 2023 10:28:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31h80w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 10:28:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385AS40L44827104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 10:28:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AFF120043;
        Tue,  5 Sep 2023 10:28:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C367C20040;
        Tue,  5 Sep 2023 10:28:02 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 10:28:02 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/1] ext4: Fix stale data exposure caused with dioread_nolock 
Date:   Tue,  5 Sep 2023 15:58:00 +0530
Message-Id: <cover.1693909504.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OphxttHMQJgk-YaQiRkaXClZQIGeBmvd
X-Proofpoint-ORIG-GUID: OphxttHMQJgk-YaQiRkaXClZQIGeBmvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=828 clxscore=1011 bulkscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The detailed report on the issues faced and the root cause can be found
in the commit message. I've intentionally added all the details to
commit message so that it can be tracked in the future, let me know if
its too long and I can try stripping some info.

For this particular fix, I've tested these patches with xfstests -g
quick with:

- 64k block size, 64k pagesize 
- 4k blocksize 64k pagesize
- both with and without nodelalloc 

and I don't see any regressions. I'll plan to run more tests on this and
report back if I notice anything. Suggestions or ideas are welcome.

Regards,
ojaswin

Ojaswin Mujoo (1):
  ext4: Mark buffer new if it is unwritten to avoid stale data exposure

 fs/ext4/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.31.1

