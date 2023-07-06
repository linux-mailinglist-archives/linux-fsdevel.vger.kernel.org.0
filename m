Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08D74A062
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjGFPFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjGFPFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:05:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3840C1725;
        Thu,  6 Jul 2023 08:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17A46609EB;
        Thu,  6 Jul 2023 15:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F0AC433C7;
        Thu,  6 Jul 2023 15:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688655930;
        bh=Rf7i8I+LfcJ8cIMf7wGyzUSCTROtn6GdIVE4P/kAZIU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=J3lqPtyW8zjsoC8LVCiAH9lmO1BOO+VQYiaQVEWmS2/RZiqBWnMsbTPPowJnafWTv
         Ka7RcI3DOuM8pttkMqwV+J/H4vH7u3jt+YG68d+FzYX7OMm0U8nsVSlvEXxx1au3mS
         Z8Pqsusg/Ijo6cTXX98lpWCjDS/74YEHkhOXEwsrYjy8mbm+JDtxesoCTq/YEJo6ZN
         qu1ky9uRwZl49kpvoMal7dQuog4ETFc0BoI+iQETjaTQPHJFOvL4pJUcvBjAUZ2i+Q
         kxzGPiKOI/HqoxML5p4AIKAAoqrUCf0BZh9epx4YoKoMT46ZwM4UajklZL7eapOOPR
         ySIEL7GI1i7Lg==
Message-ID: <6733eddd632b3a8e85518ef04dae3e28f600c961.camel@kernel.org>
Subject: Re: [PATCH v2 84/92] linux: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 11:05:28 -0400
In-Reply-To: <20230706145321.ahfawgtukrmfgfdv@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-82-jlayton@kernel.org>
         <20230706145321.ahfawgtukrmfgfdv@quack3>
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

On Thu, 2023-07-06 at 16:53 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:49, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> 								Honza
>=20

I'll fix the subject line on this one too, which should be "fs_stack:".
Many thanks for all of the review!

> > ---
> >  include/linux/fs_stack.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
> > index 54210a42c30d..010d39d0dc1c 100644
> > --- a/include/linux/fs_stack.h
> > +++ b/include/linux/fs_stack.h
> > @@ -24,7 +24,7 @@ static inline void fsstack_copy_attr_times(struct ino=
de *dest,
> >  {
> >  	dest->i_atime =3D src->i_atime;
> >  	dest->i_mtime =3D src->i_mtime;
> > -	dest->i_ctime =3D src->i_ctime;
> > +	inode_set_ctime_to_ts(dest, inode_get_ctime(src));
> >  }
> > =20
> >  #endif /* _LINUX_FS_STACK_H */
> > --=20
> > 2.41.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
