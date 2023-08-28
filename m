Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9A78B034
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjH1M3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjH1M3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CE412F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 05:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24DD362D19
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 12:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724E3C433C7;
        Mon, 28 Aug 2023 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693225732;
        bh=vwfuKOHatIHy3S0Nc2hPvCDVADPlTvPJ8YfXibTsvZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fe1w5vRTd34+8+SaWM5mjNtF8apB9wT+GSQnu/VHnl6wbzSLq38UQxfKijupOWUOG
         rhyDoAyb7aQY/lW5ub/ZL2j1hRH0nGm+OV7dmhQrrUENMnmHV1cwEOS9cx97+JwwIO
         1OgDFtnvhZEqxcquqMy7Pd2LX2TUSTx/yQNrJtavACFxzZwO7asjjhKaOQ3ukRf7Ny
         xrOktbymiHFF+2W25oZWqlXtwLVx7PMFEH6pE7+PksZ8MO2v2d8xCeHXJKSi+4YVTd
         GkrxZTjTvOEiMYmSVg7NSrNJGwBKHVbAuLMI38+OMnQT1KPbwf+Or9/6lOBAa8b1k+
         OG6kX1Du645lA==
Date:   Mon, 28 Aug 2023 14:28:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        syzbot+5b64180f8d9e39d3f061@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] super: ensure valid info
Message-ID: <20230828-farbkombinationen-gedruckt-6da10079c586@brauner>
References: <20230828-vfs-super-fixes-v1-0-b37a4a04a88f@kernel.org>
 <20230828-vfs-super-fixes-v1-2-b37a4a04a88f@kernel.org>
 <20230828120418.GB10189@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230828120418.GB10189@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Maybe I didn't read the commit log carefully enough, but why do we
> need to call kill_super_notify before free_anon_bdev and any potential
> action in ->kill_sb after calling kill_anon_super here given that
> we already add a call to kill_super_notify after ->kill_sb?

Yeah, the commit log explains this. We leave the superblock on fs_supers
past sb->kill_sb() and notify after device closure. For block based
filesystems that's the correct thing. They don't rely on sb->s_fs_info
and we need to ensure that all devices are closed.

But for filesystems like kernfs that rely on get_keyed_super() they rely
on sb->s_fs_info to recycle sbs. sb->s_fs_info is currently always freed
in sb->kill_sb()

kernfs_kill_sb()
-> kill_anon_super()
   -> kfree(info)

For such fses sb->s_fs_info is freed with the superblock still on
fs_supers which means we get a UAF when the sb is still found on the
list. So for such filesystems we need to remove and notify before
sb->s_fs_info is freed. That's done in kill_anon_super(). For such
filesystems the call in deactivate_locked_super() is a nop.
