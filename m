Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820767AEF00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbjIZOCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbjIZOCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:02:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B5120;
        Tue, 26 Sep 2023 07:01:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BC7C433C7;
        Tue, 26 Sep 2023 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695736914;
        bh=svPGZCzPrSPMIeqadaHU756x3Z6kwGm0cfJhav3gYAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GqmITccg9BeZvQhB71nuMArmjEXMuGP5dgFXPWuMYMSfUA/wSBwx/848wK+iWMiyB
         Uqx+EqeRr5dxO2Xp0XWuQR1+a+mkWGcvpE6Sq8xBSRZoxHXpad0+fZKS6LclgoajzT
         NmKDzaWNL+bwoJ/nJbpexqeqAoAsjTmrLkgUSFmcd+/WiLgRVimKdd8+Ig6VYS8dX7
         D/yvK4x4N1ZXDDhVBLqYxUKmo6ZcVteMZxQK9ywjlVeTNqL4pgUJh1sfGOTXXtFAZy
         sain2+iY/KMKdIxmJ5PAr4qrFa5M216efSqu7dWDRi/53I/5b7NfJ7txBYGweWpDly
         XvRPj2nows71g==
Date:   Tue, 26 Sep 2023 16:01:50 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] vfs: shave work on failed file open
Message-ID: <20230926-anforderungen-obgleich-47e465f0bd47@brauner>
References: <20230925205545.4135472-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925205545.4135472-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +void fput_badopen(struct file *file)
> +{
> +	if (unlikely(file->f_mode & (FMODE_BACKING | FMODE_OPENED))) {
> +		fput(file);
> +		return;
> +	}
> +
> +	if (WARN_ON(atomic_long_read(&file->f_count) != 1)) {
> +		fput(file);
> +		return;
> +	}
> +
> +	/* zero out the ref count to appease possible asserts */
> +	atomic_long_set(&file->f_count, 0);

Afaict this could just be:

if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {

> +	file_free_badopen(file);
> +}
> +EXPORT_SYMBOL(fput_badopen);

Should definitely not be exported and only be available to core vfs
code. So this should go into fs/internal.h.
