Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1A7D46B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 19:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJKRfz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 13:35:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46890 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfJKRfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:35:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so9575730qkd.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2019 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pne+NQJSftjfOjJkrPe9U8MRMQwWyQFD53LqSYfvgmQ=;
        b=aUi86JqnKFILv3MvRHhefmSb0NPptFoBNV3TRbL1ivjn+h4veKs54/+EHlkzTOOdqc
         i5tEWilHDqF5INNviZjxQwL5X2rVxsAmco7mMPIx3Syxkw4KeuhEaJoZdETpxl/KEw0F
         HqBbIIt0Sl2xN3uj5JpXkO9wAxb79QCQuvCqJtI1UDRZvg74wvkqdbGosxjfVN1+SNi1
         77GbcwrHVlt47mJZfm3uKEdqVeeBpZPtUoqa+KkZTLUfZnI6+Q2nqfhSYtPEAJ5nj4dg
         RQo45+svIB78PNCY5yzDqw/T6CxOQyOaLHoUf8fV3U0sAtE3nhiN9MDGgjD+9Kp+AXku
         +J1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pne+NQJSftjfOjJkrPe9U8MRMQwWyQFD53LqSYfvgmQ=;
        b=bp4zJIpv8yKRcG+w72ncVyyiZgIJhXChdYQNICJ+joJ6EXbkm4P2LsFSIkMz8ezB9x
         W91jV7AedwYN6MTjTG5lcnUVMbY3AMzSt1hZpJ5bM7W94uDo9RVyz7Zd7iMQqv0w5Kf9
         Cb/dQnHtrUla+m/n88aGDDv5D/pFU7wrFSRsk9BSFWVUSc4nkHEypo4x/AQEOXHFSCxp
         8RdG4lydMRTIJYcSrsOFIxaLsI6bR7ZvwSKP8JeDprwgzicrDE449Rx0rjz9PePsjJ8F
         hlYppiU/a2ZfOC+4MiNUGy2tNMbjgMKa4FBfGR8eyALuLRuoH/mP0VS3VU6jLZ6JU7Dm
         9pWg==
X-Gm-Message-State: APjAAAWvGeoNBmtfm0yDF00j3Tb58KipxVwBzBm/HkDyzt26p1Hk0Jtg
        bvjbiW8x3zxV2+IMXbqYWdFghQ==
X-Google-Smtp-Source: APXvYqxaMIuWqjYrcdt3JJ4R4MJA2It5C+09dQro4PcNGgt3PuRcMwmTvS6Nkw5sSwJ3dD398w19iw==
X-Received: by 2002:a05:620a:1249:: with SMTP id a9mr17187510qkl.235.1570815353815;
        Fri, 11 Oct 2019 10:35:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d36])
        by smtp.gmail.com with ESMTPSA id 29sm4635155qkp.86.2019.10.11.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:35:53 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:35:51 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <20191011173550.dldpghvslavhodhl@macbook-pro-91.dhcp.thefacebook.com>
References: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
 <20191011172927.4d4wnvgd7rfwwr7o@macbook-pro-91.dhcp.thefacebook.com>
 <bed67fc8-641a-18c1-0547-369c75c51508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed67fc8-641a-18c1-0547-369c75c51508@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 11, 2019 at 12:34:45PM -0500, Eric Sandeen wrote:
> On 10/11/19 12:29 PM, Josef Bacik wrote:
> > On Fri, Oct 11, 2019 at 11:49:38AM -0500, Eric Sandeen wrote:
> >> Anything that walks all inodes on sb->s_inodes list without rescheduling
> >> risks softlockups.
> >>
> >> Previous efforts were made in 2 functions, see:
> >>
> >> c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
> >> ac05fbb inode: don't softlockup when evicting inodes
> >>
> >> but there hasn't been an audit of all walkers, so do that now.  This
> >> also consistently moves the cond_resched() calls to the bottom of each
> >> loop.
> >>
> >> One remains: remove_dquot_ref(), because I'm not quite sure how to deal
> >> with that one w/o taking the i_lock.
> >>
> >> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > You've got iput cleanups in here and cond_resched()'s.  I feel like this is a
> > missed opportunity to pad your patch count.  Thanks,
> 
> yeah, I was going to suggest that I could split it out into 3
> (move cond_rescheds, clean up iputs, add new rescheds) if there was a
> request.  But it seemed a bit ridiculously granular.  Find by me
> if desired, tho.
> 
> So, was that a request?

I think just two patches, one for the iputs and one for the resched changes.
Thanks,

Josef
