Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037E05B28E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 00:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiIHWBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 18:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiIHWBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:01:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DF4F19C;
        Thu,  8 Sep 2022 14:59:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C31EAB8227A;
        Thu,  8 Sep 2022 21:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36330C433C1;
        Thu,  8 Sep 2022 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662674375;
        bh=/HOVvpz+sJygGAhZ94LvkuF6jNiDecR818x1rR3XGzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ziAXRAK+Fi/bF9GMSVOP8poDDRgu67p7SOqUL7S9oGMHlwKx0zxVlVdB8UA+WisKa
         kVFuoKWv+MAHa7Gro/kRQvgnbUEANZgF1WejcJK3cn6vMbF6n3LfYsYdia18BEgeWe
         Yo6hZcES7ugfEegxDzx414/7Ac7vOq9LtXH0mVvY=
Date:   Thu, 8 Sep 2022 14:59:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     <kernel@axis.com>, <adobriyan@gmail.com>, <vbabka@suse.cz>,
        <dancol@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc: Enable smaps_rollup without ptrace rights
Message-Id: <20220908145934.4565620db7cbc3b9ceb90e3b@linux-foundation.org>
In-Reply-To: <20220908093919.843346-1-vincent.whitchurch@axis.com>
References: <20220908093919.843346-1-vincent.whitchurch@axis.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 8 Sep 2022 11:39:19 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> smaps_rollup is currently only allowed on processes which the user has
> ptrace permissions for, since it uses a common proc open function used
> by other files like mem and smaps.
> 
> However, while smaps provides detailed, individual information about
> each memory map in the process (justifying its ptrace rights
> requirement), smaps_rollup only provides a summary of the memory usage,
> which is not unlike the information available from other places like the
> status and statm files, which do not need ptrace permissions.
> 
> The first line of smaps_rollup could however be sensitive, since it
> exposes the randomized start and end of the process' address space.
> This information however does not seem essential to smap_rollup's
> purpose and could be replaced with placeholder values to preserve the
> format without leaking information.  (I could not find any user space in
> Debian or Android which uses the information in the first line.)
> 
> Replace the start with 0 and end with ~0 and allow smaps_rollup to be
> opened and read regardless of ptrace permissions.

What is the motivation for this?  Use case?  End-user value and such?
