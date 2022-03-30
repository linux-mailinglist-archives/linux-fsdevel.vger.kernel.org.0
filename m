Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E0D4EC66E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiC3OZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbiC3OZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:25:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13694205BD7;
        Wed, 30 Mar 2022 07:23:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C3FEA210F4;
        Wed, 30 Mar 2022 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648650203;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xR5hf8kIREKN6X6wVSaN/NHYaZGL1s9/pqLKR+/n3kA=;
        b=2oFrZTB/YYZFSPML86/A2KkRqmQhRe8KJotT8rW9Yc0zf3o181BQUwNqq7m7/yrzTdLfla
        pJh9q9s5CO4Ja3M/qJZdkF0pgUFT95bU+/PMtcvHWlC5yc17SipkyKPgGIQCj/GmcZt88d
        cFtnyH8ReevsWxGav3EoUZA802c8wxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648650203;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xR5hf8kIREKN6X6wVSaN/NHYaZGL1s9/pqLKR+/n3kA=;
        b=pVf6UFYU4dy3pu3QUJVFodxzlrii4muWBxIakCsfZ5VoJaXAQTJoWFmwvrPn2R42yHsLm7
        Gm51a5cuKy5h9wBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 77DC5A3B88;
        Wed, 30 Mar 2022 14:23:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4923FDA7F3; Wed, 30 Mar 2022 16:19:25 +0200 (CEST)
Date:   Wed, 30 Mar 2022 16:19:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v4 0/3] protect relocation with sb_start_write
Message-ID: <20220330141924.GE2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
References: <cover.1648535838.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648535838.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 03:55:57PM +0900, Naohiro Aota wrote:
> This series is a follow-up to the series below [1]. The old series added
> an assertion to btrfs_relocate_chunk() to check if it is protected
> with sb_start_write(). However, it revealed another location we need
> to add sb_start_write() [2].
> 
> Also, this series moved the ASSERT from btrfs_relocate_chunk() to
> btrfs_relocate_block_group() because we do not need to call
> sb_start_write() on a non-data block group [3].
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/
> 
> [2] https://lore.kernel.org/linux-btrfs/cover.1645157220.git.naohiro.aota@wdc.com/T/#e06eecc07ce1cd1e45bfd30a374bd2d15b4fd76d8
> 
> [3] https://lore.kernel.org/linux-btrfs/YjMSaLIhKNcKUuHM@debian9.Home/
> 
> Patch 1 adds sb_{start,end}_write() to the resumed async balancing.
> 
> Patches 2 and 3 add an ASSERT to catch a future error.
> 
> --
> v4:
>   - Fix subject of patch 2 (Filipe)
>   - Revise the comment for the ASSERT (Filipe)
> v3:
>   - Only add sb_write_started(), which we really use. (Dave Chinner)
>   - Drop patch "btrfs: mark device addition as mnt_want_write_file" (Filipe Manana)
>   - Narrow asserting region to btrfs_relocate_block_group() and check only
>     when the BG is data BG. (Filipe Manana)
> v2:
>   - Use mnt_want_write_file() instead of sb_start_write() for
>     btrfs_ioctl_add_dev()
>   - Drop bogus fixes tag
>   - Change the stable target to meaningful 4.9+
> 
> Naohiro Aota (3):
>   btrfs: mark resumed async balance as writing
>   fs: add a check function for sb_start_write()
>   btrfs: assert that relocation is protected with sb_start_write()

Added to misc-next, with the comment of 3/3 updated according to
Filipe's suggestion. Thanks.
