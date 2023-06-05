Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334C723232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 23:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFEV0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 17:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjFEV0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:26:50 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BB100
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 14:26:49 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686000408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wnph7+oPyMmNyxdAR2lSsW9n2332H95DQGe3lGJ+RnM=;
        b=wwd5yLEgvSH4d+5xWJ6tolwo006zpdwkSJPNKLhPDVlmDucLbB43zlTx4L3qDNrxG2EuXQ
        3uiAAV5lhacpa4y7Tu1zknaaEHIixORHvG/LZeJ0X89Q+f3vXAM6MfzR01MFNjROJmYhzI
        3jTaKKS6JK/JJk/69GvKgK3Oow939nU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] block layer patches for bcachefs
Message-ID: <ZH5TFBy5j1eUxg00@moria.home.lan>
References: <20230525214822.2725616-1-kent.overstreet@linux.dev>
 <ee03b7ce-8257-17f9-f83e-bea2c64aff16@kernel.dk>
 <ZHEaKQH22Uxk9jPK@moria.home.lan>
 <8e874109-db4a-82e3-4020-0596eeabbadf@kernel.dk>
 <ZHYfGvPJFONm58dA@moria.home.lan>
 <2a56b6d4-5f24-9738-ec83-cefb20998c8c@kernel.dk>
 <ZH0gjyuBgYzqhZh7@moria.home.lan>
 <b1b43d30-8c7c-1a71-0ead-8b967b8af0a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b43d30-8c7c-1a71-0ead-8b967b8af0a4@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:49:37AM -0600, Jens Axboe wrote:
> On 6/4/23 5:38?PM, Kent Overstreet wrote:
> > On Tue, May 30, 2023 at 10:50:55AM -0600, Jens Axboe wrote:
> >> Sorry typo, I meant text. Just checked stack and it looks identical, but
> >> things like blk-map grows ~6% more text, and bio ~3%. Didn't check all
> >> of them, but at least those two are consistent across x86-64 and
> >> aarch64. Ditto on the data front. Need to take a closer look at where
> >> exactly that is coming from, and what that looks like.
> > 
> > A good chunk of that is because I added warnings and assertions for
> > e.g. running past the end of the bvec array. These bugs are rare and
> > shouldn't happen with normal iterator usage (e.g. the bio_for_each_*
> > macros), but I'd like to keep them as a debug mode thing.
> > 
> > But we don't yet have CONFIG_BLOCK_DEBUG - perhaps we should.
> 
> Let's split those out then, especially as we don't have a BLOCK_DEBUG
> option right now.

Already did that; there's a patch in the branch that adds
CONFIG_BLK_DEBUG with the new assertions.

> Cn you resend just the iterator changes in their current form? The
> various re-exports are a separate discussion, I think we should focus on
> the iterator bits first.

They're up in that branch with the iterator changes first now; I'll mail
them out too.
