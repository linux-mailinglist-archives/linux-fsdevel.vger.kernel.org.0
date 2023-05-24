Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7776F70FD49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjEXRzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjEXRzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:55:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A89D189;
        Wed, 24 May 2023 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dh2TURy9ckVzyhHVuUH5NnclY5r+mIKHfBiFi1WgOds=; b=oihmbSnp7hub6slekflJmgsJCm
        JBvAcQh7HtQEJziC7alsSkwCTgRurwvcEXoFSo3Igl0N3RXBfUdFU8elkHkCtUK3fRaWgXfA98WcL
        v2eJh+TauwQARixy3tT/GAkjrtWOwUiYQbwpDh2uOKXe0An7VL58rW8fy7HnCxLDBHcgReMjKRGnG
        jgcNvXIAatwmRHlyZjVuVzpy+c4Wretof0REoIlAt45dtfZqZLdEVLtr76ibn4oN02nzf2l3iSxdx
        IwaadJ1atQU8UGg6GEH/PuBCsOwhVcPn4J+ZmV3brI+AoXrWqkhFFYM4J3ALftGhJP81rwT1YE7Qz
        PP9067AA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1sht-00EHYZ-0j;
        Wed, 24 May 2023 17:55:29 +0000
Date:   Wed, 24 May 2023 10:55:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Granados <j.granados@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] sysctl: Refactor base paths registrations
Message-ID: <ZG5PkZI+BiF8g1ax@bombadil.infradead.org>
References: <20230518160705.3888592-1-j.granados@samsung.com>
 <CGME20230518160715eucas1p1973b53732f9b05aabbef2669124eb413@eucas1p1.samsung.com>
 <20230518160705.3888592-2-j.granados@samsung.com>
 <0085b175-4d82-4ba4-b19c-643422f73bec@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0085b175-4d82-4ba4-b19c-643422f73bec@roeck-us.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 06:29:06AM -0700, Guenter Roeck wrote:
> On Thu, May 18, 2023 at 06:07:04PM +0200, Joel Granados wrote:
> > This is part of the general push to deprecate register_sysctl_paths and
> > register_sysctl_table. The old way of doing this through
> > register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
> > call to register_sysctl. The 5 base paths affected are: "kernel", "vm",
> > "debug", "dev" and "fs".
> > 
> > We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
> > macro since they are no longer needed.
> > 
> > In order to quickly acertain that the paths did not actually change I
> > executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
> > same before and after the commit.
> > 
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> 
> This patch results in the following warning, seen across almost
> all architectures.
> 
> sysctl table check failed: kernel/usermodehelper Not a file
> sysctl table check failed: kernel/usermodehelper No proc_handler
> sysctl table check failed: kernel/usermodehelper bogus .mode 0555
> sysctl table check failed: kernel/keys Not a file
> sysctl table check failed: kernel/keys No proc_handler
> sysctl table check failed: kernel/keys bogus .mode 0555
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.4.0-rc3-next-20230524 #1
> Stack : ffffffff 801aed28 80e44644 00000004 81946ba4 00000000 810d3db4 b782f641
>         810f0000 81269940 810f0000 810fa610 811bb193 00000001 810d3d58 00000000
>         00000000 00000000 810099d8 000000f2 00000001 000000f3 00000000 00000000
>         ffffffff 00000002 00000000 fff80000 810f0000 810099d8 00000001 ffffffea
>         8013bab4 8113bb14 8013caa8 80fe0000 00000000 807b9d54 00000000 81270000
>         ...
> Call Trace:
> [<8010a558>] show_stack+0x38/0x118
> [<80d67edc>] dump_stack_lvl+0xa4/0xf0
> [<8039c8e0>] __register_sysctl_table+0x5b4/0x7a0
> [<811e55e4>] __register_sysctl_init+0x30/0x68
> [<811d5164>] sysctl_init_bases+0x24/0x88
> [<811e517c>] proc_root_init+0x94/0xa8
> [<811ccebc>] start_kernel+0x704/0x740
> 
> failed when register_sysctl kern_table to kernel
> 
> Reverting this patch alone results in build failures. Reverting this patch
> as well as the second patch in the series (to avoid the build failures)
> fixes the problem.
> 
> Guenter

Thanks Guenter! The issue has been fixed on sysct-next, and I suppose
the fix will get into linux-next as of tomorrow.

 Luis
