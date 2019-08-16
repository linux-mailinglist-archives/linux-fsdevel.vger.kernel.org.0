Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8CBF8FB65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfHPGtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 02:49:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58294 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:49:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G6iLRN059619;
        Fri, 16 Aug 2019 06:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=/G+76/W1zby1jpownBKRPCeTP5Tx6JGAbv6QBHhjTGE=;
 b=AOWi0izMZmjlvXpyLpNgmdV4Wdm3NzzLkMtrTvYu9HH0kQfO5WZ7O4fm16ZzB/aL2BpY
 WO4W0Av7gGmt+oFKXaM7rrLlbV6kOpzpJA2juGAHLPaThQ4OHVrCHgoh51LJKoZVwNUC
 wks7fcmgbBWoZnnGq0tzg9ukZFk+xXGe4d8/iCBjYENAXtm0Ecyt7fXPppTD1DNX9Ggz
 P5eiiACeihE9GrbEXBs5xIfLhMTrugAOeVYMBfIgB8tjLmVIS12sbnKtH0sEwaoH8bho
 dr7xA5/8ENdqNNZbjIpgVVNLUDoDPYSAhz8Nphb0rgP774pzCobq01g9hQA0EUX/PocC bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2u9nbtxrfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 06:49:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7G6mHDA074355;
        Fri, 16 Aug 2019 06:49:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2udgqfskct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 06:49:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7G6n0Y2026884;
        Fri, 16 Aug 2019 06:49:00 GMT
Received: from localhost (/10.159.134.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 23:48:59 -0700
Date:   Thu, 15 Aug 2019 23:48:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] vfs: don't allow writes to swap files
Message-ID: <20190816064858.GG15186@magnolia>
References: <156588514105.111054.13645634739408399209.stgit@magnolia>
 <156588515613.111054.13578448017133006248.stgit@magnolia>
 <20190816064121.GB2024@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816064121.GB2024@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=807
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=864 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160070
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:41:21PM -0700, Christoph Hellwig wrote:
> The new checks look fine to me, but where does the inode_drain_writes()
> function come from, I can't find that in my tree anywhere.

Doh.  Forgot to include that patch in the series. :(

/*
 * Flush file data before changing attributes.  Caller must hold any locks
 * required to prevent further writes to this file until we're done setting
 * flags.
 */
static inline int inode_drain_writes(struct inode *inode)
{
       inode_dio_wait(inode);
       return filemap_write_and_wait(inode->i_mapping);
}

> Also what does inode_drain_writes do about existing shared writable
> mapping?  Do we even care about that corner case?

We probably ought to flush and invalidate the pagecache for the entire
file so that page_mkwrite can bounce off the swapfile.

--D
