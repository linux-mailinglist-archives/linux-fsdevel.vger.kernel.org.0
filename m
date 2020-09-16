Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E226BC88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPGTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgIPGTJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:19:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89A1208E4;
        Wed, 16 Sep 2020 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600237148;
        bh=0XR7vIA8RM07+1wJZFz5+pD+mhjIp38UU8a6XXzcxFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ1Y+KMUi9WYEThAwAH7vPIfn7vzIguRiVkp/5IOiZeQ+d2JhoWp1oOiR03D3xrH4
         qlV4K3uaabBYJOS/EsIycmYctgyYyfEs7AeuMjbe3ZaO9RDf+i3+FthO16pj7GwGTE
         sSMHhpfiVG1MEUagVsfhcRZlF7gaIEJn1M9ogoLM=
Date:   Wed, 16 Sep 2020 08:19:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: add fchmodat2 syscall
Message-ID: <20200916061943.GC142621@kroah.com>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002335.GQ3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916002335.GQ3265@brightrain.aerifal.cx>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:23:38PM -0400, Rich Felker wrote:
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
> Signed-off-by: Rich Felker <dalias@libc.org>

No kselftest for this new system call, or man page?  How do we know this
actually works and what the expected outcome should be?

thanks,

greg k-h
