Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB94403A00
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 14:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhIHMie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 08:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234109AbhIHMie (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:38:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089FD61155;
        Wed,  8 Sep 2021 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631104646;
        bh=nMezGjgjwzg9bIdKI/lKo1CwMtPF/hzsmq+sSzvk1iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RB7SYU+aQABbNPtw/eKMtzShODOIWXCRyxgwmRtzQu1yJ3v4YBMq86oggOT7NO72X
         ieyEByBTieCISCNeqDdxmmYVNKXkdo46Hgwznf3J6v1cAu7dUyNEbOF+/Gwf8a4Y3E
         FC9qRh1cgCSNQVV++u8F7zHv3VQcFUlZXJttaIPY=
Date:   Wed, 8 Sep 2021 14:37:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Tao <escape@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shanpeic@linux.alibaba.com
Subject: Re: [RFC PATCH 0/2] support cgroup pool in v1
Message-ID: <YTiugxO0cDge47x6@kroah.com>
References: <cover.1631102579.git.escape@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1631102579.git.escape@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 08:15:11PM +0800, Yi Tao wrote:
> In a scenario where containers are started with high concurrency, in
> order to control the use of system resources by the container, it is
> necessary to create a corresponding cgroup for each container and
> attach the process. The kernel uses the cgroup_mutex global lock to
> protect the consistency of the data, which results in a higher
> long-tail delay for cgroup-related operations during concurrent startup.
> For example, long-tail delay of creating cgroup under each subsystems
> is 900ms when starting 400 containers, which becomes bottleneck of
> performance. The delay is mainly composed of two parts, namely the
> time of the critical section protected by cgroup_mutex and the
> scheduling time of sleep. The scheduling time will increase with
> the increase of the cpu overhead.

Perhaps you shouldn't be creating that many containers all at once?
What normal workload requires this?

thanks,

greg k-h
