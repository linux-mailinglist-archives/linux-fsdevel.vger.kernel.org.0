Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113A9401103
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhIERRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 13:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhIERRw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 13:17:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D17F760F4A;
        Sun,  5 Sep 2021 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630862209;
        bh=rKDXElkCsiyEyEsz8hDUB+IaVTc1a/MtVNCNz/8IVs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZ1F+Kfe9EOmUt2rC6ke2Urnpza4akt/Z8rgiEf6Lr75/asDA6+ZcpUZAde1oVfxB
         mje8pEmsb5n8wrKZkWyTPdE4vbtQxHq9jIvjv3zbPiZdFIsiulW9PrXCTGgHLAahCV
         3xdmitXx7gVujhnSSVknQG6yqTrMIB4up9SyydMw=
Date:   Sun, 5 Sep 2021 19:16:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p2o55S35a2Q?= <nzyang@stu.xidian.edu.cn>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        security@kernel.org
Subject: Re: Report Bug to Linux File System
Message-ID: <YTT7fpL+FjFSAQzz@kroah.com>
References: <2a299595.245.17bb495fbfa.Coremail.nzyang@stu.xidian.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a299595.245.17bb495fbfa.Coremail.nzyang@stu.xidian.edu.cn>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 05, 2021 at 02:12:13PM +0800, 杨男子 wrote:
> Hi, our team has found a problem in fs system on Linux kernel v5.10, leading to DoS attacks.
> 
> The struct file can be exhausted by normal users by calling multiple syscalls such as timerfd_create/pipe/open etc. Although the rlimit limits the max fds could be opened by a single process. A normal user can fork multiple processes, repeatedly make the timerfd_create/pipe/open syscalls and exhaust all struct files. As a result, all struct-file-allocation related operations of all other users will fail.
> 
> In fact, we try this attack inside a deprivileged docker container without any capabilities. The processes in the docker can exhaust all struct-file on the host kernel. We use a machine with 16G memory. We start 2000 processes, each process with a 1024 limit. In total, around 1613400 number struct-file are consumed and there are no available struct-file in the kernel. The total consumed memory is less than 2G , which is small, so memory control group can not help.

As has already been pointed out, containers are not any sort of
"resource boundry" to the overall system.

If you are concerned about processes using too many file handles, and
starving other processes on the system, then restrict them through the
nr_open sysctrl setting, that is what it is there for.

thanks,

greg k-h
