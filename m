Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DE550E56B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 18:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiDYQUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243339AbiDYQU2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:20:28 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4803EB97;
        Mon, 25 Apr 2022 09:17:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 23509612C; Mon, 25 Apr 2022 12:17:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 23509612C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650903442;
        bh=PaH4I/j9tPjx9pGsfjeBWqyuICZW5yRhij8ME+WiPp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P3ShbF68j8piV67euDD9EE3AadQA3mY+39lERKN2LHEayCcvwvCmSP6ni+PlZk4+a
         lmXWf7O22ArAA6P0Pkj0vq4O3B0ZZVYYwdjYB5p0noSt9QpsJuvYYKMRCmmNWyaGnw
         Ng8QVFeIy1P4xyBLgjtTR+JItRUhkeA1Nav5FaEM=
Date:   Mon, 25 Apr 2022 12:17:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220425161722.GC24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 23, 2022 at 11:44:08AM -0700, Dai Ngo wrote:
> . Redo based on Bruce's suggestion by breaking the patches into functionality
>   and also don't remove client record of courtesy client until the client is
>   actually expired.
> 
>   0001: courteous server framework with support for client with delegation only.
>         This patch also handles COURTESY and EXPIRABLE reconnect.
>         Conflict is resolved by set the courtesy client to EXPIRABLE, let the
>         laundromat expires the client on next run and return NFS4ERR_DELAY
>         OPEN request.
> 
>   0002: add support for opens/share reservation to courteous server
>         Conflict is resolved by set the courtesy client to EXPIRABLE, let the
>         laundromat expires the client on next run and return NFS4ERR_DELAY
>         OPEN request.
> 
>   0003: mv creation/destroying laundromat workqueue from nfs4_state_start and
>         and nfs4_state_shutdown_net to init_nfsd and exit_nfsd.
> 
>   0004: fs/lock: add locks_owner_has_blockers helper
>   
>   0005: add 2 callbacks to lock_manager_operations for resolving lock conflict
>   
>   0006: add support for locks to courteous server, making use of 0004 and 0005
>         Conflict is resolved by set the courtesy client to EXPIRABLE, run the
>         laundromat immediately and wait for it to complete before returning to
>         fs/lock code to recheck the lock list from the beginning.
> 
>         NOTE: I could not get queue_work/queue_delay_work and flush_workqueue
>         to work as expected, I have to use mod_delayed_work and flush_workqueue
>         to get the laundromat to run immediately.

Whoops, yes, my bad.

>         When we check for blockers in nfs4_anylock_blockers, we do not check
>         for client with delegation conflict. This is because we already hold
>         the client_lock and to check for delegation conflict we need the state_lock
>         and scanning the del_recall_lru list each time. So to avoid this overhead
>         and potential deadlock (not sure about lock of ordering of these locks)
>         we check and set the COURTESY client with delegation being recalled to
>         EXPIRABLE later in nfs4_laundromat.

Hm, OK, I'll think about that, but sounds like it should work.

--b.

> 
>   0007: show state of courtesy client in client info.
