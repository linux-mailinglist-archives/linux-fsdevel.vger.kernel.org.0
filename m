Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BD567E267
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 11:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjA0K6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 05:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjA0K6f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA964EE9;
        Fri, 27 Jan 2023 02:58:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B71961AC0;
        Fri, 27 Jan 2023 10:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97870C433EF;
        Fri, 27 Jan 2023 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674817100;
        bh=5yeFRjegMFjzUwQix33riQSeMG0naSPmYrlj8IGsT6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ty/mQCdkfAbrJ6BjTVRqNpIspHZ9G5ptMGC15r09BTJZ9wIuuxRml/R3NfH++3Mt+
         jdwcYyiaG9l1SlDC1Y7rt9x7nogWsu0YX5MYyI7TwhNY3si/fnNkXk61B5ML41U/Wf
         m4MzY4SslhuZQAskqNbugyiIkhClTGIY3Vg77v+l1+Z62pukhhk2t6hlXCvgFNzbvJ
         F2jzWysIlgtV0eiqXeNNPP2ctE5vTwRTIPfuKbBNmBRCL63bnyx6zX1wrmgs3Cm809
         tU67SVpZZwIkrkz3TPkCSzmCzigaJ54MiZAW2H5TtXuuElHyR2N9PqvafoJiC9zTBV
         ZEnbHTsDnVxog==
Date:   Fri, 27 Jan 2023 11:58:15 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are
 detected
Message-ID: <20230127105815.adgqe2opfzruxk7e@wittgenstein>
References: <20230116191425.458864-1-jannh@google.com>
 <202301260835.61F1C2CA4D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202301260835.61F1C2CA4D@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:35:49AM -0800, Kees Cook wrote:
> On Mon, Jan 16, 2023 at 08:14:25PM +0100, Jann Horn wrote:
> > Currently, filp_close() and generic_shutdown_super() use printk() to log
> > messages when bugs are detected. This is problematic because infrastructure
> > like syzkaller has no idea that this message indicates a bug.
> > In addition, some people explicitly want their kernels to BUG() when kernel
> > data corruption has been detected (CONFIG_BUG_ON_DATA_CORRUPTION).
> > And finally, when generic_shutdown_super() detects remaining inodes on a
> > system without CONFIG_BUG_ON_DATA_CORRUPTION, it would be nice if later
> > accesses to a busy inode would at least crash somewhat cleanly rather than
> > walking through freed memory.
> > 
> > To address all three, use CHECK_DATA_CORRUPTION() when kernel bugs are
> > detected.
> 
> Seems reasonable to me. I'll carry this unless someone else speaks up.

I've already picked this into a branch with other fs changes for coming cycle.

Al, please tell me in case you end up picking this up and I'll drop it ofc.

Christian
