Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881EB77504
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGZXiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 19:38:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59554 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfGZXiJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:38:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QNXnlx008852;
        Fri, 26 Jul 2019 23:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=sOZ4f2d5NvdcscXZLpkNGln28J/MfY0dpJF0XaxyVXo=;
 b=vj3bSvY8y/ZwFWZpC8sdlVbNieZyxd3zoWMZrzYpqIvKOOvES4roR1lg/qEsB2YEdnv6
 8cOFoFJT3wwS/PD8xnCAHIuOeioGboY7MPalzP37gBSJdeQK93YxIKfA7vgHBZD2TkUD
 i+5gBwCHmTkQnjLiAN0gj2NaMHtiI7iqBTXmTVu3drmJiANSdcPZOUuQKkvdp+oxJtfA
 D578lHlomD0i3FmXyv2EwkQ1WbyPP+u9AUX62T7WrABgcjZUcweQ87/ipkRWUt5shFs1
 VYlk6bcDDq6qYTs5Ka4uSUWuP1Hd3AopkoaU84wRe7P1DfUWcuveYFq6nMKE9tTHyqJx WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tx61cdf63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 23:37:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QNWwpL050294;
        Fri, 26 Jul 2019 23:37:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tycv8m6bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 23:37:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6QNbsk5003177;
        Fri, 26 Jul 2019 23:37:54 GMT
Received: from localhost (/10.145.179.122)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jul 2019 16:37:54 -0700
Date:   Fri, 26 Jul 2019 16:37:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: lift the xfs writepage code into iomap v3
Message-ID: <20190726233753.GD2166993@magnolia>
References: <20190722095024.19075-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=866
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260265
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=910 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260265
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 23, 2019 at 11:50:12AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the xfs writepage code and then lifts it to
> fs/iomap.c so that it could be use by other file system.  I've been
> wanting to this for a while so that I could eventually convert gfs2
> over to it, but I never got to it.  Now Damien has a new zonefs
> file system for semi-raw access to zoned block devices that would
> like to use the iomap code instead of reinventing it, so I finally
> had to do the work.

Hmm... I don't like how there are xfs changes mixed in with the iomap
changes, because were I to take this series as-is then I'd have to
commit both to adding iomap writeback code /and/ converting xfs at the
same time.

I think I'd be more comfortable creating a branch to merge the changes
to list.h and fs/iomap/, and then gfs2/zonefs/xfs can sprout their own
branches from there to do whatever conversions are necessary.

To me what that means is splitting patch 7 into 7a which does the iomap
changes and 7b which does the xfs changes.  To get there, I'd create a
iomap-writeback branch containing:

1 7a 8 9 10 11 12

and then a new xfs-iomap-writeback branch containing:

2 4 7b

This eliminates the need for patches 3, 5, and 6, though the cost is
that it's less clear from the history that we did some reorganizing of
the xfs writeback code and then moved it over to iomap.  OTOH, I also
see this as a way to lower risk because if some patch in the
xfs-iomap-writeback branch shakes loose a bug that doesn't affect gfs2
or zonedfs we don't have to hold them up.

I'll try to restructure this series along those lines and report back
how it went.

--D

> 
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
