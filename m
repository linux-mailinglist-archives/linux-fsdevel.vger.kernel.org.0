Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFBE3641C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhDSMfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhDSMfP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B6C961057;
        Mon, 19 Apr 2021 12:34:42 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:34:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fanotify: Adding pidfd support to the fanotify API
Message-ID: <20210419123439.q3lzgmk4clqoxs7r@wittgenstein>
References: <cover.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:21:53AM +1000, Matthew Bobrowski wrote:
> Hey Jan/Amir/Christian,
> 
> This is the RFC patch series for adding pidfd support to the fanotify
> API.
> 
> tl;dr rather than returning a pid within struct
> fanotify_event_metadata, a pidfd is returned instead when fanotify has
> been explicitly told to do so via the new FAN_REPORT_PIDFD flag.
> 
> The main driver behind returning a pidfd within an event instead of a
> pid is that it permits userspace applications to better detect if
> they've possibly lost a TOCTOU race. A common paradigm among userspace
> applications that make use of the fanotify API is to crawl /proc/<pid>
> upon receiving an event. Userspace applications do this in order to
> further ascertain contextual meta-information about the process that
> was responsible for generating the filesystem event. On high pressure
> systems, where pid recycling isn't uncommon, it's no longer considered
> as a reliable approach to directly sift through /proc/<pid> and have
> userspace applications use the information contained within
> /proc/<pid> as it could, and does, lead to program execution
> inaccuracies.
> 
> Now when a pidfd is returned in an event, a userspace application can:
> 
>     a) Obtain the pid responsible for generating the filesystem event
>        from the pidfds fdinfo.
> 
>     b) Detect whether the userspace application lost the procfs access
>        race by sending a 0 signal on the pidfd and checking the return
>        value. A -ESRCH is indicative of the userspace application
>        losing the race, meaning that the pid has been recycled.

Thank you for working on this Matthew.

I'm explicitly adding Jann and Oleg to the thread since both have been
involved in the original design.

Oleg, Jann, I know this isn't necessarily your area of expertise but if
you could share your thoughts about returning pidfds that haven't been
opened via pidfd_open() or CLONE_PIDFD that would be great.
I've been conservative about this so far but I find it hard to resist
use-cases such as this.

Christian
