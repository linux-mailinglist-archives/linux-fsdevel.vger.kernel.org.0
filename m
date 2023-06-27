Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6501D73F0DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 04:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjF0Cdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 22:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjF0Cdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:33:44 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADEC5
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 19:33:43 -0700 (PDT)
Date:   Mon, 26 Jun 2023 22:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687833221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38qafIfwmej2yIV1ZeFe4J/KUFbio8gHNCs5CXunBVc=;
        b=NSs/CdCJGB5SpYsfV+H44QeRwHi2yIisRly7GRzJvDcW+4keYpPOHE3G2O1i7rl0EJuUQL
        oePr6bXLyCH7dcUbPXg6L8qFk+3grgsfdQMHGp7MeJf0SupJHlB6zVKEBS4hScZRtthnWq
        NzLTaicV8FLEbJR5v/Iri4EFKI7kM/k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627023337.dordpfdxaad56hdn@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> fs/bcachefs/alloc_background.c: In function ‘bch2_check_alloc_info’:
> fs/bcachefs/alloc_background.c:1526:1: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>  1526 | }
>       | ^
> fs/bcachefs/reflink.c: In function ‘bch2_remap_range’:
> fs/bcachefs/reflink.c:388:1: warning: the frame size of 2352 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>   388 | }
>       | ^

What version of gcc are you using? I'm not seeing either of those
warnings - I'm wondering if gcc recently got better about stack usage
when inlining.

also not seeing any reason why bch2_remap_range's stack frame should be
that big, to my eye it looks like it should be more like 1k, so if
anyone knows some magic for seeing stack frame layout that would be
handy...

anyways, there's a patch in my testing branch that should fix
bch2_check_alloc_info
