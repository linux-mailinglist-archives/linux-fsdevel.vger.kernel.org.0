Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D3470DD12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjEWM4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjEWM4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5BF120;
        Tue, 23 May 2023 05:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0299F63207;
        Tue, 23 May 2023 12:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F01C433EF;
        Tue, 23 May 2023 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684846566;
        bh=BlFTpPUzZRA+Lfm2VLhaVbfEaR3PZ2flj9ymLK2nYgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwL2kpk4GWvyLEoR3xe0WH3BUhFm3QXrN8u/bclr/UeINHbumUUYXTGikq4xCRcZc
         /gQMW/+w8aXJ8dm+VrpdhTeeQeHXK1iytxyfN5MCZpfRBWzKGEFRFajjaJj8++T/Zp
         Qvurw3APIuLHCeebjcFqITMwncZCtQ5L0YFizxz4eZNKeIvT0BFkQGtDKhSDU+K0tU
         FCY1NTwo9tCwV43wiToIpCw3R1gb+l5A5Cyv+MAeeIBMsWcNGGkzQNJddVBJgSOGVE
         R1CcOYWBYbE4VzzU256gF++CNrh2u95BtY3qkyhyPkiTpvLYxrQ9nPd8ROuC5ZfbPf
         93prZOwlrR9OQ==
Date:   Tue, 23 May 2023 14:56:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 7/8] sysctl: Refactor base paths registrations
Message-ID: <20230523-gipfel-urfassung-01205d1cdc33@brauner>
References: <20230523122220.1610825-1-j.granados@samsung.com>
 <CGME20230523122236eucas1p17639bfdbfb30c9d751e0a8fc85fe2fd3@eucas1p1.samsung.com>
 <20230523122220.1610825-8-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230523122220.1610825-8-j.granados@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 02:22:19PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. The old way of doing this through
> register_sysctl_base and DECLARE_SYSCTL_BASE macro is replaced with a
> call to register_sysctl_init. The 5 base paths affected are: "kernel",
> "vm", "debug", "dev" and "fs".
> 
> We remove the register_sysctl_base function and the DECLARE_SYSCTL_BASE
> macro since they are no longer needed.
> 
> In order to quickly acertain that the paths did not actually change I
> executed `find /proc/sys/ | sha1sum` and made sure that the sha was the
> same before and after the commit.
> 
> We end up saving 563 bytes with this change:
> 
> ./scripts/bloat-o-meter vmlinux.0.base vmlinux.1.refactor-base-paths
> add/remove: 0/5 grow/shrink: 2/0 up/down: 77/-640 (-563)
> Function                                     old     new   delta
> sysctl_init_bases                             55     111     +56
> init_fs_sysctls                               12      33     +21
> vm_base_table                                128       -    -128
> kernel_base_table                            128       -    -128
> fs_base_table                                128       -    -128
> dev_base_table                               128       -    -128
> debug_base_table                             128       -    -128
> Total: Before=21258215, After=21257652, chg -0.00%
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> [mcgrof: modified to use register_sysctl_init() over register_sysctl()
>  and add bloat-o-meter stats]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
