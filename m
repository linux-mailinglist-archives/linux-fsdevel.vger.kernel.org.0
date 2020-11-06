Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6042A8D16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 03:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgKFCmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 21:42:39 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25396 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgKFCmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:42:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604630506; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=bwkNXvEJPn2cbdZXgiQt6o1B2rPfIaMt/j5sV88C0NtsqJsIBmv42sUmvm74wP0LyRvzlFuy8Hs0f/VpMSl+9uav+lPTf62u+7v2H3CyHrYo6rc+6Pb/lcWCyXbVOm7IcvVCkLL2wUAV5otPlqRSpGdnX95IE5VxWQZPfeOkVIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604630506; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=XW/1JDsOLWYhVNSWC+7/4EF1eY3IkevFJ25pTwTJEAI=; 
        b=FrUGYv86g44xqbHappT/SR+/q7ZHNJ9df5f/xTxr8KLJTqF6Oo8eQariLUBW/IocBp3XGBIrf+3zyPXH2FqY8bAb9UkseEIknCicDM+01bU2Bk5aSEdoEmkGBO/QDfiWsOiR/AU0jMRPhVm09vSa+Gj7RE73mMcpoyzvybp8gEA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604630506;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=XW/1JDsOLWYhVNSWC+7/4EF1eY3IkevFJ25pTwTJEAI=;
        b=P9eJW2SvoD6Ca9ZTwwKpGsNZwGhji6zrIqGQiLe5aYZUvp+8DOgwfw7bXCoGa2cL
        uZV4ngwWyIsG3IVwl9BZs4JS+ga56UPMZaYEpV4mgsvxUFUZU+NMuaMCjbFDARmzGkX
        /csOsHOl0OVJPkAapwhuEUEdeqAEVu179DGD2Kms=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604630504235156.52700683189153; Fri, 6 Nov 2020 10:41:44 +0800 (CST)
Date:   Fri, 06 Nov 2020 10:41:44 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <1759b6e6328.fdde3abc11178.4917086206975298767@mykernel.net>
In-Reply-To: <20201105155434.GI32718@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-6-cgxu519@mykernel.net>
 <20201102173052.GF23988@quack2.suse.cz>
 <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
 <20201105140332.GG32718@quack2.suse.cz>
 <CAOQ4uxiH+1rV9_hkjed2jt7YF0CMJJVa6Fc+kbzeTuMXYAQ8MQ@mail.gmail.com> <20201105155434.GI32718@quack2.suse.cz>
Subject: Re: [RFC PATCH v2 5/8] ovl: mark overlayfs' inode dirty on shared
 writable mmap
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-11-05 23:54:34 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 05-11-20 16:21:27, Amir Goldstein wrote:
 > > On Thu, Nov 5, 2020 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
 > > >
 > > > On Wed 04-11-20 19:54:03, Chengguang Xu wrote:
 > > > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:30:52 J=
an Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > > > >  > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
 > > > >  > > Overlayfs cannot be notified when mmapped area gets dirty,
 > > > >  > > so we need to proactively mark inode dirty in ->mmap operatio=
n.
 > > > >  > >
 > > > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > > >  > > ---
 > > > >  > >  fs/overlayfs/file.c | 4 ++++
 > > > >  > >  1 file changed, 4 insertions(+)
 > > > >  > >
 > > > >  > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
 > > > >  > > index efccb7c1f9bc..cd6fcdfd81a9 100644
 > > > >  > > --- a/fs/overlayfs/file.c
 > > > >  > > +++ b/fs/overlayfs/file.c
 > > > >  > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *file, s=
truct vm_area_struct *vma)
 > > > >  > >          /* Drop reference count from new vm_file value */
 > > > >  > >          fput(realfile);
 > > > >  > >      } else {
 > > > >  > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
 > > > >  > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
 > > > >  > > +            ovl_mark_inode_dirty(file_inode(file));
 > > > >  > > +
 > > > >  >
 > > > >  > But does this work reliably? I mean once writeback runs, your i=
node (as
 > > > >  > well as upper inode) is cleaned. Then a page fault comes so fil=
e has dirty
 > > > >  > pages again and would need flushing but overlayfs inode stays c=
lean? Am I
 > > > >  > missing something?
 > > > >  >
 > > > >
 > > > > Yeah, this is key point of this approach, in order to  fix the iss=
ue I
 > > > > explicitly set I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), so wha=
t i
 > > > > mean is during writeback we will call into ->write_inode() by this
 > > > > flag(I_DIRTY_SYNC) and at that place we get chance to check mappin=
g and
 > > > > re-dirty overlay's inode. The code logic like below in ovl_write_i=
node().
 > > > >
 > > > >     if (mapping_writably_mapped(upper->i_mapping) ||
 > > > >          mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK)=
)
 > > > >                  iflag |=3D I_DIRTY_PAGES;
 > > >
 > > > OK, but suppose the upper mapping is clean at this moment (upper ino=
de has
 > > > been fully written out for whatever reason, but it is still mapped) =
so your
 > > > overlayfs inode becomes clean as well. Then I don't see a mechanism =
which
 > > > would make your overlayfs inode dirty again when a write to mmap hap=
pens,
 > > > set_page_dirty() will end up marking upper inode with I_DIRTY_PAGES =
flag.
 > > >
 > > > Note that ovl_mmap() gets called only at mmap(2) syscall time but th=
en
 > > > pages get faulted in, dirtied, cleaned fully at discretion of the mm
 > > > / writeback subsystem.
 > > >
 > >=20
 > > Perhaps I will add some background.
 > >=20
 > > What I suggested was to maintain a "suspect list" in addition to
 > > the dirty ovl inodes.
 > >=20
 > > ovl inode is added to the suspect list on mmap (writable) and removed
 > > from the suspect list on release() flush() or on sync_fs() if real ino=
de is no
 > > longer writably mapped.
 > >=20
 > > There was another variant where ovl inode is added to suspect list on =
open
 > > for write and removed from suspect list on release() flush() or sync_f=
s()
 > > if real inode is not inode_is_open_for_write().
 > >=20
 > > In both cases the list will have inodes whose real is not dirty, but
 > > in both cases
 > > the list shouldn't be terribly large to traverse on sync_fs().
 > >=20
 > > Chengguang tried to implement the idea without an actual list by
 > > re-dirtying the "suspect" inodes on every write_inode(), but I persona=
lly have
 > > no idea if his idea works.
 > >=20
 > > I think we can resort to using an actual suspect list if you say that =
it
 > > cannot work like this?
 >=20
 > Yeah, the suspect list (i.e., additional list of inodes to check on sync=
)
 > you describe should work fine.=20

I think this solution still has the problem we have met in below thread[1]
The main problem is the state combination of clean overlayfs' inode && dirt=
y upper inode.
=20
[1] https://www.spinics.net/lists/linux-unionfs/msg07448.html

 > Also the "keep suspect inode dirty" idea
 > of Chengguang could work fine but we'd have to use something like
 > inode_is_open_for_write() or inode_is_writeably_mapped() (which would ne=
ed
 > to be implemented but it should be easy vma_interval_tree_foreach() walk
 > checking each found VMA for vma->vm_flags & VM_WRITE) for checking wheth=
er
 > inode should be redirtied or not.
 >=20

I'm curious that isn't  it enough to check  i_mmap_writable by mapping_writ=
ably_mapped() ?
Am I missing something?


Thanks=EF=BC=8C
Chengguang
