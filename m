Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5781C2A5046
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCTkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 14:40:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCTkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:40:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JZvwc187407;
        Tue, 3 Nov 2020 19:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d1L4dqK5RkaI0mSDsPMXtXln3Qr+2M/KnoVIVd1L25k=;
 b=DBDzbx/xB3cXaHe2iHu1JJj3kJEy4RHbE/7xrnkGVzor07tGN6DpzAEWf9IpcWGHNLjs
 DYSNiJzN5us5yDCXjYK0TVx82mrrUQ2eY7tMdip7r0klOZO15sZZyiLQep4E/G9hIn7O
 nTF1qxhIHdMRNiloV05jUiN1cfsyxIJ+SnTWIYsQR6RXZQuBA4YmxBi+fnA53SCKeSOb
 eT1icDKUDVnpRUmUZ5NTYLb+2ylDerjAy27l1XtP2GbGaA+R9vigSH4P9fU/FWz5L8lJ
 N/uWc9dHTqE/0JgFMd+q7AOMyQwLBIVhqT3cr9K1PDwVtqkCLP8VBPee6HJUNm7Ig7e3 Pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2k6am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 19:39:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JZiUo074275;
        Tue, 3 Nov 2020 19:37:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34hvrwbudf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 19:37:53 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A3JbpuE015908;
        Tue, 3 Nov 2020 19:37:51 GMT
Received: from localhost (/10.159.234.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 11:37:51 -0800
Date:   Tue, 3 Nov 2020 11:37:50 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>, fdmanana@kernel.org
Subject: Re: [RFC PATCH] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201103193750.GK7123@magnolia>
References: <20201103173300.GF7123@magnolia>
 <20201103173921.GA32219@infradead.org>
 <20201103183444.GH7123@magnolia>
 <20201103184659.GA19623@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103184659.GA19623@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9794 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 06:46:59PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 03, 2020 at 10:34:44AM -0800, Darrick J. Wong wrote:
> > > Please split the function into __sb_start_write and
> > > __sb_start_write_trylock while you're at it..
> > 
> > Any thoughts on this patch itself?  I don't feel like I have 100% of the
> > context to know whether the removal is a good idea for non-xfs
> > filesystems, though I'm fairly sure the current logic is broken.
> 
> The existing logic looks pretty bogus to me as well.  Did you try to find
> the discussion that lead to it?

TBH I don't know where the discussion happened.  The "convert to
trylock" behavior first appeared as commit 5accdf82ba25c back in 2012;
that commit seems to have come from v6 of a patch[1] that Jan Kara sent
to try to fix fs freeze handling back in 2012.  The behavior was not in
the v5[0] patch, nor was there any discussion for any of the v5 patches
that would suggest why things changed from v5 to v6.

Dave and I were talking about this on IRC yesterday, and his memory
thought that this was lockdep trying to handle xfs taking intwrite
protection while handling a write (or page_mkwrite) operation.  I'm not
sure where "XFS for example gets freeze protection on internal level
twice in some cases" would actually happen -- did xfs support nested
transactions in the past?  We definitely don't now, so I don't think the
comment is valid anymore.

The last commit to touch this area was f4b554af9931 (in 2015), which
says that Dave explained that the trylock hack + comment could be
removed, but the patch author never did that, and lore doesn't seem to
know where or when Dave actually said that?

FWIW I couldn't find a place where we could take the freeze locks in the
wrong order (or multiple times) -- I'm pretty sure the file remap stuff
(clone/dedupe/copyrange) all grab write freeze protection; I couldn't
figure out how you could start with pagefault freeze protection and then
need write freeze protection; and AFAIK none of the filesystems that
even care about intwrite will try to grab it recursively.  Most of them
don't allow nested transactions, and the one that does (nilfs2?) appears
to be careful not to nest.

--D

[0] https://lore.kernel.org/linux-fsdevel/1334592845-22862-14-git-send-email-jack@suse.cz/
[1] https://lore.kernel.org/linux-fsdevel/1338589841-9568-14-git-send-email-jack@suse.cz/
