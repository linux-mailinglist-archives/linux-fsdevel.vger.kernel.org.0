Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3925735C5F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhDLMOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 08:14:12 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17189 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240412AbhDLMOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:14:11 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 08:14:11 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1618228709; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=NeVO8RE97+uH4SRVa14O9S85j+pAHvnzVmcav28p87L7JLc9RmvRD0Oo2OjBI9EdQyS0tWw2zKZJHNqn7EkhickTIJvczITjlFk84I2EqrDymcDBpNNKv+0eHmMYnYMyt7CYTKt3gGwh9KUlGLKVHJAktQAbipaf8tELj1nREHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1618228709; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=UieouIKzy+BRhUkKMx5cdz9s+Qay2qvgcb0KUghHOco=; 
        b=oGSkdcL0RK3s1LekDiIhC+4KlBkRw7NQcfeOvnxx+Rw3MIulKUK1kkinA7hOeXTMMBYUmBfH7VtzwdQFmH0urPDRuE7NZENEs41umaQ5geGufaRm3Mt+Mkyq+cJGiQ2abTYrawz0iE2hsAXM53aQ2D4LGhsDPRs1Qe9WNqOIcDE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1618228709;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=UieouIKzy+BRhUkKMx5cdz9s+Qay2qvgcb0KUghHOco=;
        b=WYGm2hWqgwxznzD+C4Ml+jmb0rOSPcRTOhwPGGtFqY/s9P68efuE1/0dZO+jYpKo
        GICHHATwLrtATws3ljfDSOMctxvbor6elTq9lvubEwyrtlMvPo8/+7EPWAL2/xIYYgJ
        S/y0tVAFH8nb5p9MYOR6pBvAYnsByArcTcFHMT20=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1618228707804809.3274984503647; Mon, 12 Apr 2021 19:58:27 +0800 (CST)
Date:   Mon, 12 Apr 2021 19:58:27 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Miklos Szeredi" <miklos@szeredi.hu>
Cc:     "Jan Kara" <jack@suse.cz>, "Amir Goldstein" <amir73il@gmail.com>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <178c5f281d9.dde5cb9920853.3545294445882801731@mykernel.net>
In-Reply-To: <CAJfpegtyUXcyiUG=YH1Hi06qwuYdtDL_kArQxN9mJUj7JJWZ0w@mail.gmail.com>
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-5-cgxu519@mykernel.net> <CAJfpegtyUXcyiUG=YH1Hi06qwuYdtDL_kArQxN9mJUj7JJWZ0w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/9] ovl: mark overlayfs' inode dirty on
 modification
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:45:28 Miklos Szer=
edi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > Mark overlayfs' inode dirty on modification so that
 > > we can recognize target inodes during syncfs.
 > >
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  fs/overlayfs/inode.c     |  1 +
 > >  fs/overlayfs/overlayfs.h |  4 ++++
 > >  fs/overlayfs/util.c      | 14 ++++++++++++++
 > >  3 files changed, 19 insertions(+)
 > >
 > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
 > > index 8cfa75e86f56..342693657ab0 100644
 > > --- a/fs/overlayfs/inode.c
 > > +++ b/fs/overlayfs/inode.c
 > > @@ -468,6 +468,7 @@ int ovl_update_time(struct inode *inode, struct ti=
mespec64 *ts, int flags)
 > >                 if (upperpath.dentry) {
 > >                         touch_atime(&upperpath);
 > >                         inode->i_atime =3D d_inode(upperpath.dentry)->=
i_atime;
 > > +                       ovl_mark_inode_dirty(inode);
 > >                 }
 > >         }
 > >         return 0;
 > > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
 > > index f8880aa2ba0e..eaf1d5b05d8e 100644
 > > --- a/fs/overlayfs/overlayfs.h
 > > +++ b/fs/overlayfs/overlayfs.h
 > > @@ -247,6 +247,7 @@ static inline bool ovl_open_flags_need_copy_up(int=
 flags)
 > >  }
 > >
 > >  /* util.c */
 > > +void ovl_mark_inode_dirty(struct inode *inode);
 > >  int ovl_want_write(struct dentry *dentry);
 > >  void ovl_drop_write(struct dentry *dentry);
 > >  struct dentry *ovl_workdir(struct dentry *dentry);
 > > @@ -472,6 +473,9 @@ static inline void ovl_copyattr(struct inode *from=
, struct inode *to)
 > >         to->i_mtime =3D from->i_mtime;
 > >         to->i_ctime =3D from->i_ctime;
 > >         i_size_write(to, i_size_read(from));
 > > +
 > > +       if (ovl_inode_upper(to) && from->i_state & I_DIRTY_ALL)
 > > +               ovl_mark_inode_dirty(to);
 > >  }
 >=20
 > Okay, ovl_copyattr() certainly seems a good place to copy dirtyness as w=
ell.
 >=20
 > What I'm fearing is that it does not cover all the places where
 > underlying inode can be dirtied.  This really needs an audit of all
 > filesystem modifying operations.
=20
You are right. Let me fix it in next version.

Thanks,
Chengguang


 > >
 > >  static inline void ovl_copyflags(struct inode *from, struct inode *to=
)
 > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
 > > index 23f475627d07..a6f59df744ae 100644
 > > --- a/fs/overlayfs/util.c
 > > +++ b/fs/overlayfs/util.c
 > > @@ -950,3 +950,17 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, =
struct dentry *dentry,
 > >         kfree(buf);
 > >         return ERR_PTR(res);
 > >  }
 > > +
 > > +/*
 > > + * We intentionally add I_DIRTY_SYNC flag regardless dirty flag
 > > + * of upper inode so that we have chance to invoke ->write_inode
 > > + * to re-dirty overlayfs' inode during writeback process.
 > > + */
 > > +void ovl_mark_inode_dirty(struct inode *inode)
 > > +{
 > > +       struct inode *upper =3D ovl_inode_upper(inode);
 > > +       unsigned long iflag =3D I_DIRTY_SYNC;
 > > +
 > > +       iflag |=3D upper->i_state & I_DIRTY_ALL;
 > > +       __mark_inode_dirty(inode, iflag);
 > > +}
 > > --
 > > 2.26.2
 > >
 > >
 >=20
