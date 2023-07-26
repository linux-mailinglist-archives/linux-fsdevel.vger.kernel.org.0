Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F34763383
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjGZK0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjGZK0d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:26:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD08D211C;
        Wed, 26 Jul 2023 03:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FFE61A2D;
        Wed, 26 Jul 2023 10:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF4C433C7;
        Wed, 26 Jul 2023 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690367190;
        bh=5KYTw7QzTyvtxBFV3dygoBH0PeFk0S7OnkeeUk9b43Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ndKso9yUYsbZwpDHng42ep2CAfco3wLs2OV40nFjqGLYD9AEcWQWsW6ETt5eznwfc
         cv1pssJER1sswKXyNjOiTQENkKxQk0VK7z2g3ch3Yi2JD1b11x0Zkl0EFgKozkvsxy
         f1dZ8Uzp9NvZuR0ShQq2ncjDBcvWQLsdpHvv+hCoNZE8CswlcoELNBb87INDiV++T7
         H3FxOmXTcDxptDoUUj0sqZ+IrTepfzb2qKKeU0koRPwfU0de4m8txUllhzV58rHcVD
         p+AU8vMVOdefcjxtH+iRA3W4CG6/XXiQ3a2jG5SNH585qxa35MBMZ5O8U7Wt7Y0BFJ
         4GDCTXheHD02g==
Message-ID: <9b3292b65d3c63c50e671c47ed90304c4a8d1af9.camel@kernel.org>
Subject: Re: [PATCH v6 3/7] tmpfs: bump the mtime/ctime/iversion when page
 becomes writeable
From:   Jeff Layton <jlayton@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Richard Weinberger <richard@nod.at>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Anthony Iliopoulos <ailiop@suse.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org
Date:   Wed, 26 Jul 2023 06:26:23 -0400
In-Reply-To: <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
         <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
         <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
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

On Tue, 2023-07-25 at 18:39 -0700, Hugh Dickins wrote:
> On Tue, 25 Jul 2023, Jeff Layton wrote:
>=20
> > Most filesystems that use the pagecache will update the mtime, ctime,
> > and change attribute when a page becomes writeable. Add a page_mkwrite
> > operation for tmpfs and just use it to bump the mtime, ctime and change
> > attribute.
> >=20
> > This fixes xfstest generic/080 on tmpfs.
>=20
> Huh.  I didn't notice when this one crept into the multigrain series.
>=20
> I'm inclined to NAK this patch: at the very least, it does not belong
> in the series, but should be discussed separately.
>=20
> Yes, tmpfs does not and never has used page_mkwrite, and gains some
> performance advantage from that.  Nobody has ever asked for this
> change before, or not that I recall.
>=20
> Please drop it from the series: and if you feel strongly, or know
> strong reasons why tmpfs suddenly needs to use page_mkwrite now,
> please argue them separately.  To pass generic/080 is not enough.
>=20
> Thanks,
> Hugh
>=20

Dropped.

This was just something I noticed while testing this series. It stood
out since I was particularly watching for timestamp-related test
failures. I don't feel terribly strongly about it.

Thanks!

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  mm/shmem.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b154af49d2df..654d9a585820 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2169,6 +2169,16 @@ static vm_fault_t shmem_fault(struct vm_fault *v=
mf)
> >  	return ret;
> >  }
> > =20
> > +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma =3D vmf->vma;
> > +	struct inode *inode =3D file_inode(vma->vm_file);
> > +
> > +	file_update_time(vma->vm_file);
> > +	inode_inc_iversion(inode);
> > +	return 0;
> > +}
> > +
> >  unsigned long shmem_get_unmapped_area(struct file *file,
> >  				      unsigned long uaddr, unsigned long len,
> >  				      unsigned long pgoff, unsigned long flags)
> > @@ -4210,6 +4220,7 @@ static const struct super_operations shmem_ops =
=3D {
> > =20
> >  static const struct vm_operations_struct shmem_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  	.map_pages	=3D filemap_map_pages,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> > @@ -4219,6 +4230,7 @@ static const struct vm_operations_struct shmem_vm=
_ops =3D {
> > =20
> >  static const struct vm_operations_struct shmem_anon_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  	.map_pages	=3D filemap_map_pages,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> >=20
> > --=20
> > 2.41.0

--=20
Jeff Layton <jlayton@kernel.org>
