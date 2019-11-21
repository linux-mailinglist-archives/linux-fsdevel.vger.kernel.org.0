Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA47E1057BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKURAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:00:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKURAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:00:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGxKH3090224;
        Thu, 21 Nov 2019 16:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=4jTG7tKmtB4E4uAi7U1mKuZsrMojpmidKPmtl2mgAXo=;
 b=BM7JOFtnKiuCpGbRQe87oiOeJ3lyAgUUs38WNHUNhJr5wMJo2OcLXusOSIlDgSpU4G9K
 Fkcsb2TzKKJrkVz6DhABTP2mPnwkdl54RhtIc4rUW5y+At/Qi89Os7IE+C9jOxHqiNbH
 /+2SjSNaYWxoyxzCrt2Fkyv8PFehmSLlWn+oMn/sUkZb+YVCFK6RMa4n5psyis0uQoqr
 lHuaLZbhQVyLEiJn67vnRjFEhYhcvYDVmV2BCjM7bYRwZCf2CI6cTT1U5XYACmbJEA2C
 v55vNcdb0GO9MbpAujl6h9Xzsrlr3m1xcZeB3NkeoBStSIsSBtKmf4GH1JOERk8QDhnQ 2A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rqwhvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 16:59:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALGx9oB057244;
        Thu, 21 Nov 2019 16:59:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wd47xa0v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Nov 2019 16:59:25 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xALGwUIQ022842;
        Thu, 21 Nov 2019 16:58:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 08:58:30 -0800
Date:   Thu, 21 Nov 2019 08:58:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/2] iomap: Fix leakage of pipe pages while splicing
Message-ID: <20191121165829.GK6211@magnolia>
References: <20191121161144.30802-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121161144.30802-1-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=837 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210148
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 05:15:33PM +0100, Jan Kara wrote:
> Hello,
> 
> here is a fix and a cleanup for iomap code. The first patch fixes a leakage
> of pipe pages when iomap_dio_rw() splices to a pipe, the second patch is
> a cleanup that removes strange copying of iter in iomap_dio_rw(). Patches
> have passed fstests for ext4 and xfs and fix the syzkaller reproducer for
> me.

Will have a look, but in the meantime -- do you have quick reproducer
that can be packaged for fstests?  Or is it just the syzbot reproducer?

--D

> 
> 								Honza
