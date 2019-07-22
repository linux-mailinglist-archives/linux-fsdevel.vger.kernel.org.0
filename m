Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9666F6B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 02:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfGVAFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jul 2019 20:05:37 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54663 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfGVAFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jul 2019 20:05:36 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0F9DF43BFA2;
        Mon, 22 Jul 2019 10:05:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hpLoW-0000kz-HX; Mon, 22 Jul 2019 10:04:24 +1000
Date:   Mon, 22 Jul 2019 10:04:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Ting Yao <d201577678@hust.edu.cn>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Message-ID: <20190722000424.GP7689@dread.disaster.area>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <x49zhlbe8li.fsf@segfault.boston.devel.redhat.com>
 <BYAPR04MB5816B59932372E2D97330308E7C80@BYAPR04MB5816.namprd04.prod.outlook.com>
 <x49h87iqexz.fsf@segfault.boston.devel.redhat.com>
 <BYAPR04MB58164A7ACFD3B6331404ECA3E7CA0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB58164A7ACFD3B6331404ECA3E7CA0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=VHTl97k0h774ZZkx8PkA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 20, 2019 at 07:15:26AM +0000, Damien Le Moal wrote:
> Jeff,
> 
> On 2019/07/19 23:25, Jeff Moyer wrote:
> > OK, I can see how a file system eases adoption across multiple
> > languages, and may, in some cases, be easier to adopt by applications.
> > However, I'm not a fan of the file system interface for this usage.
> > Once you present a file system, there are certain expectations from
> > users, and this fs breaks most of them.
> 
> Your comments got me thinking more about zonefs specifications/features and I am
> now wondering if I am not pushing this too far in terms of simplicity. So here
> is a new RFC/Question to chew on... While keeping as a target the concept of
> "file == zone" or as close to it as possible, what do you think zonefs minimal
> feature set should be ?
> 
> One idea I have since a while back now is this:
> 1) If a zone is unused, do not show a file for it. This means adding a dynamic
> "zone allocation" code and supporting O_CREAT on open, unlink, etc. So have more
> normal file system calls behave as with a normal FS.
> 2) Allow file names to be decided by the user instead of using a fixed names.
> Again, have O_CREAT behave as expected

So now you have to implement a persistent directory structure,
atomic/transactional updates, etc. You've just added at least 2
orders of magnitude complexity to zonefs and a very substantial
amount of additional, ongoing QA to ensure it works correctly.

I think keeping it simple by exposing all zones to userspace and
leaving it to the application to track/index what zones it is
using is the simplest way forward for everyone.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
