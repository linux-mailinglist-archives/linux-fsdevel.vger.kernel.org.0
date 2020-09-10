Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D2D264BE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIJRwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgIJQQ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:16:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D97206A1;
        Thu, 10 Sep 2020 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599754568;
        bh=OgY5Qs0sNgX7gxePvw0EADB/4fq3LgqYdQ2QJdS4vac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHCKfGsKA3ReD9imzv70TocLnWw5iHbWlUxyg+ll6jDcY60h4lO0g7s+W6Ct8yzhG
         lCmmijbG5GERgZMqeUjlrk7McAxgRxlhbzTsY+czFzji3d7z+JpmMa4X2Zk1o7G6pe
         xnDuwaLrL1mnY2X5VtddJI7Uu9VMBJ37O1HHfmQg=
Date:   Thu, 10 Sep 2020 18:16:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910161615.GA1180022@kroah.com>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910142335.GG3265@brightrain.aerifal.cx>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> POSIX defines fchmodat as having a 4th argument, flags, that can be
> AT_SYMLINK_NOFOLLOW. Support for changing the access mode of symbolic
> links is optional (EOPNOTSUPP allowed if not supported), but this flag
> is important even on systems where symlinks do not have access modes,
> since it's the only way to safely change the mode of a file which
> might be asynchronously replaced with a symbolic link, without a race
> condition whereby the link target is changed.
> 
> It's possible to emulate AT_SYMLINK_NOFOLLOW in userspace, and both
> musl libc and glibc do this, by opening an O_PATH file descriptor and
> performing chmod on the corresponding magic symlink in /proc/self/fd.
> However, this requires procfs to be mounted and accessible.
> 
> It was determined (see glibc issue #14578 and commit a492b1e5ef) that,
> on some filesystems, performing chmod on the link itself produces a
> change in the inode's access mode, but returns an EOPNOTSUPP error.
> This is non-conforming and wrong. Rather than try to fix all the
> broken filesystem backends, block attempts to change the symlink
> access mode via fchmodat2 at the frontend layer. This matches the
> userspace emulation done in libc implementations. No change is made to
> the underlying chmod_common(), so it's still possible to attempt
> changes via procfs, if desired. If at some point all filesystems have
> been fixed, this could be relaxed to allow filesystems to make their
> own decision whether changing access mode of links is supported.

A new syscall just because we have broken filesystems seems really odd,
why not just fix the filesystems instead?

thanks,

greg k-h
