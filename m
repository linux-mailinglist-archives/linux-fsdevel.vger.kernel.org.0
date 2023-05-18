Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FBD708336
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjERNwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjERNwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF93E5C;
        Thu, 18 May 2023 06:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190186190C;
        Thu, 18 May 2023 13:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C05C433EF;
        Thu, 18 May 2023 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684417919;
        bh=xQeJyfMoA+rHFk5UUJlu9K+CLca1PudNfwxXKrEhcks=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dA7Gouj5BCEb5KxpMS+0pyhsrIVYUB7Ozf2Jl6GohY7SwAJWCwYvyTZsLkeZlCr3Y
         q/lVY/XkqEbdk/Y6hF+et9+X8si6gd3Ik283i2R4tlLJWWUm1OZ8/UVS7dVDspOmBZ
         ed+tdo3BAI/5MarQNkU7jCpFd3/3Cep7DbUoIImbSA4udQIjZZLTC/btCuYktNFZ9W
         NVb7z8rk7quTGvCzXnKQe9zjTk2L54ufH/i190sbbHaJ2lRV+sCjKa2LXymT5q7YmJ
         2rip+q/2eGq+Rpf/stWl1yC7SQ36WozBOwXbtkQTVZBBL0fr977Q9LDsQzRBIAwOuu
         nef/9lQwFezjg==
Message-ID: <d09ff65f6a937ddfaa5ecdc3a97c621df9809292.camel@kernel.org>
Subject: Re: [PATCH v3 0/2] NFSD: add support for NFSv4 write delegation
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 18 May 2023 09:51:57 -0400
In-Reply-To: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
References: <1684366690-28029-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-05-17 at 16:38 -0700, Dai Ngo wrote:
> NFSD: add support for NFSv4 write delegation
>=20
> The NFSv4 server currently supports read delegation using VFS lease
> which is implemented using file_lock.=20
>=20
> This patch series add write delegation support for NFSv4 server by:
>=20
>     . remove the check for F_WRLCK in generic_add_lease to allow
>       file_lock to be used for write delegation. =20
>=20
>     . grant write delegation for OPEN with NFS4_SHARE_ACCESS_WRITE
>       if there is no conflict with other OPENs.
>=20
> Write delegation conflict with another OPEN, REMOVE, RENAME and SETATTR
> are handled the same as read delegation using notify_change, try_break_de=
leg.
>=20
> Changes since v1:
>=20
> [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
> - remove WARN_ON_ONCE from encode_bitmap4
> - replace decode_bitmap4 with xdr_stream_decode_uint32_array
> - replace xdr_inline_decode and xdr_decode_hyper in decode_cb_getattr
>    with xdr_stream_decode_u64. Also remove the un-needed likely().
> - modify signature of encode_cb_getattr4args to take pointer to
>    nfs4_cb_fattr
> - replace decode_attr_length with xdr_stream_decode_u32
> - rename decode_cb_getattr to decode_cb_fattr4
> - fold the initialization of cb_cinfo and cb_fsize into decode_cb_fattr4
> - rename ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>   in fs/nfsd/nfs4xdr.c
> - correct NFS4_dec_cb_getattr_sz and update size description
>=20
> [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
> - change nfs4_handle_wrdeleg_conflict returns __be32 to fix test robot
> - change ncf_cb_cinfo to ncf_cb_change to avoid confusion of cindo usage
>   in fs/nfsd/nfs4xdr.c
>=20
> Changes since v2:
>=20
> [PATCH 2/4] NFSD: enable support for write delegation
> - rename 'deleg' to 'dl_type' in nfs4_set_delegation
> - remove 'wdeleg' in nfs4_open_delegation
>=20
> - drop [PATCH 3/4] NFSD: add supports for CB_GETATTR callback
>   and [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
>   for futher clarification of the benefits of using CB_GETATTR
>   for handling GETATTR from the 2nd client
>=20

Pretty straightforward. Not as useful (IMO) without CB_GETATTR, since
even a stray 'ls -l' in the parent directory will cause the delegation
to be recalled, but it's a reasonable first step.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
