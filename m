Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC29717D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjEaKt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjEaKtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B9125;
        Wed, 31 May 2023 03:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5924E62F5E;
        Wed, 31 May 2023 10:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38BEC433D2;
        Wed, 31 May 2023 10:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685530180;
        bh=lVRDlljIusYtHqx2sPZQ+2Cw41zWVjXdIT83etnx7V4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cxz04lOcwCUr1fIb2WDXimONDnalvdJfFvEUNZQ0QLv/7KiptWI2SoE64QrOUXdkz
         6g450Y9qpiBwGPiR5+1SxfwkMLAYSuAcSKk8YUKTfXW8NHtvepLSWP0XCJz6iTeXy/
         lUepRzRCzFXkZx7o6z725cqbf4I06nCaevZnRiTCobnxR3I7JoRvGxmsxHCXFt2DHY
         2nf5jJDLT7tTXLPHxtrH7RZdQ5Zak3nkxwG2siwodjinZAsrdYvYHjgBYnpQF6fxAE
         +uBDNRBrZB1r7wCKbE9lBQLIJ6qFe112oHymffplbpVSnzB7KGI2CJO1Ro8azcEBzz
         rI3ASxrMLbn0Q==
Date:   Wed, 31 May 2023 12:49:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 1/8] mm: vmscan: move shrinker_debugfs_remove() before
 synchronize_srcu()
Message-ID: <20230531-notlage-ankommen-93022623b74b@brauner>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-2-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-2-qi.zheng@linux.dev>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:35AM +0000, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The debugfs_remove_recursive() will wait for debugfs_file_put()
> to return, so there is no need to put it after synchronize_srcu()
> to wait for the rcu read-side critical section to exit.
> 
> Just move it before synchronize_srcu(), which is also convenient
> to put the heavy synchronize_srcu() in the delayed work later.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Afaict, should be a patch independent of this series.
