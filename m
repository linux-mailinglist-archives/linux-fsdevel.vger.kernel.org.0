Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433735FEE53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJNNDh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 09:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiJNNDg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:03:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A11C8D7E;
        Fri, 14 Oct 2022 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e74pYK7vLx6IlOPOPqh+gX/TxdxGdVFG28XXhBE8NKE=; b=XpaTghU4uz+r5xaUJJ/HBrjwdn
        8IGOQXKHEe8ekuSVqZj+ZNdqGxMX7X2bSP4s4BtJ1OEgegaqQ4WrFUDaB90deADiF420PrzXb2M0i
        8VTihJGTS1JRRRozSG9yevwcSrbvR0b4u7KcT3XSy+IzpMEIaVY8OBN4V4IhX0kEefs8oArnQ4/7s
        r0PMwWigDabkFAZRaeGjXL7Lw3YGXovPTv008a1H6Huw3GAOi9QesgVunlX7sh/vcAnHLcX+4G4Ni
        YIXvQ2LCgtGaN79MdvouF/uZJBebCMIW+4vphrYMXp/ho1VHku3rz7bxeH4IJfe/bkKVzn6SX/lxu
        384EcPBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojKLe-007dNb-Ln; Fri, 14 Oct 2022 13:03:34 +0000
Date:   Fri, 14 Oct 2022 14:03:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: mkutf8data: Add malloc return value detection
Message-ID: <Y0leJgPmNrqeZP37@casper.infradead.org>
References: <20221014075710.310943-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014075710.310943-1-zeming@nfschina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 14, 2022 at 03:57:10PM +0800, Li zeming wrote:
> Add the check and judgment statement of malloc return value.

Why?  Just to shut up some static checker?

> +++ b/fs/unicode/mkutf8data.c
> @@ -495,6 +495,9 @@ static struct node *alloc_node(struct node *parent)
>  	int bitnum;
>  
>  	node = malloc(sizeof(*node));
> +	if (unlikely(!node))
> +		return NULL;
> +

Right, so now alloc_node() can return NULL when it couldn't before.
Look at the callers ...

        while (keybits) {
                if (!*cursor)
                        *cursor = alloc_node(node);
                node = *cursor;
                if (node->nextbyte)
                        key++;

They're unprepared for alloc_node() to return NULL, so all you've done
is move the crash.
