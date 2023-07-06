Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240C749B28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGFLxG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjGFLxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:53:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD2E54;
        Thu,  6 Jul 2023 04:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6369E618CE;
        Thu,  6 Jul 2023 11:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D464FC433CC;
        Thu,  6 Jul 2023 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644383;
        bh=DImhtAAJpjJiKkZEkG2LSJB03B+4xwGNCaN9PNMpV6Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SePrBr0s42/gJR7yJhjbFLUq2cYm1S/WFm5gDRN3iw/t+s6Y9KUEIOX3gjLsh45DW
         mctT9y7hpRwO/Sb94gYLEE/ptkSj2D2mdqcC8gbHm6fc5xeJ7hoT/cdeTdjfEJsouA
         Jm2fW2OVVe8nhpmchKFKXvd8tTBCvpuQSPrrFA9ptK/wfJpV4evB4M/gu3asi++HzK
         B3kqojwc7Y64iWO5rE957Pp7esj9S5ZSb7HVhyMtJ8nM7WzwVjYYqZY1bVpW6eg5tX
         1j6P6GUb20Pp/QgeRNT27d12slmu6rI+cTGtsTQkP7smWFxYa9dzSTAuAkB1UaaFmL
         iFHPIrNm4SFRw==
Message-ID: <b1cc6c70a42bf41d023eea9f11ff0aaea10a56c3.camel@kernel.org>
Subject: Re: [PATCH v2 39/92] erofs: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
Date:   Thu, 06 Jul 2023 07:53:01 -0400
In-Reply-To: <20230706110007.dc4tpyt5e6wxi5pt@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-37-jlayton@kernel.org>
         <20230706110007.dc4tpyt5e6wxi5pt@quack3>
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

On Thu, 2023-07-06 at 13:00 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:01:04, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Acked-by: Gao Xiang <xiang@kernel.org>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Just one nit below:
>=20
> > @@ -176,10 +175,10 @@ static void *erofs_read_inode(struct erofs_buf *b=
uf,
> >  		vi->chunkbits =3D sb->s_blocksize_bits +
> >  			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
> >  	}
> > -	inode->i_mtime.tv_sec =3D inode->i_ctime.tv_sec;
> > -	inode->i_atime.tv_sec =3D inode->i_ctime.tv_sec;
> > -	inode->i_mtime.tv_nsec =3D inode->i_ctime.tv_nsec;
> > -	inode->i_atime.tv_nsec =3D inode->i_ctime.tv_nsec;
> > +	inode->i_mtime.tv_sec =3D inode_get_ctime(inode).tv_sec;
> > +	inode->i_atime.tv_sec =3D inode_get_ctime(inode).tv_sec;
> > +	inode->i_mtime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
> > +	inode->i_atime.tv_nsec =3D inode_get_ctime(inode).tv_nsec;
>=20
> Isn't this just longer way to write:
>=20
> 	inode->i_atime =3D inode->i_mtime =3D inode_get_ctime(inode);
>=20
> ?
>=20
> 								Honza

Yes. Chalk that one up to coccinelle. Fixed in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
