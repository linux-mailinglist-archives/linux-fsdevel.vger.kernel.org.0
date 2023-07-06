Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188D5749A8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjGFLZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGFLZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF961727;
        Thu,  6 Jul 2023 04:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18DDD618CE;
        Thu,  6 Jul 2023 11:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC318C433C8;
        Thu,  6 Jul 2023 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688642750;
        bh=OzCyT6XrXa4+wzTIA2Pbo4OjW9vnQ3x6fZoVglWlKF8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BzlFQ6LLxNaWzxDXyCGLSmKyjEnTT/RZ5nWFUpDXVgvg2EDdRNZtwsgmL3HqfLl24
         VYS36gUY2+j0m9UO/C+HAl9NtkoTFQFPN9sbWAC27PEp5z3uqIKMlMpL5dKddHtJfh
         XVSr5dPVdLjfYqm0H0GAyC4bvi8rlA7MOXTBvhZmZzViACYSQ4Cqqq2LFntdoczssu
         BYB5hJcr/gkCIKGYJPRl5AJYO+q98jl/RqipEnYQVKht98YTjHS+DAl5g/tmFS0rzI
         06Yy7/VmI7s4KYHy5ewKueHxzpeLRjY6cu+gI5JSB3tBFmqNjbaz1zY9mCbCEpDmoD
         XMGb0cc7feSVg==
Message-ID: <4f8c9bed3fb3ad9cfb64e008eb6a6e96b020200e.camel@kernel.org>
Subject: Re: [PATCH v2 44/92] fat: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 07:25:48 -0400
In-Reply-To: <87zg49yfcu.fsf@mail.parknet.co.jp>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-42-jlayton@kernel.org>
         <87zg49yfcu.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-07-06 at 10:54 +0900, OGAWA Hirofumi wrote:
> Jeff Layton <jlayton@kernel.org> writes:
>=20
> > @@ -1407,8 +1407,9 @@ static int fat_read_root(struct inode *inode)
> >  	MSDOS_I(inode)->mmu_private =3D inode->i_size;
> > =20
> >  	fat_save_attrs(inode, ATTR_DIR);
> > -	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode->i_ctime.tv=
_sec =3D 0;
> > -	inode->i_mtime.tv_nsec =3D inode->i_atime.tv_nsec =3D inode->i_ctime.=
tv_nsec =3D 0;
> > +	inode->i_mtime.tv_sec =3D inode->i_atime.tv_sec =3D inode_set_ctime(i=
node,
> > +									0, 0).tv_sec;
> > +	inode->i_mtime.tv_nsec =3D inode->i_atime.tv_nsec =3D 0;
>=20
> Maybe, this should simply be
>=20
> 	inode->i_mtime =3D inode->i_atime =3D inode_set_ctime(inode, 0, 0);
>=20

Yes, that would be clearer. Chalk that one up to the automated
coccinelle conversion. I've fixed it in my ctime-next branch.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
