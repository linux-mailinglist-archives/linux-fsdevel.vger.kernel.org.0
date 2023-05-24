Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53D070F13D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjEXIm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 04:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbjEXImf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 04:42:35 -0400
Received: from out-50.mta1.migadu.com (out-50.mta1.migadu.com [IPv6:2001:41d0:203:375::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971471AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 01:42:03 -0700 (PDT)
Date:   Wed, 24 May 2023 04:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684917722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NfeE66MsVipD0d/K4/FqZuOlVvQxWiCOF8XwvhL/c+o=;
        b=Bkd7MJoVVH/6uAc1V9EL/nWfsvHGFZoQhShKvhukMALDO/54FWL8DAFlKiR8n+zTvKJ/YS
        uNPxnyEY+KuxgXEYsYezoZofXtkxcUc4cUk0luygoeHvznElXOlSLzbsyiCEp709ySM/uU
        xGaC4P3320A8hFHJvvom4MCHtC42q3I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 20/32] vfs: factor out inode hash head
 calculation
Message-ID: <ZG3N10ytvE1D91XU@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-21-kent.overstreet@linux.dev>
 <20230523-plakat-kleeblatt-007077ebabb6@brauner>
 <ZG1D4gvpkFjZVMcL@dread.disaster.area>
 <ZG2yM1vzHZkW0yIA@infradead.org>
 <ZG2+Jl8X1i5zGdMK@dread.disaster.area>
 <20230524-zumeist-fotomodell-8b772735323d@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524-zumeist-fotomodell-8b772735323d@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 10:31:14AM +0200, Christian Brauner wrote:
> I'm here to help get more review done and pick stuff up. I won't be able
> to do it without additional reviewers such as Christoph helping of
> course as this isn't a one-man show.
> 
> Let's see if we can get this reviewed. If you have the bandwith to send
> it to fsdevel that'd be great. If it takes you a while to get back to it
> then that's fine too.

These patches really should have my reviewed-by on them already, I
stared at them quite a bit (and fs/inode.c in general) awhile back.

(I was attempting to convert fs/inode.c to an rhashtable up until I
realized the inode lifetime rules are completely insane, so when I saw
Dave's much simpler approach I was _more_ than happy to not have to
contemplate that mess anymore...)
