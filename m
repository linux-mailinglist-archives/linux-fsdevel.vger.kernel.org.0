Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CD72340E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 02:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjFFAcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 20:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjFFAcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:32:07 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A13A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 17:32:06 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:31:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686011522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFxQoxys/4W09oOn79IrUnlR3rRwAPSSelAzub4DB3w=;
        b=GYrJ2HdSX3TJoTTxPDFkm2BYLmg+7hl/gvwOi01e4oASj1BbnqDK7qwyHcvL6fJ/DORzXc
        eFEH9oIjheaYl2N4nSF6/5HcGLZd1A0fCZQFeeh3w+9qe2j/ZdHFiq8CiAqMdCrXPTFYV6
        wr5AogFPjClIdSqmxJBsaSWiXGHZKRo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kirill Tkhai <tkhai@ya.ru>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, viro@zeniv.linux.org.uk,
        brauner@kernel.org, djwong@kernel.org, hughd@google.com,
        paulmck@kernel.org, muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com,
        david@fromorbit.com
Subject: Re: [PATCH v2 1/3] mm: vmscan: move shrinker_debugfs_remove() before
 synchronize_srcu()
Message-ID: <ZH5+fHJj8UypQfIt@P9FQF9L96D>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599178203.70911.18350742045278218790.stgit@pro.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168599178203.70911.18350742045278218790.stgit@pro.pro>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:03:02PM +0300, Kirill Tkhai wrote:
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

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
