Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200C0506F96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345166AbiDSOCt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbiDSOCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:02:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5C114E;
        Tue, 19 Apr 2022 06:59:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93A23B819AA;
        Tue, 19 Apr 2022 13:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AEFC385A8;
        Tue, 19 Apr 2022 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650376789;
        bh=LRUihLM0sWjX5MXCAlAIJzgJ3la9JpKK4DT62glq5RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjQqeNFGBmXzAU/E3PB1IJxg7jN6ZaDvICiEzZfXo77fHqJm3qxjocbd5INjJXyJS
         4jo0lj8y31etKtnPvLE7hBOEJeH73NI2KXTRajoHzoNB5g+vbouicMy+WnC9ree9uM
         kFN2gYuG7zA9RvdaeWVVyeEym2DtGc0gIuiMBcOHYUi+lB6IYj5O5Qbk3JQH9xqbdQ
         xPbuUjketdhhMi23UGJuxnaxx7hcfzqc6z/vw69g0y5+D6pHtLbD6GNfslX7K+gAuU
         q8LQ3PdyL22hqJbnPSLy0XSwGhaTbpsE9aTWHXcN6R7cot7UpwN93NLW2ooJEqJZtT
         W+X1Tfqf2LNzw==
Date:   Tue, 19 Apr 2022 15:59:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        jlayton@kernel.org, ntfs3@lists.linux.dev, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 4/8] NFSv3: only do posix_acl_create under
 CONFIG_NFS_V3_ACL
Message-ID: <20220419135938.flv776f36v6xb6sj@wittgenstein>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650368834-2420-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650368834-2420-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:47:10PM +0800, Yang Xu wrote:
> Since nfs3_proc_create/nfs3_proc_mkdir/nfs3_proc_mknod these rpc ops are called
> by nfs_create/nfs_mkdir/nfs_mkdir these inode ops, so they are all in control of
> vfs.
> 
> nfs3_proc_setacls does nothing in the !CONFIG_NFS_V3_ACL case, so we put
> posix_acl_create under CONFIG_NFS_V3_ACL and it also doesn't affect
> sattr->ia_mode value because vfs has did umask strip.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

I have the same comment as on the xfs patch. If the filesystem has opted
out of acls and SB_POSIXACL isn't set in sb->s_flags then
posix_acl_create() is a nop. Why bother placing it under an ifdef?

It adds visual noise and it implies that posix_acl_create() actually
does something even if the filesystem doesn't support posix acls.

Unless this actually fixes something I'd drop this patch too.
