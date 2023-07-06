Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E10C749D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjGFNKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFNKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD71FC9;
        Thu,  6 Jul 2023 06:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0CFB6195C;
        Thu,  6 Jul 2023 13:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D009C433C7;
        Thu,  6 Jul 2023 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688649019;
        bh=U4DQhi7mOPrGgIbuzx0vC/TJNm7AB04bsngGM1ZNiKY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hD8s3cacuL+rlBWEE+Y2STmdjnIe2imLtc3s8dw4ZBi02XMCOR+Uzpn5rn+z7Il59
         oV8RrIID4kFpmzRqgk7vgpM1rCY0/PSQngyTKcahd28TuconlZPT3/heegUvR6KrP9
         U8E9VsTCG/0uv1e5F0oa2RfVHiOrd2B6ym1GKJ9WCosHzReHdvae7YD72qdvEO3o0H
         HCwAJDBqDmkYHrWNiXSna1aMPh3Wornxb+OH1I6QAidxfg0PzErwxosFufRhPNbs8q
         B77t6zo5ytlZMqIM79muX1+UpGgun8zGq4Lw7g018DgqzKi84WJP8KfNOXeHp1V3VJ
         0x7Al8QvkqQRA==
Message-ID: <5290be64ba87d01938c578f49443ce41f9be5e77.camel@kernel.org>
Subject: Re: [PATCH v2 42/92] ext4: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 06 Jul 2023 09:10:17 -0400
In-Reply-To: <20230706123643.3pumra5f4fthz3qq@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-40-jlayton@kernel.org>
         <20230706123643.3pumra5f4fthz3qq@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-07-06 at 14:36 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:07, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Some comment below:
>=20
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 0a2d55faa095..d502b930431b 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -3823,6 +3823,27 @@ static inline int ext4_buffer_uptodate(struct bu=
ffer_head *bh)
> >  	return buffer_uptodate(bh);
> >  }
> > =20
> > +static inline void ext4_inode_set_ctime(struct inode *inode, struct ex=
t4_inode *raw_inode)
> > +{
> > +	struct timespec64 ctime =3D inode_get_ctime(inode);
> > +
> > +	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra)) {
> > +		raw_inode->i_ctime =3D cpu_to_le32(ctime.tv_sec);
> > +		raw_inode->i_ctime_extra =3D ext4_encode_extra_time(&ctime);
> > +	} else {
> > +		raw_inode->i_ctime =3D cpu_to_le32(clamp_t(int32_t, ctime.tv_sec, S3=
2_MIN, S32_MAX));
> > +	}
> > +}
> > +
> > +static inline void ext4_inode_get_ctime(struct inode *inode, const str=
uct ext4_inode *raw_inode)
> > +{
> > +	struct timespec64 ctime =3D { .tv_sec =3D (signed)le32_to_cpu(raw_ino=
de->i_ctime) };
> > +
> > +	if (EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), i_ctime_extra))
> > +		ext4_decode_extra_time(&ctime, raw_inode->i_ctime_extra);
> > +	inode_set_ctime(inode, ctime.tv_sec, ctime.tv_nsec);
> > +}
> > +
>=20
> This duplication is kind of unpleasant. I was looking into it for a while
> and I think we can rather do some initial cleanup (attached patch 1) and
> then your conversion patch would not need to duplicate the conversion cod=
e
> (see attached patch 2).
>=20
> =09
>=20

Thanks Jan. That looks fine at first glance. I'll plan to drop my ext4
patch and replace it with these.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
