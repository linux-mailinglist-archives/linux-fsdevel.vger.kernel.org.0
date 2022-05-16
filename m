Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409B852850F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbiEPNNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiEPNM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:12:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9811EEC8;
        Mon, 16 May 2022 06:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7F3FB811B6;
        Mon, 16 May 2022 13:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB10C385B8;
        Mon, 16 May 2022 13:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652706775;
        bh=8FPoe1RAON30o/pCWwFs0A713UVrLNGUKmHerCIG1qQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nH3efThIppw0sM26m2Bc3LimWeB3POnLRTd7U7offMmfKpz5GMVyiXJfNT2O43Dro
         o6f5MFYs2Hi4cCnaIYHK43gb63YOh8OvzhAvt1bxSbKnhC9DfDhOkEhLIhC5jHtqVZ
         b/wXmwCA1cLA/3CXjBCSHFyat4voaYzevS5dtPrWtRrWgptCQzRrNSwtdsRzYEswWQ
         mGGx7MN3qLkYeYJMzyXFJXRK+CW2AKE1wHkQ46s6vkpu+o60fm3GHAqhqASscElFOY
         dmUZ295Z2emRo84c+TrzUPokDHemLm3Y/ozZTAOo3tJAsCCNSkvs1HKnE6TfE44pxN
         Tw2Sud2GlExvg==
Message-ID: <2412ef109c2af459189b9cce9a39c2ed34eb7b61.camel@kernel.org>
Subject: Re: [PATCH 1/2] fs/dcache: add d_compare() helper support
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 16 May 2022 09:12:53 -0400
In-Reply-To: <20220516122046.40655-2-xiubli@redhat.com>
References: <20220516122046.40655-1-xiubli@redhat.com>
         <20220516122046.40655-2-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-16 at 20:20 +0800, Xiubo Li wrote:
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/dcache.c            | 15 +++++++++++++++
>  include/linux/dcache.h |  2 ++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 93f4f5ee07bf..95a72f92a94b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dentry=
 *dentry,
>  				       name) =3D=3D 0;
>  }
> =20
> +/**
> + * d_compare - compare dentry name with case-exact name
> + * @parent: parent dentry
> + * @dentry: the negative dentry that was passed to the parent's lookup f=
unc
> + * @name:   the case-exact name to be associated with the returned dentr=
y
> + *
> + * Return: 0 if names are same, or 1
> + */
> +bool d_compare(const struct dentry *parent, const struct dentry *dentry,
> +	       const struct qstr *name)
> +{
> +	return !d_same_name(dentry, parent, name);
> +}
> +EXPORT_SYMBOL(d_compare);
> +
>  /**
>   * __d_lookup_rcu - search for a dentry (racy, store-free)
>   * @parent: parent dentry
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba51480b2..444b2230e5c3 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -233,6 +233,8 @@ extern struct dentry * d_alloc_parallel(struct dentry=
 *, const struct qstr *,
>  					wait_queue_head_t *);
>  extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
>  extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct =
qstr *);
> +extern bool d_compare(const struct dentry *parent, const struct dentry *=
dentry,
> +		      const struct qstr *name);
>  extern struct dentry * d_exact_alias(struct dentry *, struct inode *);
>  extern struct dentry *d_find_any_alias(struct inode *inode);
>  extern struct dentry * d_obtain_alias(struct inode *);

I wonder if we ought to just un-inline and export d_same_name instead?
Still, this is less disruptive and the dcache code is hugely performance
sensitive. It's possible that inlining that function makes a difference.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
