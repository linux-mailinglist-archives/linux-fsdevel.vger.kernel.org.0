Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60EE2286BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgGUQ4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730305AbgGUQzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:55:43 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13844C061794;
        Tue, 21 Jul 2020 09:55:43 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxvYJ-00HJkg-F7; Tue, 21 Jul 2020 16:55:39 +0000
Date:   Tue, 21 Jul 2020 17:55:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 06/24] md: open code vfs_stat in md_setup_drive
Message-ID: <20200721165539.GT2786714@ZenIV.linux.org.uk>
References: <20200721162818.197315-1-hch@lst.de>
 <20200721162818.197315-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721162818.197315-7-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:28:00PM +0200, Christoph Hellwig wrote:
> Instead of passing a kernel pointer to vfs_stat by relying on the
> implicit set_fs(KERNEL_DS) in md_setup_drive, just open code the
> trivial getattr, and use the opportunity to move a little bit more
> code from the caller into the new helper.

Ugh...

> +static void __init md_lookup_dev(const char *devname, dev_t *dev)
> +{
> +	struct kstat stat;
> +	struct path path;
> +	char filename[64];
> +
> +	if (strncmp(devname, "/dev/", 5) == 0)
> +		devname += 5;
> +	snprintf(filename, 63, "/dev/%s", devname);
> +
> +	if (!kern_path(filename, LOOKUP_FOLLOW, &path) &&
> +	    !vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_NO_AUTOMOUNT) &&
> +	    S_ISBLK(stat.mode))
> +		*dev = new_decode_dev(stat.rdev);
> +	path_put(&path);
> +}

How about fs/for_init.c and putting the damn helpers there?  With
calling conventions as close to syscalls as possible, and a fat
comment regarding their intended use being _ONLY_ the setup
in should-have-been-done-in-userland parts of init?

I really want to keep the surface as small as possible - we had
fun shite several releases ago when somebody tried that kind of
crap (with open(), IIRC).  Let's not go there again...
