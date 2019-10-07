Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B3CE753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJGPYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 11:24:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfJGPYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:24:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FO48h154592;
        Mon, 7 Oct 2019 15:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=+ws5Izj8hyAfCOW5xTuTHXPZXfrQQB1vmYoFwB5WMj8=;
 b=M2EbXHqUEkl9jgn3JwAPS1SD7e/XilSJr7Nw44zgVKVV5qkVDRfB2FFMhWfNWMms12dQ
 alb54vyWE/cT9Sq/dcwHxXlC86yZpf9GP9dqr/NtW/tIiBJFjBrBnY1vIXF+ycztFnM2
 ZSKoXPudZ6F7YAk4HdJUzQKcgQGBAgOFM8NQO4DeOH0sYLXNAXuys72/FGOR+az9+kNK
 C1u2FBc80uJ1DnNc8FLhxaCjXUtNdoOkXlWm7kgu4eMc1Pj/w0VkxXcygWWYzVNnlQoW
 J+S6HG1xeipsV+EqF0mXSV3zSyaT/nIaBsLUMDBNT3PK0Ox7A8yzn7eVSwRFzZbszBZA Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vektr7a84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 15:24:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x97FNvJj021334;
        Mon, 7 Oct 2019 15:24:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vg20402ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Oct 2019 15:24:02 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x97FNgPF020858;
        Mon, 7 Oct 2019 15:23:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 08:23:41 -0700
Date:   Mon, 7 Oct 2019 08:23:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iomap: add tracing for the readpage / readpages
Message-ID: <20191007152336.GS13108@magnolia>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-2-hch@lst.de>
 <20191006224324.GR13108@magnolia>
 <20191007054838.GA15655@lst.de>
 <20191007061705.GA20377@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007061705.GA20377@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9403 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 07, 2019 at 08:17:05AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 07, 2019 at 07:48:38AM +0200, Christoph Hellwig wrote:
> > On Sun, Oct 06, 2019 at 03:43:24PM -0700, Darrick J. Wong wrote:
> > > > +iomap-y				+= trace.o \
> > > 
> > > I think this patch is missing fs/iomap/trace.c ?
> > 
> > It does.  The file is in my tree, but I never did a git-add for it..
> 
> A branch with the file is here:
> 
>    git://git.infradead.org/users/hch/xfs.git iomap-writepage.7
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-writepage.7
> 
> I'll wait a bit until I resend to see if people find other issues.

I didn't see any, at least not in a quick overnight fstests run.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D
