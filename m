Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A793267A489
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 22:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjAXVEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 16:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAXVEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:04:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F4E05D;
        Tue, 24 Jan 2023 13:04:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B6D1B816D8;
        Tue, 24 Jan 2023 21:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31C3C433D2;
        Tue, 24 Jan 2023 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674594242;
        bh=zjcANJE6uGzwSR4wTIiOQxcwFMp4+Yz5YqNXXhvxlZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FqySnI4K96d799gpZOFbX42GtEloF+F2Qd7fEzmx0GhoOLzs+V1i9DTlrU1UKd/02
         Hjuu/ELjUesERXd5b+wWuorsVm2xPmIA5wtRHvl+GZny+5oN8q9FGbJBg2h57TomCz
         uzDtXADYIc0ipLpnAPanocU0tIlVbA416ABzGw/Y=
Date:   Tue, 24 Jan 2023 13:04:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 4/5] fs: hfs: initialize fsdata in hfs_file_truncate()
Message-Id: <20230124130401.eb5d453213d557cf3b7a8ed6@linux-foundation.org>
In-Reply-To: <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
References: <20221121112134.407362-1-glider@google.com>
        <20221121112134.407362-4-glider@google.com>
        <CAG_fn=WDjw1MVYhEh7K4HOpGNBWsq6YuyG6Xx7XcP4Xpu+KhZg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 24 Jan 2023 11:51:30 +0100 Alexander Potapenko <glider@google.com> wrote:

> On Mon, Nov 21, 2022 at 12:21 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > When aops->write_begin() does not initialize fsdata, KMSAN may report
> > an error passing the latter to aops->write_end().
> >
> > Fix this by unconditionally initializing fsdata.
> >
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> 
> Dear FS maintainers,
> 
> HFS/HFSPLUS are orphaned, can someone take this patch to their tree?
> Thanks in advance!
> (same for "fs: hfsplus: initialize fsdata in hfsplus_file_truncate()":
> https://lore.kernel.org/all/20221121112134.407362-5-glider@google.com/)

I grabbed both.

I removed the

	Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

because that might provoke the backport bots to backport this fix
across eight years worth of kernels.  Before KMSAN existed!

If you intended that this be backported then please let's come up with a
more precise Fixes: target and we'll add cc:stable.

