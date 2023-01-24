Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03D36794D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjAXKMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXKMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:12:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ABE6EAF;
        Tue, 24 Jan 2023 02:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B421ECE19CE;
        Tue, 24 Jan 2023 10:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B9C433D2;
        Tue, 24 Jan 2023 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674555132;
        bh=Hikckpna3DVXXZPGZ4BuFVYPSnZbNR3v/om5urasXP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvS8tFYynVdhY+yLg/Uo8uGL7xBxvivN7Dj+2pb5uR00svQO750DkL7jkIcs8kxEz
         /qr1QDFUHdIIuaYYn0MsgtVe/07se6catfUuNh7FLGIMb2tR/viH5ROJRNF6vLRI3Y
         mftyt3O+8jzURwwcJ+k4EizDX6UfnTBrg57Ym+V6lbxWYZEvvMDbxtTXTKp6LQ9Kac
         HMhWxO3evQAAYoHX73patO6mAOVKmp5Oi94nlj4NDZcL9LJPqPJCPSy4H/vanOOL1q
         pmV19yMGDJjwF8HID2HvxUyd0qIMLC99Q4IylZm9gZvl8vRUIMlWayW55xN4G1A+Jd
         +eX5NfNWoxZNw==
Date:   Tue, 24 Jan 2023 11:12:07 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] fs: Use CHECK_DATA_CORRUPTION() when kernel bugs are
 detected
Message-ID: <20230124101207.ofqr6qv2yla24jyd@wittgenstein>
References: <20230116191425.458864-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230116191425.458864-1-jannh@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:14:25PM +0100, Jann Horn wrote:
> Currently, filp_close() and generic_shutdown_super() use printk() to log
> messages when bugs are detected. This is problematic because infrastructure
> like syzkaller has no idea that this message indicates a bug.
> In addition, some people explicitly want their kernels to BUG() when kernel
> data corruption has been detected (CONFIG_BUG_ON_DATA_CORRUPTION).
> And finally, when generic_shutdown_super() detects remaining inodes on a
> system without CONFIG_BUG_ON_DATA_CORRUPTION, it would be nice if later
> accesses to a busy inode would at least crash somewhat cleanly rather than
> walking through freed memory.
> 
> To address all three, use CHECK_DATA_CORRUPTION() when kernel bugs are
> detected.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Looks good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
