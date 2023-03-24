Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8155F6C8615
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 20:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCXTmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 15:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCXTms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:42:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694F10C1;
        Fri, 24 Mar 2023 12:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73A28CE2755;
        Fri, 24 Mar 2023 19:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E167C4339C;
        Fri, 24 Mar 2023 19:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679686963;
        bh=cYdRTxR8dBazRdwhag620V6/LFVedTccg5+7XaXE0kY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ib/FgiIS5aIqzpEeYu3XpS3DTvGgv+D6xhqtJZadm/yN17y/6mRo7JEWo7osftdEo
         by/OZtPRrnfTEfw8rTVR0sA70oEyd12C8yHEZY84tQgmSMREklqyTerS4rHv+m6sia
         GLQXwjJ9lEylE+9CNvyNJ/7c9Cel2PhVIvUjjJ50=
Date:   Fri, 24 Mar 2023 12:42:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <djwong@kernel.org>
Subject: Re: [PATCH] fsdax: force clear dirty mark if CoW
Message-Id: <20230324124242.c881cf384ab8a37716850413@linux-foundation.org>
In-Reply-To: <1679653680-2-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679653680-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 24 Mar 2023 10:28:00 +0000 Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

> XFS allows CoW on non-shared extents to combat fragmentation[1].  The
> old non-shared extent could be mwrited before, its dax entry is marked
> dirty.  To be able to delete this entry, clear its dirty mark before
> invalidate_inode_pages2_range().

What are the user-visible runtime effects of this flaw?

Are we able to identify a Fixes: target for this?  Perhaps
f80e1668888f3 ("fsdax: invalidate pages when CoW")?
