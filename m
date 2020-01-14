Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7B49139ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 02:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgANBOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 20:14:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55482 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgANBOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:14:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1D8wG105720;
        Tue, 14 Jan 2020 01:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=yE5ZIDVe1jfzOcNsCuRD6Iv9+W3jDx2HylSrlN9qdRo=;
 b=MXOxCSBOkPhJlVXFDJ3iV6F5h0Fe3HKRJELLTGucvYYfFDDWxFVgtumdLr3/wsh4LeVA
 c4VgGUGdCCYBNP0YmbUK5plpU2jhzoYPy6+L33zNa1THIkSu9athoQ64n8JtHJhn9vLy
 QALBwxlHMok0sNGXiTsWJy5hI04EJqizdPcXGnef4SuBAuXwllaljN0viOJNaSFCRltx
 mOkM3F+CNJIaGO+GjwZdHLlbJ7jQkoBEH18bhzQmIaVJNLOaK2ZCok4KB/h68LOwiFC/
 l8CK6jmvrPexmHwR+Rye8nDJrq1UQlgjwi9zSvIZivSqGBcmS/2ckKNTENJlNAL162jv Ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73yanqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:14:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E1DOVX189803;
        Tue, 14 Jan 2020 01:14:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2xh30xg3tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 01:14:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E1E9mN016284;
        Tue, 14 Jan 2020 01:14:11 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 17:14:09 -0800
Date:   Mon, 13 Jan 2020 17:14:07 -0800
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
Subject: Re: [RFC PATCH V2 10/12] fs/xfs: Fix truncate up
Message-ID: <20200114011407.GT8247@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-11-ira.weiny@intel.com>
 <20200113222755.GP8247@magnolia>
 <20200114004047.GC29860@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114004047.GC29860@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140008
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:40:47PM -0800, Ira Weiny wrote:
> On Mon, Jan 13, 2020 at 02:27:55PM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 10, 2020 at 11:29:40AM -0800, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > When zeroing the end of a file we must account for bytes contained in
> > > the final page which are past EOF.
> > > 
> > > Extend the range passed to iomap_zero_range() to reach LLONG_MAX which
> > > will include all bytes of the final page.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/xfs/xfs_iops.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index a2f2604c3187..a34b04e8ac9c 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -910,7 +910,7 @@ xfs_setattr_size(
> > >  	 */
> > >  	if (newsize > oldsize) {
> > >  		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
> > > -		error = iomap_zero_range(inode, oldsize, newsize - oldsize,
> > > +		error = iomap_zero_range(inode, oldsize, LLONG_MAX - oldsize,
> > 
> > Huh?  Won't this cause the file size to be set to LLONG_MAX?
> 
> Not as I understand the code.

iomap_zero_range uses the standard iomap_write_{begin,end} functions,
which means that if you pass it an (offset, length) that extend beyond
EOF it will change isize to offset+length.

> But as I said in the cover I am not 100% sure of
> this fix.

> From what I can tell xfs_ioctl_setattr_dax_invalidate() should invalidate the
> mappings and the page cache and the traces I have indicate that the DAX mode
> is not changing or was properly held off.

Hmm, that implies the invalidation didn't work.  Can you find a way to
report the contents of the page cache after the dax mode change
invalidation fails?  I wonder if this is something dorky like rounding
down such that the EOF page doesn't actually get invalidated?

Hmm, no, xfs_ioctl_setattr_dax_invalidate should be nuking all the
pages... do you have a quick reproducer?

--D

> Any other suggestions as to the problem are welcome.
> 
> Ira
> 
> 
> > 
> > --D
> > 
> > >  				&did_zeroing, &xfs_buffered_write_iomap_ops);
> > >  	} else {
> > >  		error = iomap_truncate_page(inode, newsize, &did_zeroing,
> > > -- 
> > > 2.21.0
> > > 
