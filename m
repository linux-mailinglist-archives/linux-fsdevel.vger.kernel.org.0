Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B136ADA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 09:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhDZHh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 03:37:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3266 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232902AbhDZHgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:36:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13Q7XxWP121133;
        Mon, 26 Apr 2021 03:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vj2OQzjjLqs7BiSXWVriVvTs25SIobcYvo68jiLw4Uk=;
 b=pZmvAi6SqPloP4v7yebHdc376wD3sw97hQdlDLpgHHtDAFdSFjAqi0wi61SCKgrResq2
 hd4baQE5Sj0VYwQYDh/mC9mwNq8xiPAnQL8BEU/N81J7EL6YCWPbXZtudeSsE5RHiiRM
 ZMj5wnI/JOscQ4nj8zELPGRq79+N5VCDp8l1+KNJRhVqsURAU1HVx6EgUdrulY2XZQRM
 qf9ztQuiI//bP0p88GFeiwFOn+nt02uWiDbKBN7NAv6aivP7FJvnAYKE4bLGHaB7qoJG
 A68eM7fDI+xxp2EY6o4CHfevNg4duUalo5JOAQVkcO4dg8iDz6zZuSw7h26R7c7WzYMV 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385ry00h6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 03:35:36 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13Q7Y96u121861;
        Mon, 26 Apr 2021 03:35:35 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385ry00h55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 03:35:35 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13Q7TTCD031842;
        Mon, 26 Apr 2021 07:35:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 384gjxradp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 07:35:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13Q7ZTiC28377576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 07:35:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C76E5205A;
        Mon, 26 Apr 2021 07:35:29 +0000 (GMT)
Received: from oc8242746057.ibm.com.com (unknown [9.171.71.219])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C5D5E52057;
        Mon, 26 Apr 2021 07:35:27 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     elver@google.com
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, arnd@arndb.de,
        axboe@kernel.dk, b.zolnierkie@samsung.com, christian@brauner.io,
        dvyukov@google.com, geert@linux-m68k.org, glider@google.com,
        irogers@google.com, jannh@google.com, jolsa@redhat.com,
        jonathanh@nvidia.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org,
        m.szyprowski@samsung.com, mark.rutland@arm.com, mascasa@google.com,
        mingo@redhat.com, namhyung@kernel.org, oleg@redhat.com,
        pcc@google.com, peterz@infradead.org, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and si_perf to siginfo
Date:   Mon, 26 Apr 2021 09:35:11 +0200
Message-Id: <20210426073511.270990-1-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <CANpmjNPbMOUd_Wh5aHGdH8WLrYpyBFUpwx6g3Kj2D6eevvaU8w@mail.gmail.com>
References: <CANpmjNPbMOUd_Wh5aHGdH8WLrYpyBFUpwx6g3Kj2D6eevvaU8w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QwXFwizg1FxfiD25IzOGoHgPL-LRsFTX
X-Proofpoint-ORIG-GUID: 5lSoIFOb8pvez6BcVwFc5uehLV_UXxCL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-25_11:2021-04-23,2021-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=905 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260057
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

this also fixes s390.
strace's tests-m32 on s390 were failing.

Regards
Alex
