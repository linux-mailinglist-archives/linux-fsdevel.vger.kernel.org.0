Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2678DAB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbjH3Sgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbjH3ITN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B6113;
        Wed, 30 Aug 2023 01:19:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DB56620E0;
        Wed, 30 Aug 2023 08:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD6CC433C8;
        Wed, 30 Aug 2023 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693383549;
        bh=NGgSh0cGcSG/JR6ENnpJlFzHhIu4tT8GFV3OV5qe3zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8ht0AZ058W0q8ut1p0NTaAP8d84wWktL9IrTZOzBEXz+AsieH/c788d2YV/+uIHR
         4jZZjV5KPQcIHZFjefxklyND18RL2B0aWaJH3WkroslcEBg7I5HMv7vEn1BC4mw8VN
         dbcQm9/PU/pAzzm0xrEfm1MSbqQv+EO0Fr2pi2mnUDXKC6/K9VnHZpX9JJmaEuZXlF
         fmGNDyDrnAQt+qpb90wbIfB9tpExuZExgmUi/QDCQ27pkpETKHpYAV2f9qAAL6DshC
         4fav8jnlOETggUKEEj5Jf/Tnhfqh02EVtSKPe74tINsNa9SinJYjgrtJcjuoAPq/tB
         wbHyq0XA529JA==
Date:   Wed, 30 Aug 2023 10:19:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com, acl-devel@nongnu.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH 1/3] man: Document pitfall with negative permissions and
 user namespaces
Message-ID: <20230830-seilwinde-kunst-eebb96620782@brauner>
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-2-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829205833.14873-2-richard@nod.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:58:31PM +0200, Richard Weinberger wrote:
> It is little known that user namespaces and some helpers
> can be used to bypass negative permissions.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> This patch applies to the acl software project.
> ---
>  man/man5/acl.5 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/man/man5/acl.5 b/man/man5/acl.5
> index 0db86b325617..2ed144742e37 100644
> --- a/man/man5/acl.5
> +++ b/man/man5/acl.5
> @@ -495,5 +495,20 @@ These non-portable extensions are available on Linux systems.
>  .Xr acl_from_mode 3 ,
>  .Xr acl_get_perm 3 ,
>  .Xr acl_to_any_text 3
> +.Sh NOTES
> +.Ss Negative permissions and Linux user namespaces
> +While it is technically feasible to establish negative permissions through
> +ACLs, such an approach is widely regarded as a suboptimal practice.
> +Furthermore, the utilization of Linux user namespaces introduces the
> +potential to circumvent specific negative permissions.  This issue stems
> +from the fact that privileged helpers, such as
> +.Xr newuidmap 1 ,
> +enable unprivileged users to create user namespaces with subordinate user and
> +group IDs. As a consequence, users can drop group memberships, resulting
> +in a situation where negative permissions based on group membership no longer
> +apply.
> +For more details, please refer to the
> +.Xr user_namespaces 7
> +documentation.
>  .Sh AUTHOR
>  Andreas Gruenbacher, <andreas.gruenbacher@gmail.com>

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
