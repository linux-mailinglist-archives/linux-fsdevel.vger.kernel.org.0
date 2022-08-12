Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C7591128
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 15:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbiHLNFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiHLNFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 09:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680C313DE4;
        Fri, 12 Aug 2022 06:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BADE2B82439;
        Fri, 12 Aug 2022 13:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA37C433D6;
        Fri, 12 Aug 2022 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660309536;
        bh=A4D5OlKvoyMZOZL3cDr4fPPfzHJ3OS1QT1dYmR3eHzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLFoaBZhss+j7UvZzpPfuCrQ3dC7njIBJlze1hgb2H+NpuIiwkSBJ1f74Vom+2Qzb
         JgPoPk8t05yt+QE1PbUsTxDob3o9wiJxifNMndukHwJLVy6YPKG3H9T4RlGgky5CBW
         I2ksi5xqClTzFHj4EfugUING6C7P3DXCBuRRqEb3HZrMfdBjiXSmbs2b2KTdehlsBD
         oCmWXP7FICIxK33GpbMHwCG6ieQBKZDYeDOfubBda7EH+fO0raQ5sz1reqwEYOG+hO
         7gWQ+SmY1+Yg3/D0QP4BM8m2kDVKzlgVPwSCuRP80pTamKZC+91skFKFnKOUAaDtap
         hXax3yAC5iBuA==
Date:   Fri, 12 Aug 2022 15:05:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jlayton@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org,
        david@fromorbit.com, Benjamin Coddington <bcodding@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v4 3/3] ext4: unconditionally enable the i_version counter
Message-ID: <20220812130530.fb4qooayy67ppan4@wittgenstein>
References: <20220812123727.46397-1-lczerner@redhat.com>
 <20220812123727.46397-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220812123727.46397-3-lczerner@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 02:37:27PM +0200, Lukas Czerner wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> The original i_version implementation was pretty expensive, requiring a
> log flush on every change. Because of this, it was gated behind a mount
> option (implemented via the MS_I_VERSION mountoption flag).
> 
> Commit ae5e165d855d (fs: new API for handling inode->i_version) made the
> i_version flag much less expensive, so there is no longer a performance
> penalty from enabling it. xfs and btrfs already enable it
> unconditionally when the on-disk format can support it.
> 
> Have ext4 ignore the SB_I_VERSION flag, and just enable it
> unconditionally. While we're in here, remove the handling of
> Opt_i_version as well, since we're almost to 5.20 anyway.
> 
> Ideally, we'd couple this change with a way to disable the i_version
> counter (just in case), but the way the iversion mount option was
> implemented makes that difficult to do. We'd need to add a new mount
> option altogether or do something with tune2fs. That's probably best
> left to later patches if it turns out to be needed.
> 
> [ Removed leftover bits of i_version from ext4_apply_options() since it
> now can't ever be set in ctx->mask_s_flags -- lczerner ]
> 
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Benjamin Coddington <bcodding@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---

Since ext4 seems to ignore unknown mount options in ext4_parse_param()
removing seems good,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
