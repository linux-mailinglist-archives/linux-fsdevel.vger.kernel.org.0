Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAA95662
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 07:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfHTFEB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 01:04:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728777AbfHTFEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:04:00 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7K52dXE135686
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 01:03:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ug9pusfqj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 01:03:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 20 Aug 2019 06:03:56 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 20 Aug 2019 06:03:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7K53U6o39322076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 05:03:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE4E4A4040;
        Tue, 20 Aug 2019 05:03:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6610FA4055;
        Tue, 20 Aug 2019 05:03:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.62.92])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 05:03:48 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     tytso@mit.edu, ebiggers@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, chandanrmail@gmail.com,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V4 5/8] f2fs: Use read_callbacks for decrypting file data
Date:   Tue, 20 Aug 2019 10:35:29 +0530
Organization: IBM
In-Reply-To: <20190816061804.14840-6-chandan@linux.ibm.com>
References: <20190816061804.14840-1-chandan@linux.ibm.com> <20190816061804.14840-6-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19082005-0012-0000-0000-000003409143
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082005-0013-0000-0000-0000217AB39E
Message-Id: <1652707.8YmLLlegLt@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=927 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200052
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, August 16, 2019 11:48 AM Chandan Rajendra wrote:
> F2FS has a copy of "post read processing" code using which encrypted
> file data is decrypted. This commit replaces it to make use of the
> generic read_callbacks facility.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>

Hi Eric and Ted,

Looks like F2FS requires a lot more flexiblity than what can be offered by
read callbacks i.e.

1. F2FS wants to make use of its own workqueue for decryption, verity and
   decompression.
2. F2FS' decompression code is not an FS independent entity like fscrypt and
   fsverity. Hence they would need Filesystem specific callback functions to
   be invoked from "read callbacks". 

Hence I would suggest that we should drop F2FS changes made in this
patchset. Please let me know your thoughts on this.

-- 
chandan



