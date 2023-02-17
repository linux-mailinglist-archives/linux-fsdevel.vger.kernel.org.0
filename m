Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FA69B40F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBQUjj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQUjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:39:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268EE3431E;
        Fri, 17 Feb 2023 12:39:38 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HKZRNZ012321;
        Fri, 17 Feb 2023 20:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=xcPtrpeIgcfSPZSTiddzNM6oNKtBX3IQNq1yPedozqQ=;
 b=ksRnmMQ0evZHD2WpG344pQxHrySaMjHGSYWEIJMpHUlW0ytrjSMf9M8bZqUbF4/PuQkN
 6DPrtcBkcvSulz7bhEd0VxEkqABZM7f2hnf2QNkQsyzrpXi5M4lp8n+oYzc77EmpWIc4
 HRT0rAKFDfcOtGPAT7TjwIqkS/mGyKgsEjaSw/3VGbhb32vLUkoAKJYZMMrPZGu0PL1k
 JiB02Nr4H3Awrg0iQgEwD50PX682BB3FN91WYfbrAw96ZmdCAsITccDfTv3kGt9Y5jrN
 ar6QTqvyca2B2bkt7drraSXVZi9w1LUTpJ+B5mGU/kz0w/ll/Q3EtFs92gya0RG9y1Iz 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nteee3ate-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:39:12 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HKZwIx014144;
        Fri, 17 Feb 2023 20:39:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nteee3at0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:39:11 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCGQDI017665;
        Fri, 17 Feb 2023 20:39:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6req3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 20:39:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HKd7s944761578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 20:39:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B37520043;
        Fri, 17 Feb 2023 20:39:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F06D20040;
        Fri, 17 Feb 2023 20:39:07 +0000 (GMT)
Received: from localhost (unknown [9.179.0.31])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 20:39:07 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     dhowells@redhat.com
Cc:     axboe@kernel.dk, david@redhat.com, hch@infradead.org, hch@lst.de,
        hdanton@sina.com, jack@suse.cz, jgg@nvidia.com,
        jhubbard@nvidia.com, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, viro@zeniv.linux.org.uk, willy@infradead.org
Cc:     Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH v14 08/17] splice: Do splice read from a file without
 using ITER_PIPE
In-Reply-To: <20230214171330.2722188-9-dhowells@redhat.com>
In-Reply-To: 
Date:   Fri, 17 Feb 2023 21:39:07 +0100
Message-ID: <87a61ckowk.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XoBxJwlyE8n9NIT32PA3h4w5iKdsJSVE
X-Proofpoint-ORIG-GUID: SlAMGByKPowyGy6l1ocUoV4BaVHzmtpI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this commit breaks our s390x tests on linux-next which use Python 3
among other things.

We are using the Python 3 tox module and for some reason,
the above commit makes Python create files with padded zeroes.

--- a/tox/distro/lib/python3.11/site-packages/_distutils_hack/__init__.py
+++ b/tox/distro/lib/python3.11/site-packages/_distutils_hack/__init__.py
@@ -381,133 +381,4 @@
 000017c0  49 4c 53 5f 46 49 4e 44  45 52 29 0a 20 20 20 20  |ILS_FINDER).    |
 000017d0  65 78 63 65 70 74 20 56  61 6c 75 65 45 72 72 6f  |except ValueErro|
 000017e0  72 3a 0a 20 20 20 20 20  20 20 20 70 61 73 73 0a  |r:.        pass.|
-000017f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001800  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001810  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001820  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001830  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001840  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001850  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
-00001860  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
... 

How to reproduce on Fedora
--------------------------

# dnf install -y python3-tox

# cat >tox.ini <<EOF
[tox]
envlist = dev,distro,doc,lint
skipsdist = True

[testenv:distro]
sitepackages = true
EOF

# python3 -m tox -v --notest -e distro

Error processing line 1 of /mnt/test/.tox/distro/lib/python3.11/site-packages/distutils-precedence.pth:

  Traceback (most recent call last):
    File "<frozen site>", line 186, in addpackage
    File "<string>", line 1, in <module>
  ValueError: source code string cannot contain null bytes

Remainder of file ignored

# The above error message disappears if one reverts the bad commit.

Regards
Alex
