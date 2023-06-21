Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A036973911B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 22:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjFUUxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 16:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUUxZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FAA19C;
        Wed, 21 Jun 2023 13:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5227D616C9;
        Wed, 21 Jun 2023 20:53:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B9C433C9;
        Wed, 21 Jun 2023 20:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687380803;
        bh=0L/v9EWZjXDD/XXVBVimZjkfkieGicfgH7+D9uEJ7U0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DHr/hNfV+QCFp+OYMbXcuXUiyX4tuPJ1rW38kw98FnmNF3RuTfTFl4QRDSECBOTY/
         mkHnrrxAUCFUeFMesyPg0ZgVOMCNRqz/UactL/E8cjiWjeO0KwCWSSEPHtHUFVupvK
         PNys7h5sWHlGV80oh70qNwJ6OoTPk5P2Pt/qqt+YaBs/9bJLCKQ3PUKN7o+1d1dMe3
         A2PbREdtg+gqKI0jolLYH9yh5jlct+H5z/RjBaiM2k7xv8J/9eQk6ME0lwl2ZrKOTq
         xSLw6tNMcQT+35Ecu11s0fsscddfTKzgfBS9GGKn3ZdhLvpXL9HwtNIYs3LjvN6qbM
         MaY+hqnDvRKcg==
Date:   Wed, 21 Jun 2023 13:53:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH 05/11] sysctl: Add a size arg to __register_sysctl_table
Message-ID: <20230621135322.06b0ba2c@kernel.org>
In-Reply-To: <20230621091000.424843-6-j.granados@samsung.com>
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0@eucas1p1.samsung.com>
        <20230621091000.424843-6-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jun 2023 11:09:54 +0200 Joel Granados wrote:
> In order to remove the end element from the ctl_table struct arrays, we
> explicitly define the size when registering the targets.
> __register_sysctl_table is the first function to grow a size argument.
> For this commit to focus only on that function, we temporarily implement
> a size calculation in register_net_sysctl, which is an indirection call
> for all the network register calls.

You didn't CC the cover letter to netdev so replying here.

Is the motivation just the size change? Does it conflict with changes
queued to other trees?

It'd be much better if you could figure out a way to push prep into 
6.5 and then convert subsystems separately.
