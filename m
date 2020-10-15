Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BCF28F717
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 18:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389725AbgJOQrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 12:47:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46728 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388946AbgJOQrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:47:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGdsFt105036;
        Thu, 15 Oct 2020 16:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LtA7JgeCTgNJzEFvoas2D++PHkIz1MPQ0A+sBP9uiQw=;
 b=GLkfJhw82IfW16zPsuJZFxfB5XExbDV0/bSazRW9Ab9UPPfGls9q3Wfwi1Z96hxWN8bk
 dpihzj9nQ+bkyYplXd5TZ5RLZQ3ziQej/GaHLqrPZHwmb/n6H5lJQItQ+8P5ffU9H1I5
 A0eo9vnehe87OtopIkY3MpOU25BHCUsaXyNqsgVV+sKftRp3rV/uk5BJ/GrBCu/fb6fC
 vSHiFY5Eg7HWoLYqp0yI0W++rpnE6Q7qJTZL0fZyBG33h36L7axx8J4dM+uTHMq9qBHW
 T32qqH2Vbkl/8I01inAHzAWmpN5rg7q7dmWce8eNs0EtFgLXLdGBEn2/HtecqRuUPCz4 aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 343vaem3cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Oct 2020 16:46:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FGdlIt193614;
        Thu, 15 Oct 2020 16:46:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 343phrau4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Oct 2020 16:46:57 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FGkvcW013135;
        Thu, 15 Oct 2020 16:46:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Oct 2020 09:46:57 -0700
Date:   Thu, 15 Oct 2020 09:46:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] vfs: move the clone/dedupe/remap helpers to a single
 file
Message-ID: <20201015164656.GC9825@magnolia>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
 <20201015031819.GN3576660@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015031819.GN3576660@ZenIV.linux.org.uk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150110
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 04:18:19AM +0100, Al Viro wrote:
> On Wed, Oct 14, 2020 at 05:31:14PM -0700, Darrick J. Wong wrote:
> 
> > AFAICT, nobody is attempting to land any major changes in any of the vfs
> > remap functions during the 5.10 window -- for-next showed conflicts only
> > in the Makefile, so it seems like a quiet enough time to do this.  There
> > are no functional changes here, it's just moving code blocks around.
> > 
> > So, I have a few questions, particularly for Al, Andrew, and Linus:
> > 
> > (1) Do you find this reorganizing acceptable?
> 
> No objections, assuming that it's really a move (it's surprisingly easy to
> screw that up - BTDT ;-/)
> 
> I have not done function-by-function comparison, but assuming it holds...
> no problem.

<nod> The only changes between before and after are that some of the
functions lose their static status, and some gain it; and a minor
indenting issue that I'll fix for the final patch series.

As far as makefiles go, both read_write.o and filemap.o are both obj-y
targets, so I think it's safe to make remap_range.o also an obj-y
target.  The fun part will be the careful Kconfig surgery to make
remap_range.o an optional build target, but that will come later.

> > (2) I was planning to rebase this series next Friday and try to throw it
> > in at the end of the merge window; is that ok?  (The current patches are
> > based on 5.9, and applying them manually to current master and for-next
> > didn't show any new conflicts.)
> 
> Up to Linus.  I don't have anything in vfs.git around that area; the
> only remaining stuff touching fs/read_write.c is nowhere near those,
> AFAICS.

<nod> Thanks. :)

--D
