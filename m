Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A869728C68
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 02:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbjFIA11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjFIA10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284DD2134;
        Thu,  8 Jun 2023 17:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCE565253;
        Fri,  9 Jun 2023 00:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D51DC433D2;
        Fri,  9 Jun 2023 00:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686270444;
        bh=SIg2qSZ9l+pY1OkA6HENpenV0b7K5waTnRvy/sKwjlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qovGY+0h9kLFkv8QAsPqRiqvTog85N6Irziw8/5DXTE+XQCqe2huwuR906/zl7a/x
         Ho4FNOd10FP9DQauKymXsDz+ZhYXwSlGn5zAh+4ePggbfsi6GAzK1/KNUuA5lu+mB5
         pWOAXh7/CxArWsHYtqr/+ee3eOzQjML/D1WpI3fQ=
Date:   Thu, 8 Jun 2023 17:27:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kirill Tkhai <tkhai@ya.ru>, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        hughd@google.com, paulmck@kernel.org, muchun.song@linux.dev,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-Id: <20230608172722.d32733db433d385daa6c11a0@linux-foundation.org>
In-Reply-To: <ZIJhou1d55d4H1s0@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
        <168599180526.70911.14606767590861123431.stgit@pro.pro>
        <ZH6AA72wOd4HKTKE@P9FQF9L96D>
        <ZH6K0McWBeCjaf16@dread.disaster.area>
        <20230608163622.GA1435580@mit.edu>
        <ZIJhou1d55d4H1s0@dread.disaster.area>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 9 Jun 2023 09:17:54 +1000 Dave Chinner <david@fromorbit.com> wrote:

> > Given that we're at -rc5 now, and the file system folks didn't get
> > consulted until fairly late in the progress, and the fact that this
> > may cause use-after-free problems that could lead to security issues,
> > perhaps we shoould consider reverting the SRCU changeover now, and try
> > again for the next merge window?
> 
> Yes, please, because I think we can fix this in a much better way
> and make things a whole lot simpler at the same time.

Qi Zheng, if agreeable could you please prepare and send reverts of
475733dda5a ("mm: vmscan: add shrinker_srcu_generation") and of
f95bdb700bc6bb74 ("mm: vmscan: make global slab shrink lockless")?

Thanks.
