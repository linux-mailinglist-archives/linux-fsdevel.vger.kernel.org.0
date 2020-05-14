Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE401D2E3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENL1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENL1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 07:27:23 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC1C061A0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 04:27:23 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z9so1438296qvi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 04:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z4Eb6Z/rPVAAEqdRxIyzUYlyq/XLZSCN7N827gkP7SE=;
        b=Xuama2Pehfv31Tu5u95cS0aR3Up3PL2ZaP4TPeOq3w7oyLjzaiWSS8A+dcj3dLkHDM
         u6Z4vxQLsxqmxviLKbp4s2L7OIdHN02+gyGbQN4vWBpgtR4BWnTweHWfZt9bNcAnBjPJ
         /njdCkO3Yi/Klv3pse7p6MCFPDZJ4abAcNodv4ss9DPMsIYk7c2746M9XrKH9Sqz0o5e
         bWw+TLs5y1/MYoTwQqEBWKcVgHR8dHdiquyaK1wY3/QyVXZ5OFzfiZDAz7Iu5GMZ78WF
         qyC1UXJwW5mCpSnSJOE7D2oC89RmZmiluwGWrTagIRExbGtr7csUHL0Z9W7DDBg6Ts3Q
         EFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z4Eb6Z/rPVAAEqdRxIyzUYlyq/XLZSCN7N827gkP7SE=;
        b=lNp3hM/yvFrTA7nvad1E7jBp0huVf03+YitvDV0w/rGmrdzT9gZmgHaMJuRWDCGKNU
         hZaUEu/jUhlXMhJn7SCi/Gzqd88Sa4VFP3yuzLgb9auw2GIHqKT98RpfpIMsmUw15NUN
         cQWIU+F7iMtIIcmtChwEY6n9KkRwuKYZvrHV+ySCHQf0ccz3Eb/zB6E+5iEWnr3lRj/k
         AIv5qh9oUoSZU97+QKB7+/BHXRLS3qtNM0X1Q6luK5S/X9Tcpt6USE0V8P2yhwMe8ipK
         p1aAH0eEjt4ZdDKlUrVPu9oqHGUg3KYiDQb2TzfWVcE0pTJsxlns3Iw1zITdMp61CsxS
         6gYA==
X-Gm-Message-State: AOAM530KtgnqyesvGpJLMNESmmjx/IdOpMLNece/8s8HFRLIHk4tSb9M
        TuSqq61Gj3whJVPLc9wUyVJFiQ==
X-Google-Smtp-Source: ABdhPJwNzKrTSsz07dyXsXpJd6gX8DQPhRfqzzRHvRXSP01QQc+CGwjKrc9uTxvROL9gZMKBT68QNw==
X-Received: by 2002:a05:6214:18f1:: with SMTP id ep17mr4337171qvb.64.1589455642535;
        Thu, 14 May 2020 04:27:22 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id w22sm2436494qth.87.2020.05.14.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 04:27:21 -0700 (PDT)
Date:   Thu, 14 May 2020 07:27:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200514112702.GB544269@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <20200512212936.GA450429@cmpxchg.org>
 <20200513141519.061f8fca4788cd02b4d7068f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513141519.061f8fca4788cd02b4d7068f@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 02:15:19PM -0700, Andrew Morton wrote:
> On Tue, 12 May 2020 17:29:36 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > 
> > ...
> >
> > Solution
> > 
> > This patch fixes the aging inversion described above on
> > !CONFIG_HIGHMEM systems, without reintroducing the problems associated
> > with excessive shrinker LRU rotations, by keeping populated inodes off
> > the shrinker LRUs entirely.
> > 
> > Currently, inodes are kept off the shrinker LRU as long as they have
> > an elevated i_count, indicating an active user. Unfortunately, the
> > page cache cannot simply hold an i_count reference, because unlink()
> > *should* result in the inode being dropped and its cache invalidated.
> > 
> > Instead, this patch makes iput_final() consult the state of the page
> > cache and punt the LRU linking to the VM if the inode is still
> > populated; the VM in turn checks the inode state when it depopulates
> > the page cache, and adds the inode to the LRU if necessary.
> > 
> > This is not unlike what we do for dirty inodes, which are moved off
> > the LRU permanently until writeback completion puts them back on (iff
> > still unused). We can reuse the same code -- inode_add_lru() - here.
> > 
> > This is also not unlike page reclaim, where the lower VM layer has to
> > negotiate state with the higher VFS layer. Follow existing precedence
> > and handle the inversion as much as possible on the VM side:
> > 
> > - introduce an I_PAGES flag that the VM maintains under the i_lock, so
> >   that any inode code holding that lock can check the page cache state
> >   without having to lock and inspect the struct address_space
> 
> Maintaining the same info in two places is a hassle.  Is this
> optimization worthwhile?

Hm, maybe not. I'll try to get rid of it and test cache / LRU state
directly.

> > - introduce inode_pages_set() and inode_pages_clear() to maintain the
> >   inode LRU state from the VM side, then update all cache mutators to
> >   use them when populating the first cache entry or clearing the last
> > 
> > With this, the concept of "inodesteal" - where the inode shrinker
> > drops page cache - is relegated to CONFIG_HIGHMEM systems only. The VM
> > is in charge of the cache, the shrinker in charge of struct inode.
> 
> How tested is this on highmem machines?

I don't have a highmem machine, but my code is ifdeffed out on
CONFIG_HIGHMEM so the behavior shouldn't have changed there.
