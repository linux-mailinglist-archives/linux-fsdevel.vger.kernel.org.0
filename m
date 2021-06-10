Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1ED3A2F69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFJPhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 11:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhFJPhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:37:21 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AEEC061574;
        Thu, 10 Jun 2021 08:35:25 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrMiA-006d1m-Px; Thu, 10 Jun 2021 15:35:14 +0000
Date:   Thu, 10 Jun 2021 15:35:14 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YMIxMszl0SoCmzcY@zeniv-ca.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <7433441f-b175-8484-240c-d1498c8c43f2@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7433441f-b175-8484-240c-d1498c8c43f2@quicinc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:29:59AM -0400, Qian Cai wrote:

> Al, a quick fuzzing on today's linux-next triggered this. I never saw this before, so I am wondering if this is anything to do with this series. I could try to narrow it down and bisect if necessary. Any thoughts?

Do you have a reproducer?

> [ 1904.633865][T14444] BUG: KASAN: stack-out-of-bounds in iov_iter_revert+0x65c/0x760
> [ 1904.641445][T14444] Read of size 8 at addr ffff80002692faf8 by task trinity-c30/14444
> [ 1904.649275][T14444]
> [ 1904.651461][T14444] CPU: 28 PID: 14444 Comm: trinity-c30 Not tainted 5.13.0-rc5-next-20210610+ #24
> [ 1904.660419][T14444] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [ 1904.668944][T14444] Call trace:
> [ 1904.672084][T14444]  dump_backtrace+0x0/0x3b8
> [ 1904.676445][T14444]  show_stack+0x20/0x30
> [ 1904.680454][T14444]  dump_stack_lvl+0x144/0x190
> [ 1904.684987][T14444]  print_address_description.constprop.0+0xd0/0x3c8
> [ 1904.691432][T14444]  kasan_report+0x1f0/0x208
> [ 1904.695787][T14444]  __asan_report_load8_noabort+0x34/0x60
> [ 1904.701274][T14444]  iov_iter_revert+0x65c/0x760
> iov_iter_revert at /usr/src/linux-next/lib/iov_iter.c:1118

*blink*
<checks -next>
Ah, the line numbers are shifted by gfs2 stuff.

> (inlined by) iov_iter_revert at /usr/src/linux-next/lib/iov_iter.c:1058
> [ 1904.705891][T14444]  netlink_sendmsg+0x870/0xa18
> netlink_sendmsg at /usr/src/linux-next/net/netlink/af_netlink.c:1913

call of memcpy_from_skb(), calling copy_from_iter_full(), which
calls iov_iter_revert() on failure now...

Bloody hell.  Incremental, to be folded in:

diff --git a/include/linux/uio.h b/include/linux/uio.h
index fd88d9911dad..82c3c3e819e0 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -154,7 +154,7 @@ bool copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i)
 	size_t copied = copy_from_iter(addr, bytes, i);
 	if (likely(copied == bytes))
 		return true;
-	iov_iter_revert(i, bytes - copied);
+	iov_iter_revert(i, copied);
 	return false;
 }
 
@@ -173,7 +173,7 @@ bool copy_from_iter_full_nocache(void *addr, size_t bytes, struct iov_iter *i)
 	size_t copied = copy_from_iter_nocache(addr, bytes, i);
 	if (likely(copied == bytes))
 		return true;
-	iov_iter_revert(i, bytes - copied);
+	iov_iter_revert(i, copied);
 	return false;
 }
 
@@ -282,7 +282,7 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
 	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
 	if (likely(copied == bytes))
 		return true;
-	iov_iter_revert(i, bytes - copied);
+	iov_iter_revert(i, copied);
 	return false;
 }
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
