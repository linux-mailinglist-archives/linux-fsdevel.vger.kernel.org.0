Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C446E49C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDQNTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 09:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDQNTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A44B461;
        Mon, 17 Apr 2023 06:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F9561AB0;
        Mon, 17 Apr 2023 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE74BC433D2;
        Mon, 17 Apr 2023 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681737534;
        bh=PyeeTfI8QXYJ6B2oTWU56K56KQLpF2XskjQp6upqB/o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HbyeZIClPQqGSJyeLLvmyIDGi1jlGksR+Zs8xddBe2bnS2xJedIuqmwDaJu8+tIcs
         LCVvOd9fr+4GMdKrer0sQ+walMErAYp1K63yWEcnsG1bAsasvJtZWCqOkLZ6zQnPwh
         11DALm6faqP+9X9KuN4aDgRtE9mA/MTaEGoTl1HpPhfXXk8pnigTGYll+rZnzUFdCQ
         G9qMlO/tlHbU+rXwxZxdHxXNljZy8iVWe/NidepLYDLOGDmt43ucO+35NUk4zwJDh/
         dHijeMCE5irAUPq7JPXT2bfEzYMrknWvXHAk0uLUPPwIGq9abYnoX7tWRunK5mQ0MV
         PFL5w/h2PsbUg==
Message-ID: <7596d06350a556741e1d1e54d0927d1a65b26939.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Mon, 17 Apr 2023 09:18:52 -0400
In-Reply-To: <176640ae-3ff7-c3e9-218a-2952425336e7@linux.ibm.com>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
         <94c2aadfb2fe7830d0289ffe6084581b99505a58.camel@kernel.org>
         <176640ae-3ff7-c3e9-218a-2952425336e7@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-17 at 08:45 -0400, Stefan Berger wrote:
>=20
> On 4/17/23 06:05, Jeff Layton wrote:
> > On Sun, 2023-04-16 at 21:57 -0400, Stefan Berger wrote:
> > >=20
> > > On 4/7/23 09:29, Jeff Layton wrote:
>=20
> > > >=20
> > > > Note that there Stephen is correct that calling getattr is probably
> > > > going to be less efficient here since we're going to end up calling
> > > > generic_fillattr unnecessarily, but I still think it's the right th=
ing
> > > > to do.
> > >=20
> > > I was wondering whether to use the existing inode_eq_iversion() for a=
ll
> > > other filesystems than overlayfs, nfs, and possibly other ones (which=
 ones?)
> > > where we would use the vfs_getattr_nosec() via a case on inode->i_sb-=
>s_magic?
> > > If so, would this function be generic enough to be a public function =
for libfs.c?
> > >=20
> > > I'll hopefully be able to test the proposed patch tomorrow.
> > >=20
> > >=20
> >=20
> > No, you don't want to use inode_eq_iversion here because (as the commen=
t
> > over it says):
>=20
> In the ima_check_last_writer() case the usage of inode_eq_iversion() was =
correct since
> at this point no record of  its value was made and therefore no writer ne=
eded to change
> the i_value again due to IMA:
>=20
> 		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
> 					    &iint->atomic_flags);
> 		if (!IS_I_VERSION(inode) ||
> 		    !inode_eq_iversion(inode, iint->version) ||
> 		    (iint->flags & IMA_NEW_FILE)) {
> 			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
> 			iint->measured_pcrs =3D 0;
> 			if (update)
> 				ima_update_xattr(iint, file);
> 		}
>=20
> The record of the value is only made when the actual measurement is done =
in
> ima_collect_measurement()
>=20

True, but we don't have a generic mechanism to do a this. What you're
doing only works for IS_I_VERSION inodes.

> Compared to this the usage of vfs_getattr_nosec() is expensive since it r=
esets the flag.
>=20
>          if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode))=
 {
>                  stat->result_mask |=3D STATX_CHANGE_COOKIE;
>                  stat->change_cookie =3D inode_query_iversion(inode);
>          }
>=20
> 	idmap =3D mnt_idmap(path->mnt);
> 	if (inode->i_op->getattr)
> 		return inode->i_op->getattr(idmap, path, stat,
> 					    request_mask, query_flags);
>=20
> Also, many filesystems will have their getattr now called as well.
>=20

...as they should!

> I understand Christian's argument about the maintenance headache to a cer=
tain degree...
>=20

IMA is not equipped to understand the subtleties of how the i_version
counter is implemented on different filesystems. In the past it dealt
with this by limiting its usage to IS_I_VERSION inodes, but that is
already problematic today. For instance: xfs currently sets the
SB_I_VERSION flag, but its i_version counter also bumps the value on
atime updates. That means that IMA is doing more remeasurements on xfs
than are needed.

I'm trying to clean a lot of this up, but IMA's current usage isn't
really helping since it's poking around in areas it shouldn't be. Doing
a getattr is the canonical way to query this value since it leaves it up
to the filesystem how to report this value.

If this turns out to cause a performance regression we can look at
adding a getattr-like routine that _only_ reports the change attribute.
I wouldn't want to do that though unless the need were clear (and backed
up by performance numbers).
--=20
Jeff Layton <jlayton@kernel.org>
