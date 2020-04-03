Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5299C19DE1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDCSkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 14:40:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35872 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgDCSkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:40:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033IdpwV070659;
        Fri, 3 Apr 2020 18:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=US8sLZnPxZ4y6UO3tSsSOv7UIGRPUmZ6f+wFCFJJeOQ=;
 b=xeFMnEEbWYLoDz5Q5V+8ejlUQ96+jvJQ6VH388yPYlgQsWMjCKX3dhXGui0EA5iDYxIL
 SeUdA9Iz1umAPmeBbGKEqvD7xq77dQHg765FxTV5LNf4FzEW28t5zAHIRUMDQN2RsxLd
 cvGmvppcaH9X75UfLaXlyHr5PrTxVV1kwHo153hFWyfzo/sU2ua2zuOtwu0DEegGZfll
 3ym5lVJlp5dzzOtFk4YwEnMPFUDISPnW/vXZ4/6FuwEI3DgPx8KZuKRzeOvxczjSNopZ
 Lt4Vw44B6sKXAQDA8Ffyx4/m/wDeh+etYwCvW11i2yUnsUjji91jZcegnl5uy0upMfxw Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 303yunn8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:39:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033ISOBr169247;
        Fri, 3 Apr 2020 18:37:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 302g4xyebw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 18:37:51 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033Ibm72020164;
        Fri, 3 Apr 2020 18:37:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 11:37:48 -0700
Date:   Fri, 3 Apr 2020 11:37:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200403183746.GQ80283@magnolia>
References: <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
 <20200403154828.GJ3952565@iweiny-DESK2.sc.intel.com>
 <20200403170338.GD29920@quack2.suse.cz>
 <20200403181843.GK3952565@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403181843.GK3952565@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9580 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030151
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:18:43AM -0700, Ira Weiny wrote:
> On Fri, Apr 03, 2020 at 07:03:38PM +0200, Jan Kara wrote:
> > On Fri 03-04-20 08:48:29, Ira Weiny wrote:
> > > On Fri, Apr 03, 2020 at 09:27:31AM +0200, Christoph Hellwig wrote:
> > > > On Thu, Apr 02, 2020 at 01:55:19PM -0700, Ira Weiny wrote:
> > > > > > I'd just return an error for that case, don't play silly games like
> > > > > > evicting the inode.
> > > > > 
> > > > > I think I agree with Christoph here.  But I want to clarify.  I was heading in
> > > > > a direction of failing the ioctl completely.  But we could have the flag change
> > > > > with an appropriate error which could let the user know the change has been
> > > > > delayed.
> > > > > 
> > > > > But I don't immediately see what error code is appropriate for such an
> > > > > indication.  Candidates I can envision:
> > > > > 
> > > > > EAGAIN
> > > > > ERESTART
> > > > > EUSERS
> > > > > EINPROGRESS
> > > > > 
> > > > > None are perfect but I'm leaning toward EINPROGRESS.
> > > > 
> > > > I really, really dislike that idea.  The whole point of not forcing
> > > > evictions is to make it clear - no this inode is "busy" you can't
> > > > do that.  A reasonably smart application can try to evict itself.
> > > 
> > > I don't understand.  What Darrick proposed would never need any
> > > evictions.  If the file has blocks allocated the FS_XFLAG_DAX flag can
> > > not be changed.  So I don't see what good eviction would do at all.
> > 
> > I guess there's some confusion here (may well be than on my side). Darrick
> > propose that we can switch FS_XFLAG_DAX only when file has no blocks
> > allocated - fine by me. But that still does not mean than we can switch
> > S_DAX immediately, does it? Because that would still mean we need to switch
> > aops on living inode and that's ... difficult and Christoph didn't want to
> > clutter the code with it.
> > 
> > So I've understood Darrick's proposal as: Just switch FS_XFLAG_DAX flag,
> > S_DAX flag will magically switch when inode gets evicted and the inode gets
> > reloaded from the disk again. Did I misunderstand anything?
> > 
> > And my thinking was that this is surprising behavior for the user and so it
> > will likely generate lots of bug reports along the lines of "DAX inode flag
> > does not work!". So I was pondering how to make the behavior less
> > confusing... The ioctl I've suggested was just a poor attempt at that.
> 
> Ok but then I don't understand Christophs comment to "just return an error for
> that case"?  Which case?
> 
> > 
> > > > But returning an error and doing a lazy change anyway is straight from
> > > > the playbook for arcane and confusing API designs.
> > > 
> > > Jan countered with a proposal that the FS_XFLAG_DAX does change with
> > > blocks allocated.  But that S_DAX would change on eviction.  Adding that
> > > some eviction ioctl could be added.
> > 
> > No, I didn't mean that we can change FS_XFLAG_DAX with blocks allocated. I
> > was still speaking about the case without blocks allocated.
> 
> Ah ok good point.  But again what 'error' do we return when FS_XFLAG_DAX
> changed but S_DAX did not?
> 
> > 
> > > You then proposed just returning an error for that case.  (This lead me to
> > > believe that you were ok with an eviction based change of S_DAX.)
> > > 
> > > So I agreed that changing S_DAX could be delayed until an explicit eviction.
> > > But, to aid the 'smart application', a different error code could be used to
> > > indicate that the FS_XFLAG_DAX had been changed but that until that explicit
> > > eviction occurs S_DAX would remain.
> > > 
> > > So I don't fully follow what you mean by 'lazy change'?
> > > 
> > > Do you still really, really dislike an explicit eviction method for changing
> > > the S_DAX flag?
> > > 
> > > If FS_XFLAG_DAX can never be changed on a file with blocks allocated and the
> > > user wants to change the mode of operations on their 'data'; they would have to
> > > create a new file with the proper setting and move the data there.  For example
> > > copy the file into a directory marked FS_XFLAG_DAX==true?
> > > 
> > > I'm ok with either interface as I think both could be clear if documented.
> > 
> > I agree that what Darrick suggested is technically easily doable and can be
> > documented. But it is not natural behavior (i.e., different than all inode
> > flags we have) and we know how careful people are when reading
> > documentation...
> > 
> 
> Ok For 5.8 why don't we not allow FS_XFLAG_DAX to be changed on files _at_
> _all_...
> 
> In summary:
> 
>  - Applications must call statx to discover the current S_DAX state.

Ok.

>  - There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
>    the parent directory FS_XFLAG_DAX inode flag.  (There is no way to change
>    this flag after file creation.)
> 
>    If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
>    inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
>    Unless overridden...

Ok, fine with me. :)

>  - There exists a dax= mount option.
> 
>    "-o dax=off" means "never set S_DAX, ignore FS_XFLAG_DAX"
>    	"-o nodax" means "dax=off"

I surveyed the three fses that support dax and found that none of the
filesystems actually have a 'nodax' flag.  Now would be the time not to
add such a thing, and make people specify dax=off instead.  It would
be handy if we could have a single fsparam_enum for figuring out the dax
mount options.

>    "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
>    	"-o dax" by itself means "dax=always"
>    "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default
> 
>  - There exists an advisory directory inode flag FS_XFLAG_DAX that can be
>    changed at any time.  The flag state is copied into any files or
>    subdirectories when they are created within that directory.  If programs
>    require file access runs in S_DAX mode, they'll have to create those files

"...they must create..."

>    inside a directory with FS_XFLAG_DAX set, or mount the fs with an
>    appropriate dax mount option.

Otherwise seems ok to me.

--D

> 
> 
> ???
> 
> Ira
> 
