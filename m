Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9018F139EF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 02:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgANBaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 20:30:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58216 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbgANBaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:30:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1TE0t105524;
        Tue, 14 Jan 2020 01:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=A6M6k3ikXF8yBWj9VHiQxI6pJTnSUujmxK2S/8NxTcw=;
 b=GKgg2CgDiqDxyhrkWOqF5UoV2rsi4K9yH9eAVdbJxkCwdoEtLoEPutV0eO8fXq9FQ4a6
 64D23mOZG1H98R4V+rWk5icqO2pxgB5ZEy7If5GR3rlVDKTm44wtUbooYstWE61y6xLY
 3jqHo/KXOoArSRRa61aEhf2kSx6MJiyH5TCJTIfzIL/hKG7bndLDlQ5IGAqf9RWA9hn8
 f/4mPMz0qC85XqsvtE9d4ye8zPyOCwMCpYQfp58opVNt268rwz3Pk6MKRv3BCfTnsOo5
 PGSvO9I4sMNUyPjm+uWgIOcA3XjZWib8IHOcfxro+uwIJRtbvmu/PhZxHqGr76yD9CbZ 7A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73tjpw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:30:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1TDD3176589;
        Tue, 14 Jan 2020 01:30:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xfrgjp4mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:30:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E1U68n006854;
        Tue, 14 Jan 2020 01:30:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 17:30:06 -0800
Date:   Mon, 13 Jan 2020 17:30:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Message-ID: <20200114013004.GU8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-10-ira.weiny@intel.com>
 <20200113222212.GO8247@magnolia>
 <20200114004610.GD29860@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114004610.GD29860@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140011
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:46:10PM -0800, Ira Weiny wrote:
> On Mon, Jan 13, 2020 at 02:22:12PM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 10, 2020 at 11:29:39AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> 
> [snip]
> 
> > >  
> > > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > > index bc3654fe3b5d..1ab0906c6c7f 100644
> > > --- a/fs/xfs/xfs_ioctl.c
> > > +++ b/fs/xfs/xfs_ioctl.c
> > > @@ -1200,6 +1200,14 @@ xfs_ioctl_setattr_dax_invalidate(
> > >  		goto out_unlock;
> > >  	}
> > >  
> > > +	/*
> > > +	 * If there is a mapping in place we must remain in our current mode.
> > > +	 */
> > > +	if (atomic64_read(&inode->i_mapped)) {
> > 
> > Urk, should we really be messing around with the address space
> > internals?
> 
> I contemplated a function call instead of checking i_mapped directly?  Is that
> what you mean?

Yeah.  Abstracting the details just enough that filesystems don't have
to know that i_mapped is atomic64 etc.

> 
> > 
> > > +		error = -EBUSY;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > >  	error = filemap_write_and_wait(inode->i_mapping);
> > >  	if (error)
> > >  		goto out_unlock;
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 631f11d6246e..6e7dc626b657 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -740,6 +740,7 @@ struct inode {
> > >  #endif
> > >  
> > >  	void			*i_private; /* fs or device private pointer */
> > > +	atomic64_t               i_mapped;
> > 
> > I would have expected to find this in struct address_space since the
> > mapping count is a function of the address space, right?
> 
> I suppose but the only external call (above) would be passing an inode.  So to
> me it seemed better here.

But the number of memory mappings reflects the state of the address
space, not the inode.  Or maybe put another way, if I were an mm
developer I would not expect to look in struct inode for mm state.

static inline bool inode_has_mappings(struct inode *inode)
{
	return atomic64_read(&inode->i_mapping->mapcount) > 0;
}

OTOH if there exist other mm developers who /do/ find that storing the
mmap count in struct inode is more logical, please let me know. :)

--D

> Ira
> 
> > 
> > --D
> > 
