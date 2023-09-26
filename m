Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B57AEA3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjIZKWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 06:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIZKWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:22:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD7B3;
        Tue, 26 Sep 2023 03:21:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3E0C433CA;
        Tue, 26 Sep 2023 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695723717;
        bh=qvZpB1dUa1GvX0J4/Ie56RzBn0dFYJRP141sFX3VSFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7IRT5eBKAHRA5cdoVlHZ6ATr3SeWFhee08fJzKGLCWXR1BuRBv2mymaS8hQmJ4Bg
         RDIhsST4QyiyWAcRW/+Ni2/Ci6imxhv1s+Sk+R9IfkL4iNwdrN8paNg0J6iIp5EEhq
         A+r/iUuK8dck6FzmqA6UPyL6nTrlZDh1RWCBZS8LKCcVrcJFHsxbPBU0QCi1Yq7kfS
         Zk7YV5aL8hE7m0M7SaQyXtSn5pHKS1CBV5vqj4vUnDBdYQ1jWK1mYY4mSG5NwSBLo1
         RlW4bEGWHjJS3aFTxzIENKZSv3VTcn4kFW4AZPXNZW8lR/LGEGOGlWBGtU/b83t+S4
         el5gQNYVcRezg==
Date:   Tue, 26 Sep 2023 12:21:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/splice: don't block splice_direct_to_actor() after
 data was read
Message-ID: <20230926-achtlos-ungeschehen-ee0e5f2c7666@brauner>
References: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
 <20230926063609.2451260-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926063609.2451260-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +		/*
> +		 * After at least one byte was read from the input
> +		 * file, don't wait for blocking I/O in the following
> +		 * loop iterations; instead of blocking for arbitrary
> +		 * amounts of time in the kernel, let userspace decide
> +		 * how to proceed.  This avoids excessive latency if
> +		 * the output is being consumed faster than the input
> +		 * file can fill it (e.g. sendfile() from a slow hard
> +		 * disk to a fast network).
> +		 */
> +		flags |= SPLICE_F_NOWAIT;
> +

Hm, so the thing that is worrysome about this change is that this may
cause regressions afaict as this is a pretty significant change from
current behavior.
