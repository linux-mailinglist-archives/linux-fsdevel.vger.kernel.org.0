Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88213D3D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 06:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAPFk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 00:40:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40230 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPFk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:40:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G5d7gu190046;
        Thu, 16 Jan 2020 05:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=O2y4baYCtSNrkp+Lgi4+LG2ZXQzVmAuC/rt2XIZW9PA=;
 b=eW1quC/w9DYviZi5ANfhhCjpqQRWjXrdU0tvP336utZX/NTHPUbobP6OseGnqNPeQpAD
 DrBVEr8CIJ6jztliVgCgKymibxSWjWIF0YBA7/DCNiB0m9gHWxZYssfdkios/KQCzcg5
 ta0mE25xLLYqLYRom7L2aWtJwmHrAVIFPfDjJTC60i4ESdpWKkzOC74jlLuV+vmdxJl9
 GDecA5dcNljY0DkbhpKn1OgRl0b5VOLxnRWJ2nnQzH1YQkSIiWAzMtmZb/UsZxtgVEzJ
 GWlEdyUHWt4k6NHw5kcT1Pq3ENkk8ZujbT0kPu7BK8E8yBRRv9rRwa+7ofd5mPFgmLon 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xf73yr9nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 05:40:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00G5cvwP158428;
        Thu, 16 Jan 2020 05:40:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xj61kxudk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 05:40:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00G5egnb008491;
        Thu, 16 Jan 2020 05:40:42 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jan 2020 21:40:42 -0800
Date:   Wed, 15 Jan 2020 21:40:40 -0800
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
Subject: Re: [RFC PATCH V2 07/12] fs: Add locking for a dynamic inode 'mode'
Message-ID: <20200116054040.GC8235@magnolia>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-8-ira.weiny@intel.com>
 <20200113221218.GM8247@magnolia>
 <20200114002005.GA29860@iweiny-DESK2.sc.intel.com>
 <20200114010322.GS8247@magnolia>
 <20200115190846.GE23311@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115190846.GE23311@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9501 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 11:08:46AM -0800, Ira Weiny wrote:
> On Mon, Jan 13, 2020 at 05:03:22PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 13, 2020 at 04:20:05PM -0800, Ira Weiny wrote:
> > > On Mon, Jan 13, 2020 at 02:12:18PM -0800, Darrick J. Wong wrote:
> > > > On Fri, Jan 10, 2020 at 11:29:37AM -0800, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 
> > > > > +``lock_mode``
> > > > > +	called to prevent operations which depend on the inode's mode from
> > > > > +        proceeding should a mode change be in progress
> > > > 
> > > > "Inodes can't change mode, because files do not suddenly become
> > > > directories". ;)
> > > 
> > > Yea sorry.
> > > 
> > > > 
> > > > Oh, you meant "lock_XXXX is called to prevent a change in the pagecache
> > > > mode from proceeding while there are address space operations in
> > > > progress".  So these are really more aops get and put functions...
> > > 
> > > At first I actually did have aops get/put functions but this is really
> > > protecting more than the aops vector because as Christoph said there are file
> > > operations which need to be protected not just address space operations.
> > > 
> > > But I agree "mode" is a bad name...  Sorry...
> > 
> > inode_fops_{get,set}(), then?
> > 
> > inode_start_fileop()
> > inode_end_fileop() ?
> > 
> > Trying to avoid sounding foppish <COUGH>
> 
> What about?
> 
> inode_[un]lock_state()?

Kinda vague -- which state?  inodes retain a lot of different state.

This locking primitive ensures that file operations pointers can't
change while any operations are ongoing, right?

--D

> Ira
> 
