Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A464752372
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 08:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfFYGXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 02:23:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbfFYGXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:23:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P6HCVC102334
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:20 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbc92byyt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2019 02:23:20 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <chandan@linux.ibm.com>;
        Tue, 25 Jun 2019 07:23:17 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 07:23:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P6NDtI51708146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 06:23:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AAD5AE045;
        Tue, 25 Jun 2019 06:23:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83F5CAE057;
        Tue, 25 Jun 2019 06:23:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.58])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 06:23:11 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 6/7] Add decryption support for sub-pagesized blocks
Date:   Tue, 25 Jun 2019 11:52:43 +0530
Organization: IBM
In-Reply-To: <20190621212916.GD167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com> <20190616160813.24464-7-chandan@linux.ibm.com> <20190621212916.GD167064@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19062506-0008-0000-0000-000002F6BFB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062506-0009-0000-0000-00002263EE89
Message-Id: <3201150.UV5xBNPoiD@localhost.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, June 22, 2019 2:59:17 AM IST Eric Biggers wrote:
> On Sun, Jun 16, 2019 at 09:38:12PM +0530, Chandan Rajendra wrote:
> > To support decryption of sub-pagesized blocks this commit adds code to,
> > 1. Track buffer head in "struct read_callbacks_ctx".
> > 2. Pass buffer head argument to all read callbacks.
> > 3. Add new fscrypt helper to decrypt the file data referred to by a
> >    buffer head.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> > ---
> >  fs/buffer.c                    |  55 +++++++++------
> >  fs/crypto/bio.c                |  21 +++++-
> >  fs/f2fs/data.c                 |   2 +-
> >  fs/mpage.c                     |   2 +-
> >  fs/read_callbacks.c            | 118 +++++++++++++++++++++++++--------
> >  include/linux/buffer_head.h    |   1 +
> >  include/linux/read_callbacks.h |  13 +++-
> >  7 files changed, 158 insertions(+), 54 deletions(-)
> > 
> 
> This is another patch that unnecessarily changes way too many components at
> once.  My suggestions elsewhere would resolve this, though:
> 
> - This patch changes fs/f2fs/data.c and fs/mpage.c only to pass a NULL
>   buffer_head to read_callbacks_setup().  But as per my comments on patch 1,
>   read_callbacks_setup() should be split into read_callbacks_setup_bio() and
>   read_callbacks_end_bh().
> 
> - This patch changes fs/crypto/ only to add support for the buffer_head
>   decryption work.  But as per my comments on patch 1, that should be in
>   read_callbacks.c instead.
> 
> And adding buffer_head support to fs/read_callbacks.c should be its own patch,
> *or* should simply be folded into the patch that adds fs/read_callbacks.c.
> 
> Then the only thing remaining in this patch would be updating fs/buffer.c to
> make it use the read_callbacks, which should be retitled to something like
> "fs/buffer.c: add decryption support via read_callbacks".
> 

I agree.

-- 
chandan



