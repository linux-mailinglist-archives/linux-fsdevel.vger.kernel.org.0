Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36687A6471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjISNKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjISNKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:10:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CA1F0;
        Tue, 19 Sep 2023 06:10:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00FBC433C7;
        Tue, 19 Sep 2023 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695129015;
        bh=fKtzBWEofH5v1GYTVSYZWO24cb4nlr3YNFlYtWFPX6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Quo0fwZfZz+mEXkkeHG+ybYZE5Cubows801uzSsktmDKDxbPbtO7Pr4K2m45SHQF5
         +ThVqV30tie3e/f5W01p0HVHB0FKXNrjz2y1BWJ9Wf5ILW8tlVH5/stunIDHBTvfsw
         Sxg9PY1isUfYDSg1ufOj4cjCJrYRplTvt2PtKzck9qrIDOypfTlUvfibvy5rBxfRCp
         TDHBQ1wgKSZ2mlFBfycRO4dcrVjGWOK4+1Ljz+y9GmOdGiyjvYO67+l54FNDf7l6rO
         wi79bfxVA2rrwZ79zkTKrEeJOuP5/uZ6GAzfL8KvcV9p6IhLAouYjOA7wejdzWmkGw
         YGWcUIQI+pPsw==
Date:   Tue, 19 Sep 2023 15:10:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/posix_acl: apply umask if superblock disables ACL
 support
Message-ID: <20230919-verweben-signieren-5c69a314440c@brauner>
References: <20230919081808.1096542-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919081808.1096542-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:18:07AM +0200, Max Kellermann wrote:
> The function posix_acl_create() applies the umask only if the inode
> has no ACL (= NULL) or if ACLs are not supported by the filesystem
> driver (= -EOPNOTSUPP).
> 
> However, this happens only after after the IS_POSIXACL() check
> succeeded.  If the superblock doesn't enable ACL support, umask will
> never be applied.  A filesystem which has no ACL support will of
> course not enable SB_POSIXACL, rendering the umask-applying code path
> unreachable.

The fix is in the wrong place if !IS_POSIXACL() umask stripping happens
in the VFS. So if at all we need to fix stripping umask for O_TMPFILE in
the vfs.

Have you verified that commit ac6800e279a2 ("fs: Add missing umask strip
in vfs_tmpfile") doesn't already fix this?
