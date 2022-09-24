Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB95E8FDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Sep 2022 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiIXVle convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Sep 2022 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIXVle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Sep 2022 17:41:34 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B64F45982;
        Sat, 24 Sep 2022 14:41:31 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id AD6B21C5C3A;
        Sat, 24 Sep 2022 21:41:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id A97AA6000A;
        Sat, 24 Sep 2022 21:41:27 +0000 (UTC)
Message-ID: <4501be92173de178fe0a4207bbe9b5794dde2ef4.camel@perches.com>
Subject: Re: [PATCH] virtio_fs.c: add check kmalloc return
From:   Joe Perches <joe@perches.com>
To:     liujing <liujing@cmss.chinamobile.com>, vgoyal@redhat.com
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 24 Sep 2022 14:41:26 -0700
In-Reply-To: <20220924141728.3343-1-liujing@cmss.chinamobile.com>
References: <20220924141728.3343-1-liujing@cmss.chinamobile.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: A97AA6000A
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: i9x4t7rfwx3o3eh7rwdk4hhjbakyp31p
X-Rspamd-Server: rspamout05
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+OMW+9Os61D9KqHecZ0xpvLQTaOdFP+zw=
X-HE-Tag: 1664055687-37209
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-09-24 at 10:17 -0400, liujing wrote:
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Generally it's better to have a commit message

> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
[]
> @@ -989,6 +989,10 @@ __releases(fiq->lock)
>  
>  	/* Allocate a buffer for the request */
>  	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
> +

A blank line is not typically used here.

> +	if (forget == NULL)
> +		return -ENOMEM;

And this is unnecessary as __GFP_NOFAIL will do what it says.

include/linux/gfp_types.h:

 * %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures. The allocation could block
 * indefinitely but will never return with failure. Testing for
 * failure is pointless.

