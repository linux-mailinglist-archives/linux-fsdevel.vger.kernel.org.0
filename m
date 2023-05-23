Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43BE70DA71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjEWK0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjEWK02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379E2109
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 03:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE1B630B0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C47C433EF;
        Tue, 23 May 2023 10:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684837586;
        bh=HMq522vFmr1iy5Q05t/E5Rxh7XBHLbz7gJyHDePXeBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRv72JrcJN35tTYdO+L4dc8KVCOOdzNIQAQaOJ7gcdg9HP2rJmVefCeB5yKEQEV4c
         JWrg31xEoQoBdDoYXv5Wiy6MwdT0+lR7J2Q9Nt+LwfJrWsTfiQd8e3kh9nJdEosJDB
         2Hce7W4wBvzr0VKyyelb7MRCAN4vkrXaWmxhUgSCJUpY3BLtZPWv4YYNGgJxH8YBXT
         8jUfzZy8KsD3trakWNIztNRzKZ8aftaVtrMDXRGoEFQtfBQXJdXwMYsnaqx4em6XKm
         lViOSmw22e1dts7f2rs+uNzvykeMkSYeJx7Bkb7/4Y6dpzG/WHUJCtmJqesNcmO0XI
         AXS4VcaSZwHFA==
Date:   Tue, 23 May 2023 12:26:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: support O_PATH FDs in BPF_OBJ_PIN
 and BPF_OBJ_GET commands
Message-ID: <20230523-sturheit-leitkultur-80521982adf7@brauner>
References: <20230522232917.2454595-1-andrii@kernel.org>
 <20230522232917.2454595-3-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522232917.2454595-3-andrii@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:29:15PM -0700, Andrii Nakryiko wrote:
> Current UAPI of BPF_OBJ_PIN and BPF_OBJ_GET commands of bpf() syscall
> forces users to specify pinning location as a string-based absolute or
> relative (to current working directory) path. This has various
> implications related to security (e.g., symlink-based attacks), forces
> BPF FS to be exposed in the file system, which can cause races with
> other applications.
> 
> One of the feedbacks we got from folks working with containers heavily
> was that inability to use purely FD-based location specification was an
> unfortunate limitation and hindrance for BPF_OBJ_PIN and BPF_OBJ_GET
> commands. This patch closes this oversight, adding path_fd field to
> BPF_OBJ_PIN and BPF_OBJ_GET UAPI, following conventions established by
> *at() syscalls for dirfd + pathname combinations.
> 
> This now allows interesting possibilities like working with detached BPF
> FS mount (e.g., to perform multiple pinnings without running a risk of
> someone interfering with them), and generally making pinning/getting
> more secure and not prone to any races and/or security attacks.
> 
> This is demonstrated by a selftest added in subsequent patch that takes
> advantage of new mount APIs (fsopen, fsconfig, fsmount) to demonstrate
> creating detached BPF FS mount, pinning, and then getting BPF map out of
> it, all while never exposing this private instance of BPF FS to outside
> worlds.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
