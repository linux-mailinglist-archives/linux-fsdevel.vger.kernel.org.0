Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D78771D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjHGJ3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjHGJ27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB0E76
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 02:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2F7E6170D
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 09:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271DFC433C7;
        Mon,  7 Aug 2023 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691400538;
        bh=hujkC5Bjsu5FXP4+fJwkcyECN+y7mmQQ8ny6u3jSvbI=;
        h=Date:From:To:Cc:Subject:From;
        b=Zz6thB3OGU1gdy+q8Dp7lgK/YFqA6FLGFhm7ABemLYN9daSPcSFNjI3otWMvhawJG
         nio89EVh8xCY/bxp56mixN9319H2i3azDFnWz21QZIqKswIgHKrLBWwUL9k/cjrW+w
         i3pHwTyS8d/94BFQpzz3K7uMPBqR4E80+zxJMfPLVZCEJh/DTiJCOIJUJE0aQBPGJV
         6hJjXe8e/uxm0cny7lI4TzTgZk6NG+QUWC9PWPZtlzv023ASuMcrl5xkEBs0GfO5vg
         5yV3035+aPnj4TAejWGKIrOy0gIbd5oElmy8Mtmn1T38b2G8HycMUVV2y4TZrfj+Sn
         DVRNKiUWpNwcQ==
Date:   Mon, 7 Aug 2023 11:28:54 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, jack@suse.cz
Cc:     linux-fsdevel@vger.kernel.org
Subject: bd_holder
Message-ID: <20230807-hinzu-barhocker-7e7826d113cb@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been looking into reducing sb_lock and replacing it mostly with a
new file_system_type->fs_super_lock which would be a
per-file-system-type spinlock protecting fs_type->fs_supers.

With the changes in vfs.super bd_holder always stores the super_block
and so we should be able to get rid of get_super() and user_get_super()
completely. Am I right in this or is there something that would prevent
us from doing something like the following (completely untested sketch)?:

struct super_block *get_super(struct block_device *bdev)
{
        struct super_block *sb;

        if (!bdev)
                return NULL;

        spin_lock(&sb_lock);

        sb = bdev->bd_holder;
        if (!sb)
                goto out_unlock;

        if (hlist_unhashed(&sb->s_instances))
                goto out_unlock;

        sb->s_count++;
        spin_unlock(&sb_lock);
        down_read(&sb->s_umount);
        /* still alive? */
        if (sb->s_root && (sb->s_flags & SB_BORN))
                return sb;
        up_read(&sb->s_umount);
        /* nope, got unmounted */
        spin_lock(&sb_lock);
        __put_super(sb);

out_unlock:
        spin_unlock(&sb_lock);
        return NULL;
}

instead of looping through super_blocks? The only thing that irritates
me is the restart logic in the current helpers.
