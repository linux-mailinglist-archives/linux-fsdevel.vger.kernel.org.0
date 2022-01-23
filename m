Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50B497387
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jan 2022 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiAWRXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Jan 2022 12:23:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239209AbiAWRXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:23:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20NBC4mM027485;
        Sun, 23 Jan 2022 17:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=i3Vh3XJA6JQ+zfpjlnzzTalkQ5lrX4tuvsm5X/IloMg=;
 b=I78wS8Z1iva8xJ672h2oUp9d6GRCSXz9e3z3ieTd0ONoP5euTaAzQzi0e3yCyN9+LjS4
 vwCW0B4UQZnXaWLVbwXQMbhWq3ZXeTpci/Zg1diLUpfSms/KtKXQPfYSGQ+Dgf70TXRe
 FrT2IWeiLe0mmiofv6UyCSepyWrGokfR9yNzF0A08/z3zur5vIf+4tnV8YWfut3XVe/J
 I1RHKlFNNjpMYFE+1KQjHQfXyGq3mk4bisxZX6aGyr7WcU5hYFgW+PTVtRFmLAnXIELl
 PWYe8gAnM1wzq3c11o8c2pFkK41ryXXxB7CGyKRVC1H6S2I86ioi9Mc4NVlzL4/di01K eA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ds5x8m41d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:40 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20NHCxC7006389;
        Sun, 23 Jan 2022 17:23:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3dr9j8x6e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jan 2022 17:23:38 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20NHNZ1q19464466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jan 2022 17:23:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3AF3A4055;
        Sun, 23 Jan 2022 17:23:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF0B7A4053;
        Sun, 23 Jan 2022 17:23:33 +0000 (GMT)
Received: from localhost (unknown [9.43.59.179])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 23 Jan 2022 17:23:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 0/2] jbd2: Kill age-old t_handle_lock transaction spinlock
Date:   Sun, 23 Jan 2022 22:53:26 +0530
Message-Id: <cover.1642953021.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U_bWx-XDLp1vBi3cF9Oz4_kcPdQ2jas8
X-Proofpoint-GUID: U_bWx-XDLp1vBi3cF9Oz4_kcPdQ2jas8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-23_05,2022-01-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=658 malwarescore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201230132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

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


[1]: https://lore.kernel.org/linux-ext4/1280939957-3277-4-git-send-email-tytso@mit.edu/
[2]: https://lore.kernel.org/linux-ext4/20120103153245.GE31457@quack.suse.cz/
[3]: https://lore.kernel.org/linux-ext4/20220113112749.d5tfszcksvxvshnn@quack3.lan/

Ritesh Harjani (2):
  jbd2: Kill t_handle_lock transaction spinlock
  jbd2: Remove CONFIG_JBD2_DEBUG to update t_max_wait

 fs/jbd2/transaction.c | 36 ++++++++++++------------------------
 include/linux/jbd2.h  |  3 ---
 2 files changed, 12 insertions(+), 27 deletions(-)

--
2.31.1

