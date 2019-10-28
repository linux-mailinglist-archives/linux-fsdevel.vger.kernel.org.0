Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E03E7D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 00:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfJ1X4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 19:56:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37884 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfJ1X4n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 19:56:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SNnt5o194228;
        Mon, 28 Oct 2019 23:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=pX26Az5wjD3cescteqioCNoPFwO1sBOt2UYPks4Y0qY=;
 b=U7XsprzxgcYhk1W7bWnamUhcdhbjW42DUKBZio590w+R4ZuB/BDerYv3pQCF+5XhVRSS
 rfJLdJUjmljyq+JtVEHr2pqTuH5FblL8dzIXhDR5azpXpvJa7yyc0OWo4ndykjtmPyY9
 SoOl7J1rFPyX+sn7c0ecfK+efziDCyxK96shWTcYfuhG1z/Q4Mp5QcwKfjt5cPJCYETn
 YZPBB9iB3GOuZ7ng1/+wTVMXweRKCjgQLbgNruhGIQXfclLrd2eGsNh9Kwier4Df1C/H
 48xQccjwurRN/4r1sTy72IAzX8NJmDSOcJCOozTMvgXAQ8Yxo5l4Qn0UQZzGl2ii5HTk jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vvumfa2s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 23:56:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SNrNtE177417;
        Mon, 28 Oct 2019 23:56:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vvyksuaq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 23:56:26 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9SNuMT7013125;
        Mon, 28 Oct 2019 23:56:22 GMT
Received: from localhost (/10.159.156.71)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 16:56:22 -0700
Date:   Mon, 28 Oct 2019 16:56:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com
Subject: Re: [PATCH v6 04/11] ext4: move set iomap routines into a separate
 helper ext4_set_iomap()
Message-ID: <20191028235621.GC15221@magnolia>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <36c0b0028215ed0a39697512054f3fa4799b0701.1572255425.git.mbobrowski@mbobrowski.org>
 <20191028170348.GA15203@magnolia>
 <20191028203641.GA25021@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028203641.GA25021@bobrowski>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280225
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:36:41AM +1100, Matthew Bobrowski wrote:
> On Mon, Oct 28, 2019 at 10:03:48AM -0700, Darrick J. Wong wrote:
> > On Mon, Oct 28, 2019 at 09:51:31PM +1100, Matthew Bobrowski wrote:
> > > +static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
> > > +			   struct ext4_map_blocks *map, loff_t offset,
> > > +			   loff_t length)
> > > +{
> > > +	u8 blkbits = inode->i_blkbits;
> > > +
> > > +	/*
> > > +	 * Writes that span EOF might trigger an I/O size update on completion,
> > > +	 * so consider them to be dirty for the purpose of O_DSYNC, even if
> > > +	 * there is no other metadata changes being made or are pending.
> > > +	 */
> > > +	iomap->flags = 0;
> > > +	if (ext4_inode_datasync_dirty(inode) ||
> > > +	    offset + length > i_size_read(inode))
> > > +		iomap->flags |= IOMAP_F_DIRTY;
> > > +
> > > +	if (map->m_flags & EXT4_MAP_NEW)
> > > +		iomap->flags |= IOMAP_F_NEW;
> > > +
> > > +	iomap->bdev = inode->i_sb->s_bdev;
> > > +	iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
> > > +	iomap->offset = (u64) map->m_lblk << blkbits;
> > > +	iomap->length = (u64) map->m_len << blkbits;
> > > +
> > > +	if (map->m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN)) {
> > 
> > /me wonders if this would be easier to follow if it was less indenty:
> > 
> > /*
> >  * <giant comment from below>
> >  */
> > if (m_flags & EXT4_MAP_UNWRITTEN) {
> > 	iomap->type = IOMAP_UNWRITTEN;
> > 	iomap->addr = ...
> > } else if (m_flags & EXT4_MAP_MAPPED) {
> > 	iomap->type = IOAMP_MAPPED;
> > 	iomap->addr = ...
> > } else {
> > 	iomap->type = IOMAP_HOLE;
> > 	iomap->addr = IOMAP_NULL_ADDR;
> > }
> > 
> > Rather than double-checking m_flags?
> 
> Yeah, you're right. The extra checks and levels of indentation aren't really
> necessary and can be simplified further, as you've suggested above.
> 
> Thanks for looking over this for me.
> 
> /me adds this to the TODO for v7.

<nod> I didn't see anything else obviously wrong, FWIW.

--D

> --<M>--
