Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2731D2F8099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 17:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbhAOQVN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 11:21:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbhAOQVM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:21:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57908238EB;
        Fri, 15 Jan 2021 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610727631;
        bh=0LIBqQvC7kcEb8wCig0ihLzDofrD0kXpv+uSG7yCO6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PhC8FKWO3cX9re7AwU0ZXmksr5EPLInEdwoU8TQH7Dkg6o4VNCHzH9/mM2KaM9GAT
         faJe0WPQembm4Ep0RouHSW1PSejQLK/c095dUwV3VlXnebLEiafqacwCrwCs4IKv56
         yKl/ZxOa3Vx/2y2+2R6muRqA4L+rQiT9pvi0qCjQ=
Date:   Fri, 15 Jan 2021 17:20:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <YAHAzW1cVSaMzBYj@kroah.com>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <X/QJCgoLPhfECEmP@kroah.com>
 <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
 <X/WSA7nmsUSrpsfr@kroah.com>
 <62583aaa-d557-8c9a-5959-52c9efad1fe3@codeaurora.org>
 <X/hv634I9JOoHZRk@kroah.com>
 <1adf9aa4-ed7e-8f05-a354-57419d61ec18@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1adf9aa4-ed7e-8f05-a354-57419d61ec18@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:31:26AM -0800, Siddharth Gupta wrote:
> 
> On 1/8/2021 6:44 AM, Greg KH wrote:
> > On Thu, Jan 07, 2021 at 02:03:47PM -0800, Siddharth Gupta wrote:
> > > On 1/6/2021 2:33 AM, Greg KH wrote:
> > > > > > > Since the binary attributes don't support splice_{read,write} functions the
> > > > > > > calls to splice_{read,write} used the default kernel_{read,write} functions.
> > > > > > > With the above change this results in an -EINVAL return from
> > > > > > > do_splice_from[4].
> > > > > > > 
> > > > > > > This essentially means that sendfile will not work for any binary attribute
> > > > > > > in the sysfs.
> > > > > > Have you tried fixing this with a patch much like what we did for the
> > > > > > proc files that needed this?  If not, can you?
> > > > > I am not aware of this fix, could you provide me a link for reference? I
> > > > > will try it out.
> > > > Look at the series of commits starting at fe33850ff798 ("proc: wire up
> > > > generic_file_splice_read for iter ops") for how this was fixed in procfs
> > > > as an example of what also needs to be done for binary sysfs files.
> > > I tried to follow these fixes, but I am unfamiliar with fs code. I don't see
> > > the generic_file_splice_write function anymore on newer kernels, also AFAICT
> > > kernfs_ops does not define {read,write}_iter operations. If the solution is
> > > simple and someone could provide the patches I would be happy to test them
> > > out. If not, some more information about how to proceed would be nice.
> > Can you try this tiny patch out below?
> Sorry for the delay, I tried out the patch, but I am still seeing the error.
> Please take a look at these logs with
> android running in the userspace[1]:
> 
> [   62.295056][  T249] remoteproc remoteproc1: powering up
> xxxxxxxx.remoteproc-cdsp
> [   62.304138][  T249] remoteproc remoteproc1: Direct firmware load for
> cdsp.mdt failed with error -2
> [   62.312976][  T249] remoteproc remoteproc1: Falling back to sysfs
> fallback for: cdsp.mdt
> [   62.469748][  T394] ueventd: firmware: loading 'cdsp.mdt' for '/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/remoteproc/remoteproc1/cdsp.mdt'
> [   62.498700][  T394] ueventd: firmware: sendfile failed { '/sys/devices/platform/soc/xxxxxxxx.remoteproc-cdsp/remoteproc/remoteproc1/cdsp.mdt',
> 'cdsp.mdt' }: Invalid argument
> 
> Thanks,
> Sid
> 
> [1]: https://android.googlesource.com/platform/system/core/+/refs/heads/master/init/firmware_handler.cpp#57

Thanks for letting me know.  I'll try to work on this on Monday and add
splice to the in-kernel firmware testing suite, as it would have caught
this...

greg k-h
