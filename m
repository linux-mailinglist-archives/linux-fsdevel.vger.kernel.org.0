Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED3F168A10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 23:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgBUWo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 17:44:27 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:39462 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgBUWo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:44:27 -0500
Received: from dread.disaster.area (pa49-195-185-106.pa.nsw.optusnet.com.au [49.195.185.106])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D5E3782097C;
        Sat, 22 Feb 2020 09:44:21 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j5H1v-0004KQ-A8; Sat, 22 Feb 2020 09:44:19 +1100
Date:   Sat, 22 Feb 2020 09:44:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200221224419.GW10776@dread.disaster.area>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221174449.GB11378@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=bkRQb8bsQZKWSSj4M57YXw==:117 a=bkRQb8bsQZKWSSj4M57YXw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=dh8Lkc1bKYycxuq4kUYA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 06:44:49PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 20, 2020 at 04:41:28PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DAX requires special address space operations (aops).  Changing DAX
> > state therefore requires changing those aops.
> > 
> > However, many functions require aops to remain consistent through a deep
> > call stack.
> > 
> > Define a vfs level inode rwsem to protect aops throughout call stacks
> > which require them.
> > 
> > Finally, define calls to be used in subsequent patches when aops usage
> > needs to be quiesced by the file system.
> 
> I am very much against this.  There is a reason why we don't support
> changes of ops vectors at runtime anywhere else, because it is
> horribly complicated and impossible to get right.  IFF we ever want
> to change the DAX vs non-DAX mode (which I'm still not sold on) the
> right way is to just add a few simple conditionals and merge the
> aops, which is much easier to reason about, and less costly in overall
> overhead.

*cough*

That's exactly what the original code did. And it was broken
because page faults call multiple aops that are dependent on the
result of the previous aop calls setting up the state correctly for
the latter calls. And when S_DAX changes between those calls, shit
breaks.

It's exactly the same problem as switching aops between two
dependent aops method calls - we don't solve anything by merging
aops and checking IS_DAX in each method because the race condition
is still there.

/me throws his hands in the air and walks away

-Dave.
-- 
Dave Chinner
david@fromorbit.com
