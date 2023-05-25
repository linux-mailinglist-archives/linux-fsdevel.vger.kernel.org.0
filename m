Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128C2710BFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjEYMY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjEYMYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 08:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AA0189;
        Thu, 25 May 2023 05:24:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8B464513;
        Thu, 25 May 2023 12:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24EAC433D2;
        Thu, 25 May 2023 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685017493;
        bh=6ByQ9jPlC0Z75D3momx9qOf9bXDHoK8a5ZO34jIyhdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A50oeQE+ZDEOQtWA7fRPVjjH3HWhpGb6eq76F6qEMBB/sv448Rl8+Omj3Z6UjVF95
         kVeGvt1uTFklhrDRqwya95JFNvNwv9Dir8RxIE1RwUTCK+gkII36xwwLSO64IFmeIJ
         BJnMdpLq1baho77fNdby4YjtH/cqEpmrPrfYhHIp0S/fLdqbAbld7aK0vZYNdAihIr
         HXPSbjzUSlOqswBFgCFyElqyNcmKnWC6GBpXdWDDnsGmEedEgSUWPNQKHR314R42QK
         JiGC8EEUTY6Kfvmz8Jf7fKyXOHro1jBojt5YZb1tk+fzajZvjA4cpz6oVDmmyMgaBo
         Fa6DAvLRTj7WQ==
Date:   Thu, 25 May 2023 14:24:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs: use UB-safe check for signed addition overflow in
 remap_verify_area
Message-ID: <20230525-normung-essverhalten-5e8579dc8e15@brauner>
References: <20230523162628.17071-1-dsterba@suse.com>
 <20230524-umfahren-stift-d1c34fd1d0fa@brauner>
 <20230525120935.GI30909@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525120935.GI30909@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 02:09:35PM +0200, David Sterba wrote:
> On Wed, May 24, 2023 at 04:16:17PM +0200, Christian Brauner wrote:
> > On Tue, 23 May 2023 18:26:28 +0200, David Sterba wrote:
> > > The following warning pops up with enabled UBSAN in tests fstests/generic/303:
> > > 
> > >   [23127.529395] UBSAN: Undefined behaviour in fs/read_write.c:1725:7
> > >   [23127.529400] signed integer overflow:
> > >   [23127.529403] 4611686018427322368 + 9223372036854775807 cannot be represented in type 'long long int'
> > >   [23127.529412] CPU: 4 PID: 26180 Comm: xfs_io Not tainted 5.2.0-rc2-1.ge195904-vanilla+ #450
> > >   [23127.556999] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
> > >   [23127.557001] Call Trace:
> > >   [23127.557060]  dump_stack+0x67/0x9b
> > >   [23127.557070]  ubsan_epilogue+0x9/0x40
> > >   [23127.573496]  handle_overflow+0xb3/0xc0
> > >   [23127.573514]  do_clone_file_range+0x28f/0x2a0
> > >   [23127.573547]  vfs_clone_file_range+0x35/0xb0
> > >   [23127.573564]  ioctl_file_clone+0x8d/0xc0
> > >   [23127.590144]  do_vfs_ioctl+0x300/0x700
> > >   [23127.590160]  ksys_ioctl+0x70/0x80
> > >   [23127.590203]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> > >   [23127.590210]  __x64_sys_ioctl+0x16/0x20
> > >   [23127.590215]  do_syscall_64+0x5c/0x1d0
> > >   [23127.590224]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >   [23127.590231] RIP: 0033:0x7ff6d7250327
> > >   [23127.590241] RSP: 002b:00007ffe3a38f1d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> > >   [23127.590246] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ff6d7250327
> > >   [23127.590249] RDX: 00007ffe3a38f220 RSI: 000000004020940d RDI: 0000000000000003
> > >   [23127.590252] RBP: 0000000000000000 R08: 00007ffe3a3c80a0 R09: 00007ffe3a3c8080
> > >   [23127.590255] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 0000000000000000
> > >   [23127.590260] R13: 0000000000000000 R14: 3fffffffffff0000 R15: 00007ff6d750a20c
> > > 
> > > [...]
> > 
> > Independent of this fix it is a bit strange that we have this
> > discrepancy between struct file_clone_range using u64s and the internal
> > apis using loff_t. It's not a big deal but it's a bit ugly.
> 
> The file_clone_range used to be a private btrfs ioctl with u64 types
> that got lifted to VFS, inheriting the types.
> 
> 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")

Yeah, I saw that when I looked up the history. I understand why it
happened it's just a bit unforunate. Thanks!
