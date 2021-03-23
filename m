Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1389B3462D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 16:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhCWP26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 11:28:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232816AbhCWP2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:28:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12NFGQtq158809;
        Tue, 23 Mar 2021 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HEgPNmOQ2fGg+4o6ggG+TNuvsojvFlxy9dBHlBe6Svc=;
 b=j6Axg86BIT6TdVpK3dBy599D+sEsSqA4nMaJjCiiop2oShxkrUfHnnN/Xd3h/Swxo7aa
 5NKOVTNS1xlKE0pRfPk80TITeQTTiyDX19Dnq2BY0H3i2iy8EC2JnSL5ccfLWBgv394m
 ab5x/brQxo90AIXLxqy2cFVgak4tCpENma9XCPf+ub+FBQ1D7d2OKK2ItTEFC/J6xGI2
 1xzVmwJQR9UAg+rnRwKM2mZ5SzMiZk7aJ6Yj+jPpon/fTZk3u/DB6Vfmq8jCRG2CeNxl
 jpZEhKAeKLRcD3BG+t2CpzLz6jFlUKn0Cj93iuW7UNljsWf/qS7i2lfaigmROHE9DZ5Q MA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37fjth8dmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 11:27:59 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12NFLY4H007748;
        Tue, 23 Mar 2021 15:27:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 37d99xhtu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Mar 2021 15:27:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12NFRs1e30146828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 15:27:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B779A52052;
        Tue, 23 Mar 2021 15:27:54 +0000 (GMT)
Received: from [9.199.34.65] (unknown [9.199.34.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 280B65205A;
        Tue, 23 Mar 2021 15:27:52 +0000 (GMT)
Subject: Re: [PATCH v3 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org
Cc:     darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <7f9d5477-b156-e084-9412-307dd67149b1@linux.ibm.com>
Date:   Tue, 23 Mar 2021 20:57:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-23_06:2021-03-22,2021-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103230112
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/19/21 7:22 AM, Shiyang Ruan wrote:
> From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> 
> This patchset is attempt to add CoW support for fsdax, and take XFS,
> which has both reflink and fsdax feature, as an example.


Thanks for the patchset. I have tried reviewing the series from logical
correctness and to some extent functional correctness.
Since I am not well versed with the core functionality of COW operation,
so I may have requested for some clarifications where I could not get
the code 100% on what it is doing.


> 
> (Rebased on v5.11)
> ==
> 
Thanks. Yes, I see some conflicts when tried to apply on latest kernel.

-ritesh
