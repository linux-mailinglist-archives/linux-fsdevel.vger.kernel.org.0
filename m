Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F812224D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 04:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLQDCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 22:02:32 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40774 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfLQDCb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:02:31 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ih382-0006OH-Gc; Tue, 17 Dec 2019 03:02:30 +0000
Date:   Tue, 17 Dec 2019 04:02:29 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com
Subject: Re: [PATCH v3 0/4] Add pidfd getfd ioctl (Was Add ptrace get_fd
 request)
Message-ID: <20191217030229.2lcfrdbcc6ynumht@wittgenstein>
References: <20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217005842.GA14379@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:58:45AM +0000, Sargun Dhillon wrote:
> This patchset introduces a mechanism to capture file descriptors from other
> processes by pidfd and ioctl. Although this can be achieved using

I like the idea in general as it's quite useful in general. And also for
the seccomp notifier and probably for CRIU too.
A few things that crossed my mind.
A thing I'm worried about is that this will be a stepping stone for
people argue for an fd-replacement feature though I think that
fd-injection not replacement might be sufficient.

I wonder whether we need to worry about special file descriptors, i.e.
anything anon-inode based, or devpts devices but I guess those concerns
already apply to ptrace anyway.

One more thing, with GETFD it seems useful to me that later we can add
a new flag - like I suggested in the previous version - to the seccomp
notifier that would allow a caller to request that with each seccomp
message received via the notifier ioctl() from the kernel a pidfd is
sent along. This would make it quite elegant to get fds for the
supervised task.

Christian
