Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C96E31325D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 13:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhBHMcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 07:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231514AbhBHMcL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:32:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9793364E29;
        Mon,  8 Feb 2021 12:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612787490;
        bh=F2PHpBLXNZAIsLSijUxMtD8FTU+zeIu+dTbyywDf+co=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=agvJ8G3M7d4N1y+ftubHybgDAY9Qy0fd02C9eqUnWJJW1kDtfxx+/rNI+EVytu0lA
         r8RwgR+09OuPdkah7j5hDhAYHYr1TGf+mnAAp3AfwQzGjLhdzu4I7HzwYs1nYh7NyW
         3SV8w2/fu6NJx/+LdNXTkODgxYTvWS0itJygiFEFF1Cmz1i2N8az3dpleDYPs6S2Xr
         zhd80853FAKfsO3OriiH90MpAqjpNqIXYhsWZKQ8togwLkdnkdoZip5Mxfs7Re+K9i
         jkv4WPhrZxpayNjvv+AI82JGax+/4Ycs7529ew//usKvwIEsHlSh6ZXHW4imogk0ni
         qLRYt9FM6YL8g==
Message-ID: <948beb902296da5bb5d1a0db705ecb190623af84.camel@kernel.org>
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
From:   Jeff Layton <jlayton@kernel.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Date:   Mon, 08 Feb 2021 07:31:28 -0500
In-Reply-To: <20210203221726.GF2172@grain>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
         <20210203193201.GD2172@grain>
         <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
         <20210203221726.GF2172@grain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-02-04 at 01:17 +0300, Cyrill Gorcunov wrote:
> On Thu, Feb 04, 2021 at 12:35:42AM +0300, Pavel Tikhomirov wrote:
> > 
> > AFAICS if pid is held only by 1) fowner refcount and by 2) single process
> > (without threads, group and session for simplicity), on process exit we go
> > through:
> > 
> > do_exit
> >   exit_notify
> >     release_task
> >       __exit_signal
> >         __unhash_process
> >           detach_pid
> >             __change_pid
> >               free_pid
> >                 idr_remove
> > 
> > So pid is removed from idr, and after that alloc_pid can reuse pid numbers
> > even if old pid structure is still alive and is still held by fowner.
> ...
> > Hope this answers your question, Thanks!
> 
> Yeah, indeed, thanks! So the change is sane still I'm
> a bit worried about backward compatibility, gimme some
> time I'll try to refresh my memory first, in a couple
> of days or weekend (though here are a number of experienced
> developers CC'ed maybe they reply even faster).

I always find it helpful to refer to the POSIX spec [1] for this sort of
thing. In this case, it says:

F_GETOWN
    If fildes refers to a socket, get the process ID or process group ID
specified to receive SIGURG signals when out-of-band data is available.
Positive values shall indicate a process ID; negative values, other than
-1, shall indicate a process group ID; the value zero shall indicate
that no SIGURG signals are to be sent. If fildes does not refer to a
socket, the results are unspecified.

In the event that the PID is reused, the kernel won't send signals to
the replacement task, correct? Assuming that's the case, then this patch
looks fine to me too. I'll plan to pick it for linux-next later today,
and we can hopefully get this into v5.12.

[1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html#tag_16_122
-- 
Jeff Layton <jlayton@kernel.org>

