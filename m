Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196A4BBDE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiBRQ6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 11:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiBRQ6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:58:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168422790AD;
        Fri, 18 Feb 2022 08:58:29 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C9AF71F3A2;
        Fri, 18 Feb 2022 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645203507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmkZkd30UdFJ6yDzJ/qU6SXd37ZCVpyyfwrnRu4eiJk=;
        b=kuwUHnWmrEMwJYeIUDxCrQR2hLotiZyEvXD1pWG/VKCfl+nxz4akBOk/6R/dtNlnG5cVC8
        mNkA8pxJ4nydFTJ2Rwcj3jn68YPek8Mvdzey/V+WUALOjHK1lZHYALQgfYZ6o346Fj6YqN
        vKoDGu2RN/k76lDbUd5LLi9bMFNDIhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645203507;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QmkZkd30UdFJ6yDzJ/qU6SXd37ZCVpyyfwrnRu4eiJk=;
        b=hJc3dn6WnLszrsNzpTz5kAm5bCzxjU8fNQNj94MAjYXo/30+MeHflbxX0qJjJ8b6q4HYe0
        eN1V1KxUbNilLIDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9A4D8A3B83;
        Fri, 18 Feb 2022 16:58:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E2B53DA829; Fri, 18 Feb 2022 17:54:41 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:54:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
Subject: Re: [PATCH v3 0/2] btrfs: zoned: mark relocation as writing
Message-ID: <20220218165441.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com
References: <cover.1645157220.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645157220.git.naohiro.aota@wdc.com>
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

On Fri, Feb 18, 2022 at 01:14:17PM +0900, Naohiro Aota wrote:
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
> v3:
>   - Return bool instead of asserting and let caller decide what to do
>     (suggested by Dave Chinner)
> v2:
>   - Implement asserting functions not to directly touch the internal
>     implementation
> 
> Naohiro Aota (2):
>   fs: add asserting functions for sb_start_{write,pagefault,intwrite}
>   btrfs: zoned: mark relocation as writing

Topic branch updated, thanks.
