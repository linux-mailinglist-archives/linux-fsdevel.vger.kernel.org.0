Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3133749B1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGFLrr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGFLrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8184D124;
        Thu,  6 Jul 2023 04:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0954561908;
        Thu,  6 Jul 2023 11:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B0AC433C7;
        Thu,  6 Jul 2023 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644064;
        bh=CcRPw0eryDk6Uzi3dfXUi3cnjVTZ76trI3a28Kui0gw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PI0pqoQlg4ZtdxNuQhusA2J7TMuOk+nkP3fwX4IM+xcAZ6wHKTYSvkYBxcR7+pc9H
         cjJgu5tkDMC+VrT1jOg3aM/vqEqnrM8LIg6lfjUoYG3Ds/cYasSP+t7wRHWMD1Qk4k
         O19MxH86UWt2p9Q17ex3rdVdQgYyNYuL+8d3fHnZ3nngfXAOImdE11AgirhZQ6wiJ7
         qNyj6cNU3khptBz+wzOWArr09GSkI1lxpR4Wr9aZzj0sdJ+Uejn4u0uFYzJ+b43ikV
         yvQkSQwdN2CKqxBIibVq9dJsHZJybz/7FA3Oj2iIwzlXAOuPqlwlA2nJV/r3UhwKOX
         ZEL3xOez9dnBA==
Message-ID: <491b4b44e76ec9d52fe1dbe840c9820dc6713a39.camel@kernel.org>
Subject: Re: [PATCH v2 30/92] ceph: convert to ctime accessor functions
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Date:   Thu, 06 Jul 2023 07:47:42 -0400
In-Reply-To: <20230706105345.cdoadx7hvb227vts@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
         <20230705190309.579783-1-jlayton@kernel.org>
         <20230705190309.579783-28-jlayton@kernel.org>
         <20230706105345.cdoadx7hvb227vts@quack3>
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

On Thu, 2023-07-06 at 12:53 +0200, Jan Kara wrote:
> On Wed 05-07-23 15:00:55, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Reviewed-by: Xiubo Li <xiubli@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Just one nit below:
>=20
> > @@ -688,6 +688,7 @@ void ceph_fill_file_time(struct inode *inode, int i=
ssued,
> >  			 struct timespec64 *mtime, struct timespec64 *atime)
> >  {
> >  	struct ceph_inode_info *ci =3D ceph_inode(inode);
> > +	struct timespec64 ictime =3D inode_get_ctime(inode);
> >  	int warn =3D 0;
> > =20
> >  	if (issued & (CEPH_CAP_FILE_EXCL|
> > @@ -696,11 +697,12 @@ void ceph_fill_file_time(struct inode *inode, int=
 issued,
> >  		      CEPH_CAP_AUTH_EXCL|
> >  		      CEPH_CAP_XATTR_EXCL)) {
> >  		if (ci->i_version =3D=3D 0 ||
> > -		    timespec64_compare(ctime, &inode->i_ctime) > 0) {
> > +		    timespec64_compare(ctime, &ictime) > 0) {
> >  			dout("ctime %lld.%09ld -> %lld.%09ld inc w/ cap\n",
> > -			     inode->i_ctime.tv_sec, inode->i_ctime.tv_nsec,
> > +			     inode_get_ctime(inode).tv_sec,
> > +			     inode_get_ctime(inode).tv_nsec,
>=20
> I think here you can use ictime instead of inode_get_ctime(inode).
> Otherwise feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20

Thanks. Fixed in my tree.
--=20
Jeff Layton <jlayton@kernel.org>
