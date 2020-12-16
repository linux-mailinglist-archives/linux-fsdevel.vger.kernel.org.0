Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F49C2DB965
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 03:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgLPCrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 21:47:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48110 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgLPCrb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:47:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG2iQFr060031;
        Wed, 16 Dec 2020 02:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=WkCjasEHHy7py54Y2YmM8Hp8LCLtjfYuzvd3sPD2fgI=;
 b=HRPBZ1n1r4YYFJMqvwxqxobnCC8pPSyTiY3O8BBNihRVerUQAh1Dwe+MuK9XM63QVbTh
 E5LAPvc0G3eYYWwd4sAFBxJ7gg6m8G/ccfxjKGbWAZNfL/jaUw0i6bNG4xlqZWRPW8+N
 63XClUkN4jj4VGs6nZpKvvCpBTheMtzJvQHQzc5zmJ7Xtv5GtjM8L+A4q4P/NMmDimBM
 zKCXUSpwfATQfYo0KVaFdLu9kdqr7cqPGCL0wUpSlBHqbEhu8FlIFuJYVStg0nvPv5BZ
 E43zhimIo8Zvw1NkLsSaGch9+Q1wEabNEnmiKsHLvRciyi6W+R6bWWyIhHIEXZb0Zji7 fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9rds72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 02:46:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG2jAV8015913;
        Wed, 16 Dec 2020 02:46:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35e6js2byy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 02:46:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BG2kJYw003814;
        Wed, 16 Dec 2020 02:46:20 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 18:46:19 -0800
Date:   Tue, 15 Dec 2020 18:46:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        dan.j.williams@intel.com, hch@lst.de, song@kernel.org,
        rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201216024618.GC6918@magnolia>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
 <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
 <20201215231022.GL632069@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215231022.GL632069@dread.disaster.area>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160014
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:10:22AM +1100, Dave Chinner wrote:
> On Tue, Dec 15, 2020 at 11:05:07AM -0800, Jane Chu wrote:
> > On 12/15/2020 3:58 AM, Ruan Shiyang wrote:
> > > Hi Jane
> > > 
> > > On 2020/12/15 上午4:58, Jane Chu wrote:
> > > > Hi, Shiyang,
> > > > 
> > > > On 11/22/2020 4:41 PM, Shiyang Ruan wrote:
> > > > > This patchset is a try to resolve the problem of tracking shared page
> > > > > for fsdax.
> > > > > 
> > > > > Change from v1:
> > > > >    - Intorduce ->block_lost() for block device
> > > > >    - Support mapped device
> > > > >    - Add 'not available' warning for realtime device in XFS
> > > > >    - Rebased to v5.10-rc1
> > > > > 
> > > > > This patchset moves owner tracking from dax_assocaite_entry() to pmem
> > > > > device, by introducing an interface ->memory_failure() of struct
> > > > > pagemap.  The interface is called by memory_failure() in mm, and
> > > > > implemented by pmem device.  Then pmem device calls its ->block_lost()
> > > > > to find the filesystem which the damaged page located in, and call
> > > > > ->storage_lost() to track files or metadata assocaited with this page.
> > > > > Finally we are able to try to fix the damaged data in filesystem and do
> > > > 
> > > > Does that mean clearing poison? if so, would you mind to elaborate
> > > > specifically which change does that?
> > > 
> > > Recovering data for filesystem (or pmem device) has not been done in
> > > this patchset...  I just triggered the handler for the files sharing the
> > > corrupted page here.
> > 
> > Thanks! That confirms my understanding.
> > 
> > With the framework provided by the patchset, how do you envision it to
> > ease/simplify poison recovery from the user's perspective?
> 
> At the moment, I'd say no change what-so-ever. THe behaviour is
> necessary so that we can kill whatever user application maps
> multiply-shared physical blocks if there's a memory error. THe
> recovery method from that is unchanged. The only advantage may be
> that the filesystem (if rmap enabled) can tell you the exact file
> and offset into the file where data was corrupted.
> 
> However, it can be worse, too: it may also now completely shut down
> the filesystem if the filesystem discovers the error is in metadata
> rather than user data. That's much more complex to recover from, and
> right now will require downtime to take the filesystem offline and
> run fsck to correct the error. That may trash whatever the metadata
> that can't be recovered points to, so you still have a uesr data
> recovery process to perform after this...

...though for the future future I'd like to bypass the default behaviors
if there's somebody watching the sb notification that will also kick off
the appropriate repair activities.  The xfs auto-repair parts are coming
along nicely.  Dunno about userspace, though I figure if we can do
userspace page faults then some people could probably do autorepair
too.

--D

> > And how does it help in dealing with page faults upon poisoned
> > dax page?
> 
> It doesn't. If the page is poisoned, the same behaviour will occur
> as does now. This is simply error reporting infrastructure, not
> error handling.
> 
> Future work might change how we correct the faults found in the
> storage, but I think the user visible behaviour is going to be "kill
> apps mapping corrupted data" for a long time yet....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
