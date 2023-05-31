Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB881717DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbjEaLTT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjEaLTR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2256E8;
        Wed, 31 May 2023 04:19:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692D6639C9;
        Wed, 31 May 2023 11:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB99C433D2;
        Wed, 31 May 2023 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685531952;
        bh=ToTeTlz4GT6G/6GQm6hNhi8FfFWRCLrQ1yYMfpbTM4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFY0evFGICDbhQkArkviVHB8hFnqWVMegKHud8QMC5hTp9trN9fhJ2OEMSEyjCDUE
         MZJE9ni1WZx3nVs3fNlK2xhNVvhyz34ueS7t97dbQyFFEzS87yOKZKA2J1TrEXOGOG
         9CTm5n9RP35bzmNyqoXIXe13lnpnRMEu+StQWwnsSif5FOiPrA+I0SHACcUcpZLsU5
         IqmK4QWsZVkTdlWV4qCzx5nXGK/KUzHJARBIJXnZ+/q0utZuE43qgxGmbs7m2MwjGd
         UUBLpOv0LylTp0ZqbcQzIb/CAjfL9Os5RfBs6SknTYB7qvv3yi0PlnEgYE56B/eYkv
         pfsMGgzd6eatw==
Date:   Wed, 31 May 2023 13:19:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] fs: introduce struct
 super_operations::destroy_super() callback
Message-ID: <20230531-pikiert-jobaussicht-87bbd3da0de5@brauner>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-6-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-6-qi.zheng@linux.dev>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:39AM +0000, Qi Zheng wrote:
> From: Kirill Tkhai <tkhai@ya.ru>
> 
> The patch introduces a new callback, which will be called
> asynchronous from delayed work.
> 
> This will allows to make ::nr_cached_objects() safe
> to be called on destroying superblock in next patches,
> and to split unregister_shrinker() into two primitives.
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/super.c         | 3 +++
>  include/linux/fs.h | 1 +
>  2 files changed, 4 insertions(+)

Misses updates to
Documentation/filesystems/locking.rst
Documentation/filesystems/vfs.rst
