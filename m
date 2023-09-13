Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E23079E12C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbjIMHvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238670AbjIMHvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:51:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6F198B;
        Wed, 13 Sep 2023 00:51:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E33C433C7;
        Wed, 13 Sep 2023 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694591471;
        bh=+AOQSKFwpnsVZVGwl9Voawht6qIoVhFaH29VpknF7KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQWVz6H3mjhA4/V4vZ/B8L7X9Y9fDMApjtH9F5vRWIH0L0aBd1UObb2vAwHaWOXyq
         c68zvdibbl/B2LKNaxiK7sQjk438rNyIMpzUKoQlhc0ecDf2GoOYGhZyHc57zo9ihY
         CTVGWGX2ufULJfCQSYKfg0khW4tGRiiYjm+XPJm2IJ7TAkG+GBXYcUcC4SVl5xp19E
         Kq2ma4As+NO3VR7d5elT3LYC+stPhCAuMirsihmyUKycwa49ms3DIoi4/luaXFOWXk
         ugIFk91/4qhsnvk3b2a5Gi1NCIFA7E4lHtMsueV5BbQiwxIKd+l+Np6ZZ5VPVQEBu9
         UEDzvlcvieSSQ==
Date:   Wed, 13 Sep 2023 09:51:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
Subject: Re: [PATCH] selinux: fix handling of empty opts in
 selinux_fs_context_submount()
Message-ID: <20230913-flohmarkt-zukauf-7a96c6ed5aca@brauner>
References: <20230911142358.883728-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911142358.883728-1-omosnace@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:23:58PM +0200, Ondrej Mosnacek wrote:
> selinux_set_mnt_opts() relies on the fact that the mount options pointer
> is always NULL when all options are unset (specifically in its
> !selinux_initialized() branch. However, the new
> selinux_fs_context_submount() hook breaks this rule by allocating a new
> structure even if no options are set. That causes any submount created
> before a SELinux policy is loaded to be rejected in
> selinux_set_mnt_opts().
> 
> Fix this by making selinux_fs_context_submount() leave fc->security
> set to NULL when there are no options to be copied from the reference
> superblock.
> 
> Reported-by: Adam Williamson <awilliam@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2236345
> Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
