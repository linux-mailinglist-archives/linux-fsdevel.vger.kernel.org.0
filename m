Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED46D86E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjDETcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDETcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307859FF
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C321563F24
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 19:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C99C433D2;
        Wed,  5 Apr 2023 19:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680723122;
        bh=7cT4GyWOJKMcdlBi01zYvZsMVT8sK5bMcefl+mw/nKE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7rM/Pk4ykluUIQmBOLgT0rgRWA0YFQl2DZgdcZw4gGe8VJgFhgTwgPHtyh+Alor9
         WGUFqrv2M0VFvR0C5B+tQJAQBEeQyzzwaHf7GQpVKC0GE1TpwxeO6VIUNHH8l9nARz
         CWsHHAtzHNeNnCQi7hlpGQjYUh6OaTvo02DnBhS5ds4Js5vFTuRHSYwnV6vNSOjUQb
         e+AkLqSXCeKmBLATOyskzI8acicCtku4M/igMtA7Q/RAPfPVYFtA5vQqwvQ86vEsYh
         kEUC0Je2XCcg6HKzaKIrzN55S/oB5wcZ4rMJLPyhmZTXOzZAS/4gx4FwzE56gTFu1Y
         P8uDldnhvSI7g==
Date:   Wed, 5 Apr 2023 14:32:00 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] fs: fix __lookup_mnt() documentation
Message-ID: <ZC3MsNqkSCuqa8D1@do-x1extreme>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
 <20230202-fs-move-mount-replace-v2-3-f53cd31d6392@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v2-3-f53cd31d6392@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:13:08PM +0200, Christian Brauner wrote:
> The comment on top of __lookup_mnt() states that it finds the first
> mount implying that there could be multiple mounts mounted at the same
> dentry with the same parent.
> 
> This was true on old kernels where __lookup_mnt() could encounter a
> stack of child mounts such that each child had the same parent mount and
> was mounted at the same dentry. These were called "shadow mounts" and
> were created during mount propagation. So back then if a mount @m in the
> destination propagation tree already had a child mount @p mounted at
> @mp then any mount @n we propagated to @m at the same @mp would be
> appended after the preexisting mount @p in @mount_hashtable.
> 
> This hasn't been the case for quite a while now and I don't see an
> obvious way how such mount stacks could be created in another way. And
> if that's possible it would invalidate assumptions made in other parts
> of the code.
> 
> So for a long time on all relevant kernels the child-parent relationship
> is unique per dentry. So given a child mount @c mounted at its parent
> mount @p on dentry @mp means that @c is the only child mounted on
> @p at @mp. Should a mount @m be propagated to @p on @mp then @m will be
> mounted on @p at @mp and the preexisting child @c will be remounted on
> top of @m at @m->mnt_root.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

I've been confused by the comment on __lookup_mnt() before, so this is a
helpful update.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
