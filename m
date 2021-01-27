Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BC030592A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhA0LFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 06:05:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236307AbhA0LDE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:03:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611745336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ju2N1jG53lMFxxVc2NAYc72E2pl8QR5olvZUsyDkBak=;
        b=AA9bvWk5QA70wiw6O1ZPSDKUoqyu0AVXkgupz7DWubfXYLwjZdranJNQOeXK67PiHXNqrP
        Ps2F1OxikIKZssE6h1Vs7SpZUjh9ufNGMSdPAtlyTn6XVfb1YJ4Z/8o58VS3Q7PIRxtVnv
        O6qDC/79DfVs86Id/zmCKilWMrRYH9M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82B07AD2B;
        Wed, 27 Jan 2021 11:02:16 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:02:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>, surenb@google.com,
        minchan@kernel.org, gregkh@linuxfoundation.org, hridya@google.com,
        jannh@google.com, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] procfs/dmabuf: Add /proc/<pid>/task/<tid>/dmabuf_fds
Message-ID: <YBFIMIR2FXoYDd+0@dhcp22.suse.cz>
References: <20210126225138.1823266-1-kaleshsingh@google.com>
 <20210127090526.GB827@dhcp22.suse.cz>
 <6b314cf2-99f0-8e63-acc7-edebe2ca97d7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b314cf2-99f0-8e63-acc7-edebe2ca97d7@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 27-01-21 11:53:55, Christian König wrote:
[...]
> In general processes are currently not held accountable for memory they
> reference through their file descriptors. DMA-buf is just one special case.

True

> In other words you can currently do something like this
> 
> fd = memfd_create("test", 0);
> while (1)
>     write(fd, buf, 1024);
> 
> and the OOM killer will terminate random processes, but never the one
> holding the memfd reference.

memfd is just shmem under cover, no? And that means that the memory gets
accounted to MM_SHMEMPAGES. But you are right that this in its own
doesn't help much if the fd is shared and the memory stays behind a
killed victim.

But I do agree with you that there are resources which are bound to a
process life time but the oom killer has no idea about those as they are
not accounted on a per process level and/or oom_badness doesn't take
them into consideration.
-- 
Michal Hocko
SUSE Labs
