Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB171792C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjEaH4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjEaH4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:56:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6217013E;
        Wed, 31 May 2023 00:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D976358E;
        Wed, 31 May 2023 07:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD816C433D2;
        Wed, 31 May 2023 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685519702;
        bh=oQMKNQRLgA4ZCsezODjVAhD2XTTy3QKxeBK/2FUHClA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMTHL3iGQTevlNsUjFG/8KGtglQhrdKh6TRlgrmvzMOHQPY9mKf0JOG/zVfvv7+9Q
         jVbAkp4UynX6IRnhAiDmkFsb1fuQGoBlE7jJyxPfK5PBXdUCnrL3i5uQy4tQ5fKXuu
         byQ8n/xuaf3R1YT0SdxbARajYAP0DCGDx5BvPuCB/e6ZeQuBnHVD+YChxLpDYyXB3D
         2IMMOUSiVENkZLvH+88IqnkLH9/rneFOeIumHYMl8WQK6lGb0Ii2GF3hLmMWNhH2Da
         fyT1iRADU425l5/Je1TouTGgF74IWW1SVYLBkxWT/yRBNjbRCyzZp/BaIUeOtCXay9
         GqpqUHz5UVXFw==
Date:   Wed, 31 May 2023 09:54:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     chenzhiyin <zhiyin.chen@intel.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nanhai.zou@intel.com
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner>
References: <20230530020626.186192-1-zhiyin.chen@intel.com>
 <20230530-wortbruch-extra-88399a74392e@brauner>
 <20230531015549.GA1648@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531015549.GA1648@quark.localdomain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 06:55:49PM -0700, Eric Biggers wrote:
> On Tue, May 30, 2023 at 10:50:42AM +0200, Christian Brauner wrote:
> > On Mon, May 29, 2023 at 10:06:26PM -0400, chenzhiyin wrote:
> > > In the syscall test of UnixBench, performance regression occurred
> > > due to false sharing.
> > > 
> > > The lock and atomic members, including file::f_lock, file::f_count
> > > and file::f_pos_lock are highly contended and frequently updated
> > > in the high-concurrency test scenarios. perf c2c indentified one
> > > affected read access, file::f_op.
> > > To prevent false sharing, the layout of file struct is changed as
> > > following
> > > (A) f_lock, f_count and f_pos_lock are put together to share the
> > > same cache line.
> > > (B) The read mostly members, including f_path, f_inode, f_op are
> > > put into a separate cache line.
> > > (C) f_mode is put together with f_count, since they are used
> > > frequently at the same time.
> > > 
> > > The optimization has been validated in the syscall test of
> > > UnixBench. performance gain is 30~50%, when the number of parallel
> > > jobs is 16.
> > > 
> > > Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> > > ---
> > 
> > Sounds interesting, but can we see the actual numbers, please? 
> > So struct file is marked with __randomize_layout which seems to make
> > this whole reordering pointless or at least only useful if the
> > structure randomization Kconfig is turned off. Is there any precedence
> > to optimizing structures that are marked as randomizable?
> 
> Most people don't use CONFIG_RANDSTRUCT.  So it's still worth optimizing struct
> layouts for everyone else.

Ok, good to know.
We should still see actual numbers and the commit message should mention
that this interacts with __randomize_layout and why it's still useful.
