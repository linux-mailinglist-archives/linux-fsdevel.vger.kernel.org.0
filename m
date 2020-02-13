Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE8A15CB9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgBMUA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:00:58 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgBMUA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:00:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJrhqu135470;
        Thu, 13 Feb 2020 20:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qnXvCz+6kkBoPYOIM0/jTaDZgIKo/FzttVj0aM4nTps=;
 b=jgFLIUgTANvySdJiTiSOWLLDtmwnL6d4K6je3f2CKN4kA7dJay9VEC0JeJ0NhnWZgfjG
 ROrzJBY9xmtJ31PFsxqeXNXn+lmQhWrrg/xAbqf69bnU+MlxycyrGZvGUb6hp6CgIqbY
 TnfAaKrUx1V0n8dqbZaVpir1xWDrmglcMWW1PTZ5QWkmrEvuhNh1040ZMUCFZzyI9PKj
 MPaGC+UEJkrIAH7CO4BqCjTMX+IVPOJ3Ep1Ro5bH0Q+J0sF2zq/QNRlvVx2hSqY/W0Hn
 np0PBc/Y2/VgRDIOpayGGjBRjB27edstidqdfmLuXmv9Mw5BubELnKQvGyWpwZ725IsZ Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y2p3svrvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 20:00:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01DJw3oV022714;
        Thu, 13 Feb 2020 19:58:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y4k80gv0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:58:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01DJwflD021036;
        Thu, 13 Feb 2020 19:58:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Feb 2020 11:58:41 -0800
Date:   Thu, 13 Feb 2020 11:58:39 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] Enable per-file/directory DAX operations V3
Message-ID: <20200213195839.GG6870@magnolia>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <x49imke1nj0.fsf@segfault.boston.devel.redhat.com>
 <20200211201718.GF12866@iweiny-DESK2.sc.intel.com>
 <x49sgjf1t7n.fsf@segfault.boston.devel.redhat.com>
 <20200213190156.GA22854@iweiny-DESK2.sc.intel.com>
 <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213190513.GB22854@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9530 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130139
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:05:13AM -0800, Ira Weiny wrote:
> On Thu, Feb 13, 2020 at 11:01:57AM -0800, 'Ira Weiny' wrote:
> > On Wed, Feb 12, 2020 at 02:49:48PM -0500, Jeff Moyer wrote:
> > > Ira Weiny <ira.weiny@intel.com> writes:
> > > 
>  
> [snip]
> 
> > > Given that we document the dax mount
> > > option as "the way to get dax," it may be a good idea to allow for a
> > > user to selectively disable dax, even when -o dax is specified.  Is that
> > > possible?
> > 
> > Not with this patch set.  And I'm not sure how that would work.  The idea was
> > that -o dax was simply an override for users who were used to having their
> > entire FS be dax.  We wanted to depreciate the use of "-o dax" in general.  The
> > individual settings are saved so I don't think it makes sense to ignore the -o
> > dax in favor of those settings.  Basically that would IMO make the -o dax
> > useless.
> 
> Oh and I forgot to mention that setting 'dax' on the root of the FS basically
> provides '-o dax' functionality by default with the ability to "turn it off"
> for files.

Please don't further confuse FS_XFLAG_DAX and S_DAX.  They are two
separate flags with two separate behaviors:

FS_XFLAG_DAX is a filesystem inode metadata flag.

Setting FS_XFLAG_DAX on a directory causes all files and directories
created within that directory to inherit FS_XFLAG_DAX.

Mounting with -o dax causes all files and directories created to have
FS_XFLAG_DAX set regardless of the parent's status.

The FS_XFLAG_DAX can be get and set via the fs[g]etxattr ioctl.

-------

S_DAX is the flag that controls the IO path in the kernel for a given
inode.

Loading a file inode into the kernel (via _iget) with FS_XFLAG_DAX set
or creating a file inode that inherits FS_XFLAG_DAX causes the incore
inode to have the S_DAX flag set if the storage device supports it.

Files with S_DAX set use the dax IO paths through the kernel.

The S_DAX flag can be queried via statx.

--D

> Ira
> 
> > 
> > Ira
> > 
