Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B252EA57F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 07:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAEGhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 01:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbhAEGhn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:37:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC6BD22286;
        Tue,  5 Jan 2021 06:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609828622;
        bh=oZOFcC23CV20+DCygF8foWIBHoqErFJTMYyklPRWOCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGL+AKY/X85vM+06sLdW3kxiRkJn1D/91jJ0TY+FBrRFixllk6NS/sjOJcZnI3/G9
         E2s8luVagf8slq81cf6YnJGvvcbaJtVGAO8xMhgBwS2moiH51GUIJLRGk8DCvfCwih
         q+IHUzb8G87w1v0BESEogXL3v0pUOM9DfFW8VzB4=
Date:   Tue, 5 Jan 2021 07:36:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     mcgrof@kernel.org, rafael@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>
Subject: Re: PROBLEM: Firmware loader fallback mechanism no longer works with
 sendfile
Message-ID: <X/QJCgoLPhfECEmP@kroah.com>
References: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e6f44b1-a0d2-d1d1-9c11-dcea163f8f03@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:43:45PM -0800, Siddharth Gupta wrote:
> Hi all,
> 
> With the introduction of the filesystem change "fs: don't allow splice
> read/write without explicit ops"[1] the fallback mechanism of the firmware
> loader[2] no longer works when using sendfile[3] from the userspace.

What userspace program are you using to load firmware?  Are you not
using the in-kernel firmware loader for some reason?

> Since the binary attributes don't support splice_{read,write} functions the
> calls to splice_{read,write} used the default kernel_{read,write} functions.
> With the above change this results in an -EINVAL return from
> do_splice_from[4].
> 
> This essentially means that sendfile will not work for any binary attribute
> in the sysfs.

Have you tried fixing this with a patch much like what we did for the
proc files that needed this?  If not, can you?

> [1]: https://github.com/torvalds/linux/commit/36e2c7421f02a22f71c9283e55fdb672a9eb58e7#diff-70c49af2ed5805fc1406ed6e6532d6a029ada1abd90cca6442711b9cecd4d523
> [2]: https://github.com/torvalds/linux/blob/master/drivers/base/firmware_loader/main.c#L831
> [3]: https://github.com/torvalds/linux/blob/master/fs/read_write.c#L1257
> [4]: https://github.com/torvalds/linux/blob/master/fs/splice.c#L753

kernel development is on git.kernel.org, not github :)

thanks,

greg k-h
