Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B45435363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 21:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhJTTFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 15:05:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50022 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230290AbhJTTFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 15:05:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19KJ2gOS023773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Oct 2021 15:02:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D07C315C00CC; Wed, 20 Oct 2021 15:02:42 -0400 (EDT)
Date:   Wed, 20 Oct 2021 15:02:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
Message-ID: <YXBn0sHLZZQaYg5H@mit.edu>
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
 <YW13pS716ajeSgXj@dhcp22.suse.cz>
 <CAHS8izMnkiHtNLEzJXL64zNinbEp0oU96dPCJYfqJqk4AEQW2A@mail.gmail.com>
 <YW/cs51K/GyhhJDk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW/cs51K/GyhhJDk@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:09:07AM +0200, Michal Hocko wrote:
> > 3. We would need to extend this functionality to other file systems of
> > persistent disk, then mount that file system with 'memcg=<dedicated
> > shared library memcg>'. Jobs can then use the shared library and any
> > memory allocated due to loading the shared library is charged to a
> > dedicated memcg, and not charged to the job using the shared library.
> 
> This is more of a question for fs people. My understanding is rather
> limited so I cannot even imagine all the possible setups but just from
> a very high level understanding bind mounts can get really interesting.
> Can those disagree on the memcg? 
> 
> I am pretty sure I didn't get to think through this very deeply, my gut
> feeling tells me that this will open many interesting questions and I am
> not sure whether it solves more problems than it introduces at this moment.
> I would be really curious what others think about this.

My understanding of the proposal is that the mount option would be on
the superblock, and it would not be a per-bind-mount option, ala the
ro mount option.  In other words, the designation of the target memcg
for which all tmpfs files would be charged would be something that
would be stored in the struct super.  I'm also going to assume that
the only thing that gets charged is memory for files that are backed
on the tmpfs.  So for example, if there is a MAP_PRIVATE mapping, the
base page would have be charged to the target memcg when the file was
originally created.  However, if the process tries to modify a private
mapping, and there page allocated on the copy-on-write would get
charged to the process's memcg, and not to the tmpfs's target memcg.

If we make these simplifying assumptions, then it should be fairly
simple.  Essentially, the model is that whenever we do the file system
equivalent of "block allocation" for the file system, the tmpfs file
system has all of the pages associated with that file system is
charged to the target memcg.  That's pretty straightforward, and is
pretty easy to model and anticipate.

In fact, if the only use case was #3 (shared libraries and library
runtimes) this workload could be accomodated without needing any
kernel changes.  This could be done by simply having the setup process
run in the "target memcg", and it would simply copy all of the shared
libraries and runtime files into the tmpfs at setup time.  So that
would get charged to the memcg which first allocated the file, and
that would be the setup memcg.  And all of the Kubernetes containers
that use these shared libraries and language runtimes, when they map
those pages read-only into their task processes, since those tmpfs
pages were charged to the setup memcg, they won't get charged to the
task containers.  And I *do* believe that it's much easier to
anticipate how much memory will be used by these shared files, and so
we don't need to potentially give a task container enough memory quota
so that if it is the first container to start running, it gets charged
with all of the memory, while all of the other containers can afford
to freeload off the first container --- but we still have to give
those containers enough memory in their memcg in case those *other*
containers happen to be the first one to get launched.

Cheers,

						- Ted
