Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970E60D226
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiJYQ7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJYQ65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:58:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC2100BE4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 09:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A548B81CAB
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 16:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0802C433D6;
        Tue, 25 Oct 2022 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666717134;
        bh=caPrt3bm3ntWPzN9eNPjgjfHYs4PwnJDY7XBnhNX1zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UjwZP5QQYwyoOwfN9y2gor2oAMNotAOjxVreopBJY93dGhIk3zSo4MCrf+iSlb4Q8
         cieSFatKrxIR2YPfPfY7KBlw+HSK1qx3muEjZG0PIVjkceQS5VpgwE1JHcSP8+n1VH
         jBdFt6/Sd46MQ9rs8lEk6iZyqlxEfJYkZ44xXlyrPZsT863LHgmzcyYiEbR6ezMIUz
         MCxgReficmq3FvCfZJ5q1XvxsuGX6r0xXUN8l/CaHO8AyqF5iwcJMBgLc5abZN3emQ
         iSQD+uxtmsoJworW8SQZJGNZp/y3kJjbHFxVxAekbAvbuqI7rg5Ussc7kJPXyFxCBM
         hGca+aXrkuk0Q==
Date:   Tue, 25 Oct 2022 18:58:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        kernel-team <kernel-team@fb.com>,
        Seth Forshee <sforshee@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v3] fuse: Rearrange fuse_allow_current_process checks
Message-ID: <20221025165849.jmal5awdnbxh44qm@wittgenstein>
References: <20221025161017.3548254-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221025161017.3548254-1-davemarchevsky@fb.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 09:10:17AM -0700, Dave Marchevsky wrote:
> This is a followup to a previous commit of mine [0], which added the
> allow_sys_admin_access && capable(CAP_SYS_ADMIN) check. This patch
> rearranges the order of checks in fuse_allow_current_process without
> changing functionality.
> 
> [0] added allow_sys_admin_access && capable(CAP_SYS_ADMIN) check to the
> beginning of the function, with the reasoning that
> allow_sys_admin_access should be an 'escape hatch' for users with
> CAP_SYS_ADMIN, allowing them to skip any subsequent checks.
> 
> However, placing this new check first results in many capable() calls when
> allow_sys_admin_access is set, where another check would've also
> returned 1. This can be problematic when a BPF program is tracing
> capable() calls.
> 
> At Meta we ran into such a scenario recently. On a host where
> allow_sys_admin_access is set but most of the FUSE access is from
> processes which would pass other checks - i.e. they don't need
> CAP_SYS_ADMIN 'escape hatch' - this results in an unnecessary capable()
> call for each fs op. We also have a daemon tracing capable() with BPF and
> doing some data collection, so tracing these extraneous capable() calls
> has the potential to regress performance for an application doing many
> FUSE ops.
> 
> So rearrange the order of these checks such that CAP_SYS_ADMIN 'escape
> hatch' is checked last. Add a small helper, fuse_permissible_uidgid, to
> make the logic easier to understand. Previously, if allow_other is set
> on the fuse_conn, uid/git checking doesn't happen as current_in_userns
> result is returned. These semantics are maintained here:
> fuse_permissible_uidgid check only happens if allow_other is not set.
> 
>   [0]: commit 9ccf47b26b73 ("fuse: Add module param for CAP_SYS_ADMIN access bypassing allow_other")
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> ---
> v2 -> v3: lore.kernel.org/linux-fsdevel/20221020201409.1815316-1-davemarchevsky@fb.com
> 
>   * Add fuse_permissible_uidgid, rearrange fuse_allow_current_process to
>     not use 'goto' (Christian)
> 
> v1 -> v2: lore.kernel.org/linux-fsdevel/20221020183830.1077143-1-davemarchevsky@fb.com
> 
>   * Add missing brackets to allow_other if statement (Andrii)

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
