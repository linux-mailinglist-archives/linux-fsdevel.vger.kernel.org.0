Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70A6DD79C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDKKNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDKKNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:13:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D872D67;
        Tue, 11 Apr 2023 03:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D10C61DB8;
        Tue, 11 Apr 2023 10:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D1C433EF;
        Tue, 11 Apr 2023 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681207997;
        bh=4Q/EAEWo9UpGXd/anbl1f2oKicbJxZtgyVSIkT3Ec8Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A9FMtlBrmy1ikjBhg28g0HMfHSK5VBrVwE/RhJd1Mb4bhY6FR5poV7y6TR41EciHK
         mpgFzJDOR1ZG6am0PUy92ZEaPcaJX4UHsIgCmObGSwubfJBSaqSBU6D6hs1QOJfNQc
         PIil0MxcSPhybrw2PPV8Bm4PYwIesgXwiUK6D7KWcDJMTVTI76ohxA8OjcPbbBl1u7
         4AJVpGCw2m8btICtn85O4YNry4GpoqRCbV6CanmBIQZst8l2RRtgoKYcSgxncUqxTZ
         +mKk7bf4Kk9SZ5U0jycRN6ypvpP2FOXNaB/A31uAKFlYj09tjO4NCt6uDxVE+jF2VD
         6x3yPXvQ+ChjA==
Message-ID: <b137033f3cd971b0cfc71045cab63440dfe9c7f8.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Tue, 11 Apr 2023 06:13:15 -0400
In-Reply-To: <20230411-holzbalken-stuben-6cea8b722a1b@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <20230409-genick-pelikan-a1c534c2a3c1@brauner>
         <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
         <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
         <8f5cc243398d5bae731a26e674bdeff465da3968.camel@kernel.org>
         <20230411-holzbalken-stuben-6cea8b722a1b@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-11 at 11:49 +0200, Christian Brauner wrote:
>=20
> >=20
> > > Afaict, filesystems that persist i_version to disk automatically rais=
e
> > > SB_I_VERSION. I would guess that it be considered a bug if a filesyst=
em
> > > would persist i_version to disk and not raise SB_I_VERSION. If so IMA
> > > should probably be made to check for IS_I_VERSION() and it will proba=
bly
> > > get that by switching to vfs_getattr_nosec().
> >=20
> > Not quite. SB_I_VERSION tells the vfs that the filesystem wants the
> > kernel to manage the increment of the i_version for it. The filesystem
> > is still responsible for persisting that value to disk (if appropriate)=
.
>=20
> Yes, sure it's the filesystems responsibility to persist it to disk or
> not. What I tried to ask was that when a filesystem does persist
> i_version to disk then would it be legal to mount it without
> SB_I_VERSION (because ext2/ext3 did use to have that mount option)? If
> it would then the filesystem would probably need to take care to leave
> the i_version field in struct inode uninitialized to avoid confusion or
> would that just work? (Mere curiosity, don't feel obligated to go into
> detail here. I don't want to hog your time.)
>=20

In modern kernels, not setting SB_I_VERSION would mainly have the effect
of stopping increments of i_version field on write. It would also mean
that the STATX_CHANGE_COOKIE is not automatically reported via getattr.

You probably wouldn't want to mount the fs without SB_I_VERSION set. The
missing increments could trick an observer into believing that nothing
had changed in the file across mounts when it actually had.
--=20
Jeff Layton <jlayton@kernel.org>
