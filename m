Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9C5F39A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 01:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJCXKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 19:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJCXKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:10:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C1021807;
        Mon,  3 Oct 2022 16:10:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EDB8218A2;
        Mon,  3 Oct 2022 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664838625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ejKKwxeNyusGZxKnFiJMaJEeeRSK2DzQgo4ydgx89g=;
        b=VY71chfImQSzPd3upwKIXL6zNeJZEY8W/YbnIU45MigfkVdmbkemLe/KUgltj/U+66tx6f
        zLKLx90Ypt+TjTCixH+WXnReGJOO7VjZJY1tfP9Rdi+IuS6MhC9h88IWu0z1QEgpuWc22J
        l07z2sU3SDnTkASWTnVwIstaSPqUkfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664838625;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ejKKwxeNyusGZxKnFiJMaJEeeRSK2DzQgo4ydgx89g=;
        b=SiXZz3uIude1n8ftVJhEPSRHiECfuhox4wNzLhvgLOZE1lNFGGyguyvi21JZqq99V44kgw
        c21CW3cSGaY/tjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2EA6B1332F;
        Mon,  3 Oct 2022 23:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0sW6N9prO2M2EwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 03 Oct 2022 23:10:18 +0000
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
        linux-xfs@vger.kernel.org, "Colin Walters" <walters@verbum.org>
Subject: Re: [PATCH v6 2/9] iversion: clarify when the i_version counter must
 be updated
In-reply-to: <20220930111840.10695-3-jlayton@kernel.org>
References: <20220930111840.10695-1-jlayton@kernel.org>,
 <20220930111840.10695-3-jlayton@kernel.org>
Date:   Tue, 04 Oct 2022 10:10:14 +1100
Message-id: <166483861470.14457.7243696062075946548@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Sep 2022, Jeff Layton wrote:
> The i_version field in the kernel has had different semantics over
> the decades, but NFSv4 has certain expectations. Update the comments
> in iversion.h to describe when the i_version must change.
>=20
> Cc: Colin Walters <walters@verbum.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326=
033@noble.neil.brown.name/#t
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/iversion.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 6755d8b4f20b..9925cac1fa94 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,14 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version mu=
st
> - * appear different to observers if there was a change to the inode's data=
 or
> - * metadata since it was last queried.
> + * appear larger to observers if there was an explicit change to the inode=
's
> + * data or metadata since it was last queried.
> + *
> + * An explicit change is one that would ordinarily result in a change to t=
he
> + * inode status change time (aka ctime). i_version must appear to change, =
even
> + * if the ctime does not (since the whole point is to avoid missing update=
s due
> + * to timestamp granularity). If POSIX mandates that the ctime must change=
 due
> + * to an operation, then the i_version counter must be incremented as well.

POSIX doesn't (that I can see) describe when the ctime changes w.r.t
when the file changes.  For i_version we do want to specify that
i_version change is not visible before the file change is visible.
So this goes beyond the POSIX mandate.  I might be worth making that
explicit.
But this patch is nonetheless an improvement, so:

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>   *
>   * Observers see the i_version as a 64-bit number that never decreases. If=
 it
>   * remains the same since it was last checked, then nothing has changed in=
 the
> --=20
> 2.37.3
>=20
>=20
