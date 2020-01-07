Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14EC4131EA8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgAGEgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 23:36:25 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47730 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbgAGEgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 23:36:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074YsE1085910;
        Tue, 7 Jan 2020 04:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=ZkObfQJ3aLTfUDlWz1/H9GrUZm6vFEcO3N6e1Nr/N5o=;
 b=JWl7seMyh/sKhuxzW7P3DtP/EAoNB/SZAymx99crurUpfcuUv2SmthMjxXWWWv7mDraH
 i6CsGpnC0GKOilKE51Fb05b4L4J1Dp8d6e3okfZhjZ+wOA5rVz2/tuMlU78svT/EAuTS
 G4szSJtCcCZMvxErO6m+knjZAU4/Dv6q3+tdvqIJ2+De+DGNbiw3eJYeUsJcbMe4CocK
 yYqTqkdTwL2Sz9784mqjPo8Zd0Q0/OuAjtiJYVxTDAiyrdVUaHYLUpGvU9dkeBA4DmkA
 uuMPEdw+ZDirNPWX/teHMtNgkcWirHVfLeQdGVhTg5aZ1hJfAV/hUhUByWo5Ia+sKrCn Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbqjvmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:35:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0074YEk7115196;
        Tue, 7 Jan 2020 04:35:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xcjvc8hh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 04:35:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0074Zn7V027336;
        Tue, 7 Jan 2020 04:35:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 20:35:49 -0800
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
        <20191218222726.GC47399@gmail.com> <yq1fthhdttv.fsf@oracle.com>
        <20191220035237.GB718@sol.localdomain>
Date:   Mon, 06 Jan 2020 23:35:46 -0500
In-Reply-To: <20191220035237.GB718@sol.localdomain> (Eric Biggers's message of
        "Thu, 19 Dec 2019 19:52:37 -0800")
Message-ID: <yq136cr3mu5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Eric,

> However, the nature of the per-bio information is very different.
> Most of the complexity in blk-integrity is around managing of a
> separate integrity scatterlist for each bio, alongside the regular
> data scatterlist.

> That's not something we need or want for inline encryption.  For each
> bio we just need a key, algorithm, data unit number, and data unit
> size.  Since the data unit number (IV) is automatically incremented
> for each sector and the encryption is length-preserving, there's no
> per-sector data.

Fair enough. I just wanted to make sure that you guys had actually
looked at the integrity stuff and determined it wasn't a good fit.

> There are some ways the two features could be supported simultaneously
> without using more space, like making the pointer point to a linked
> list of tagged structs, or making the struct contain both a
> bio_crypt_ctx and bio_integrity_payload (or whichever combination is
> enabled in kconfig).

We have previously discussed having a facility in which you could chain
several different things (with different prep/endio functions) off a
bio. Similar to how we allow arbitrary stacking of block_devices. That
was actually my main interest in terms of opening the integrity can of
worms in this thread. Trying to find out which pieces of the plumbing,
if any, could potentially be made generic and feature-independent.

The copy offload efforts, which are now again picking up momentum, also
need to hang things off of the bio. That's the original reason the
integrity field became a union, fwiw.

> So if people really aren't willing to accept the extra 8 bytes per bio
> even behind a kconfig option, my vote is we that we put
> bi_crypt_context in the union with bi_integrity, and add a flag
> REQ_INLINECRYPT (like REQ_INTEGRITY) that indicates that the
> bi_crypt_context member of the union is valid.

Agreed.

> We'd also need some error-handling to prevent the two features from
> actually being used together.  It looks like there are several cases
> to consider.  One of them is what happens if bio_crypt_set_ctx() is
> called when blk-integrity verification or generation is enabled for
> the disk.

The integrity profile is only attached if the device driver identifies a
discovered device as capable. At least in the short term no device
should indicate simultaneous support for DIX and your crypto interface.

Not saying that sanity checks shouldn't exist. But I think both of these
features fall into things that are registered at device discovery time
so we shouldn't need to clutter the I/O hot path with mutual exclusivity
checks.

-- 
Martin K. Petersen	Oracle Linux Engineering
