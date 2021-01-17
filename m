Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801C72F9593
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 22:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbhAQVhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 16:37:04 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:38501 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729744AbhAQVhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 16:37:00 -0500
Received: from dread.disaster.area (pa49-181-54-82.pa.nsw.optusnet.com.au [49.181.54.82])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id D65ED8C0E;
        Mon, 18 Jan 2021 08:36:13 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l1FiX-0011je-Ct; Mon, 18 Jan 2021 08:36:13 +1100
Date:   Mon, 18 Jan 2021 08:36:13 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Raphael Carvalho <raphael.scarv@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Avi Kivity <avi@scylladb.com>, andres@anarazel.de
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
Message-ID: <20210117213613.GC78941@dread.disaster.area>
References: <20210112010746.1154363-1-david@fromorbit.com>
 <CACz=WechdgSnVHQsg0LKjMiG8kHLujBshmc270yrdjxfpffmDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACz=WechdgSnVHQsg0LKjMiG8kHLujBshmc270yrdjxfpffmDQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=NAd5MxazP4FGoF8nXO8esw==:117 a=NAd5MxazP4FGoF8nXO8esw==:17
        a=kj9zAlcOel0A:10 a=EmqxpYm9HcoA:10 a=7-415B0cAAAA:8
        a=0_TVRECrlnMT9PilEVQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 03:45:14PM -0300, Raphael Carvalho wrote:
> On Tue, Jan 12, 2021 at 7:46 AM Dave Chinner <david@fromorbit.com> wrote:
> 
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
> >
> 
> I like this optimistic approach very much. One question though: If
> application submits IO with RWF_NOWAIT, then this fallback step will be
> avoided and application will receive EAGAIN, right?

Yes, all the proposed patches do this correctly.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
