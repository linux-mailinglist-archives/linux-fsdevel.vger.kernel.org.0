Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74146736826
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFTJoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 05:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjFTJoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BAF1;
        Tue, 20 Jun 2023 02:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45328610AB;
        Tue, 20 Jun 2023 09:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71195C433C9;
        Tue, 20 Jun 2023 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687254261;
        bh=TZyJoiijizJIfdppKOKgW0H+ofylm830zll6I94VB48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EAqG3PbCYRe4DZlIRwPg2bILfOF0TzOQXMY3bProAtlevE6HUhvWcVzabjggh+fXP
         kh95RqIkTCHXW+mrtSHKet7Znc5qoq5ZAxB5DPbnQX+PdxEP8DEejCzfHpG9zqtFuJ
         8oYGnt7SxsDy/UA5xJvh0r+5dhOrT1OGxMOi96T2rCTEEefoP5op11UK+TFP/3eLmF
         tmat0oA93Rg75lzuIUJ/4tyMc0HwNGSPYyaXurYv3ClxWexkxltEfPf7LgeNTA0LqJ
         kOc/mtYqx7ZXA196vGez9Jxs/kjRCPZ7F3fDGTKU1cjNkotYwMvIgDqF4iUwq5uwHx
         khHlgDr3yPeTg==
Date:   Tue, 20 Jun 2023 11:44:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Li Dong <lidong@vivo.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] fs: Fix bug in lock_rename_child that can cause deadlock
Message-ID: <20230620-abfertigung-notlage-8b1c217bddf3@brauner>
References: <20230619133734.851-1-lidong@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619133734.851-1-lidong@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:37:14PM +0800, Li Dong wrote:
> Function xx causes a deadlock，because s_vfs_rename_mutex was not released when return
> 
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---

This is a cross-directory rename which requires s_vfs_rename_mutex to be
held. You're suggesting to drop it, violating basic locking assumptions
with dire consequences:

lock_rename_child()
{
        c1->d_parent != p2
        -> acquire s_vfs_rename_mutex
}

pairs with

old_parent = c1->d_parent;
unlock_rename(old_parent, p2)
{
        if (old_parent != p2)
        -> release s_vfs_rename_mutex
}

See the usage in ksmbd:

trap = lock_rename_child(old_child, new_path.dentry);
old_parent = dget(old_child->d_parent);
unlock_rename(old_parent, new_path.dentry);
