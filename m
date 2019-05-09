Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE4184CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfEIFUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 01:20:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34770 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfEIFUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 01:20:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x495IsZo115927;
        Thu, 9 May 2019 05:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=B8z4d8TJNj7koMdhbwwSONC3L788gplZi1QmnQt9lSw=;
 b=sOKMzQs5HA6DMqgcFVo0M1FPIyb0zffuQwWLF0ODrbOVP4adAloro9SDXIfcyJEZx2Bo
 FZs5K3Za4NdUD9xmOurbfeQ4mfg0PANRrAcgFaFDdd+UuCjaXdPGq1LNV4+V63Fc9ex6
 6VgJ8siSv4LAKFIcgtT3JtHspaBR+I195JAcxAi1mVqaj88a45noD5pF1S+t+24S1ale
 UZ7bTpNPLA3vYIkBqGvDkZt03gXtzTKqrjeSmcWWBCp4/nFHW9Xnm4iwHoWUTf6DyREq
 cYwIQ7uGECLlbygTu5vjtPFQikl/GQIhsXtYHq8CG7FuVqPl1VOQrv8fK3M8KW8M9K1g Vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s94bg8bj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 05:19:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x495J6Aj122685;
        Thu, 9 May 2019 05:19:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2s9ayfyn0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 May 2019 05:19:43 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x495JeMa032738;
        Thu, 9 May 2019 05:19:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 May 2019 22:19:40 -0700
Date:   Wed, 8 May 2019 22:19:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Vijay Chidambaram <vijay@cs.utexas.edu>,
        lsf-pc@lists.linux-foundation.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties
 contract
Message-ID: <20190509051938.GE5352@magnolia>
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
 <CAHWVdUXS+e71QNFAyhFUY4W7o3mzVCb=8UrRZAN=v9bv7j6ssA@mail.gmail.com>
 <CAOQ4uxjNWLvh7EmizA7PjmViG5nPMsvB2UbHW6-hhbZiLadQTA@mail.gmail.com>
 <20190503023043.GB23724@mit.edu>
 <20190509014327.GT1454@dread.disaster.area>
 <20190509022013.GC7031@mit.edu>
 <20190509025845.GV1454@dread.disaster.area>
 <20190509033100.GB29703@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509033100.GB29703@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905090034
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9251 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905090034
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 08, 2019 at 11:31:00PM -0400, Theodore Ts'o wrote:
> On Thu, May 09, 2019 at 12:58:45PM +1000, Dave Chinner wrote:
> > 
> > SOMC does not defining crash consistency rules - it defines change
> > dependecies and how ordering and atomicity impact the dependency
> > graph. How other people have interpreted that is out of my control.
> 
> Fine; but it's a specific set of the crash consistency rules which I'm
> objecting to; it's not a promise that I think I want to make.  (And
> before you blindly sign on the bottom line, I'd suggest that you read
> it very carefully before deciding whether you want to agree to those
> consistency rules as something that XFS will have honor forever.  The
> way I read it, it's goes beyond what you've articulated as SOMC.)

I find myself (unusually) rooting for the status quo, where we /don't/
have a big SOMC rulebook that everyone has to follow, and instead we
just tell people that if they really want to know a filesystem they had
better try their workload with that fs + storage.  If they don't like
what they find, we have a reasonable amount of competition and niche
specialization amongst the many filesystems that they can try the
others, or if they're still unsatisfied, see if they can drive a
consensus.  Filesystems are like cars -- the basic interfaces are more
or less the same and they but the implementations can still differ.

(They also tend to crash, catch on fire, and leave a smear of
destruction in their wake.)

> > A new syscall with essentially the same user interface doesn't
> > guarantee that these implementation problems will be solved.
> 
> Well, it makes it easier to send all of the requests to the file
> system in a single bundle.  I'd also argue that it's simpler and
> easier for an application to use a fsync2() interface as I sketched
> out than trying to use the whole AIO or io_uring machinery.

I *would* like to see a more concrete fsync2 proposal.  And while I'm
asking for ponies, whatever it is that came out of the DAX file flags
discussion too.

> 
> > So it's essentially identical to the AIO_FSYNC interface, except
> > that it is synchronous.
> 
> Pretty much, yes.

OH yeah, I forgot we wired that up finally.

> > Sheesh! Did LSFMM include a free lobotomy for participants, or
> > something?

"I'd rather have a bottle in front of me..."

Peace out, see you all on the 20th!

--D

> Well, we missed your presence, alas.  No doubt your attendance would
> have improved the discussion.
> 
> Cheers,
> 
> 					- Ted
