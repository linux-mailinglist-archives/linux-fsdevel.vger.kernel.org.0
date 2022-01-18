Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB9A49206A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiARHlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiARHlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:41:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B0C061574;
        Mon, 17 Jan 2022 23:41:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 009DCB81238;
        Tue, 18 Jan 2022 07:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716BBC00446;
        Tue, 18 Jan 2022 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491674;
        bh=fxQKuKC48Za3WskfwSPk4C7lOszUQQkhqFePaAQVz1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFTUDrH+zR3SzgKLpLvmjC2YB2wgmwDxmggIWiW50W5AlE8uZmnVoU2jFXmdB61bx
         ftxnwzCUdA1WlvZEhIYr3a3CGzhG0mmFb/wHRjhqcx1tJ7LmdQA7bibvMgoqfjqJK+
         xURFeEmNBsWY8CyEHKf/qKn9NYOj1tLW0rBKHNtpTKP13sQbH+R8hBgCSecnmtxfyz
         yXxIb/biHEIeAb+WOpj4gkaSBv4nz8lpWpNLHzM+PQAcXI+ZmoLZYDDHP8BrStYcKt
         82eBb2MNPpsI+c4ZLQ0Gn0IjSjLNW1x6TRjGmqS9MwufTHxpKibx1DK0hAtuKvAeWG
         iDb74xe6p1Lwg==
Date:   Tue, 18 Jan 2022 09:41:02 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     cgel.zte@gmail.com
Cc:     mhiramat@kernel.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        johan@kernel.org, bhelgaas@google.com, elver@google.com,
        masahiroy@kernel.org, zhang.yunkai@zte.com.cn, axboe@kernel.dk,
        vgoyal@redhat.com, jack@suse.cz, leon@kernel.org,
        akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
        palmerdabbelt@google.com, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, rostedt@goodmis.org,
        ahalaney@redhat.com, valentin.schneider@arm.com,
        peterz@infradead.org, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dong.menglong@zte.com.cn
Subject: Re: [PATCH v7 2/2] init/do_mounts.c: create second mount for
 initramfs
Message-ID: <YeZvDrUexrOqvmnF@kernel.org>
References: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
 <20220117134352.866706-3-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117134352.866706-3-zhang.yunkai@zte.com.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 01:43:52PM +0000, cgel.zte@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> If using container platforms such as Docker, upon initialization it
> wants to use pivot_root() so that currently mounted devices do not
> propagate to containers. An example of value in this is that
> a USB device connected prior to the creation of a containers on the
> host gets disconnected after a container is created; if the
> USB device was mounted on containers, but already removed and
> umounted on the host, the mount point will not go away until all
> containers unmount the USB device.
> 
> Another reason for container platforms such as Docker to use pivot_root
> is that upon initialization the net-namspace is mounted under
> /var/run/docker/netns/ on the host by dockerd. Without pivot_root
> Docker must either wait to create the network namespace prior to
> the creation of containers or simply deal with leaking this to each
> container.
> 
> pivot_root is supported if the rootfs is a initrd or block device, but
> it's not supported if the rootfs uses an initramfs (tmpfs). This means
> container platforms today must resort to using block devices if
> they want to pivot_root from the rootfs. A workaround to use chroot()
> is not a clean viable option given every container will have a
> duplicate of every mount point on the host.

Sorry if this was already answered.

My understanding is that you have initramfs with docker installed on it and
with one or more container images packed there. And the desire is to use
this initramfs to run docker containers and for that you need to enable
pivot_root for initramfs.

Have you tried packing docker and the containers to a block image that can
be loop-mounted from the initramfs? Then you can chroot to that loop
mounted filesystem and there pivot_root will be available for docker.
 
> In order to support using container platforms such as Docker on
> all the supported rootfs types we must extend Linux to support
> pivot_root on initramfs as well. This patch does the work to do
> just that.

-- 
Sincerely yours,
Mike.
