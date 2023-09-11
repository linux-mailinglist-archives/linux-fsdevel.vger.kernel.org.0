Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCABF79B25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 01:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbjIKUw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbjIKTd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:33:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31112A;
        Mon, 11 Sep 2023 12:33:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D25FC433D9;
        Mon, 11 Sep 2023 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694460830;
        bh=A13nCizsPVmYBTbUjrBG25LzeCrAW+6QKClcpIWHnJ8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fvR3s8wYTcQ+luyKyniLwLNvvrko39sEie18l9chvLpa+05FrM4efx2JBo4bP71Jv
         jWScYlwktNu2uPnfy0pz6yQJvKGSchA/dlz0stUsmU8hBHWgcS35jaOD5KClT3Z82l
         6JuAG6QLIRjSo/94KixZd6Kf6Ukxsi61syTTsExIOWR3AO+r5ETNhtmln2CmkezwGW
         oIWJ4Q/aTnwY0KZdJRCHDdBR/DKbMjWnMc7vSSJWSXO82c0EWO1U9SJ5PaycM96tqM
         C3baWtGM2yRGdK3VyxabTmZvIMIeecXuxxnloUWodt7YFiUSv8pXt0Wvu1AcBlkt1J
         AB1OTlC8wgt3Q==
Message-ID: <11597d56bbb44a83fcbce8d1161068dd96a41ec4.camel@kernel.org>
Subject: Re: [PATCH] selinux: fix handling of empty opts in
 selinux_fs_context_submount()
From:   Jeff Layton <jlayton@kernel.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
Date:   Mon, 11 Sep 2023 15:33:48 -0400
In-Reply-To: <20230911142358.883728-1-omosnace@redhat.com>
References: <20230911142358.883728-1-omosnace@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-09-11 at 16:23 +0200, Ondrej Mosnacek wrote:
> selinux_set_mnt_opts() relies on the fact that the mount options pointer
> is always NULL when all options are unset (specifically in its
> !selinux_initialized() branch. However, the new
> selinux_fs_context_submount() hook breaks this rule by allocating a new
> structure even if no options are set. That causes any submount created
> before a SELinux policy is loaded to be rejected in
> selinux_set_mnt_opts().
>=20
> Fix this by making selinux_fs_context_submount() leave fc->security
> set to NULL when there are no options to be copied from the reference
> superblock.
>=20
> Reported-by: Adam Williamson <awilliam@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2236345
> Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init pr=
oblem, preventing NFS sb sharing")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 10350534de6d6..2aa0e219d7217 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2775,14 +2775,20 @@ static int selinux_umount(struct vfsmount *mnt, i=
nt flags)
>  static int selinux_fs_context_submount(struct fs_context *fc,
>  				   struct super_block *reference)
>  {
> -	const struct superblock_security_struct *sbsec;
> +	const struct superblock_security_struct *sbsec =3D selinux_superblock(r=
eference);
>  	struct selinux_mnt_opts *opts;
> =20
> +	/*
> +	 * Ensure that fc->security remains NULL when no options are set
> +	 * as expected by selinux_set_mnt_opts().
> +	 */
> +	if (!(sbsec->flags & (FSCONTEXT_MNT|CONTEXT_MNT|DEFCONTEXT_MNT)))
> +		return 0;
> +
>  	opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
>  	if (!opts)
>  		return -ENOMEM;
> =20
> -	sbsec =3D selinux_superblock(reference);
>  	if (sbsec->flags & FSCONTEXT_MNT)
>  		opts->fscontext_sid =3D sbsec->sid;
>  	if (sbsec->flags & CONTEXT_MNT)

Reviewed-by: Jeff Layton <jlayton@kernel.org>
