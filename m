Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E216123A922
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgHCPIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 11:08:07 -0400
Received: from verein.lst.de ([213.95.11.211]:39081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHCPIH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:08:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E766D68BFE; Mon,  3 Aug 2020 17:08:02 +0200 (CEST)
Date:   Mon, 3 Aug 2020 17:08:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: add file system helpers that take kernel pointers for the init
 code v4
Message-ID: <20200803150802.GA19112@lst.de>
References: <20200728163416.556521-1-hch@lst.de> <20200803145622.GB4631@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803145622.GB4631@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:56:23AM -0400, Qian Cai wrote:
> On Tue, Jul 28, 2020 at 06:33:53PM +0200, Christoph Hellwig wrote:
> > Hi Al and Linus,
> > 
> > currently a lot of the file system calls in the early in code (and the
> > devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
> > This is one of the few last remaining places we need to deal with to kill
> > off set_fs entirely, so this series adds new helpers that take kernel
> > pointers.  These helpers are in init/ and marked __init and thus will
> > be discarded after bootup.  A few also need to be duplicated in devtmpfs,
> > though unfortunately.
> 
> Reverting this series from next-20200803 fixed the crash below on shutdown.

Please try this patch:

---
From 6448eebe2fe7189cedc5136ab3464517956922b7 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Mon, 3 Aug 2020 15:56:18 +0200
Subject: init: fix init_dup

Don't allocate an unused fd for each call.  Also drop the extra
reference from filp_open after the init_dup calls while we're at it.

Fixes: 36e96b411649 ("init: add an init_dup helper")
Reported-by Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/init.c   | 2 +-
 init/main.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/init.c b/fs/init.c
index 730e05acda2392..e9c320a48cf157 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -260,6 +260,6 @@ int __init init_dup(struct file *file)
 	fd = get_unused_fd_flags(0);
 	if (fd < 0)
 		return fd;
-	fd_install(get_unused_fd_flags(0), get_file(file));
+	fd_install(fd, get_file(file));
 	return 0;
 }
diff --git a/init/main.c b/init/main.c
index 089e21504b1fc1..9dae9c4f806bb9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1470,6 +1470,7 @@ void __init console_on_rootfs(void)
 	init_dup(file);
 	init_dup(file);
 	init_dup(file);
+	fput(file);
 }
 
 static noinline void __init kernel_init_freeable(void)
-- 
2.27.0

