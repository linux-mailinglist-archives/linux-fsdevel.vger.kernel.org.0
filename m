Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E469078FD6D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjIAMnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjIAMnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:43:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A578E7F;
        Fri,  1 Sep 2023 05:43:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0246CCE22C4;
        Fri,  1 Sep 2023 12:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A4C433C8;
        Fri,  1 Sep 2023 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693572191;
        bh=nI8FHKEH0dWAUEpvP+qL1a2MgAAsdrR82NR2nEd33u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQYgs4zGGf61loFYnVxKQVG9kVFEG6vZdNvW/3wmdU3ucNYOk1C6NCg8PdPVII2qY
         AMdOHZwrv+XpR16ML54YSTvlXgCFEvh5WFfBkyhAeKsbAeBCifSPXHyNKJPDv9GtYk
         NHBCnDZkMLKp34G3DTXUTz1cwmE3Ofigv9WRfCTwDzoMNZzOSU8E0HOYmAmGZ+XVAn
         Itu1zCDbIc6LpAem+gUBnGXKrj4YipxGcEfAGkWYpOsje7uCVMXER8yCbL8bWcKpxS
         DJG+2EnOLDlPtb5LmspxuXAbyoqvVcXFKDUM8AFp07QzLq4xz7riBY6+FaT00AHJXU
         GI5eoyC6xAUZQ==
Date:   Fri, 1 Sep 2023 14:43:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <20230901-begehbar-schubsen-4f59559ad581@brauner>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831151414.2714750-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:14:14PM +0200, Mateusz Guzik wrote:
> Thread "Use exclusive lock for file_remove_privs" [1] reports an issue
> which should have been found by asserts -- inode not write locked by the
> caller.
> 
> It did not happen because the attempt to do it in notify_change:
> WARN_ON_ONCE(!inode_is_locked(inode));
> 
> passes if the inode is only read-locked:
> static inline int rwsem_is_locked(struct rw_semaphore *sem)
> {
>         return atomic_long_read(&sem->count) != 0;
> }
> 
> According to git blame this regressed from 2 commits:
> 1. 5955102c9984 ("wrappers for ->i_mutex access") which replaced a
>    bunch of mutex_is_locked with inode_is_locked
> 2. 9902af79c01a ("parallel lookups: actual switch to rwsem") which
>    implemented inode_is_locked as a mere check on the semaphore being
>    held in *any* manner
> 
> In order to remedy this I'm proposing lockdep-ing the check with 2
> helpers: inode_assert_locked and inode_assert_write_locked
> 
> Below I'm adding the helpers and converting *some* of the spots modified
> by the first patch. I boot tested it and nothing blow up on ext4, but
> btrfs should cause a complaint.
> 
> I can finish the other spots originally touched by 1 and touch up the 3
> uses I grepped in fs/namei.c, but ultimately filesystem maintainers are
> going to have to patch their code at their leasure. On top of that there
> are probably quite a few places which should assert, but don't.
> 
> Comments?

I think this is useful and I would be supportive of this.
