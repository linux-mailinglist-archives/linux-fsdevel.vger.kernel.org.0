Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED74550E556
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbiDYQQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbiDYQQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D25119ECB;
        Mon, 25 Apr 2022 09:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C8EC612F2;
        Mon, 25 Apr 2022 16:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F7C385A7;
        Mon, 25 Apr 2022 16:13:49 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 0/3] Avoid live-lock in btrfs fault-in+uaccess loop
Date:   Mon, 25 Apr 2022 17:13:47 +0100
Message-Id: <165090314404.2743611.7102822933741144292.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423100751.1870771-1-catalin.marinas@arm.com>
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 23 Apr 2022 11:07:48 +0100, Catalin Marinas wrote:
> A minor update from v3 here:
> 
> https://lore.kernel.org/r/20220406180922.1522433-1-catalin.marinas@arm.com
> 
> In patch 3/3 I dropped the 'len' local variable, so the btrfs patch
> simply replaces fault_in_writeable() with fault_in_subpage_writeable()
> and adds a comment. I kept David's ack as there's no functional change
> since v3.
> 
> [...]

Applied to arm64 (for-next/fault-in-subpage). Also changed the
probe_subpage_writeable() prototype to use char __user * instead of void
__user * (as per Andrew's suggestion).

[1/3] mm: Add fault_in_subpage_writeable() to probe at sub-page granularity
      https://git.kernel.org/arm64/c/da32b5817253
[2/3] arm64: Add support for user sub-page fault probing
      https://git.kernel.org/arm64/c/f3ba50a7a100
[3/3] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
      https://git.kernel.org/arm64/c/18788e34642e

-- 
Catalin

