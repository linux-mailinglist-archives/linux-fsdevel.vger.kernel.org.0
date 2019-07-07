Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5236186A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 01:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfGGXYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jul 2019 19:24:05 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58808 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfGGXYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jul 2019 19:24:05 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4420A43B261;
        Mon,  8 Jul 2019 09:24:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hkGUg-0006b2-P1; Mon, 08 Jul 2019 09:22:54 +1000
Date:   Mon, 8 Jul 2019 09:22:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] dget_parent() misuse in xfs_filestream_get_parent()
Message-ID: <20190707232254.GF7689@dread.disaster.area>
References: <20190628060026.GR17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628060026.GR17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=OjdfWhF5gRNsxT9O6HoA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 07:00:27AM +0100, Al Viro wrote:
> 	dget_parent() never returns NULL.  So this
> 
>         parent = dget_parent(dentry);
>         if (!parent)
>                 goto out_dput;
> 
>         dir = igrab(d_inode(parent));
>         dput(parent);
> 
> out_dput:
> 
> is obviously fishy.  What is that code trying to do?  Is that
> "dentry might be a root of disconnected tree, in which case
> we want xfs_filestream_get_parent() to return NULL"? 

We want the parent inode of the current file inode if it is in
memory. We don't care about the parent dentry that is returned as
such, it's just the mechanism for finding the directory inode. The
directory inode is what holds the allocation policy for all files in
that directory, and that's what we need here.

If there is no parent directory inode in memory, then we'll just use
the default allocator behaviour rather than the context specific
one we get from the directory inode...

> If so,
> that should be
> 
>         parent = dget_parent(dentry);
>         if (parent != dentry)
> 		dir = igrab(d_inode(parent));
>         dput(parent);

Seems reasonable. This code is largely legacy functionality, the
allocator was really a specific workload policy that was never
widely deployed and so the combination of disconnected dentries and
this allocator have probably never been seen in real life...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
