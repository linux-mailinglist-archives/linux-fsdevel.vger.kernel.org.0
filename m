Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD25F3989
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJCXGP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJCXGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:06:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F24240A4;
        Mon,  3 Oct 2022 16:06:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 88721218B1;
        Mon,  3 Oct 2022 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664838369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDGs3Bk2iDM8Sg1N7ysr2TYE6vffr3zLzEKlNym2d6g=;
        b=mlmAiiBBQBbBVYOh5gea+uvcUPEM0yazoPg1sYcsKc/Z4pPAPwbLD3gdEaFs0bksRg1Auf
        /pSgfhLbJyiVhdwosRU0m1F+AzihZbODVc1Acdli1DXW18aaRvZ96cucNGyiV7BdYHhJc+
        445uOun1/0aubSINbuqbOug00c5PSCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664838369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDGs3Bk2iDM8Sg1N7ysr2TYE6vffr3zLzEKlNym2d6g=;
        b=WDnQb66RAHB0dwcO5OD+IifbJsp1dpu0MyTzMD3DGromzQwfD/A3LcPWLl2rJR8FXkQQYV
        d5tjJmT28kUR2lCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 912851332F;
        Mon,  3 Oct 2022 23:06:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5AKFNtqO2P8EQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 23:06:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 1/9] iversion: move inode_query_iversion to libfs.c
In-reply-to: <20220930111840.10695-2-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-2-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 10:05:59 +1100
Message-id: <166483835973.14457.2650225208160842573@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sep 2022, Jeff Layton wrote:
> There's no need to have such a large function forcibly inlined.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: NeilBrown <neilb@suse.de>

you could possible make the "I_VERSION_QUERIED already set" case inline
and the "needs to be set" case out-of-line, but it probably isn't worth
it.=20

Thanks,
NeilBrown


> ---
>  fs/libfs.c               | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/iversion.h | 38 ++------------------------------------
>  2 files changed, 38 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 682d56345a1c..5ae81466a422 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1566,3 +1566,39 @@ bool inode_maybe_inc_iversion(struct inode *inode, b=
ool force)
>  	return true;
>  }
>  EXPORT_SYMBOL(inode_maybe_inc_iversion);
> +
> +/**
> + * inode_query_iversion - read i_version for later use
> + * @inode: inode from which i_version should be read
> + *
> + * Read the inode i_version counter. This should be used by callers that w=
ish
> + * to store the returned i_version for later comparison. This will guarant=
ee
> + * that a later query of the i_version will result in a different value if
> + * anything has changed.
> + *
> + * In this implementation, we fetch the current value, set the QUERIED fla=
g and
> + * then try to swap it into place with a cmpxchg, if it wasn't already set=
. If
> + * that fails, we try again with the newly fetched value from the cmpxchg.
> + */
> +u64 inode_query_iversion(struct inode *inode)
> +{
> +	u64 cur, new;
> +
> +	cur =3D inode_peek_iversion_raw(inode);
> +	do {
> +		/* If flag is already set, then no need to swap */
> +		if (cur & I_VERSION_QUERIED) {
> +			/*
> +			 * This barrier (and the implicit barrier in the
> +			 * cmpxchg below) pairs with the barrier in
> +			 * inode_maybe_inc_iversion().
> +			 */
> +			smp_mb();
> +			break;
> +		}
> +
> +		new =3D cur | I_VERSION_QUERIED;
> +	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
> +	return cur >> I_VERSION_QUERIED_SHIFT;
> +}
> +EXPORT_SYMBOL(inode_query_iversion);
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index e27bd4f55d84..6755d8b4f20b 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -234,42 +234,6 @@ inode_peek_iversion(const struct inode *inode)
>  	return inode_peek_iversion_raw(inode) >> I_VERSION_QUERIED_SHIFT;
>  }
> =20
> -/**
> - * inode_query_iversion - read i_version for later use
> - * @inode: inode from which i_version should be read
> - *
> - * Read the inode i_version counter. This should be used by callers that w=
ish
> - * to store the returned i_version for later comparison. This will guarant=
ee
> - * that a later query of the i_version will result in a different value if
> - * anything has changed.
> - *
> - * In this implementation, we fetch the current value, set the QUERIED fla=
g and
> - * then try to swap it into place with a cmpxchg, if it wasn't already set=
. If
> - * that fails, we try again with the newly fetched value from the cmpxchg.
> - */
> -static inline u64
> -inode_query_iversion(struct inode *inode)
> -{
> -	u64 cur, new;
> -
> -	cur =3D inode_peek_iversion_raw(inode);
> -	do {
> -		/* If flag is already set, then no need to swap */
> -		if (cur & I_VERSION_QUERIED) {
> -			/*
> -			 * This barrier (and the implicit barrier in the
> -			 * cmpxchg below) pairs with the barrier in
> -			 * inode_maybe_inc_iversion().
> -			 */
> -			smp_mb();
> -			break;
> -		}
> -
> -		new =3D cur | I_VERSION_QUERIED;
> -	} while (!atomic64_try_cmpxchg(&inode->i_version, &cur, new));
> -	return cur >> I_VERSION_QUERIED_SHIFT;
> -}
> -
>  /*
>   * For filesystems without any sort of change attribute, the best we can
>   * do is fake one up from the ctime:
> @@ -283,6 +247,8 @@ static inline u64 time_to_chattr(struct timespec64 *t)
>  	return chattr;
>  }
> =20
> +u64 inode_query_iversion(struct inode *inode);
> +
>  /**
>   * inode_eq_iversion_raw - check whether the raw i_version counter has cha=
nged
>   * @inode: inode to check
> --=20
> 2.37.3
>=20
>=20
