Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD697B663
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 01:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfG3Xs3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 19:48:29 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59543 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfG3Xs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:48:29 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D6D2543FD26;
        Wed, 31 Jul 2019 09:48:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hsbps-0002Ap-Ua; Wed, 31 Jul 2019 09:47:16 +1000
Date:   Wed, 31 Jul 2019 09:47:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Message-ID: <20190730234716.GY7689@dread.disaster.area>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area>
 <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
 <3D2360FA-AD48-48AE-B1CE-D1CF58C1B8AB@dilger.ca>
 <BYAPR04MB5816BD641DF55A93986DF826E7DC0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816BD641DF55A93986DF826E7DC0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=csMc22W9G3xQcTkcgCcA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:06:33AM +0000, Damien Le Moal wrote:
> If we had a pread_nofs()/pwrite_nofs(), that would work. Or we could define a
> RWF_NORECLAIM flag for pwritev2()/preadv2(). This last one could actually be the
> cleanest approach.

Clean, yes, but I'm not sure we want to expose kernel memory reclaim
capabilities to userspace... It would be misleading, too, because we
still want to allow reclaim to occur, just not have reclaim recurse
into other filesystems....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
