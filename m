Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5B613906
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiJaOdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiJaOdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A3FD2A
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 07:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05F9AB816CE
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 14:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF6C433D6;
        Mon, 31 Oct 2022 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667226778;
        bh=6hqU3Z7l19qje3J1WT9Tdn9PvDSEd2ATNx1FlvaNtWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSz95+RQX1T/MSjlbxcxJjV2BxOPrXYrGfZtFcD/wL2R+HhMgdDg6/l3GWqQvmncV
         bSqYRtL/23kdRJAAD8/Xf7cpaxlqzzjAZNTDMhDRKE7Ku46HUgx0n7HA8O+yjygtfy
         xQPgBKMpo4XagX7gXK+AFLxaFCgt9np404bt0KMQSVswEy9x8G5C7L6kfCekU0Ijdj
         d2RNu6Bo4rTdVpTPqvPyOXdUyYZUS7/KUFQpNRQF0hEaoP4quvUsp2w6BBjgVEkqMb
         R3Vs/53QQy8j++IC51lJFQaZoYM+iCCudiDx/Dj8C4QnT2AceFeYknyPqF+tfzTdbU
         98IZdiVLKkq8w==
Date:   Mon, 31 Oct 2022 09:32:57 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] fs: introduce dedicated idmap type for mounts
Message-ID: <Y1/cmf3/u4jzFMwX@do-x1extreme>
References: <20221028111041.448001-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028111041.448001-1-brauner@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:10:41PM +0200, Christian Brauner wrote:
> Last cycle we've already made the interaction with idmapped mounts more
> robust and type safe by introducing the vfs{g,u}id_t type. This cycle we
> concluded the conversion and removed the legacy helpers.
> 
> Currently we still pass around the plain namespace that was attached to
> a mount. This is in general pretty convenient but it makes it easy to
> conflate filesystem and mount namespaces and what different roles they
> have to play. Especially for filesystem developers without much
> experience in this area this is an easy source for bugs.
> 
> Instead of passing the plain namespace we introduce a dedicated type
> struct mnt_idmap and replace the pointer with a pointer to a struct
> mnt_idmap. There are no semantic or size changes for the mount struct
> caused by this.
> 
> We then start converting all places aware of idmapped mounts to rely on
> struct mnt_idmap. Once the conversion is done all helpers down to the
> really low-level make_vfs{g,u}id() and from_vfs{g,u}id() will take a
> struct mnt_idmap argument instead of two namespace arguments. This way
> it becomes impossible to conflate the two removing and thus eliminating
> the possibility of any bugs. Fwiw, I fixed some issues in that area a
> while ago in ntfs3 and ksmbd in the past. Afterwards only low-level code
> can ultimately use the associated namespace for any permission checks.
> Even most of the vfs can be completely obivious about this ultimately
> and filesystems will never interact with it in any form in the future.
> 
> A struct mnt_idmap currently encompasses a simple refcount a pointer to
> the relevant namespace the mount is idmapped to. If a mount isn't
> idmapped then it will point to a static nop_mnt_idmap and if it doesn't
> that it is idmapped. As usual there are no allocations or anything
> happening for non-idmapped mounts. Everthing is carefully written to be
> a nop for non-idmapped mounts as has always been the case.
> 
> If an idmapped mount is created a struct mnt_idmap is allocated and a
> reference taken on the relevant namespace. Each mount that gets idmapped
> or inherits the idmap simply bumps the reference count on struct
> mnt_idmap. Just a reminder that we only allow a mount to change it's
> idmapping a single time and only if it hasn't already been attached to
> the filesystems and has no active writers.
> 
> The actual changes are fairly straightforward but this will have huge
> benefits for maintenance and security in the long run even if it causes
> some churn. I'm aware that there's some cost for all of you. And I'll
> commit to doing this work and make this as painless as I can.
> 
> Note that this also makes it possible to extend struct mount_idmap in
> the future. For example, it would be possible to place the namespace
> pointer in an anonymous union together with an idmapping struct. This
> would allow us to expose an api to userspace that would let it specify
> idmappings directly instead of having to go through the detour of
> setting up namespaces at all.
> 
> This adds the infrastructure.
> 
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>

I like this for avoiding confusion about which namespace is which, and
for the clarity provided by nop_mnt_idmapping.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
