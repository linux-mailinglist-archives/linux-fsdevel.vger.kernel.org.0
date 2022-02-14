Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34664B587C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355492AbiBNR0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 12:26:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357084AbiBNR0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:26:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365E49257;
        Mon, 14 Feb 2022 09:26:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 96F43210F9;
        Mon, 14 Feb 2022 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644859588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLRDxdaEBVwMG0OKk+cDwaYpsSm2hU9I4warhuYUM/c=;
        b=CEIrNYi3h2Eqdd2VzKtmsAUu7aOPoArKy9LRQ3+ldy/xqBpkBFk7DAHW0SbHuji775c4L7
        oABroqgbWMPwCkHdvSTI8tXWEqpsIY0ePNe0s9C8r4cE3mDls38ZaoLXpTkuXFkln5+Saq
        yt4ZLUEoETyoXMv5+c9mmK0qlp7fgMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644859588;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLRDxdaEBVwMG0OKk+cDwaYpsSm2hU9I4warhuYUM/c=;
        b=WN6j5OJBc1y4NVgcVwLLCe6DtZRqKccwuFvkHhvajI8Yxy8kJpM7zWdAWKPlaZg5jZW9zA
        RiI60UxH3iy7G1Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5E92DA3B83;
        Mon, 14 Feb 2022 17:26:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C802FDA832; Mon, 14 Feb 2022 18:22:44 +0100 (CET)
Date:   Mon, 14 Feb 2022 18:22:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 0/2] btrfs: zoned: mark relocation as writing
Message-ID: <20220214172244.GI12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
References: <cover.1644469146.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1644469146.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:59:03PM +0900, Naohiro Aota wrote:
> There is a hung_task issue with running generic/068 on an SMR
> device. The hang occurs while a process is trying to thaw the
> filesystem. The process is trying to take sb->s_umount to thaw the
> FS. The lock is held by fsstress, which calls btrfs_sync_fs() and is
> waiting for an ordered extent to finish. However, as the FS is frozen,
> the ordered extent never finish.
> 
> Having an ordered extent while the FS is frozen is the root cause of
> the hang. The ordered extent is initiated from btrfs_relocate_chunk()
> which is called from btrfs_reclaim_bgs_work().
> 
> The first patch is a preparation patch to add asserting functions to
> check if sb_start_{write,pagefault,intwrite} is called.
> 
> The second patch adds sb_{start,end}_write and the assert function at
> proper places.
> 
> Changelog:
> v2:
>   - Implement asserting functions not to directly touch the internal
>     implementation
> 
> Naohiro Aota (2):
>   fs: add asserting functions for sb_start_{write,pagefault,intwrite}
>   btrfs: zoned: mark relocation as writing

Added as topic branch to for-next. I'd appreciate acks for the
sb_start_* helpers before the patches go to to Linus' tree.
