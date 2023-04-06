Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C256DA4A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjDFVYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDFVYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:24:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5C72121;
        Thu,  6 Apr 2023 14:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47D0D64355;
        Thu,  6 Apr 2023 21:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E8DC433EF;
        Thu,  6 Apr 2023 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680816253;
        bh=LbWm78oWoTDpGOfCvbkZXdpUH2nKup/cCLkZcPzTBfg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ED3Rcxi6MZkfT2K29Xh0PPSaCSyAJXkPmlaVq1Fd46F/RXf6E3OAgmvoD0JWFNyoQ
         INPAjF2jOtAJVRtZaDMqmX3YbmwK5/t9lXRmc60rBv0Q7H/ADkIqUZFQ7VANSW3yWA
         AKu41KcJA0FiuL1twCnRmuSsVi2BhewIAd+g2CWyprGBk5IMC2ZFwRBCXEJuUrr/nk
         HEC6xQfsTwUgiOia/fYkXYDU7FI2uk6geUnEsHSH6Accg8zN4UtjH3OMyl4PPg06dT
         SOOy4TPVr8GksBmolbovQUQM9mLIS3JNGkcZY+glGsvsXpB2l/X9xGlMAW2YzUUj90
         wEWs3/r8u+6Sw==
Message-ID: <4f739cc6847975991874d56ef9b9716c82cf62a3.camel@kernel.org>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Jeff Layton <jlayton@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        miklos@szeredi.hu, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Date:   Thu, 06 Apr 2023 17:24:11 -0400
In-Reply-To: <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
         <20230406-diffamieren-langhaarig-87511897e77d@brauner>
         <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
         <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
         <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
         <20230406-wasser-zwanzig-791bc0bf416c@brauner>
         <546145ecbf514c4c1a997abade5f74e65e5b1726.camel@kernel.org>
         <45a9c575-0b7e-f66a-4765-884865d14b72@linux.ibm.com>
         <60339e3bd08a18358ac8c8a16dc67c74eb8ba756.camel@kernel.org>
         <d61ed13b-0fd2-0283-96d2-0ff9c5e0a2f9@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-04-06 at 16:22 -0400, Stefan Berger wrote:
>=20
> On 4/6/23 15:37, Jeff Layton wrote:
> > On Thu, 2023-04-06 at 15:11 -0400, Stefan Berger wrote:
> > >=20
> > > On 4/6/23 14:46, Jeff Layton wrote:
> > > > On Thu, 2023-04-06 at 17:01 +0200, Christian Brauner wrote:
> > > > > On Thu, Apr 06, 2023 at 10:36:41AM -0400, Paul Moore wrote:
> > >=20
> > > >=20
> > > > Correct. As long as IMA is also measuring the upper inode then it s=
eems
> > > > like you shouldn't need to do anything special here.
> > >=20
> > > Unfortunately IMA does not notice the changes. With the patch provide=
d in the other email IMA works as expected.
> > >=20
> >=20
> >=20
> > It looks like remeasurement is usually done in ima_check_last_writer.
> > That gets called from __fput which is called when we're releasing the
> > last reference to the struct file.
> >=20
> > You've hooked into the ->release op, which gets called whenever
> > filp_close is called, which happens when we're disassociating the file
> > from the file descriptor table.
> >=20
> > So...I don't get it. Is ima_file_free not getting called on your file
> > for some reason when you go to close it? It seems like that should be
> > handling this.
>=20
> I would ditch the original proposal in favor of this 2-line patch shown h=
ere:
>=20
> https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b22=
1af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
>=20
>=20

Ok, I think I get it. IMA is trying to use the i_version from the
overlayfs inode.

I suspect that the real problem here is that IMA is just doing a bare
inode_query_iversion. Really, we ought to make IMA call
vfs_getattr_nosec (or something like it) to query the getattr routine in
the upper layer. Then overlayfs could just propagate the results from
the upper layer in its response.

That sort of design may also eventually help IMA work properly with more
exotic filesystems, like NFS or Ceph.

> The new proposed i_version increase occurs on the inode that IMA sees lat=
er on for
> the file that's being executed and on which it must do a re-evaluation.
>=20
> Upon file changes ima_inode_free() seems to see two ima_file_free() calls=
,
> one for what seems to be the upper layer (used for vfs_* functions below)
> and once for the lower one.
> The important thing is that IMA will see the lower one when the file gets
> executed later on and this is the one that I instrumented now to have its
> i_version increased, which in turn triggers the re-evaluation of the file=
 post
> modification.
>=20
> static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
> [...]
> 	struct fd real;
> [...]
> 	ret =3D ovl_real_fdget(file, &real);
> 	if (ret)
> 		goto out_unlock;
>=20
> [...]
> 	if (is_sync_kiocb(iocb)) {
> 		file_start_write(real.file);
> -->		ret =3D vfs_iter_write(real.file, iter, &iocb->ki_pos,
> 				     ovl_iocb_to_rwf(ifl));
> 		file_end_write(real.file);
> 		/* Update size */
> 		ovl_copyattr(inode);
> 	} else {
> 		struct ovl_aio_req *aio_req;
>=20
> 		ret =3D -ENOMEM;
> 		aio_req =3D kmem_cache_zalloc(ovl_aio_request_cachep, GFP_KERNEL);
> 		if (!aio_req)
> 			goto out;
>=20
> 		file_start_write(real.file);
> 		/* Pacify lockdep, same trick as done in aio_write() */
> 		__sb_writers_release(file_inode(real.file)->i_sb,
> 				     SB_FREEZE_WRITE);
> 		aio_req->fd =3D real;
> 		real.flags =3D 0;
> 		aio_req->orig_iocb =3D iocb;
> 		kiocb_clone(&aio_req->iocb, iocb, real.file);
> 		aio_req->iocb.ki_flags =3D ifl;
> 		aio_req->iocb.ki_complete =3D ovl_aio_rw_complete;
> 		refcount_set(&aio_req->ref, 2);
> -->		ret =3D vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
> 		ovl_aio_put(aio_req);
> 		if (ret !=3D -EIOCBQUEUED)
> 			ovl_aio_cleanup_handler(aio_req);
> 	}
>          if (ret > 0)						<--- this get it to work
>                  inode_maybe_inc_iversion(inode, false);		<--- since this=
 inode is known to IMA
> out:
>          revert_creds(old_cred);
> out_fdput:
>          fdput(real);
>=20
> out_unlock:
>          inode_unlock(inode);
>=20
>=20
>=20
>=20
>     Stefan
>=20
> >=20
> > In any case, I think this could use a bit more root-cause analysis.
>=20

--=20
Jeff Layton <jlayton@kernel.org>
