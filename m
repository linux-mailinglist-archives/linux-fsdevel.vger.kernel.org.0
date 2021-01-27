Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB0305902
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhA0K72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:59:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:46604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhA0K5w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:57:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611745026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KNfOaCzUHOdUdJ/TqcQ2MmdjRFgh4Um7ViH2fY+0P1o=;
        b=Osv0B8NTTHLSjRsWyItdGALjB1hmRVEfoeriP2Empr4NuhKsZOwIKcW8ZLdySJ34JX62OV
        vXFExcsQ4aRL2zV3o9PZVl4kF7AaidDuXnH/tHCl/MDFBVtiB1QGxtaSDGyjtvGyamPMQg
        gEyFuLN0R70gEluj9kfRaQCanEcC+uU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE9ABAD57;
        Wed, 27 Jan 2021 10:57:05 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:57:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        kernel-team <kernel-team@android.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, Hui Su <sh_def@163.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
Message-ID: <YBFG/zBxgnapqLAK@dhcp22.suse.cz>
References: <20210126225138.1823266-1-kaleshsingh@google.com>
 <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2tc_GSPYdgGqTRotUp6NqFoUKdoN_p978+BOLoD_Fdjw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-01-21 11:47:29, Jann Horn wrote:
> +jeffv from Android
> 
> On Tue, Jan 26, 2021 at 11:51 PM Kalesh Singh <kaleshsingh@google.com> wrote:
> > In order to measure how much memory a process actually consumes, it is
> > necessary to include the DMA buffer sizes for that process in the memory
> > accounting. Since the handle to DMA buffers are raw FDs, it is important
> > to be able to identify which processes have FD references to a DMA buffer.
> 
> Or you could try to let the DMA buffer take a reference on the
> mm_struct and account its size into the mm_struct? That would probably
> be nicer to work with than having to poke around in procfs separately
> for DMA buffers.

Yes that would make some sense to me as well but how do you know that
the process actually uses a buffer? If it mmaps it then you already have
that information via /proc/<pid>/maps. My understanding of dma-buf is
really coarse but my impression is that you can consume the memory via
standard read syscall as well. How would you account for that.

[...]
Skipping over a large part of your response but I do agree that the
interface is really elaborate to drill down to the information.

> I'm not convinced that introducing a new procfs file for this is the
> right way to go. And the idea of having to poke into multiple
> different files in procfs and in sysfs just to be able to compute a
> proper memory usage score for a process seems weird to me. "How much
> memory is this process using" seems like the kind of question the
> kernel ought to be able to answer (and the kernel needs to be able to
> answer somewhat accurately so that its own OOM killer can do its job
> properly)?

Well, shared buffers are tricky but it is true that we already consider
shmem in badness so this wouldn't go out of line. Kernel oom killer
could be more clever with these special fds though and query for buffer
size directly.
-- 
Michal Hocko
SUSE Labs
