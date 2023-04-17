Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E87F6E44CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDQKHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 06:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDQKHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6476D7ED1;
        Mon, 17 Apr 2023 03:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8152E614BD;
        Mon, 17 Apr 2023 10:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DA0C433D2;
        Mon, 17 Apr 2023 10:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681725906;
        bh=nlMhgVd7pguxjkFgcrm5IWWYvfrdSdeliQ3gHwuSens=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b7Wr1gVx1JAIPRvlVI2Vh+6Ckw9sh4l3MkAu5081Z4TVOtf7hfxtBuru6QnFVxa2Q
         H1b+6CfjA7wys2oZ2WHiJgetHLEvaUV2YMS6vILvm9OSbwH9UBrimAh3vvf8BegXRb
         hgNCTLR4S3Y1og3sdeYhYK5EvX+dZlgATgA6PFRuYNF9fK6Phgnx4hCWzEIp2TTgSM
         M6VjkfNQkMZwlpEZxHWeGSGBvvz4T5+KQczGGmqTqbvyMeym8riZRxSKxNcA73AhgE
         lF52ABKuSpyCdcZdjNE7KgaXR2e/EOY+xAR31H2uhTg2cvjiKEUAOIYN/6VXUmULgD
         Sq8WYSMyqiP8w==
Message-ID: <94c2aadfb2fe7830d0289ffe6084581b99505a58.camel@kernel.org>
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
Date:   Mon, 17 Apr 2023 06:05:04 -0400
In-Reply-To: <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <e2455c0e-5a17-7fc1-95e3-5f2aca2eb409@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Sun, 2023-04-16 at 21:57 -0400, Stefan Berger wrote:
>=20
> On 4/7/23 09:29, Jeff Layton wrote:
> > > > > >=20
> > > > > > I would ditch the original proposal in favor of this 2-line pat=
ch shown here:
> > > > > >=20
> > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468=
-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > >=20
> > > We should cool it with the quick hacks to fix things. :)
> > >=20
> >=20
> > Yeah. It might fix this specific testcase, but I think the way it uses
> > the i_version is "gameable" in other situations. Then again, I don't
> > know a lot about IMA in this regard.
> >=20
> > When is it expected to remeasure? If it's only expected to remeasure on
> > a close(), then that's one thing. That would be a weird design though.
>=20
> IMA should remeasure the file when it has visibly changed for another thr=
ead or process.
>=20
>=20
> > > > -----------------------8<---------------------------
> > > >=20
> > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > >=20
> > > > IMA currently accesses the i_version out of the inode directly when=
 it
> > > > does a measurement. This is fine for most simple filesystems, but c=
an be
> > > > problematic with more complex setups (e.g. overlayfs).
> > > >=20
> > > > Make IMA instead call vfs_getattr_nosec to get this info. This allo=
ws
> > > > the filesystem to determine whether and how to report the i_version=
, and
> > > > should allow IMA to work properly with a broader class of filesyste=
ms in
> > > > the future.
> > > >=20
> > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > >=20
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > >=20
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). Tha=
t
> > >      is in line what we do with all other inode attributes. IOW, the
> > >      overlayfs inode's i_version counter should aim to mirror the
> > >      relevant layer's i_version counter. I wouldn't know why that
> > >      shouldn't be the case. Asking the other way around there doesn't
> > >      seem to be any use for overlayfs inodes to have an i_version tha=
t
> > >      isn't just mirroring the relevant layer's i_version.
> >=20
> > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > inode.
> >=20
> > You can't just copy=A0up the value from the upper. You'll need to call
> > inode_query_iversion(upper_inode), which will flag the upper inode for =
a
> > logged i_version update on the next write. IOW, this could create some
> > (probably minor) metadata write amplification in the upper layer inode
> > with IS_I_VERSION inodes.
> >=20
> >=20
> > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > >      Currently, ima assumes that it will get the correct i_version fr=
om
> > >      an inode but that just doesn't hold for stacking filesystem.
> > >=20
> > > While (1) would likely just fix the immediate bug (2) is correct and
> > > _robust_. If we change how attributes are handled vfs_*() helpers wil=
l
> > > get updated and ima with it. Poking at raw inodes without using
> > > appropriate helpers is much more likely to get ima into trouble.
> >=20
> > This will fix it the right way, I think (assuming it actually works),
> > and should open the door for IMA to work properly with networked
> > filesystems that support i_version as well.
> >=20
> > Note that there Stephen is correct that calling getattr is probably
> > going to be less efficient here since we're going to end up calling
> > generic_fillattr unnecessarily, but I still think it's the right thing
> > to do.
>=20
> I was wondering whether to use the existing inode_eq_iversion() for all
> other filesystems than overlayfs, nfs, and possibly other ones (which one=
s?)
> where we would use the vfs_getattr_nosec() via a case on inode->i_sb->s_m=
agic?
> If so, would this function be generic enough to be a public function for =
libfs.c?
>=20
> I'll hopefully be able to test the proposed patch tomorrow.
>=20
>=20

No, you don't want to use inode_eq_iversion here because (as the comment
over it says):

 * Note that we don't need to set the QUERIED flag in this case, as the val=
ue
 * in the inode is not being recorded for later use.

The IMA code _does_ record the value for later use. Furthermore, it's
not valid to use inode_eq_iversion on a non-IS_I_VERSION inode, so it's
better to just use vfs_getattr_nosec which allows IMA to avoid all of
those gory details.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
