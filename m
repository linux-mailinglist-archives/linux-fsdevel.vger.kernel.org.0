Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49F8352370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfFYGXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 02:23:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729251AbfFYGXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:23:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P6HadS056102
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tbdd59tne-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:18 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 25 Jun 2019 07:23:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 07:23:11 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P6NA8M37421188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 06:23:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4137AE057;
        Tue, 25 Jun 2019 06:23:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22F32AE053;
        Tue, 25 Jun 2019 06:23:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 06:23:08 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 0/7] Consolidate FS read I/O callbacks code
Date:   Tue, 25 Jun 2019 11:54:18 +0530
Organization: IBM
In-Reply-To: <20190621221550.GF167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com> <20190621221550.GF167064@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19062506-0028-0000-0000-0000037D4CB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062506-0029-0000-0000-0000243D6CB7
Message-Id: <1680442.JJIz71cjaA@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, June 22, 2019 3:45:51 AM IST Eric Biggers wrote:
> On Sun, Jun 16, 2019 at 09:38:06PM +0530, Chandan Rajendra wrote:
> > This patchset moves the "FS read I/O callbacks" code into a file of its
> > own (i.e. fs/read_callbacks.c) and modifies the generic
> > do_mpage_readpge() to make use of the functionality provided.
> > 
> > "FS read I/O callbacks" code implements the state machine that needs
> > to be executed after reading data from files that are encrypted and/or
> > have verity metadata associated with them.
> > 
> > With these changes in place, the patchset changes Ext4 to use
> > mpage_readpage[s] instead of its own custom ext4_readpage[s]()
> > functions. This is done to reduce duplication of code across
> > filesystems. Also, "FS read I/O callbacks" source files will be built
> > only if CONFIG_FS_ENCRYPTION is enabled.
> > 
> > The patchset also modifies fs/buffer.c to get file
> > encryption/decryption to work with subpage-sized blocks.
> > 
> > The patches can also be obtained from
> > https://github.com/chandanr/linux.git at branch subpage-encryption-v3.
> > 
> 
> FWIW: while doing my review I put together an (untested) incremental patch that
> addresses my comments on the code, so I've provided it below in case you want to
> start with it when addressing my comments.
> 
> This is just a single diff against your subpage-encryption-v3 branch, so of
> course it would still need to be folded into the appropriate patches.  Also see
> my suggestions in reply to patch 2 about how to better organize the series.  I
> also left TODOs in kerneldoc comments that still need to be updated.
> 

Thanks for all your help. I will post the next version of the patchset
addressing all your review comments.

-- 
chandan



