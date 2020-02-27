Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42317171526
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgB0KkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 05:40:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21994 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728779AbgB0KkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:40:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RAdLJ8100160
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 05:40:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydxep17b3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 05:40:05 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 10:40:02 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 10:39:58 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RAdvVp36634932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 10:39:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31E0F4203F;
        Thu, 27 Feb 2020 10:39:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34ADB42042;
        Thu, 27 Feb 2020 10:39:52 +0000 (GMT)
Received: from [9.199.158.169] (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 10:39:51 +0000 (GMT)
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, tytso@mit.edu,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        krisman@collabora.com, surajjs@amazon.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 27 Feb 2020 16:09:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20022710-4275-0000-0000-000003A5F326
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022710-4276-0000-0000-000038BA33DA
Message-Id: <20200227103952.34ADB42042@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_03:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270085
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> fallocate() goes thru standard blocks allocator, which try to behave very
> good for life allocation cases: block placement and future file size
> prediction, delayed blocks allocation, etc. But it almost impossible
> to allocate blocks from specified place for our specific case. The only
> ext4 block allocator option possible to use is that the allocator firstly
> tries to allocate blocks from the same block group, that inode is related to.
> But this is not enough for effective files compaction.
> 
> This patchset implements an extension of fallocate():
> 
> 	fallocate2(int fd, int mode, loff_t offset, loff_t len,
> 		   unsigned long long physical)
> 
> The new argument is @physical offset from start of device, which is must
> for block allocation. In case of [@physical, @physical + len] block range
> is available for allocation, the syscall assigns the corresponding extent/
> extents to inode. In case of the range or its part is occupied, the syscall
> returns with error (maybe, smaller range will be allocated. The behavior
> is the same as when fallocate() meets no space in the middle).

Doesn't this interface kills the whole philosophy of letting filesystems
to decide which block it sees as most fit for allocation. IMHO user
passing over actual physical location from where the FS should allocate,
does not sound like a good interface.


-ritesh

