Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307AE2A8CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 03:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgKFCUM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 21:20:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33640 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFCUM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:20:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A62JdwW026318;
        Fri, 6 Nov 2020 02:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LE3XesdwYiRpyIOzFHaebvgJsYWxfN4WTiQjadmBn08=;
 b=iAXAlztOSzSWVpqc4sVadM0JE5CL707c6MBcpuEbTx7yClz1Ow7MC9SpOCed7GfTwuw+
 ig0THaqOqq8DX3m9de9STFM19GsrY9QwZu9719MfYNa2eF5jn7ZI6qA9oaubmPv/1cGP
 bevRW/hhdFrny3RJeP761c8TPX7FG9bLiEVVaFG3cNnPOrLRLrfigcd57Av8C5y+BJqz
 8J5ipQ98vJ5KP8UEaehFWSi1HKUwYyuamf5MGB4elBLclWFrJw2ykbEJrFFoLlvXyZJS
 eX48lh50w2S2E3NmxnucU8Ey3EQjDVmHnnZT6ay/9WvEjzaD6h/WfPhLYHmXYAStS726 HQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34hhb2ey92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 06 Nov 2020 02:20:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A62Eorl119227;
        Fri, 6 Nov 2020 02:19:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34hw0jdqea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Nov 2020 02:19:59 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A62Jqeu014492;
        Fri, 6 Nov 2020 02:19:52 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Nov 2020 18:19:52 -0800
Date:   Thu, 5 Nov 2020 18:19:51 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fdmanana@kernel.org
Subject: Re: [RFC PATCH] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201106021951.GF7148@magnolia>
References: <20201103173300.GF7123@magnolia>
 <20201103173921.GA32219@infradead.org>
 <20201103183444.GH7123@magnolia>
 <20201103184659.GA19623@infradead.org>
 <20201103193750.GK7123@magnolia>
 <20201105213415.GD7391@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105213415.GD7391@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9796 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060014
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 08:34:15AM +1100, Dave Chinner wrote:
> On Tue, Nov 03, 2020 at 11:37:50AM -0800, Darrick J. Wong wrote:
> > On Tue, Nov 03, 2020 at 06:46:59PM +0000, Christoph Hellwig wrote:
> > > On Tue, Nov 03, 2020 at 10:34:44AM -0800, Darrick J. Wong wrote:
> > > > > Please split the function into __sb_start_write and
> > > > > __sb_start_write_trylock while you're at it..
> > > > 
> > > > Any thoughts on this patch itself?  I don't feel like I have 100% of the
> > > > context to know whether the removal is a good idea for non-xfs
> > > > filesystems, though I'm fairly sure the current logic is broken.
> > > 
> > > The existing logic looks pretty bogus to me as well.  Did you try to find
> > > the discussion that lead to it?
> > 
> > TBH I don't know where the discussion happened.  The "convert to
> > trylock" behavior first appeared as commit 5accdf82ba25c back in 2012;
> > that commit seems to have come from v6 of a patch[1] that Jan Kara sent
> > to try to fix fs freeze handling back in 2012.  The behavior was not in
> > the v5[0] patch, nor was there any discussion for any of the v5 patches
> > that would suggest why things changed from v5 to v6.
> > 
> > Dave and I were talking about this on IRC yesterday, and his memory
> > thought that this was lockdep trying to handle xfs taking intwrite
> > protection while handling a write (or page_mkwrite) operation.  I'm not
> > sure where "XFS for example gets freeze protection on internal level
> > twice in some cases" would actually happen -- did xfs support nested
> > transactions in the past?  We definitely don't now, so I don't think the
> > comment is valid anymore.
> > 
> > The last commit to touch this area was f4b554af9931 (in 2015), which
> > says that Dave explained that the trylock hack + comment could be
> > removed, but the patch author never did that, and lore doesn't seem to
> > know where or when Dave actually said that?
> 
> I'm pretty sure this "nesting internal freeze references" stems from
> the fact we log and flush the superblock after fulling freezing the
> filesystem to dirty the journal so recovery after a crash while
> frozen handles unlinked inodes.
> 
> The high level VFS freeze annotations were not able to handle
> running this transaction when transactions were supposed to already
> be blocked and drained, so there was a special hack to hide it from
> lockdep. Then we ended up hiding it from the VFS via
> XFS_TRANS_NO_WRITECOUNT in xfs_sync_sb() because we needed it in
> more places than just freeze (e.g. the log covering code
> run by the background log worker). It's kinda documented here:
> 
> /*
>  * xfs_sync_sb
>  *
>  * Sync the superblock to disk.
>  *
>  * Note that the caller is responsible for checking the frozen state of the
>  * filesystem. This procedure uses the non-blocking transaction allocator and
>  * thus will allow modifications to a frozen fs. This is required because this
>  * code can be called during the process of freezing where use of the high-level
>  * allocator would deadlock.
>  */
> 
> So, AFAICT, the whole "XFS nests internal transactions" lockdep 
> handling in __sb_start_write() has been unnecessary for quite a few
> years now....

Yeah.  Would you be willing to RVB this, or are you all waiting for a v2
series?

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
