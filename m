Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF14ADA55C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 08:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390377AbfJQGNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 02:13:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731726AbfJQGNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:13:48 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9H6DQ9C098616
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2019 02:13:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vng3v3ex5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2019 02:13:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Thu, 17 Oct 2019 07:13:04 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Oct 2019 07:13:02 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9H6CUCb19333460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 06:12:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1FBDA4054;
        Thu, 17 Oct 2019 06:13:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08D1A405F;
        Thu, 17 Oct 2019 06:13:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.50.5])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Oct 2019 06:13:00 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] ext4: support encryption with blocksize != PAGE_SIZE
Date:   Thu, 17 Oct 2019 11:44:58 +0530
Organization: IBM
In-Reply-To: <20191016221142.298754-1-ebiggers@kernel.org>
References: <20191016221142.298754-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19101706-0020-0000-0000-00000379CCE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101706-0021-0000-0000-000021CFF40F
Message-Id: <2830996.s4omRzobaj@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910170051
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, October 17, 2019 3:41 AM Eric Biggers wrote: 
> Hello,
> 
> This patchset makes ext4 support encryption on filesystems where the
> filesystem block size is not equal to PAGE_SIZE.  This allows e.g.
> PowerPC systems to use ext4 encryption.
> 
> Most of the work for this was already done in prior kernel releases; now
> the only part missing is decryption support in block_read_full_page().
> Chandan Rajendra has proposed a patchset "Consolidate FS read I/O
> callbacks code" [1] to address this and do various other things like
> make ext4 use mpage_readpages() again, and make ext4 and f2fs share more
> code.  But it doesn't seem to be going anywhere.
> 
> Therefore, I propose we simply add decryption support to
> block_read_full_page() for now.  This is a fairly small change, and it
> gets ext4 encryption with subpage-sized blocks working.
> 
> Note: to keep things simple I'm just allocating the work object from the
> bi_end_io function with GFP_ATOMIC.  But if people think it's necessary,
> it could be changed to use preallocation like the page-based read path.
> 
> Tested with 'gce-xfstests -c ext4/encrypt_1k -g auto', using the new
> "encrypt_1k" config I created.  All tests pass except for those that
> already fail or are excluded with the encrypt or 1k configs, and 2 tests
> that try to create 1023-byte symlinks which fails since encrypted
> symlinks are limited to blocksize-3 bytes.  Also ran the dedicated
> encryption tests using 'kvm-xfstests -c ext4/1k -g encrypt'; all pass,
> including the on-disk ciphertext verification tests.
> 
> [1] https://lkml.kernel.org/linux-fsdevel/20190910155115.28550-1-chandan@linux.ibm.com/T/#u
>

Hi Eric,

Thanks a lot for doing this.

The changes seem to be good. I have started test runs on my ppc64le guest and
I will reply with the test results once they complete.

-- 
chandan



