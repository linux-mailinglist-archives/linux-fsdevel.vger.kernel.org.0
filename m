Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9980B14CE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgA2QUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:20:23 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgA2QUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:20:22 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TGI9Dg030229;
        Wed, 29 Jan 2020 16:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=G9TEQB6BlDjmUu0ctyivuWabL47dN2hpe0pXemy87mw=;
 b=sisbA2l1781YJbo34v6gPNdFDickDeW5jqTsuM+rbYChWNvaIFxavOyvqeeiplS2QwOs
 zLaWDRkr++OOaYV9l83JztRdOSaAiK8lmegtRlKBvL661gx0DUlcTkr/IJq+aP8awtXx
 HOFn150t5H9FJLNuKP5sujpkg3/0pdBSkL/KW16wNbsB9D0saHuMAMdmoveKBE5/lyON
 OvRYr6lgm9c/p1ZjRagZufrgwqduTIS0+tFB8TCeBIirgZuG4MMBjkYyW8n1g3GA/vB8
 jAlaG7Ssa5JmcDEppxcKVyciTWRSkoE5B3dlFAVamrzznvjJ9Si19sSxoj2q/wKfRYkX /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xrearednn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 16:20:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TGJECP069461;
        Wed, 29 Jan 2020 16:20:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xth5khumh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 16:19:58 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00TGIecR021829;
        Wed, 29 Jan 2020 16:18:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 08:18:40 -0800
Date:   Wed, 29 Jan 2020 08:18:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [RFCv2 4/4] ext4: Move ext4_fiemap to use iomap infrastructure
Message-ID: <20200129161839.GA3674276@magnolia>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <0147a2923d339bdef5802dde8d5019d719f0d796.1580121790.git.riteshh@linux.ibm.com>
 <20200128152830.GA3673284@magnolia>
 <20200129061939.61BFF11C04C@d06av25.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129061939.61BFF11C04C@d06av25.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:49:38AM +0530, Ritesh Harjani wrote:
> Hello Darrick,
> 
> On 1/28/20 8:58 PM, Darrick J. Wong wrote:
> > On Tue, Jan 28, 2020 at 03:48:28PM +0530, Ritesh Harjani wrote:
> > > Since ext4 already defines necessary iomap_ops required to move to iomap
> > > for fiemap, so this patch makes those changes to use existing iomap_ops
> > > for ext4_fiemap and thus removes all unwanted code.
> > > 
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >   fs/ext4/extents.c | 279 +++++++---------------------------------------
> > >   fs/ext4/inline.c  |  41 -------
> > >   2 files changed, 38 insertions(+), 282 deletions(-)
> > > 
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index 0de548bb3c90..901caee2fcb1 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > 
> > <snip> Just a cursory glance...
> > 
> > > @@ -5130,40 +4927,42 @@ static int ext4_xattr_fiemap(struct inode *inode,
> > >   				EXT4_I(inode)->i_extra_isize;
> > >   		physical += offset;
> > >   		length = EXT4_SB(inode->i_sb)->s_inode_size - offset;
> > > -		flags |= FIEMAP_EXTENT_DATA_INLINE;
> > >   		brelse(iloc.bh);
> > >   	} else { /* external block */
> > >   		physical = (__u64)EXT4_I(inode)->i_file_acl << blockbits;
> > >   		length = inode->i_sb->s_blocksize;
> > >   	}
> > > -	if (physical)
> > > -		error = fiemap_fill_next_extent(fieinfo, 0, physical,
> > > -						length, flags);
> > > -	return (error < 0 ? error : 0);
> > > +	iomap->addr = physical;
> > > +	iomap->offset = 0;
> > > +	iomap->length = length;
> > > +	iomap->type = IOMAP_INLINE;
> > > +	iomap->flags = 0;
> > 
> > Er... external "ACL" blocks aren't IOMAP_INLINE.
> 
> Sorry, I should have mentioned about this too in the cover letter.
> So current patchset is mainly only converting bmap & fiemap to use iomap
> APIs. Even the original implementation does not have external ACL block
> implemented for xattr_fiemap.

Er ... yes it did.  The "} else { /* external block */" block sets
physical to i_file_acl.

> Let me spend some time to implement it. But I would still like to keep
> that as a separate patch.
> 
> But thanks for looking into it. There's this point 2.a & 2.b mentioned in
> the cover letter where I could really use your help in understanding
> if all of that is a known behavior from iomap_fiemap side
> (whenever you have some time of course :) )

i'll go have a look.

--D

> -ritesh
> 
