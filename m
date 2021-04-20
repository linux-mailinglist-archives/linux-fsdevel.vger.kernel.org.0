Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E41365880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhDTMGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 08:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232229AbhDTMGH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:06:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30048613BC;
        Tue, 20 Apr 2021 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618920335;
        bh=ZiHFBNeowD0y96Ybd6GgNVVH0YPOMIokIMnSawx/I6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ePV/HMcc9f+LS5cg6VomboUm0NIv23uuSuBV9Kyhx2lTKXBHLpSKoEhvIFhxDp+Yt
         Hh1r41ld6x7JhzOCD8/sbZU9XNF73DKBbhRWkNbrV7awJjFmJ4zylLyWdkf8mq/gT+
         GVeQsVuNAHwoKnDMbcJ6d8svbs17BCkp/hZ1uy1U71jksL/vcG5/wVQiqWFUQ19qND
         Vq0cG5e2EJZBFjU+W7Y80NJN7Qdn+j5koh5J00yDa/THlbihu7HOAVbxMT3yotDoVQ
         GPD4Cgdxp2sBL0doAvtv5GEn7E/jT93K6HAX49T/0bBqhlE8ji8VcEheiAtYCfwdh5
         oOir6xzbVz4Qw==
Date:   Tue, 20 Apr 2021 15:05:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs: proc.rst: meminfo: briefly describe gaps in memory
 accounting
Message-ID: <YH7Dh3eF+GyVxNGg@kernel.org>
References: <20210420085105.1156640-1-rppt@kernel.org>
 <YH6aa8WJotXh8F+b@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH6aa8WJotXh8F+b@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 11:10:03AM +0200, Michal Hocko wrote:
> On Tue 20-04-21 11:51:05, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Some trivial changelog would be better than nothing.
 
oh, sure.

> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> But I do agree that this is a useful information to have in the
> documentation. Having networking counters as an example is helpful as
> well. I am not familiar with those myself much and I do remember there
> is much to it than just sockstat. It would be great to consult this with
> some networking expert and extend the documentation for that case which
> tends to be quite common AFAIK.
 
I've found a citation from one of Eric Dumazet's emails [1], and used that
instead:

... subsystem specific interfaces, for instance /proc/net/sockstat for TCP
memory allocations

[1] https://lore.kernel.org/lkml/CANn89iKprp7WYeZy4RRO5jHykprnSCcVBc7Tk14Ui_MA9OK7Fg@mail.gmail.com

> Anyway this is already an improvement and a step into the right
> direction.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> one nit below
> > ---
> >  Documentation/filesystems/proc.rst | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 48fbfc336ebf..bf245151645b 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -929,8 +929,15 @@ meminfo
> >  ~~~~~~~
> >  
> >  Provides information about distribution and utilization of memory.  This
> > -varies by architecture and compile options.  The following is from a
> > -16GB PIII, which has highmem enabled.  You may not have all of these fields.
> > +varies by architecture and compile options. Please note that is may happen
> 
> that it may happen

Right.
 
> > +that the memory accounted here does not add up to the overall memory usage
> > +and the difference for some workloads can be substantial. In many cases
> > +there are other means to find out additional memory using subsystem
> > +specific interfaces, for instance /proc/net/sockstat for networking
> > +buffers.
> > +
> > +The following is from a 16GB PIII, which has highmem enabled.
> > +You may not have all of these fields.
> >  
> >  ::
> >  
> > -- 
> > 2.29.2
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.
