Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447E8128AB4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 19:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLUSEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 13:04:05 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 13:04:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLHx7Wo045873;
        Sat, 21 Dec 2019 18:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=HKC1R9SgkMvYJYTaHovH/yRQ9M5aM7mhEjHLD/l21FA=;
 b=TV4oTEuftgRbFoxKCRk58EzCbtV05GHZYcHNauGQp4wWjbgCzdnfdunEVAXcGTx/1wta
 3Kno1UzhnUCdsvYVRCb77TW/M2G9Bx+WhsNcxPzm4Zd7S9vLgvVOUicvNijlVGX9SI7g
 KyuWGg0moSJwGf4RGyhVoNQviXjtEzpzPcEaeWKItDlmIuUekoV0Y/aLuSb9jz6sW31I
 YRvr7q0yIHyRH7gG2chHa3lQu5I1BiwFw+H+ChzPj6ysn5FbKixzWPqko5eMD9gnOTeg
 Ay/abQZnhRguQPOPOZtdinLBg0AX5CUt23QvDxtUOXKSzP8wv+vwFb0AYZLI69W+LeP5 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2x1c1qhe6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:03:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBLI3ePx122234;
        Sat, 21 Dec 2019 18:03:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2x1ar3haee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Dec 2019 18:03:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBLI2t0w023662;
        Sat, 21 Dec 2019 18:02:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Dec 2019 10:02:55 -0800
Date:   Sat, 21 Dec 2019 10:02:54 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org,
        fdmanana@kernel.org, nborisov@suse.com, dsterba@suse.cz,
        jthumshirn@suse.de, linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 3/8] iomap: Move lockdep_assert_held() to iomap_dio_rw()
 calls
Message-ID: <20191221180254.GE7476@magnolia>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
 <20191213195750.32184-4-rgoldwyn@suse.de>
 <20191221134118.GA17355@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221134118.GA17355@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9478 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=694 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912210158
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 21, 2019 at 05:41:18AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 13, 2019 at 01:57:45PM -0600, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Filesystems such as btrfs can perform direct I/O without holding the
> > inode->i_rwsem in some of the cases like writing within i_size.
> > So, remove the check for lockdep_assert_held() in iomap_dio_rw()
> 
> As said last time: in the callers the assert is completely pointless,
> as it is always very close to taking the lock.  This was just intended
> to deal with callers not adhering to the iomap_dio_rw calling
> conventins, and moving the assert to the calllers doesn't help with
> that at all.
> 
> So if you think you need to remove it do just that and write a changelog
> explaining the why much better.

Uh... that's exactly what this patch does, and the commit message says
that btrfs doesn't need to hold i_rwsem to guarantee concurrency
correctness.

Hm, but maybe the commit message is simply too subtle here?  How about:

"Filesystems do not necessarily need i_rwsem to ensure correct operation
with multiple threads, so remove the i_rwsem assertion in iomap_dio_rw.
For example, btrfs can perform directio within i_size without needing to
hold i_rwsem."

--D
