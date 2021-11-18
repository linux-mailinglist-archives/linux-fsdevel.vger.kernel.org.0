Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA445574B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 09:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbhKRIvr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 03:51:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55218 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243306AbhKRIvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:51:43 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C09A1FD29;
        Thu, 18 Nov 2021 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637225322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K1ZCPVq3M/kq9T4nlqgpL35Tc3peJZijmvs4kEuxGJA=;
        b=Pa9rSh+Aq6osGp7TDt1OWOX3Fqw0zfTH2foxwF0j5jwP7LkZcobFCOdu53aiZwY6a42sIu
        Y9UYvASMomOZkRJafHSII6R7VLGWcMXMF59q+3+hIXZyYmSXfcTVhoe4FenubXtRHz2/N1
        43hTQf4y3/iib7lf7xP35eyjfIt2AdQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DE05AA3B85;
        Thu, 18 Nov 2021 08:48:41 +0000 (UTC)
Date:   Thu, 18 Nov 2021 09:48:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
Message-ID: <YZYTaSVUWUhW0d9t@dhcp22.suse.cz>
References: <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz>
 <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz>
 <CAHS8izPcnwOqf8bjfrEd9VFxdA6yX3+a-TeHsxGgpAR+_bRdNA@mail.gmail.com>
 <YZN5tkhHomj6HSb2@dhcp22.suse.cz>
 <CAHS8izNTbvhjEEb=ZrH2_4ECkVhxnCLzyd=78uWmHA_02iiA9Q@mail.gmail.com>
 <YZOWD8hP2WpqyXvI@dhcp22.suse.cz>
 <CAHS8izPyCDucFBa9ZKz09g3QVqSWLmAyOmwN+vr=X2y7yZjRQA@mail.gmail.com>
 <CALvZod7FHO6edK1cR+rbt6cG=+zUzEx3+rKWT5mi73Q29_Y5qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7FHO6edK1cR+rbt6cG=+zUzEx3+rKWT5mi73Q29_Y5qA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 16-11-21 13:55:54, Shakeel Butt wrote:
> On Tue, Nov 16, 2021 at 1:27 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Tue, Nov 16, 2021 at 3:29 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Yes, exactly. I meant that all this special casing would be done at the
> > > shmem layer as it knows how to communicate this usecase.
> > >
> >
> > Awesome. The more I think of it I think the ENOSPC handling is perfect
> > for this use case, because it gives all users of the shared memory and
> > remote chargers a chance to gracefully handle the ENOSPC or the SIGBUS
> > when we hit the nothing to kill case. The only issue is finding a
> > clean implementation, and if the implementation I just proposed sounds
> > good to you then I see no issues and I'm happy to submit this in the
> > next version. Shakeel and others I would love to know what you think
> > either now or when I post the next version.
> >
> 
> The direction seems reasonable to me. I would have more comments on
> the actual code. At the high level I would prefer not to expose these
> cases in the filesystem code (shmem or others) and instead be done in
> a new memcg interface for filesystem users.

A library like function in the memcg proper sounds good to me I just
want to avoid any special casing in the core of the memcg charging and
special casing there.

-- 
Michal Hocko
SUSE Labs
