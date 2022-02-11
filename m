Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF04B2B3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351879AbiBKRE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 12:04:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiBKRE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:04:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FEB102;
        Fri, 11 Feb 2022 09:04:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6643B82ADF;
        Fri, 11 Feb 2022 17:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B125DC340E9;
        Fri, 11 Feb 2022 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644599095;
        bh=Sp7dZxkZVKWWeAoO1rNGVqZMJj/tCvRKVNvSSCvn8Pw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OTn5Wmz3ZV0keueb60DJ13Q3rk13NLl1uLqdX7z0tKq5Xrau07fdrCh2Fq5RF7eWL
         d13iPo8bbR03ZBuM6N/EjCtaN17DBQ+zKNswtoqWZS9E5neNE3XGjM87I4Q6N4rzEc
         Rvcj4+z/a4SukkXiwdUEzJMuQhui05Z4T3lAuKNJp90X1PJapdkkfQZhmIge+4F9lU
         MdhCYEEnMVuvxEz9KcvO6HzKzp2qy/K1QbgQ+0KIKGQKsW5mwaF8JEhibuM/DSREeS
         mocisgLmjVettQrg9YU/GeQBTphtELd+ujJCWFQudM8+YyPgHs19k3IrJbwSy0T38s
         urNOcjPdpo6RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70FE55C0610; Fri, 11 Feb 2022 09:04:55 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:04:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [BUG] Splat in __register_sysctl_table() in next-20220210
Message-ID: <20220211170455.GA1328576@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

I just wanted to be the 20th person to report the below splat in
init_fs_stat_sysctls() during boot.  ;-)

It happens on all rcutorture scenarios, for whatever that might be
worth.

						Thanx, Paul

------------------------------------------------------------------------

[    1.219815] calling  init_fs_stat_sysctls+0x0/0x37 @ 1
[    1.220440] CPU: 0 PID: 1 Comm: swapper Not tainted 5.17.0-rc3-next-20220210 #852
[    1.221353] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[    1.224133] Call Trace:
[    1.224439]  <TASK>
[    1.224702]  dump_stack_lvl+0x22/0x29
[    1.225122]  dump_stack+0x15/0x2a
[    1.225611]  __register_sysctl_table+0x4b2/0xab0
[    1.226158]  ? init_fs_open_sysctls+0x2b/0x2b
[    1.226755]  register_sysctl_mount_point+0x24/0x40
[    1.227396]  init_fs_stat_sysctls+0x2f/0x37
[    1.227884]  do_one_initcall+0x128/0x3e0
[    1.228445]  do_initcall_level+0xca/0x168
[    1.229215]  do_initcalls+0x66/0x95
[    1.229620]  do_basic_setup+0x18/0x1e
[    1.230105]  kernel_init_freeable+0xa9/0x113
[    1.230617]  ? rest_init+0x150/0x150
[    1.231101]  kernel_init+0x1c/0x200
[    1.231550]  ? rest_init+0x150/0x150
[    1.231981]  ret_from_fork+0x22/0x30
[    1.232471]  </TASK>
[    1.232743] initcall init_fs_stat_sysctls+0x0/0x37 returned 0 after 12029 usecs
