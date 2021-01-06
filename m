Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6512EBC65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 11:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAFKdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 05:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbhAFKdB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:33:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B66D2310D;
        Wed,  6 Jan 2021 10:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609929140;
        bh=8orHryq6VnH6jtYez3tMeFosmYrZSBFx73SQxgbE9EA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAGBatnSWl+hg9LtX0ozJrIWea13acKYZ1KBJtRAU+lEqkyf6KUqAgyfS/1lMljFe
         oghlrZJARLTTUAnpbCqJWJD12MYXH80mbHk69QBi6L/XS7evnTHiyZxRKj36MKxMSY
         kctCfaLutNwPPytJAqCp6a0Jp3533uXe/g+c7HJc=
Date:   Wed, 6 Jan 2021 11:33:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <X/WSA7nmsUSrpsfr@kroah.com>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <X/QJCgoLPhfECEmP@kroah.com>
 <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 05:00:58PM -0800, Siddharth Gupta wrote:
> 
> On 1/4/2021 10:36 PM, Greg KH wrote:
> > On Mon, Jan 04, 2021 at 02:43:45PM -0800, Siddharth Gupta wrote:
> > > Hi all,
> > > 
> > > With the introduction of the filesystem change "fs: don't allow splice
> > > read/write without explicit ops"[1] the fallback mechanism of the firmware
> > > loader[2] no longer works when using sendfile[3] from the userspace.
> > What userspace program are you using to load firmware?
> The userspace program is in the android userspace which listens to a uevent
> from the firmware loader and then loads the firmware using sendfile[1].
> >   Are you not using the in-kernel firmware loader for some reason?
> We have certain non-standard firmware paths that should not be added to the
> linux kernel, and the firmware_class.path only supports a single path.

That option is just for a single override, which should be all that you
need if the other paths that are built into the kernel do not work.
Surely one of the 5 different paths here are acceptable?

If not, how many more do you need?

And last I looked, Android wants you to use the built-in kernel firmware
loader, and NOT an external firmware binary anymore.  So this shouldn't
be an issue for your newer systems anyway :)

> > > Since the binary attributes don't support splice_{read,write} functions the
> > > calls to splice_{read,write} used the default kernel_{read,write} functions.
> > > With the above change this results in an -EINVAL return from
> > > do_splice_from[4].
> > > 
> > > This essentially means that sendfile will not work for any binary attribute
> > > in the sysfs.
> > Have you tried fixing this with a patch much like what we did for the
> > proc files that needed this?  If not, can you?
> I am not aware of this fix, could you provide me a link for reference? I
> will try it out.

Look at the series of commits starting at fe33850ff798 ("proc: wire up
generic_file_splice_read for iter ops") for how this was fixed in procfs
as an example of what also needs to be done for binary sysfs files.

thanks,

greg k-h
