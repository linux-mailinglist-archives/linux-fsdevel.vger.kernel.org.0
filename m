Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B427214C34
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGELuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELuT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD4A2073E;
        Sun,  5 Jul 2020 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949819;
        bh=6H4BG9XUn4FArWwJ1aHdJuAbaZICFxfaIIk6oHWyqSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEndCB28R0sfFMfC1Jsnwtvx3NntdXF6wKOBm9AoAbFI0D0SuHggK8qbd54n7Oklq
         CpGgbmTxLKfcc1gltZEeyNAmEIxnhGySwZaUq9W3RfDH5g33e/hzIcUhlyNssJh3aO
         4qvNF3EXSBP/nhQO5JVioPo23rX4w9mFMFkqsvlA=
Date:   Sun, 5 Jul 2020 13:50:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705115021.GA1227929@kroah.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> Hello
> 
> At first, I thought that the proposed system call is capable of
> reading *multiple* small files using a single system call - which
> would help increase HDD/SSD queue utilization and increase IOPS (I/O
> operations per second) - but that isn't the case and the proposed
> system call can read just a single file.

If you want to do this for multple files, use io_ring, that's what it
was designed for.  I think Jens was going to be adding support for the
open/read/close pattern to it as well, after some other more pressing
features/fixes were finished.

> Without the ability to read multiple small files using a single system
> call, it is impossible to increase IOPS (unless an application is
> using multiple reader threads or somehow instructs the kernel to
> prefetch multiple files into memory).

There's not much (but it is mesurable) need to prefetch virtual files
into memory first, which is primarily what this syscall is for (procfs,
sysfs, securityfs, etc.)  If you are dealing with real-disks, then yes,
the overhead of the syscall might be in the noise compared to the i/o
path of the data.

> While you are at it, why not also add a readfiles system call to read
> multiple, presumably small, files? The initial unoptimized
> implementation of readfiles syscall can simply call readfile
> sequentially.

Again, that's what io_uring is for.

thanks,

greg k-h
