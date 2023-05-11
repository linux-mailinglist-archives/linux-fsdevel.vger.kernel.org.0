Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E46FF3DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjEKOSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbjEKOSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23FE7
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 07:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 329C564DD0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 14:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761B3C433D2;
        Thu, 11 May 2023 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683814679;
        bh=lT6PfI2HCbD1D3tsSZljBKYO5NIwXcsxYdHEKyMc7ug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBEVI6Lf8a+fvdcoKVXuvdlHaCdzZYqXCYXWV/ouXtapypLU3lommQ3aftBSyR68j
         gDZ/mgTMzuWpDPpsLFwknNcGn2OsvNIn3bQ+IDXDb+vDIerX6DuJjaUfrhhWi20qTG
         UykWmd/woF+xBtfzdzmse3GphnnHNn3TudHqBb3i/JjTU0IM/fgv3OjMfne+ZHz2RR
         pb0LI95VaTX06tYcY40HEXyUNxlFPB4jqTInhLUaCLAg5Nlo/lIWdhx30Sng+a1dl2
         X89H5QGfZA/xi0Lf3fZkd0Fk2ljSuxtM/dI5KAOAYeSLliIV1bHKn4Z1trHGQeMFNG
         QZBVHu1ysc0AA==
Date:   Thu, 11 May 2023 07:17:58 -0700
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] fs: allow to mount beneath top mount
Message-ID: <ZFz5Fm7kVVFUc3FY@do-x1extreme>
References: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202-fs-move-mount-replace-v4-0-98f3d80d7eaa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 01:18:38PM +0200, Christian Brauner wrote:
> Changes in v4:
> - Tweak the logic and helper that's used to prevent mounting beneath a
>   mount if the propagation relationship between the source mount, parent
>   mount, and top mount would lead to nonsensical mount trees.
> - Link to v3: https://lore.kernel.org/r/20230202-fs-move-mount-replace-v3-0-377893f74bc8@kernel.org
> 
> Changes in v3:
> - Refuse to mount source trees whose root has been overmounted after
>   path resolution of the source path has finished but before we grabbed
>   the namespace semaphore. This avoids the creation of shadow mounts.
> - Refuse to mount if the mount we're mounting beneath has been moved to
>   a different mountpoint before we grabbed the namespace semaphore.
> - Refuse to mount if the mount we're mounting beneath has been unmounted
>   before we grabbed the namespace semaphore.
> - Link to v2: https://lore.kernel.org/r/20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org
> 
> Changes in v2:
> - s/MOVE_MOUNT_TUCK/MOVE_MOUNT_BENEATH/ which is a much clearer name.
> - Improve commit message.
> - Link to v1: https://lore.kernel.org/r/20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org

Reviewed the changes since my last review. I'll send one
follow up about some wording in a comment, but other than that LGTM.

Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
