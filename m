Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0612EF421
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 15:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbhAHOoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 09:44:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbhAHOoW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:44:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC3982388B;
        Fri,  8 Jan 2021 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610117022;
        bh=Cp2wA57ecYdtDg0Wseygbmw/tUYcjrk2toCIX0dnUWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/HqKeZjizb5BXQakcncaHA/bYJVzNoAVhAR5FHpcDO0H7h/eoBWy1e7oITDYZXkS
         FoPG8p7YJvlQIqPGXKf3EiBexVAMs4Z6RaEroVfxBbW6SA9CGvx+59VYuLOeqYJ8Zm
         meL6Fj2F55KQVdhrhBq7t6PfmUC6k4W1VFeUwzNY=
Date:   Fri, 8 Jan 2021 15:44:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <X/hv634I9JOoHZRk@kroah.com>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
 <X/QJCgoLPhfECEmP@kroah.com>
 <180bdfaf-8c84-6946-b46f-3729d4eb17cc@codeaurora.org>
 <X/WSA7nmsUSrpsfr@kroah.com>
 <62583aaa-d557-8c9a-5959-52c9efad1fe3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62583aaa-d557-8c9a-5959-52c9efad1fe3@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:03:47PM -0800, Siddharth Gupta wrote:
> On 1/6/2021 2:33 AM, Greg KH wrote:
> > > > > Since the binary attributes don't support splice_{read,write} functions the
> > > > > calls to splice_{read,write} used the default kernel_{read,write} functions.
> > > > > With the above change this results in an -EINVAL return from
> > > > > do_splice_from[4].
> > > > > 
> > > > > This essentially means that sendfile will not work for any binary attribute
> > > > > in the sysfs.
> > > > Have you tried fixing this with a patch much like what we did for the
> > > > proc files that needed this?  If not, can you?
> > > I am not aware of this fix, could you provide me a link for reference? I
> > > will try it out.
> > Look at the series of commits starting at fe33850ff798 ("proc: wire up
> > generic_file_splice_read for iter ops") for how this was fixed in procfs
> > as an example of what also needs to be done for binary sysfs files.
> I tried to follow these fixes, but I am unfamiliar with fs code. I don't see
> the generic_file_splice_write function anymore on newer kernels, also AFAICT
> kernfs_ops does not define {read,write}_iter operations. If the solution is
> simple and someone could provide the patches I would be happy to test them
> out. If not, some more information about how to proceed would be nice.

Can you try this tiny patch out below?

thanks,

greg k-h

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f277d023ebcd..113bc816d430 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -968,6 +968,8 @@ const struct file_operations kernfs_file_fops = {
 	.release	= kernfs_fop_release,
 	.poll		= kernfs_fop_poll,
 	.fsync		= noop_fsync,
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
 };
 
 /**
