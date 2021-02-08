Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD54A313325
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBHNUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 08:20:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhBHNTl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:19:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19E2164E8C;
        Mon,  8 Feb 2021 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612790340;
        bh=V8l77nGfH8viK0lg21lyfDivRFNKcdkT4YjQ7wzkRbE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ltupn+ZP4BiBWYAK+vVGENeSNIcw2s7BWyHgmUggnPNhbyZL7VrVXJq6nk2bXTKkx
         KSL7+PyLDy7zIcr7E1rEPNIx1ytbf7zmqOGu0nHFPEjfMj+2OOkyRYye2hussDEOXv
         MOrzApkTgn1FwOVl8WX6kJff3m0j30hBzYDFy/o8XQrtUpJgjIiwMmbKuC3EO6i0BQ
         B5768uJtcwahsGbtlLAOKxXkmof2fzC7tHBuSSXTZMhB0zL3n0F4JhgC7CqySUFdkV
         76k/CAWAeQh5LE4kinHXpri346A6ixs+FJFnwEweS4tk/SYavcmcw7LpkJZ+NxZo4D
         fJUu1R2R4KY2A==
Message-ID: <c649c66a0fc75de0338712edc5df088ee8fe86b3.camel@kernel.org>
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
From:   Jeff Layton <jlayton@kernel.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Date:   Mon, 08 Feb 2021 08:18:58 -0500
In-Reply-To: <ff782e1e-6fe9-4730-2528-76dc07211e0a@virtuozzo.com>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
         <20210203193201.GD2172@grain>
         <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
         <20210203221726.GF2172@grain>
         <948beb902296da5bb5d1a0db705ecb190623af84.camel@kernel.org>
         <ff782e1e-6fe9-4730-2528-76dc07211e0a@virtuozzo.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-08 at 15:57 +0300, Pavel Tikhomirov wrote:
> 
> On 2/8/21 3:31 PM, Jeff Layton wrote:
> > On Thu, 2021-02-04 at 01:17 +0300, Cyrill Gorcunov wrote:
> > > On Thu, Feb 04, 2021 at 12:35:42AM +0300, Pavel Tikhomirov wrote:
> > > > 
> > > > AFAICS if pid is held only by 1) fowner refcount and by 2) single process
> > > > (without threads, group and session for simplicity), on process exit we go
> > > > through:
> > > > 
> > > > do_exit
> > > >    exit_notify
> > > >      release_task
> > > >        __exit_signal
> > > >          __unhash_process
> > > >            detach_pid
> > > >              __change_pid
> > > >                free_pid
> > > >                  idr_remove
> > > > 
> > > > So pid is removed from idr, and after that alloc_pid can reuse pid numbers
> > > > even if old pid structure is still alive and is still held by fowner.
> > > ...
> > > > Hope this answers your question, Thanks!
> > > 
> > > Yeah, indeed, thanks! So the change is sane still I'm
> > > a bit worried about backward compatibility, gimme some
> > > time I'll try to refresh my memory first, in a couple
> > > of days or weekend (though here are a number of experienced
> > > developers CC'ed maybe they reply even faster).
> > 
> > I always find it helpful to refer to the POSIX spec [1] for this sort of
> > thing. In this case, it says:
> > 
> > F_GETOWN
> >      If fildes refers to a socket, get the process ID or process group ID
> > specified to receive SIGURG signals when out-of-band data is available.
> > Positive values shall indicate a process ID; negative values, other than
> > -1, shall indicate a process group ID; the value zero shall indicate
> > that no SIGURG signals are to be sent. If fildes does not refer to a
> > socket, the results are unspecified.
> > 
> > In the event that the PID is reused, the kernel won't send signals to
> > the replacement task, correct?
> 
> Correct. Looks like only places to send signal to owner are send_sigio() 
> and send_sigurg() (at least nobody else dereferences fown->pid_type). 
> And in both places we lookup for task to send signal to with pid_task() 
> or do_each_pid_task() (similar to what I do in patch) and will not find 
> any task if pid was reused. Thus no signal would be sent.
> 

Thanks for confirming it. I queued it up for linux-next (with a small
amendment to the changelog), and it should be there later today or
tomorrow. It might not hurt to roll up a manpage patch too if you have
the cycles. It'd be nice to spell out what a 0 return means there.

> > Assuming that's the case, then this patch
> > looks fine to me too. I'll plan to pick it for linux-next later today,
> > and we can hopefully get this into v5.12.
> > 
> > [1]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/fcntl.html#tag_16_122
> > 
> 
> Thanks for finding it!
> 

No problem. That site is worth bookmarking for this sort of thing... ;)
-- 
Jeff Layton <jlayton@kernel.org>

