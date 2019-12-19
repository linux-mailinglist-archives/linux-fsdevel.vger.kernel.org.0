Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061B61258D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 01:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLSAs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 19:48:28 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36292 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 19:48:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ0iMd9157571;
        Thu, 19 Dec 2019 00:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VjYqnKsbKLbGD7l5o8X0VpqMjq3yPMzJMi6BXtsxD14=;
 b=kwma+DRoyxBskpnclqNLB0aDpF8HvXVbZH5jt+b/PdrMyJ+FBk7t8gL8mXeDEZ0u3IBo
 y/C9i9XvRGsuPEl3K8HpoK9JzdIwSlIxpnpItdtDtCt4RqTRhlDwojFLly31r0a+Inoe
 8AuCKirdNfDtYUjcc5bSkigVGtjkuRlPX+DKwppFj9Cbe29e0+7aZqU0yNkoXD7mYeaF
 4MUnRb+s/oYwBx8RAZIBEuNqGvAXKOJeF7XJG2midn8083OJtmXiJe5ELYKRdYU/Jvh5
 a5I502v6Sz/24k9eRkPuMCA7Nt4AVB+dQrbQqWHP1aTS2E6hMqprfyOpi+ieq94hY0qZ Ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wvqpqgxbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 00:48:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBJ0iOtp112735;
        Thu, 19 Dec 2019 00:48:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wyp08j1hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 00:48:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBJ0lxd5003393;
        Thu, 19 Dec 2019 00:47:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Dec 2019 16:47:59 -0800
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191218145136.172774-1-satyat@google.com>
        <20191218145136.172774-3-satyat@google.com>
        <20191218212116.GA7476@magnolia> <yq1y2v9e37b.fsf@oracle.com>
        <20191218222726.GC47399@gmail.com>
Date:   Wed, 18 Dec 2019 19:47:56 -0500
In-Reply-To: <20191218222726.GC47399@gmail.com> (Eric Biggers's message of
        "Wed, 18 Dec 2019 14:27:26 -0800")
Message-ID: <yq1fthhdttv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912190005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9475 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912190005
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric,

> There's not really any such thing as "use the bio integrity plumbing".
> blk-integrity just does blk-integrity; it's not a plumbing layer that
> allows other features to be supported.  Well, in theory we could
> refactor and rename all the hooks to "blk-extra" and make them
> delegate to either blk-integrity or blk-crypto, but I think that would
> be overkill.

I certainly don't expect your crypto stuff to plug in without any
modification to what we currently have. I'm just observing that the
existing plumbing is designed to have pluggable functions that let
filesystems attach additional information to bios on writes and process
additional attached information on reads. And the block layer already
handles slicing and dicing these attachments as the I/O traverses the
stack.

There's also other stuff that probably won't be directly applicable or
interesting for your use case. It just seems like identifying actual
commonalities and differences would be worthwhile.

Note that substantial changes to the integrity code would inevitably
lead to a lot of pain and suffering for me. So from that perspective I
am very happy if you leave it alone. From an architectural viewpoint,
however, it seems that there are more similarities than differences
between crypto and integrity. And we should avoid duplication where
possible. That's all.

> What we could do, though, is say that at most one of blk-crypto and
> blk-integrity can be used at once on a given bio, and put the
> bi_integrity and bi_crypt_context pointers in union.  (That would
> require allocating a REQ_INLINECRYPT bit so that we can tell what the
> pointer points to.)

Absolutely. That's why it's a union. Putting your stuff there is a
prerequisite as far as I'm concerned. No need to grow the bio when the
two features are unlikely to coexist. We can revisit that later should
the need arise.

-- 
Martin K. Petersen	Oracle Linux Engineering
