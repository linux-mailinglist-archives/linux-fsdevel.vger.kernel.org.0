Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D82B022
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE0IZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 04:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfE0IZC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 04:25:02 -0400
Received: from localhost (unknown [84.241.203.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD4421726;
        Mon, 27 May 2019 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558945501;
        bh=pNi9ElRmbgKcVsMAozIr/CKsDF7+HV1MuHhCRH+SbJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o32e9Re5vNeEhy2VCggN3WvqmbwYgC02e7Onfx/pzZe5hlHwDIrTFvLQ+UUuCyyGz
         aJhlI566W+Sw6/yej45+/fx3EQEJOGGBCyULUyMEL6Yz2Y221dn4AjvWM1syyHa7l3
         ChxlZ3AHaR4aIafAj+B+tC/kCqgLzBqpAFfrOQ9o=
Date:   Mon, 27 May 2019 10:24:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Sort out fsnotify_nameremove() mess
Message-ID: <20190527082457.GE21124@kroah.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 05:34:01PM +0300, Amir Goldstein wrote:
> Jan,
> 
> For v3 I went with a straight forward approach.
> Filesystems that have fsnotify_{create,mkdir} hooks also get
> explicit fsnotify_{unlink,rmdir} hooks.
> 
> Hopefully, this approach is orthogonal to whatever changes Al is
> planning for recursive tree remove code, because in many of the
> cases, the hooks are added at the entry point for the recursive
> tree remove.
> 
> After looking closer at all the filesystems that were converted to
> simple_remove in v2, I decided to exempt another 3 filesystems from
> the fsnotify delete hooks: hypfs,qibfs and aafs.
> hypfs is pure cleanup (*). qibfs and aafs can remove dentry on user
> configuration change, but they do not generate create events, so it
> is less likely that users depend on the delete events.
> 
> That leaves configfs the only filesystem that gets the new delete hooks
> even though it does not have create hooks.

why doesn't configfs have create hooks?  That's what userspace does in
configfs, shouldn't it be notified about it?  Keeping it "unequal" seems
odd to me.


thanks,

greg k-h
