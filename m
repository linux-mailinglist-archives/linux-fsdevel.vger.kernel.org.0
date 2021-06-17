Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667AE3ABA48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 19:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhFQRLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 13:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFQRLa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:11:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8747C6102A;
        Thu, 17 Jun 2021 17:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623949762;
        bh=zDSVq3G22Kf7jAi9pHiVbZ+ouTpFq58n3IVXW7LrigQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4f048lHUQ/IJAMlzqUwf+3itioESmZl7OgfTg+wXHtlgOzgvHjp/PDNxc2y9Tfc1
         D23KVWOISpLsX6Mg+XGilGH3S7Bvll1dgE29M96igFlh+8Rj89aDiw/9OFiPZ8HMSu
         OnuBAqzhPAcINxiVB0I6qAcvW5KQmHkZOgGadvBylxpO64C/U662Pu6m8qPKysL98C
         A3mczog88rCR4RSFRVFcKkhKmuYNQLwD6so3v6jT6CyRFODST6FS2bVmw6Q7WF2dwU
         /oPdHqxPAhsfSV14t7Gj7JNJaZW1L7FugOLoYPf33weA8Asrk/WkxHrCpW43l44zjp
         rzb6uC/xLThfA==
Date:   Thu, 17 Jun 2021 10:09:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Problem with xfs in an old version
Message-ID: <20210617170922.GA158165@locust>
References: <CAB5KdOat4A7ZP1MDKHuXra7YN8cZ1J_K5W4M+G_Ye44un79_BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB5KdOat4A7ZP1MDKHuXra7YN8cZ1J_K5W4M+G_Ye44un79_BQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 12:06:40AM +0800, Haiwei Li wrote:
> Hi,
> 
> Sorry to bother. I get a xfs error on kernel 3.10.x. And i don't know how to
> debug. I got nothing useful from search engines. So I sent an e-mail
> here. If there
> are other more suitable ways to discuss the problem, please let me know, thanks!
> 
> I have gotten a message on the console.
> 
> '-bash: /data/.my_history: Input/output error'
> 
> I tried:
> 
> # ls -l / | grep data
> ls: cannot access /data: Input/output error
> d?????????    ? ?    ?        ?            ? data
> 
> The mount point info is:
> 
> '/dev/vdb on /data type xfs (rw,noatime,attr2,inode64,prjquota)'
> 
> System log messages as below:
> 
> ffff882b86a34000: 31 38 38 32 30 31 36 0a 00 00 00 00 00 00 00 00
> 1882016.........
> ffff882b86a34010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> ffff882b86a34020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> ffff882b86a34030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> XFS (vdb): Internal error xfs_inode_buf_verify at line 410 of file
> XXXX/fs/x[2021-06-17 18:28:51]fs/xfs_inode.c.  Caller
> 0xffffffffa04d410e
> 
> CPU: 0 PID: 7715 Comm: kworker/0:1H Tainted: G     U     O
> 3.10.107-1-tlinux2_kvm_guest-0051 #1
> Hardware name: Smdbmds KVM, BIOS seabios-1.9.1-qemu-project.org 04/01/2014
> Workqueue: xfslogd xfs_buf_iodone_work [xfs]
>  ffff882ec52d9000 000000001a1ab7e6 ffff882efa97fd50 ffffffff819f1d23
>  ffff882efa97fd68 ffffffffa047da9b ffffffffa04d410e ffff882efa97fda0
>  ffffffffa047daf5 0000019a00000001 0000000000000001 ffff882b86a34000
> Call Trace:
>  [<ffffffff819f1d23>] dump_stack+0x19/0x1b
>  [<ffffffffa047da9b>] xfs_error_report+0x3b/0x40 [xfs]
>  [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
>  [<ffffffffa047daf5>] xfs_corruption_error+0x55/0x80 [xfs]
>  [<ffffffffa04d40a4>] xfs_inode_buf_verify+0x94/0xe0 [xfs]
>  [<ffffffffa04d410e>] ? xfs_inode_buf_read_verify+0xe/0x10 [xfs]
>  [<ffffffffa04d410e>] xfs_inode_buf_read_verify+0xe/0x10 [xfs]
>  [<ffffffffa047b305>] xfs_buf_iodone_work+0xa5/0xd0 [xfs]
>  [<ffffffff8106c00c>] process_one_work+0x17c/0x450
>  [<ffffffff8106cebb>] worker_thread+0x11b/0x3a0
>  [<ffffffff8106cda0>] ? manage_workers.isra.26+0x2a0/0x2a0
>  [<ffffffff810737cf>] kthread+0xcf/0xe0
>  [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
>  [<ffffffff81ad5908>] ret_from_fork+0x58/0x90
>  [<ffffffff81073700>] ? insert_kthread_work+0x40/0x40
> XFS (vdb): Corruption detected. Unmount and run xfs_repair
> ffff882b86a34100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> ffff882b86a34110: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> ffff882b86a34120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> ffff882b86a34130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ................
> 
> I reboot and remount. It works normally. No error again. I guess data from the
> wrong blocks was returned to XFS.
> 
> I have no idea how to reproduce. Our workload sometimes triggers the problem.
> To data, the problem only occurs on 3.10.x in three versions 3.10.x, 4.14.x and
> 5.4.x.
> 
> Environment: Containers with workload are running in a kvm vm. The problem
> occurs in the kvm vm.
> 
> Any ideas on how to debug? Thanks!

Uh, does xfs_repair -n on the unmounted filesystem complain about this
corrupt inode?

--D

> 
> --
> Haiwei
