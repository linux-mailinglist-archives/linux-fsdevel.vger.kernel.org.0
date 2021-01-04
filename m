Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4412E9CF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbhADSUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:20:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48022 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbhADSUp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:20:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104Hwh5J158233;
        Mon, 4 Jan 2021 18:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TflZweK4yN8+HOp7rLn3uJumfxqV/idgYDk9wA/ocYw=;
 b=a5Fd/hETnYgFYvRCrQ5pg4wJZ49Zhojgl5ifOmBpKXv8iDs5K86Y7Di0A8Eq7CyI0ofp
 1VvbqF6wPYDpuznjtUrXNN6WTjKk+/qpl09y0x42ApBc3E0IuIHIkfC48LdjjwdztPUj
 pn0kFLHq0oGEhUGlcHQDHHTMGhXL0Fn1fS04dvzWIzWZ2wacp3vKDb+rLHwXZVOIHIVp
 Sh0FwxyZ/EFh+xCEeQKoC2tG/iqyynHskStlYNFeR2VGsCGVJHPS9x6I9ZZyEaUQP/xh
 S5/6XdfxUrD2RBRYfHbkTyLSJuv2Yr5BgGDSLFPhZInabRave67eS4S9bwGavNpQXOWH wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35tebann0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 18:20:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104I0QMg103721;
        Mon, 4 Jan 2021 18:20:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4rag2ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 18:20:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104IJxK0027721;
        Mon, 4 Jan 2021 18:19:59 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 10:19:58 -0800
Date:   Mon, 4 Jan 2021 10:19:58 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210104181958.GE6908@magnolia>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040118
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> Hi,
> 
> For things like database journals using fallocate(0) is not sufficient,
> as writing into the the pre-allocated data with O_DIRECT | O_DSYNC
> writes requires the unwritten extents to be converted, which in turn
> requires journal operations.
> 
> The performance difference in a journalling workload (lots of
> sequential, low-iodepth, often small, writes) is quite remarkable. Even
> on quite fast devices:
> 
>     andres@awork3:/mnt/t3$ grep /mnt/t3 /proc/mounts
>     /dev/nvme1n1 /mnt/t3 xfs rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota 0 0
> 
>     andres@awork3:/mnt/t3$ fallocate -l $((1024*1024*1024)) test_file
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 117.587 s, 9.1 MB/s
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.69125 s, 291 MB/s
> 
>     andres@awork3:/mnt/t3$ fallocate -z -l $((1024*1024*1024)) test_file
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     z262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 109.398 s, 9.8 MB/s
> 
>     andres@awork3:/mnt/t3$ dd if=/dev/zero of=test_file bs=4096 conv=notrunc iflag=count_bytes count=$((1024*1024*1024)) oflag=direct,dsync
>     262144+0 records in
>     262144+0 records out
>     1073741824 bytes (1.1 GB, 1.0 GiB) copied, 3.76166 s, 285 MB/s
> 
> 
> The way around that, from a database's perspective, is obviously to just
> overwrite the file "manually" after fallocate()ing it, utilizing larger
> writes, and then to recycle the file.
> 
> 
> But that's a fair bit of unnecessary IO from userspace, and it's IO that
> the kernel can do more efficiently on a number of types of block
> devices, e.g. by utilizing write-zeroes.
> 
> 
> Which brings me to $subject:
> 
> Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> doesn't convert extents into unwritten extents, but instead uses
> blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> myself, but ...
> 
> Doing so as a variant of FALLOC_FL_ZERO_RANGE seems to make the most
> sense, as that'd work reasonably efficiently to initialize newly
> allocated space as well as for zeroing out previously used file space.
> 
> 
> As blkdev_issue_zeroout() already has a fallback path it seems this
> should be doable without too much concern for which devices have write
> zeroes, and which do not?

Question: do you want the kernel to write zeroes even for devices that
don't support accelerated zeroing?  Since I assume that if the fallocate
fails you'll fall back to writing zeroes from userspace anyway...

Second question: Would it help to have a FALLOC_FL_DRY_RUN flag that
could be used to probe if a file supports fallocate without actually
changing anything?  I'm (separately) pursuing a fix for the loop device
not being able to figure out if a file actually supports a particular
fallocate mode.

--D

> Greetings,
> 
> Andres Freund
