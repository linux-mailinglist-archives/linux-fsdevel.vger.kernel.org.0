Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDDC630917
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 03:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiKSCGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 21:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiKSCGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8059E102E;
        Fri, 18 Nov 2022 18:06:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CF0E6279E;
        Sat, 19 Nov 2022 02:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1C2C433C1;
        Sat, 19 Nov 2022 02:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668823565;
        bh=PYHzkPK6EeFAw8e5v+EFg4avol5sP5cCH88qO5yYu2A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uCaRoAnBBJStiZda/IzSFKvMRYrUP7XKrvC7I24jFmNkf+Sop74EbH5ONE7GC3XUv
         VtCQ9nJIAWlFnh6x2eaNLMUhdDm2YVNDQC9XkTM1uj8oCsNQ7JV3VRNegyWjOFTrRE
         T74wOg1F3+o51AJqlDbIjFUXnh+nstntQrpeeExuep3XjA/og+fvcjEa8Vr4aUxSlH
         qxkMvbxJgTkSzCUFkDfVpzc7z9kZROmEcrPqAlLKlr3wQhcgONJFNVDwwUP7UR4Mmd
         qkjilYzJ7c/zOqid2FZCb+7u8LOOCILP5YHDyQQGew57PZ96z/EPIemej+m7MCXd/e
         gSMtJgPdjef3A==
Message-ID: <9a521db6342b977805d7161406f86d44fea7ba55.camel@kernel.org>
Subject: Re: [PATCH] Add process name to locks warning
From:   Jeff Layton <jlayton@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Nov 2022 21:06:03 -0500
In-Reply-To: <20221118234357.243926-1-ak@linux.intel.com>
References: <20221118234357.243926-1-ak@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-18 at 15:43 -0800, Andi Kleen wrote:
> It's fairly useless to complain about using an obsolete feature without
> telling the user which process used it. My Fedora desktop randomly drops
> this message, but I would really need this patch to figure out what
> triggers is.
>=20

Interesting. The only program I know of that tried to use these was
samba, but we patched that out a few years ago (about the time this
patch went in). Are you running an older version of samba?

> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 607f94a0e789..2e45232dbeb1 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2096,7 +2096,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned i=
nt, cmd)
>  	 * throw a warning to let people know that they don't actually work.
>  	 */
>  	if (cmd & LOCK_MAND) {
> -		pr_warn_once("Attempt to set a LOCK_MAND lock via flock(2). This suppo=
rt has been removed and the request ignored.\n");
> +		pr_warn_once("%s: Attempt to set a LOCK_MAND lock via flock(2). This s=
upport has been removed and the request ignored.\n", current->comm);
>  		return 0;
>  	}
> =20

Looks reasonable. Would it help to print the pid or tgid as well?=20
--=20
Jeff Layton <jlayton@kernel.org>
