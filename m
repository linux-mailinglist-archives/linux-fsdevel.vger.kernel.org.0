Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7350171293
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgB0Iae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 03:30:34 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:54604 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbgB0Iae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:30:34 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id BF54D7E83E9;
        Thu, 27 Feb 2020 19:30:30 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7EYv-000849-AF; Thu, 27 Feb 2020 19:30:29 +1100
Date:   Thu, 27 Feb 2020 19:30:29 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
Message-ID: <20200227083029.GL10737@dread.disaster.area>
References: <20200226161404.14136-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=vcMIKiOjALrSOcI2QM0A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> As there is no limit for negative dentries, it is possible that a sizeable
> portion of system memory can be tied up in dentry cache slabs. Dentry slabs
> are generally recalimable if the dentries are in the LRUs. Still having
> too much memory used up by dentries can be problematic:

I don't get it.

Why isn't the solution simply "constrain the application generating
unbound numbers of dentries to a memcg"?

Then when the memcg runs out of memory, it will start reclaiming the
dentries that were allocated inside the memcg that are using all
it's resources, thereby preventing unbound growth of the dentry
cache.

I mean, this sort of resource control is exactly what memcgs are
supposed to be used for and are already used for. I don't see why we
need all this complexity for global dentry resource management when
memcgs should already provide an effective means of managing and
placing bounds on the amount of memory any specific application can
use...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
