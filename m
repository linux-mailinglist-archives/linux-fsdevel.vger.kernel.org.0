Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC41132543
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 12:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgAGLxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 06:53:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39152 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAGLxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:53:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so53598796wrt.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 03:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xneQoTqKKrNYgVN7q4Qq8Lombhc67ZIKSD7HEKMmthA=;
        b=Tj4G8/02g59CM5qyMchcFEJJPmcGqO7dV33ImIdCNLGe6hk3sqR+CrtvdpnPp8maOF
         rTI7q0o8PKvvUNoMIfdD6gZ9bq7Sv5RwahUNSTZA+dmwLrT9kztuP1QBjN7NwTRulNxU
         upgaqSHW39yPqfzp/z0i9/wixw6AsnIup7Uf7Rb9rsy8SYL1Me/3SeSyej6Hz3rJZ99O
         y0XqV46WsE+dxzTVNFVIcGG1eH+Y69qqJLK3Z0wDRUNMriaZM6KLh7V30mhss8sYy7ha
         Uyk/N9f2HiECCB9NukU9vwTDwdXeYIWfrPwUvguwW17eTl0IbU7Gtr6aAQApx9o3Rl+W
         IoJQ==
X-Gm-Message-State: APjAAAXO/kEIRSj907VYWAaTAK5/uwrCg0TXc0aCgsnwvkeee8sbdTbO
        hdeKjMafqxrzkbJ1zSbl4UU=
X-Google-Smtp-Source: APXvYqxQ3hHn2LXtmCGLxLP13E2z0SS5SE0gmPuCfjB/793S2BcLfKnvSruTv0oAycQu74tIFgjXMw==
X-Received: by 2002:a5d:50ce:: with SMTP id f14mr108511028wrt.254.1578398014643;
        Tue, 07 Jan 2020 03:53:34 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s128sm26944703wme.39.2020.01.07.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 03:53:33 -0800 (PST)
Date:   Tue, 7 Jan 2020 12:53:33 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Congestion
Message-ID: <20200107115333.GF32178@dhcp22.suse.cz>
References: <20191231125908.GD6788@bombadil.infradead.org>
 <20200106115514.GG12699@dhcp22.suse.cz>
 <20200106232100.GL23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106232100.GL23195@dread.disaster.area>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 10:21:00, Dave Chinner wrote:
> On Mon, Jan 06, 2020 at 12:55:14PM +0100, Michal Hocko wrote:
> > On Tue 31-12-19 04:59:08, Matthew Wilcox wrote:
> > > 
> > > I don't want to present this topic; I merely noticed the problem.
> > > I nominate Jens Axboe and Michael Hocko as session leaders.  See the
> > > thread here:
> > 
> > Thanks for bringing this up Matthew! The change in the behavior came as
> > a surprise to me. I can lead the session for the MM side.
> > 
> > > https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/
> > > 
> > > Summary: Congestion is broken and has been for years, and everybody's
> > > system is sleeping waiting for congestion that will never clear.
> > > 
> > > A good outcome for this meeting would be:
> > > 
> > >  - MM defines what information they want from the block stack.
> > 
> > The history of the congestion waiting is kinda hairy but I will try to
> > summarize expectations we used to have and we can discuss how much of
> > that has been real and what followed up as a cargo cult. Maybe we just
> > find out that we do not need functionality like that anymore. I believe
> > Mel would be a great contributor to the discussion.
> 
> We most definitely do need some form of reclaim throttling based on
> IO congestion, because it is trivial to drive the system into swap
> storms and OOM killer invocation when there are large dirty slab
> caches that require IO to make reclaim progress and there's little
> in the way of page cache to reclaim.

Just to clarify. I do agree that we need some form of throttling. Sorry
if my wording was confusing. What I meant is that I am not sure whether
wait_iff_congested as it is implemented now is the right way. We
definitely have to slow/block the reclaim when there is a lot of dirty
(meta)data. How to do that is a good topic to discuss.

[skipping the rest of the email which has many good points]

-- 
Michal Hocko
SUSE Labs
