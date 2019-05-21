Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098AF2582E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfEUTUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 15:20:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37620 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEUTUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 15:20:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hTAIz-0003v8-BX; Tue, 21 May 2019 19:20:09 +0000
Date:   Tue, 21 May 2019 20:20:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, jannh@google.com, fweimer@redhat.com,
        oleg@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        arnd@arndb.de, shuah@kernel.org, tkjos@android.com,
        ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
Message-ID: <20190521192009.GK17978@ZenIV.linux.org.uk>
References: <20190521150006.GJ17978@ZenIV.linux.org.uk>
 <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28114.1558456227@warthog.procyon.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 05:30:27PM +0100, David Howells wrote:

> If we can live with close_from(int first) rather than close_range(), then this
> can perhaps be done a lot more efficiently by:
> 
> 	new = alloc_fdtable(first);
> 	spin_lock(&files->file_lock);
> 	old = files_fdtable(files);
> 	copy_fds(new, old, 0, first - 1);
> 	rcu_assign_pointer(files->fdt, new);
> 	spin_unlock(&files->file_lock);
> 	clear_fds(old, 0, first - 1);
> 	close_fdt_from(old, first);
> 	kfree_rcu(old);

I really hate to think how that would interact with POSIX locks...
