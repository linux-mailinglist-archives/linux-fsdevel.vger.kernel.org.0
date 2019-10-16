Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DAED9C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394461AbfJPVWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 17:22:36 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33166 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394411AbfJPVWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:22:35 -0400
Received: from dread.disaster.area (pa49-181-198-88.pa.nsw.optusnet.com.au [49.181.198.88])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3ED0643E8EA;
        Thu, 17 Oct 2019 08:22:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iKqkX-0001LK-9m; Thu, 17 Oct 2019 08:22:29 +1100
Date:   Thu, 17 Oct 2019 08:22:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [Project Quota]file owner could change its project ID?
Message-ID: <20191016212229.GJ16973@dread.disaster.area>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=ocld+OpnWJCUTqzFQA3oTA==:117 a=ocld+OpnWJCUTqzFQA3oTA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=QQG8O11YrPY9A1I9HsUA:9
        a=wzy0uYdRrGvVSUI7:21 a=drtSVpqNNNfG8ioO:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 07:51:15PM +0800, Wang Shilong wrote:
> On Mon, Oct 14, 2019 at 12:41 AM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
> >
> > On Sat, Oct 12, 2019 at 02:33:36PM +0800, Wang Shilong wrote:
> > > Steps to reproduce:
> > > [wangsl@localhost tmp]$ mkdir project
> > > [wangsl@localhost tmp]$ lsattr -p project -d
> > >     0 ------------------ project
> > > [wangsl@localhost tmp]$ chattr -p 1 project
> > > [wangsl@localhost tmp]$ lsattr -p -d project
> > >     1 ------------------ project
> > > [wangsl@localhost tmp]$ chattr -p 2 project
> > > [wangsl@localhost tmp]$ lsattr -p -d project
> > >     2 ------------------ project
> > > [wangsl@localhost tmp]$ df -Th .
> > > Filesystem     Type  Size  Used Avail Use% Mounted on
> > > /dev/sda3      xfs    36G  4.1G   32G  12% /
> > > [wangsl@localhost tmp]$ uname -r
> > > 5.4.0-rc2+
> > >
> > > As above you could see file owner could change project ID of file its self.
> > > As my understanding, we could set project ID and inherit attribute to account
> > > Directory usage, and implement a similar 'Directory Quota' based on this.
> >
> > So the problem here is that the admin sets up a project quota on a
> > directory, then non-container users change the project id and thereby
> > break quota enforcement?  Dave didn't sound at all enthusiastic, but I'm
> > still wondering what exactly you're trying to prevent.
> 
> Yup, we are trying to prevent no-root users to change their project ID.
> As we want to implement 'Directory Quota':

You can already implement "Directory Quota" with project quotas.

What you are asking for is a different implementation of "Directory
Quota" to what we currently support.

> If non-root users could change their project ID, they could always try
> to change its project ID to steal space when EDQUOT returns.

Audit trail will tell you if users are doing this :P

Basically,  what you want is a -strict- directory quota, where users
are unable to select the quota ID the directory is placed under.
i.e. it is entirely admin controlled, and users can't place
different directories under different quota IDs.

We can do this, but we need and explicit description of the
behaviour your require, and how it differs from the existing
"directory quota via project quotas" mechanism that people currently
use. i.e. there are two very different use cases for "directory
quotas" here, and users are going to need to know which one to
select for their intended us. 

> Yup, if mount option could be introduced to make this case work,
> that will be nice.

That's maybe ten  lines of code. I expect that the documentation of
the use cases and the differences in behaviour between the two modes
of behaviour will be a couple of hundred lines at least...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
