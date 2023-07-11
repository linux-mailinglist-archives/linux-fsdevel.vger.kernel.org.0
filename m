Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD874F683
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 19:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGKRGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGKRGN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DCB7;
        Tue, 11 Jul 2023 10:05:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D31DE61575;
        Tue, 11 Jul 2023 17:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738DBC433CA;
        Tue, 11 Jul 2023 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689095158;
        bh=/dly5nbaWfwT5KcM51jbms5tjAC68wuJHQC6spfOCes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKNiTx0nlXElPNltIH7tVxIYhrH4+PpUD8Dc07/k0Izs3ugMZnUi2in8BaO6VbEdl
         ry06e5Y33ljoJtzy9osjg2fP4KzV1XbFyEnd7gsG2FIA+RZaLpIe1KkEJHEp9ozM1h
         EOaLqah9uSCy954cvFhCywNC7IULAlNbcI8NGThYVj4RTqUgmq/J7MW4IPf0RYVQwC
         iEkSYyAxCJ4VKuJ+m5vcT+TMCnEQM6cKi28dCVN6H+n+FarUeWuBakNOTMmZtmooWW
         /OA4qpwMaSysa1sQ5LrLbF/l0rN0S2BYe0e4yjaK54AdqbeNEjtyo/zE81SpWj2Nbb
         YPkf5nTcal/NQ==
Date:   Tue, 11 Jul 2023 19:05:44 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, James.Bottomley@HansenPartnership.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        axboe@kernel.dk, benh@kernel.crashing.org, borntraeger@de.ibm.com,
        bp@alien8.de, catalin.marinas@arm.com, christian@brauner.io,
        dalias@libc.org, davem@davemloft.net, deepa.kernel@gmail.com,
        deller@gmx.de, dhowells@redhat.com, fenghua.yu@intel.com,
        fweimer@redhat.com, geert@linux-m68k.org, glebfm@altlinux.org,
        gor@linux.ibm.com, hare@suse.com, hpa@zytor.com,
        ink@jurassic.park.msu.ru, jhogan@kernel.org, kim.phillips@arm.com,
        ldv@altlinux.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, luto@kernel.org, mattst88@gmail.com,
        mingo@redhat.com, monstr@monstr.eu, mpe@ellerman.id.au,
        namhyung@kernel.org, paulus@samba.org, peterz@infradead.org,
        ralf@linux-mips.org, sparclinux@vger.kernel.org, stefan@agner.ch,
        tglx@linutronix.de, tony.luck@intel.com, tycho@tycho.ws,
        will@kernel.org, x86@kernel.org, ysato@users.sourceforge.jp,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v4 2/5] fs: Add fchmodat2()
Message-ID: <20230711-spendabel-lotosblume-f08d23a83ebf@brauner>
References: <cover.1689074739.git.legion@kernel.org>
 <cover.1689092120.git.legion@kernel.org>
 <f2a846ef495943c5d101011eebcf01179d0c7b61.1689092120.git.legion@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2a846ef495943c5d101011eebcf01179d0c7b61.1689092120.git.legion@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:16:04PM +0200, Alexey Gladkov wrote:
> On the userspace side fchmodat(3) is implemented as a wrapper
> function which implements the POSIX-specified interface. This
> interface differs from the underlying kernel system call, which does not
> have a flags argument. Most implementations require procfs [1][2].
> 
> There doesn't appear to be a good userspace workaround for this issue
> but the implementation in the kernel is pretty straight-forward.
> 
> The new fchmodat2() syscall allows to pass the AT_SYMLINK_NOFOLLOW flag,
> unlike existing fchmodat.
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/fchmodat.c;h=17eca54051ee28ba1ec3f9aed170a62630959143;hb=a492b1e5ef7ab50c6fdd4e4e9879ea5569ab0a6c#l35
> [2] https://git.musl-libc.org/cgit/musl/tree/src/stat/fchmodat.c?id=718f363bc2067b6487900eddc9180c84e7739f80#n28
> 
> Co-developed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/open.c                | 18 ++++++++++++++----
>  include/linux/syscalls.h |  2 ++
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 0c55c8e7f837..39a7939f0d00 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -671,11 +671,11 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>  	return err;
>  }
>  
> -static int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +static int do_fchmodat(int dfd, const char __user *filename, umode_t mode, int lookup_flags)

Should all be unsigned instead of int here for flags. We also had a
documentation update to that effect but smh never sent it.
user_path_at() itself takes an unsigned as well.

I'll fix that up though.
