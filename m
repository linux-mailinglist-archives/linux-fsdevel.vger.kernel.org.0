Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA24578DAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjH3Sgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbjH3ISb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF4113;
        Wed, 30 Aug 2023 01:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B4C620E0;
        Wed, 30 Aug 2023 08:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E795C433C7;
        Wed, 30 Aug 2023 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693383507;
        bh=SkpG/DDT3OihqReQuHpG/g4EXzWeKyPLmZtNNtBCmFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM8LH5oL2nGsXVe6N2Zt1wmivBmSOHvsHRh2MH9q2hYgZzWkKHIMh5b4bluxUc/aQ
         zv66D+9FP8IwKpdMPcC+R8EpCNAfQOa+i1w30F0/P+KfMnIM117xs6AE3b1qz/MOdO
         1H8WJnIBWsZmMNd2IBuZQHp84Wo5QpySUR5BleFUFdzPIRhOCdvpHmWSBaygPLDR5w
         NZM6BJUJlbfhvze7nBH4nExFm7lA1MHqJNYm1y+3qFqAOz9ULD2m7S191b9WcmhYAp
         UCAikQYRB+x7L9xY/erMOQuUO8ap/BDraPHu0vcbBF6EFPHDHscSz2i+IF89sXaCWY
         2LiJLQisKcgYw==
Date:   Wed, 30 Aug 2023 10:18:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com, acl-devel@nongnu.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH 2/3] user_namespaces.7: Document pitfall with negative
 permissions and user namespaces
Message-ID: <20230830-baldigen-zogen-facd760442ee@brauner>
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-3-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829205833.14873-3-richard@nod.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:58:32PM +0200, Richard Weinberger wrote:
> It is little known that user namespaces and some helpers
> can be used to bypass negative permissions.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> This patch applies to the Linux man-pages project.
> ---
>  man7/user_namespaces.7 | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/man7/user_namespaces.7 b/man7/user_namespaces.7
> index a65854d737cf..4927e194bcdc 100644
> --- a/man7/user_namespaces.7
> +++ b/man7/user_namespaces.7
> @@ -1067,6 +1067,35 @@ the remaining unsupported filesystems
>  Linux 3.12 added support for the last of the unsupported major filesystems,
>  .\" commit d6970d4b726cea6d7a9bc4120814f95c09571fc3
>  XFS.
> +.SS Negative permissions and Linux user namespaces
> +While it is technically feasible to establish negative permissions through
> +DAC or ACL settings, such an approach is widely regarded as a suboptimal
> +practice. Furthermore, the utilization of Linux user namespaces introduces the
> +potential to circumvent specific negative permissions.  This issue stems
> +from the fact that privileged helpers, such as
> +.BR newuidmap (1) ,
> +enable unprivileged users to create user namespaces with subordinate user and
> +group IDs. As a consequence, users can drop group memberships, resulting
> +in a situation where negative permissions based on group membership no longer
> +apply.

For the content,
Acked-by: Christian Brauner <brauner@kernel.org>
