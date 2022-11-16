Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B0162BC1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKPLhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238903AbiKPLgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:36:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6747324;
        Wed, 16 Nov 2022 03:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 769F9CE1AF8;
        Wed, 16 Nov 2022 11:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D24C433D7;
        Wed, 16 Nov 2022 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668597951;
        bh=63lbNRns+/yqfd4fyIXTp217CwLKlgWeFOWjOua8/6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AD56dKqiLOOiPf5B/BVU6Ykn6uAG4tlL8JrrUuHx4nEr2uv/xfBp76+w19A7UY9VY
         VOA9IcDLvl1ioRaXjAN6qKE0jvON4rzjHKhrr3eavf8FBPapY5ZG7X8ZbiYc8tTZK8
         Iu0n9MfIv7ugMACTurACDCMFALAXz09S4ey5FjGFVgW4cPFZi4mmA9Yc9AKFibRgFB
         BwRoPoJoQssIlRoyse2zPmE0v/xm6AyvJJUfbctczYOBNxIj1xM9KrSzviVzPgd7BW
         WW9sAFe9oigeYqnJGKYE3C3w7FtAawsh+2WyFDghl9KAw9CTZWnChxZ65j4t/S9dnO
         SipGYSNpuFDHg==
Message-ID: <76c783969445db694a18a35b51fc886c4efe5fb6.camel@kernel.org>
Subject: Re: [RFC PATCH] filelock: new helper: vfs_file_has_locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>, chuck.lever@oracle.com
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Date:   Wed, 16 Nov 2022 06:25:49 -0500
In-Reply-To: <4fac935b-8e33-2202-48c2-80bdfddc074e@redhat.com>
References: <20221114140747.134928-1-jlayton@kernel.org>
         <30355bc8aa4998cb48b34df958837a8f818ceeb0.camel@kernel.org>
         <54b90281-c575-5aee-e886-e4d7b50236f0@redhat.com>
         <4a8720c8a24a9b06adc40fdada9c621fd5d849df.camel@kernel.org>
         <a8c94ba5-c01f-3bb6-0b35-2aee06b9d6e7@redhat.com>
         <969b751761988e75b11a75b1f44171305019711a.camel@kernel.org>
         <4fac935b-8e33-2202-48c2-80bdfddc074e@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-16 at 19:16 +0800, Xiubo Li wrote:
> On 16/11/2022 18:55, Jeff Layton wrote:
> > On Wed, 2022-11-16 at 14:49 +0800, Xiubo Li wrote:
> > > On 15/11/2022 22:40, Jeff Layton wrote:
> > >=20
> ...
> > > > +	spin_lock(&ctx->flc_lock);
> > > > +	ret =3D !list_empty(&ctx->flc_posix) || !list_empty(&ctx->flc_flo=
ck);
> > > > +	spin_unlock(&ctx->flc_lock);
> > > BTW, is the spin_lock/spin_unlock here really needed ?
> > >=20
> > We could probably achieve the same effect with barriers, but I doubt
> > it's worth it. The flc_lock only protects the lists in the
> > file_lock_context, so it should almost always be uncontended.
> >=20
> I just see some other places where are also checking this don't use the=
=20
> spin lock.
>=20
>=20

True.

There are a number of places that don't and that use list_empty_careful.
Some of those  We could convert to that here, but again, I'm not sure
it's worth it. Let's stick with using the spinlocks here, since this
isn't a performance-critical codepath anyway.

>=20
> > > > +	return ret;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(vfs_inode_has_locks);
> > > > +
> > > >    #ifdef CONFIG_PROC_FS
> > > >    #include <linux/proc_fs.h>
> > > >    #include <linux/seq_file.h>
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index e654435f1651..d6cb42b7e91c 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_loc=
k *);
> > > >    extern int vfs_test_lock(struct file *, struct file_lock *);
> > > >    extern int vfs_lock_file(struct file *, unsigned int, struct fil=
e_lock *, struct file_lock *);
> > > >    extern int vfs_cancel_lock(struct file *filp, struct file_lock *=
fl);
> > > > +bool vfs_inode_has_locks(struct inode *inode);
> > > >    extern int locks_lock_inode_wait(struct inode *inode, struct fil=
e_lock *fl);
> > > >    extern int __break_lease(struct inode *inode, unsigned int flags=
, unsigned int type);
> > > >    extern void lease_get_mtime(struct inode *, struct timespec64 *t=
ime);
> > > All the others LGTM.
> > >=20
> > > Thanks.
> > >=20
> > > - Xiubo
> > >=20
> > >=20
> > Thanks. I'll re-post it "officially" in a bit and will queue it up for
> > v6.2.
>=20

--=20
Jeff Layton <jlayton@kernel.org>
