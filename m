Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68006DB8A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395256AbfJQUtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 16:49:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfJQUtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:49:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKdV1T080013;
        Thu, 17 Oct 2019 20:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=25IO1oLsQE+/ECgN1OQ0SznJdZ92tH/ZPgQjpNHO8gc=;
 b=otkwOVuMYbP9eBbux6ELH5UTvaZKjgwNTbDuTr2mgVZsGzAS1CxJ2YMMIaYq87QGrnIa
 9Y8fFTUVMkA0skUy68TgAh1Q/8CqD+PnZisaiimswhu3OIiSy8HnYFS24UQpwJADCH88
 J5o6MHT3CIGbdUBLUSmtUJbp2TjwqJDxLEPBZ5SuA0HpVwUqJH107Dsf8Gpw8QfKaNIG
 xrg78qrjtfPyCusADvaEzm59mjxNeuRutU/pouXCHXsxuUocL0ykJnz7vqHaHFvPvL7x
 K4uX/eGU6VITXFwAepAA+ZpJIu/Rz0InTkAt7FY6Rym+3HBzihUz7umJh7pVUrtAM0b4 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vk7frrrp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 20:49:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HKcbNb186077;
        Thu, 17 Oct 2019 20:49:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vpcm3kmh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 20:49:13 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9HKnB1A004209;
        Thu, 17 Oct 2019 20:49:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 20:49:11 +0000
Date:   Thu, 17 Oct 2019 13:49:09 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: lift the xfs writepage code into iomap v8
Message-ID: <20191017204909.GO13108@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=650
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=735 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170186
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:56:10PM +0200, Christoph Hellwig wrote:
> Hi Darrick,
> 
> this series cleans up the xfs writepage code and then lifts it to
> fs/iomap/ so that it could be use by other file system.
> 
> Note: the submit_ioend hook has not been renamed.  Feel free to
> rename it if you really dislike the name.

Heh, ok.  ->prepare_ioend it is.

Is a v3 of "iomap and xfs COW cleanups" coming soon?

--D

> 
> Changes since v7:
>  - fix various commit log typos
>  - fix up various comments
>  - move some of the iomap tracepoint additions to an earlier patch
>  - rebased on top of "iomap: iomap that extends beyond EOF should be
>    marked dirty"
> 
> Changes since v6:
>  - actually add trace.c to the patch
>  - move back to the old order that massages XFS into shape and then
>    lifts the code to iomap
>  - cleanup iomap_ioend_compare
>  - cleanup the add_to_ioend checks
> 
> Changes since v5:
>  - move the tracing code to fs/iomap/trace.[ch]
>  - fix a bisection issue with the tracing code
>  - add an assert that xfs_end_io now only gets "complicated" completions
>  - better document the iomap_writeback_ops methods in iomap.h
> 
> Changes since v4:
>  - rebased on top 5.4-rc1
>  - drop the addition of list_pop / list_pop_entry
>  - re-split a few patches to better fit Darricks scheme of keeping the
>    iomap additions separate from the XFS switchover
> 
> Changes since v3:
>  - re-split the pages to add new code to iomap and then switch xfs to
>    it later (Darrick)
> 
> Changes since v2:
>  - rebased to v5.3-rc1
>  - folded in a few changes from the gfs2 enablement series
> 
> Changes since v1:
>  - rebased to the latest xfs for-next tree
>  - keep the preallocated transactions for size updates
>  - rename list_pop to list_pop_entry and related cleanups
>  - better document the nofs context handling
>  - document that the iomap tracepoints are not a stable API
