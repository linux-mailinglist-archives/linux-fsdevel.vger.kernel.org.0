Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9F311875
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBFCio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBFCgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:36:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D17C08EE7B;
        Fri,  5 Feb 2021 16:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mZCRVETJ8PFFSolgHhB5Tp0serDneMbD0XJnnQKOZTI=; b=BxHBM4b9ULo1IOmmp+yYoLbHzA
        T7jAwmuzi3nMiMuX4tSkT/PrHmdvmiGIRtRT/UkrGY+MQn3UjhuH9epQ5p+ZfcNl6+MGqcoaQTzOA
        3u9fGYgTMy7MutsAZYCmCG0OHhLpFF54+pcZVvNUrQol7VN1x8yplUX+rdXTzoCUqFlzpK8rwKzOJ
        diBnw2RUzvs+/6D90s2sCtbcRqjpD9AINeb0tex9RhkHpmLzu0NaLJXeHfsRlLizZU5m9K5zi40tm
        QNvThKpybBm2o4UpU5v+Xa3rIySjTRMa2Ah7VNAJ7CBgXfTwVgoU6hQwCFVDeU9jgxIKa2NtGEDov
        vygqBJ+w==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l8BdT-0004md-Uz; Sat, 06 Feb 2021 00:39:40 +0000
Subject: Re: [PATCH v4 1/2] procfs: Allow reading fdinfo with PTRACE_MODE_READ
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        christian.koenig@amd.com, kernel-team@android.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20210205213353.669122-1-kaleshsingh@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe8780a1-364e-ec8f-48ee-192438d52c01@infradead.org>
Date:   Fri, 5 Feb 2021 16:39:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210205213353.669122-1-kaleshsingh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/5/21 1:33 PM, Kalesh Singh wrote:
> Android captures per-process system memory state when certain low memory
> events (e.g a foreground app kill) occur, to identify potential memory
> hoggers. In order to measure how much memory a process actually consumes,
> it is necessary to include the DMA buffer sizes for that process in the
> memory accounting. Since the handle to DMA buffers are raw FDs, it is
> important to be able to identify which processes have FD references to
> a DMA buffer.
> 
> Currently, DMA buffer FDs can be accounted using /proc/<pid>/fd/* and
> /proc/<pid>/fdinfo -- both are only readable by the process owner,
> as follows:
>   1. Do a readlink on each FD.
>   2. If the target path begins with "/dmabuf", then the FD is a dmabuf FD.
>   3. stat the file to get the dmabuf inode number.
>   4. Read/ proc/<pid>/fdinfo/<fd>, to get the DMA buffer size.
> 
> Accessing other processes’ fdinfo requires root privileges. This limits

Tangential:
Please just use ASCII "'" -- it's good enough.

> the use of the interface to debugging environments and is not suitable
> for production builds.  Granting root privileges even to a system process
> increases the attack surface and is highly undesirable.
> 
> Since fdinfo doesn't permit reading process memory and manipulating
> process state, allow accessing fdinfo under PTRACE_MODE_READ_FSCRED.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> Changes in v2:
>   - Update patch description
> 
>  fs/proc/base.c |  4 ++--
>  fs/proc/fd.c   | 15 ++++++++++++++-
>  2 files changed, 16 insertions(+), 3 deletions(-)


-- 
~Randy

