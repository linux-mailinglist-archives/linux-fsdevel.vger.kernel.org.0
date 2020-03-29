Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9C196A77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 01:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC2AzO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 20:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC2AzO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 20:55:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ACFA206E6;
        Sun, 29 Mar 2020 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585443313;
        bh=ipcz8CF5vJBhq/jojERqbxhpgngS7JifWVfGVos415M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fy7egyjarazEMzddBaWBlWIt8r2CcHS5ldkDO42+zt7I985H8LiZHctV2K/kkYx2r
         1+FY7GIIl4h2JKpawy0f7iCqQYDUhNOWL6EFrTRIcPKdHKuyO95pqfzUJXNmWTXZJx
         XmWeZ1Zb30qdb+0eaExTFk5j+ueoKs0QIOWE8GyE=
Date:   Sat, 28 Mar 2020 17:55:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH (repost)] umh: fix refcount underflow in
 fork_usermode_blob().
Message-Id: <20200328175512.e89ff65333e6c65fea211c12@linux-foundation.org>
In-Reply-To: <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
        <20200312143801.GJ23230@ZenIV.linux.org.uk>
        <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
        <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
        <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 27 Mar 2020 09:51:34 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Since free_bprm(bprm) always calls allow_write_access(bprm->file) and
> fput(bprm->file) if bprm->file is set to non-NULL, __do_execve_file()
> must call deny_write_access(file) and get_file(file) if called from
> do_execve_file() path. Otherwise, use-after-free access can happen at
> fput(file) in fork_usermode_blob().
> 
>   general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6b6b: 0000 [#1] SMP DEBUG_PAGEALLOC
>   CPU: 3 PID: 4131 Comm: insmod Tainted: G           O      5.6.0-rc5+ #978
>   Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 07/29/2019
>   RIP: 0010:fork_usermode_blob+0xaa/0x190

This is rather old code - what casued this to be observed now?  Some
unusual userspace behaviour?


