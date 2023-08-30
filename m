Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676A278DB17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjH3Sic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242376AbjH3ITn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56210113;
        Wed, 30 Aug 2023 01:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DAD620E0;
        Wed, 30 Aug 2023 08:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD74BC433C7;
        Wed, 30 Aug 2023 08:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693383580;
        bh=kjI6vk/vledVRuhpga0aWbejize1M7Ga+k+PNBBadfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=adqVTvrd1PVvv3whqkLn70awYYXIhoImMIomwyrOs+0PtAJbXmA8/TFDN7c0Ho5Lr
         fYzF7qxZuTjCqGC6yluCOOyUT1XuQjGELMSshvS508s7iwNFruI78syiShuCGUnCbI
         RQ5tQgamPT0SyLiwzxgSkYHC3yJGT90SuqTVd8qrLzOB8by7yR3nm8y3eR+R9Pduyq
         /di3e72TYUFhuzcSzHv103rQW52UfcQZjoaDWjfW7Antt83952EsGu6c4VpDoFFhCH
         nE27HTxe6h7dcBw6ruWIeLWao8XN2gmq2r+CPg+7msOEl+DU8zzcaDz0Ols0kmCl6Y
         K+MUF2FgodSsA==
Date:   Wed, 30 Aug 2023 10:19:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     alx@kernel.org, serge@hallyn.com, christian@brauner.io,
        ipedrosa@redhat.com, gscrivan@redhat.com,
        andreas.gruenbacher@gmail.com, acl-devel@nongnu.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH 3/3] man: Document pitfall with negative permissions and
 user namespaces
Message-ID: <20230830-bachbett-papier-0cc012ebc5ca@brauner>
References: <20230829205833.14873-1-richard@nod.at>
 <20230829205833.14873-4-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829205833.14873-4-richard@nod.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:58:33PM +0200, Richard Weinberger wrote:
> It is little known that user namespaces and some helpers
> can be used to bypass negative permissions.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
> This patch applies to the shadow project.
> ---
>  man/subgid.5.xml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/man/subgid.5.xml b/man/subgid.5.xml
> index e473768d..8ed281e5 100644
> --- a/man/subgid.5.xml
> +++ b/man/subgid.5.xml
> @@ -55,6 +55,15 @@
>        <filename>/etc/subgid</filename> if subid delegation is managed via subid
>        files.
>      </para>
> +    <para>
> +      Additionally, it's worth noting that the utilization of subordinate group
> +      IDs can affect the enforcement of negative permissions. User can drop their
> +      supplementary groups and bypass certain negative permissions.
> +      For more details see
> +      <citerefentry>
> +	<refentrytitle>user_namespaces</refentrytitle><manvolnum>7</manvolnum>
> +      </citerefentry>.
> +    </para>
>    </refsect1>

Looks good to me (content),
Acked-by: Christian Brauner <brauner@kernel.org>
