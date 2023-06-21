Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD07386DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjFUOZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbjFUOZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D019A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 07:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E5661583
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 14:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD46C433C8;
        Wed, 21 Jun 2023 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687357527;
        bh=BfGOe0I45lsErg16RimlJAbgW4jm5+Y1Xz63I2aqDqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fb5r7W7q0ZzTe66WABaggV+h8k0/UzesLssQsnKE4P06R3IjJ4c0Z9xTLfyHJ6Kb1
         szHA+bf/duIGs+gr7nWklvg2pylghybWlG5nkh+lLc68emPJ5xq3MTUiDaJ1y+MhRz
         UaEBHoSPaGIZ7nEg2/pDSi32GyW8EsvBr6MTEx7p/IoJMagwFsSafNywRaepqpYNgz
         Ib1evAdB5VGFVb3olKBf1XqFRn8ChzQO5E8m1rLYQUVrMmwPKoOxjPj+7uWOCsPSlo
         r+9/KuOAiuM36VKKyyOl+5YisG/M6GMhWyuNUSEc7fh6O3vGC3D7Zz2BGcbwcaNvNB
         NraL0Dc1+r5Wg==
Date:   Wed, 21 Jun 2023 16:25:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] shmemfs stable directory offsets
Message-ID: <20230621-zerquetschen-dannen-fb40bfa6d610@brauner>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
 <B3ADB232-DA75-45E9-9F7B-CB7BF524F713@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B3ADB232-DA75-45E9-9F7B-CB7BF524F713@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:46PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jun 6, 2023, at 9:10 AM, Chuck Lever <cel@kernel.org> wrote:
> > 
> > The following series is for continued discussion of the need for
> > and implementation of stable directory offsets for shmemfs/tmpfs.
> > 
> > As discussed in Vancouver, I've re-implemented this change in libfs
> > so that other "simple" filesystems can use it. There were a few
> > other suggestions made during that event that I haven't tried yet.
> > 
> > Changes since v2:
> > - Move bulk of stable offset support into fs/libfs.c
> > - Replace xa_find_after with xas_find_next for efficiency
> > 
> > Changes since v1:
> > - Break the single patch up into a series
> > 
> > Changes since RFC:
> > - Destroy xarray in shmem_destroy_inode() instead of free_in_core_inode()
> > - A few cosmetic updates
> > 
> > ---
> > 
> > Chuck Lever (3):
> >      libfs: Add directory operations for stable offsets
> >      shmem: Refactor shmem_symlink()
> >      shmem: stable directory offsets
> > 
> > 
> > fs/dcache.c            |   1 +
> > fs/libfs.c             | 185 +++++++++++++++++++++++++++++++++++++++++
> > include/linux/dcache.h |   1 +
> > include/linux/fs.h     |   9 ++
> > mm/shmem.c             |  58 +++++++++----
> > 5 files changed, 240 insertions(+), 14 deletions(-)
> 
> The good news is that so far I have received no complaints from bots
> on this series.
> 
> The bad news is I have received no human comments. Ping?

I haven't gotten around to reviewing this yet but it is still on my
radar. We should plan to get this done for v6.6. I'll aim to review
during the merge window. Sorry for the delay.
