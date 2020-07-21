Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC62C2284CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgGUQGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:06:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43422 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgGUQGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:06:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LG1UVD048595;
        Tue, 21 Jul 2020 16:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LSsHWv/Ry310RdY8DfK9RbXStKhT7a/ijlTJRfNYKBw=;
 b=F3w1juxlH5QSmHd+imiuYdZGWjKHnzEv/NKoyKwhIc/s7GN+vHaAzidQDTB/DhjAEyeT
 d/Gx8vucWDL2jzjYsFydj9gp/ppR/d1HKXkpQ4M+nBfyMU/lBxulYLTGIP63iUbn+XMa
 5AJJ7SdGe5ThlcDK+Ad12dSY6V2RP2uwwvf/W6jgJCOAzcaF6075T2S5EuIypvbdsOMZ
 5GZy7LilCugLI4xLlHnpqSBJQc4HmAEDrO9FuVijPQrTmhxzqZDLoVgUPaZUuxoFXLdV
 7XUINu6FhLHiAiQirWudIChRb2+CCLxB/+abECYiU5zPJXFWz1kdRwMYbxCbqSB925uM yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32bs1me5ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 16:05:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFi0cn060765;
        Tue, 21 Jul 2020 16:03:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32e33ght6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 16:03:47 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06LG3i8F028849;
        Tue, 21 Jul 2020 16:03:45 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 16:03:44 +0000
Date:   Tue, 21 Jul 2020 09:03:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200721160342.GC3151642@magnolia>
References: <20200713074633.875946-1-hch@lst.de>
 <20200720215125.bfz7geaftocy4r5l@fiona>
 <20200721145313.GA9217@lst.de>
 <20200721150432.GH15516@casper.infradead.org>
 <20200721150615.GA10330@lst.de>
 <20200721151437.GI15516@casper.infradead.org>
 <20200721151616.GA11074@lst.de>
 <20200721153136.GJ15516@casper.infradead.org>
 <20200721154240.GB11652@lst.de>
 <20200721155201.GL15516@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721155201.GL15516@casper.infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=1
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210113
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:52:01PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 21, 2020 at 05:42:40PM +0200, Christoph Hellwig wrote:
> > On Tue, Jul 21, 2020 at 04:31:36PM +0100, Matthew Wilcox wrote:
> > > > Umm, no.  -ENOTBLK is internal - the file systems will retry using
> > > > buffered I/O and the error shall never escape to userspace (or even the
> > > > VFS for that matter).
> > > 
> > > Ah, I made the mistake of believing the comments that I could see in
> > > your patch instead of reading the code.
> > > 
> > > Can I suggest deleting this comment:
> > > 
> > >         /*
> > >          * No fallback to buffered IO on errors for XFS, direct IO will either
> > >          * complete fully or fail.
> > >          */
> > > 
> > > and rewording this one:
> > > 
> > >                 /*
> > >                  * Allow a directio write to fall back to a buffered
> > >                  * write *only* in the case that we're doing a reflink
> > >                  * CoW.  In all other directio scenarios we do not
> > >                  * allow an operation to fall back to buffered mode.
> > >                  */
> > > 
> > > as part of your revised patchset?
> > 
> > That isn't actually true.  In current mainline we only fallback on
> > reflink RMW cases, but with this series we also fall back for
> > invalidation failures.
> 
> ... that's why I'm suggesting that you delete the first one and rewrite
> the second one.  Because they aren't true.

/*
 * We allow only three outcomes of a directio: (1) it succeeds
 * completely; (2) it fails with a negative error code; or (3) it
 * returns -ENOTBLK to signal that we should fall back to buffered IO.
 *
 * The third scenario should only happen if iomap refuses to perform the
 * direct IO, or the direct write request requires CoW but is not aligned
 * to the filesystem block size.
 */

?

--D
