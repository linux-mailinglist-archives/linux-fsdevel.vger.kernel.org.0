Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5452F3FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394677AbhALWgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:36:41 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:52240 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbhALWgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:36:41 -0500
Received: from dread.disaster.area (pa49-179-167-107.pa.nsw.optusnet.com.au [49.179.167.107])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id E0CC81140135;
        Wed, 13 Jan 2021 09:35:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kzRum-005pO5-3V; Wed, 13 Jan 2021 09:13:24 +1100
Date:   Wed, 13 Jan 2021 09:13:24 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andres@anarazel.de
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
Message-ID: <20210112221324.GU331610@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=+wqVUQIkAh0lLYI+QRsciw==:117 a=+wqVUQIkAh0lLYI+QRsciw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=7gNsaiQ1Yi_N14eLDtUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:01:35AM +0200, Avi Kivity wrote:
> On 1/12/21 3:07 AM, Dave Chinner wrote:
> > Hi folks,
> > 
> > This is the XFS implementation on the sub-block DIO optimisations
> > for written extents that I've mentioned on #xfs and a couple of
> > times now on the XFS mailing list.
> > 
> > It takes the approach of using the IOMAP_NOWAIT non-blocking
> > IO submission infrastructure to optimistically dispatch sub-block
> > DIO without exclusive locking. If the extent mapping callback
> > decides that it can't do the unaligned IO without extent
> > manipulation, sub-block zeroing, blocking or splitting the IO into
> > multiple parts, it aborts the IO with -EAGAIN. This allows the high
> > level filesystem code to then take exclusive locks and resubmit the
> > IO once it has guaranteed no other IO is in progress on the inode
> > (the current implementation).
> 
> 
> Can you expand on the no-splitting requirement? Does it involve only
> splitting by XFS (IO spans >1 extents) or lower layers (RAID)?

XFS only.

> The reason I'm concerned is that it's the constraint that the application
> has least control over. I guess I could use RWF_NOWAIT to avoid blocking my
> main thread (but last time I tried I'd get occasional EIOs that frightened
> me off that).

Spurious EIO from RWF_NOWAIT is a bug that needs to be fixed. DO you
have any details?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
