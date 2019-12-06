Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11A6114DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 09:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFIuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 03:50:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725866AbfLFIuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 03:50:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB68lK6k059881
        for <linux-fsdevel@vger.kernel.org>; Fri, 6 Dec 2019 03:50:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq9f8txdt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 03:50:00 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 6 Dec 2019 08:49:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 08:49:56 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB68ntZt63242478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 08:49:55 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DE10A4051;
        Fri,  6 Dec 2019 08:49:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEF21A405F;
        Fri,  6 Dec 2019 08:49:53 +0000 (GMT)
Received: from [9.199.159.162] (unknown [9.199.159.162])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 08:49:53 +0000 (GMT)
Subject: Re: [PATCHv4 0/3] Fix inode_lock sequence to scale performance of DIO
 mixed R/W workload
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, jack@suse.cz,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
References: <20191205064624.13419-1-riteshh@linux.ibm.com>
 <97fe59fa-0161-c035-40d0-3a9770ab426c@linux.alibaba.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 6 Dec 2019 14:19:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <97fe59fa-0161-c035-40d0-3a9770ab426c@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120608-0028-0000-0000-000003C5C5A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120608-0029-0000-0000-00002488EA68
Message-Id: <20191206084953.CEF21A405F@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_02:2019-12-04,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060076
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 12/6/19 2:16 PM, Joseph Qi wrote:
> Tested with the following case:
> 
> fio -name=parallel_dio_reads_test -filename=/mnt/nvme0n1/testfile \
> -direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=$bs \
> -size=20G -numjobs=8 -runtime=600 -group_reporting
> 
> The performance result is the same as reverting parallel dio reads[1]
> or even slightly better in both bandwidth and latency, which is as

That's great!!


> expected.
> 
> So, Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Thanks :)

-ritesh

