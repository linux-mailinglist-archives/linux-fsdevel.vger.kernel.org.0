Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8143C17AFA4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 21:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEUV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 15:21:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:49780 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEUV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:21:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9wzk-005u6z-JP; Thu, 05 Mar 2020 20:21:24 +0000
Date:   Thu, 5 Mar 2020 20:21:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH] mnt: add support for non-rootfs initramfs
Message-ID: <20200305202124.GV23230@ZenIV.linux.org.uk>
References: <20200305193511.28621-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305193511.28621-1-ignat@cloudflare.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:35:11PM +0000, Ignat Korchagin wrote:
> The main need for this is to support container runtimes on stateless Linux
> system (pivot_root system call from initramfs).
> 
> Normally, the task of initramfs is to mount and switch to a "real" root
> filesystem. However, on stateless systems (booting over the network) it is just
> convenient to have your "real" filesystem as initramfs from the start.
> 
> This, however, breaks different container runtimes, because they usually use
> pivot_root system call after creating their mount namespace. But pivot_root does
> not work from initramfs, because initramfs runs form rootfs, which is the root
> of the mount tree and can't be unmounted.
> 
> One can solve this problem from userspace, but it is much more cumbersome. We
> either have to create a multilayered archive for initramfs, where the outer
> layer creates a tmpfs filesystem and unpacks the inner layer, switches root and
> does not forget to properly cleanup the old rootfs. Or we need to use keepinitrd
> kernel cmdline option, unpack initramfs to rootfs, run a script to create our
> target tmpfs root, unpack the same initramfs there, switch root to it and again
> properly cleanup the old root, thus unpacking the same archive twice and also
> wasting memory, because kernel stores compressed initramfs image indefinitely.
> 
> With this change we can ask the kernel (by specifying nonroot_initramfs kernel
> cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
> before the initramfs handling code, so initramfs gets unpacked directly into
> the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

IDGI.  Why not simply this as the first thing from your userland:
	mount("/", "/", NULL, MS_BIND | MS_REC, NULL);
	chdir("/..");
	chroot(".");
3 syscalls and you should be all set...
