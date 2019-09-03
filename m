Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80DA76C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 00:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfICWQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 18:16:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfICWQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:16:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83MGQ5b144943;
        Tue, 3 Sep 2019 22:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ZL17AaGu0G0XjAP5zYEczWuw5F4oqmxX6arH9Djkzjo=;
 b=C0G+NCKrOwblFKMjV7oWMknkZcctdpTDUbEqKO2WZ7cy/wuCroFJJNtLjqZ+PnummutF
 S/1tTFUYo/s2LmMJwrFjuHjwWje1ZJYutyp3LIVIrnBU6k9CwlT1V9HLHsPjgWn+KTTh
 UHxiKCGyX+Pme/Z2Wimuo1NENgjT8hYS7UeKW4IddpdJdSvHBtodBW8Sb1PYU6jEYvcf
 baf71FiNc+KFEptkyT6Fdd3V+uErqQOW2aF1sU8Vf21I/uAmAyg1qnFUNAk2i2ikDvjb
 D2dBssUB484gNwFpyc9kcWaiXEMHlOXj9i5DIduP4blrNV5iIN0VtJ9S7fQVRLeDJO6N Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ut0tqg00v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 22:16:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83ME2pZ066676;
        Tue, 3 Sep 2019 22:16:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2us5phcke0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Sep 2019 22:16:25 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83MGMaJ012316;
        Tue, 3 Sep 2019 22:16:23 GMT
Received: from localhost (/10.145.178.11)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 15:16:22 -0700
Date:   Tue, 3 Sep 2019 15:16:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, agruenba@redhat.com,
        Damien.LeMoal@wdc.com, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: iomap_dio_rw ->end_io improvements
Message-ID: <20190903221621.GH568270@magnolia>
References: <20190903130327.6023-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130327.6023-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030221
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030221
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:03:25PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series contains two updates to the end_io handling for the iomap
> direct I/O code.  The first patch is from Matthew and passes the size and
> error separately, and has been taken from his series to convert ext4 to
> use iomap for direct I/O.  The second one moves the end_io handler into a
> separate ops structure.  This should help with Goldwyns series to use the
> iomap code in btrfs, but as-is already ensures that we don't store a
> function pointer in a mutable data structure.

The biggest problem with merging these patches (and while we're at it,
Goldwyn's patch adding a srcmap parameter to ->iomap_begin) for 5.4 is
that they'll break whatever Andreas and Damien have been preparing for
gfs2 and zonefs (respectively) based off the iomap-writeback work branch
that I created off of 5.3-rc2 a month ago.

Digging through the gfs2 and zonefs code, it doesn't look like it would
be difficult to adapt them to the changes, but forcing a rebase at this
point would (a) poke holes in the idea of creating stable work branches
and (b) shoot holes in all the regression testing they've done so far.
I do not have the hardware to test either in detail.

So the question is: Are all three (xfs/gfs2/zonefs?) downstream users of
iomap ok with a rebase a week and a half before the 5.4 merge window
opens?  I'm still inclined to push all these patches (iomap cow and the
directio improvements) into a work branch for 5.5, but if someone wants
this for 5.4 badly enough to persuade everyone else to start their
testing again, then I could see trying to make this happen (no later
than 5pm Pacific on Thursday).  Bear in mind I'm on vacation starting
Friday and going until the 15th...

Once iomap accumulates more users (ext4, btrfs) then this sort of thing
will never scale and will likely never happen again.

Thoughts?  Flames? :)

--D
