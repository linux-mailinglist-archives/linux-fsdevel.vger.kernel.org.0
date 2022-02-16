Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D8A4B817F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 08:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiBPH1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 02:27:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiBPH1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:27:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251B2DD63;
        Tue, 15 Feb 2022 23:26:54 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21G5ep9H024639;
        Wed, 16 Feb 2022 07:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jtH1pPjry3jraE5+mHy3i2+OKX8n0us0+3wvxhnh7/4=;
 b=RfeUdSe3ttw/3fPwZGbtZ4lMBem+xuIEhL5ZFcH4/Dvg4hTUgW0gGeieO3Cfb0D8xSHO
 bb1NdyLnRrEnkuxgVIFirdAgKgXE6xim2TR9zO1JJnkhNY8ZHpGtg2vmoxAqyPqLW/7X
 9zbfUem+bHZKvsDiu1l/qWPYed+j/HdEzW3m39Oi+k6D/TZh5UaST8UYkYTbUzFsuPJm
 YNtvaoIwuiN6xaASdROXdXCsv7txrrm2XM5W+/+uorhkJPgXJKvW1Z5YzdENceI+76oW
 Wo9zXniKL0lLnvlN7kwVgmAHcs8ZRygvxPqDlQ/dMwWoJSBo6uU5tuDYHKq9JpUH0wyf uA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8spgb5cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:52 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21G6rvK8029514;
        Wed, 16 Feb 2022 07:00:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3e645jv1rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 07:00:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21G70lre42205588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 07:00:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D953DA405B;
        Wed, 16 Feb 2022 07:00:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67AB6A4054;
        Wed, 16 Feb 2022 07:00:47 +0000 (GMT)
Received: from localhost (unknown [9.43.85.173])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 07:00:47 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 REBASED 0/2] jbd2: Kill t_handle_lock transaction spinlock
Date:   Wed, 16 Feb 2022 12:30:34 +0530
Message-Id: <cover.1644992076.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9X8wXBpTY6itGfgz1CeVG0IEdk2_SSjp
X-Proofpoint-ORIG-GUID: 9X8wXBpTY6itGfgz1CeVG0IEdk2_SSjp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_02,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=643
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This is mainly just rebasing the patch series on top of recent use-after-free
fix submitted [4], due to conflict in function jbd2_journal_wait_updates().
No other changes apart from that.


Testing
========
I have again tested xfstests with -g log,metadata,auto group with 4k bs
config (COFIG_KASAN disabled). I haven't found any regression due to these
patches in my testing.


Original cover letter
======================
This small patch series kills the age-old t_handle_lock transaction spinlock,
which on careful inspection, came out to be not very useful anymore.
At some of the places it isn't required at all now and for the rest
(e.g. update_t_max_wait()), we could make use of atomic cmpxchg to make the
code path lockless.

This was tested with fstests with -g quick and -g log on my qemu setup.
I had also done some extensive fsmark testing to see that we don't see any
bottleneck resulting from removal of CONFIG_JBD2_DEBUG to update t_max_wait
in patch-2. None of my test showed any bottleneck.

Note that there had been several patches in the past over time which had led to
t_handle_lock becoming obselete now e.g. [1-2]
In this work, couple of the code paths to remove this spinlock were observed
while doing code review and to get completely rid of it was something which was
suggested by Jan [3].
Thanks to Jan for thorough review and suggestions :)


References
===========
[v1]: https://lore.kernel.org/all/cover.1642953021.git.riteshh@linux.ibm.com/
[1]: https://lore.kernel.org/linux-ext4/1280939957-3277-4-git-send-email-tytso@mit.edu/
[2]: https://lore.kernel.org/linux-ext4/20120103153245.GE31457@quack.suse.cz/
[3]: https://lore.kernel.org/linux-ext4/20220113112749.d5tfszcksvxvshnn@quack3.lan/
[4]: https://lore.kernel.org/all/948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com/


Ritesh Harjani (2):
  jbd2: Kill t_handle_lock transaction spinlock
  jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait

 fs/jbd2/transaction.c | 35 ++++++++++++-----------------------
 include/linux/jbd2.h  |  3 ---
 2 files changed, 12 insertions(+), 26 deletions(-)

--
2.31.1

