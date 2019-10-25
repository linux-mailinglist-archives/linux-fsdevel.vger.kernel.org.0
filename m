Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB4E4C35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 15:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504715AbfJYNau (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 09:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504702AbfJYNau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:30:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PDUd8b089869
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 09:30:49 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv0aekfrp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 09:30:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Fri, 25 Oct 2019 14:28:34 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 14:28:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PDSUR749152076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 13:28:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75C05AE057;
        Fri, 25 Oct 2019 13:28:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53399AE045;
        Fri, 25 Oct 2019 13:28:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.19.25])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 13:28:29 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ext4: support encryption with blocksize != PAGE_SIZE
Date:   Fri, 25 Oct 2019 19:00:29 +0530
Organization: IBM
In-Reply-To: <20191023033312.361355-1-ebiggers@kernel.org>
References: <20191023033312.361355-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19102513-0028-0000-0000-000003AF7A56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102513-0029-0000-0000-00002471B0B4
Message-Id: <17874972.D0pmjP8EC8@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250127
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, October 23, 2019 9:03 AM Eric Biggers wrote: 
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

I have tested this patchset on ppc64le with both 4k and 64k block size. There
were no regressions. Hence,

Tested-by: Chandan Rajendra <chandan@linux.ibm.com>

-- 
chandan



