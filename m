Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B022A9346
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 10:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgKFJs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 04:48:26 -0500
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25314 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgKFJsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:48:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604656077; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=MSmTPSwjzWLU5Bhgctdkm0Vgxtdf8Ox1bbgazQFhUXCoYklXhsQCDFfTbNWGST35+dVif1mOO/duJ9Z2Dgykg5MVjTVbd9fAThM9qaOdJWS0D1gvxW3OsHjLRyO19KBg5caP9LofJm9HrQxgCAcqEf/iqxwR+pKSfo80Sva7c8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1604656077; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=+LDnOM55hFpykMdYrDdRYXpDthm7MbEXewulUu6Zd94=; 
        b=d/dFl1KCuJyW6IB7jhjCTMzEc4GSPpjAlSJBhAsu37ZbGLbzVdtF0teDOeFL7Y038dJA34EdkxDszip9fS/7l8j/2ofG7xwh+S/pijmrA2Bj3Ffw4v2DDU3hOypnQDNTw78pFvr6KtcpHYFT+ZNBB98aLy1AhiOZmCSgS3sSJpw=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1604656077;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=+LDnOM55hFpykMdYrDdRYXpDthm7MbEXewulUu6Zd94=;
        b=Eg4Fq1wGL3bKwXkJAFDzSy5taRghc8GrQVWtMjKVrQD3Zo9o6f4qw/AqPtlX6o9P
        r66YkDPLpLkTzNrNGusfjuO8/kP1tyvyQCfhWV7SqdoQr8gxZkdqUyVredag1xNNnW5
        h6dBzEra4LzohWjSxAtXdOaHSiNkK+ZqGeN6zjBw=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1604656075468540.3725758477291; Fri, 6 Nov 2020 17:47:55 +0800 (CST)
Date:   Fri, 06 Nov 2020 17:47:55 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Amir Goldstein" <amir73il@gmail.com>,
        "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <1759cf492c8.11cac446f12251.3388484787199140990@mykernel.net>
In-Reply-To: <20201106085023.GA25479@quack2.suse.cz>
References: <20201025034117.4918-1-cgxu519@mykernel.net>
 <20201025034117.4918-6-cgxu519@mykernel.net>
 <20201102173052.GF23988@quack2.suse.cz>
 <175931b5387.1349cecf47061.3904278910555065520@mykernel.net>
 <20201105140332.GG32718@quack2.suse.cz>
 <CAOQ4uxiH+1rV9_hkjed2jt7YF0CMJJVa6Fc+kbzeTuMXYAQ8MQ@mail.gmail.com>
 <20201105155434.GI32718@quack2.suse.cz>
 <1759b6e6328.fdde3abc11178.4917086206975298767@mykernel.net> <20201106085023.GA25479@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2020-11-06 16:50:23 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Fri 06-11-20 10:41:44, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-11-05 23:54:34 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Thu 05-11-20 16:21:27, Amir Goldstein wrote:
 > >  > > On Thu, Nov 5, 2020 at 4:03 PM Jan Kara <jack@suse.cz> wrote:
 > >  > > >
 > >  > > > On Wed 04-11-20 19:54:03, Chengguang Xu wrote:
 > >  > > > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2020-11-03 01:30=
:52 Jan Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > > > >  > On Sun 25-10-20 11:41:14, Chengguang Xu wrote:
 > >  > > > >  > > Overlayfs cannot be notified when mmapped area gets dirt=
y,
 > >  > > > >  > > so we need to proactively mark inode dirty in ->mmap ope=
ration.
 > >  > > > >  > >
 > >  > > > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > > > >  > > ---
 > >  > > > >  > >  fs/overlayfs/file.c | 4 ++++
 > >  > > > >  > >  1 file changed, 4 insertions(+)
 > >  > > > >  > >
 > >  > > > >  > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
 > >  > > > >  > > index efccb7c1f9bc..cd6fcdfd81a9 100644
 > >  > > > >  > > --- a/fs/overlayfs/file.c
 > >  > > > >  > > +++ b/fs/overlayfs/file.c
 > >  > > > >  > > @@ -486,6 +486,10 @@ static int ovl_mmap(struct file *fi=
le, struct vm_area_struct *vma)
 > >  > > > >  > >          /* Drop reference count from new vm_file value =
*/
 > >  > > > >  > >          fput(realfile);
 > >  > > > >  > >      } else {
 > >  > > > >  > > +        if (vma->vm_flags & (VM_SHARED|VM_MAYSHARE) &&
 > >  > > > >  > > +            vma->vm_flags & (VM_WRITE|VM_MAYWRITE))
 > >  > > > >  > > +            ovl_mark_inode_dirty(file_inode(file));
 > >  > > > >  > > +
 > >  > > > >  >
 > >  > > > >  > But does this work reliably? I mean once writeback runs, y=
our inode (as
 > >  > > > >  > well as upper inode) is cleaned. Then a page fault comes s=
o file has dirty
 > >  > > > >  > pages again and would need flushing but overlayfs inode st=
ays clean? Am I
 > >  > > > >  > missing something?
 > >  > > > >  >
 > >  > > > >
 > >  > > > > Yeah, this is key point of this approach, in order to  fix th=
e issue I
 > >  > > > > explicitly set I_DIRTY_SYNC flag in ovl_mark_inode_dirty(), s=
o what i
 > >  > > > > mean is during writeback we will call into ->write_inode() by=
 this
 > >  > > > > flag(I_DIRTY_SYNC) and at that place we get chance to check m=
apping and
 > >  > > > > re-dirty overlay's inode. The code logic like below in ovl_wr=
ite_inode().
 > >  > > > >
 > >  > > > >     if (mapping_writably_mapped(upper->i_mapping) ||
 > >  > > > >          mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITE=
BACK))
 > >  > > > >                  iflag |=3D I_DIRTY_PAGES;
 > >  > > >
 > >  > > > OK, but suppose the upper mapping is clean at this moment (uppe=
r inode has
 > >  > > > been fully written out for whatever reason, but it is still map=
ped) so your
 > >  > > > overlayfs inode becomes clean as well. Then I don't see a mecha=
nism which
 > >  > > > would make your overlayfs inode dirty again when a write to mma=
p happens,
 > >  > > > set_page_dirty() will end up marking upper inode with I_DIRTY_P=
AGES flag.
 > >  > > >
 > >  > > > Note that ovl_mmap() gets called only at mmap(2) syscall time b=
ut then
 > >  > > > pages get faulted in, dirtied, cleaned fully at discretion of t=
he mm
 > >  > > > / writeback subsystem.
 > >  > > >
 > >  > >=20
 > >  > > Perhaps I will add some background.
 > >  > >=20
 > >  > > What I suggested was to maintain a "suspect list" in addition to
 > >  > > the dirty ovl inodes.
 > >  > >=20
 > >  > > ovl inode is added to the suspect list on mmap (writable) and rem=
oved
 > >  > > from the suspect list on release() flush() or on sync_fs() if rea=
l inode is no
 > >  > > longer writably mapped.
 > >  > >=20
 > >  > > There was another variant where ovl inode is added to suspect lis=
t on open
 > >  > > for write and removed from suspect list on release() flush() or s=
ync_fs()
 > >  > > if real inode is not inode_is_open_for_write().
 > >  > >=20
 > >  > > In both cases the list will have inodes whose real is not dirty, =
but
 > >  > > in both cases
 > >  > > the list shouldn't be terribly large to traverse on sync_fs().
 > >  > >=20
 > >  > > Chengguang tried to implement the idea without an actual list by
 > >  > > re-dirtying the "suspect" inodes on every write_inode(), but I pe=
rsonally have
 > >  > > no idea if his idea works.
 > >  > >=20
 > >  > > I think we can resort to using an actual suspect list if you say =
that it
 > >  > > cannot work like this?
 > >  >=20
 > >  > Yeah, the suspect list (i.e., additional list of inodes to check on=
 sync)
 > >  > you describe should work fine.=20
 > >=20
 > > I think this solution still has the problem we have met in below threa=
d[1]
 > > The main problem is the state combination of clean overlayfs' inode &&=
 dirty upper inode.
 >=20
 > But I think the scheme Amir proposed and I detailed in my previous email
 > should prevent that state. Because while the inode is mapped, it will be
 > kept in the dirty list. So which scenario do you think would lead to cle=
an
 > overlayfs inode and dirty upper inode?

If keeping in the dirty list means making  overlayfs inode dirty, then
I think we don't need extra list for that, vfs itself has writeback list an=
d
the solution will be exactly the same as mine(re-dirty) . Right?


 >=20
 > > [1] https://www.spinics.net/lists/linux-unionfs/msg07448.html
 > >=20
 > >  > Also the "keep suspect inode dirty" idea
 > >  > of Chengguang could work fine but we'd have to use something like
 > >  > inode_is_open_for_write() or inode_is_writeably_mapped() (which wou=
ld need
 > >  > to be implemented but it should be easy vma_interval_tree_foreach()=
 walk
 > >  > checking each found VMA for vma->vm_flags & VM_WRITE) for checking =
whether
 > >  > inode should be redirtied or not.
 > >  >=20
 > >=20
 > > I'm curious that isn't  it enough to check  i_mmap_writable by
 > > mapping_writably_mapped() ?  Am I missing something?
 >=20
 > What is i_mmap_writeable? I've grepped the tree and didn't find anything
 > like that...
 >=20

Maybe spelling mistake? The reason I check this is I'm afraid of the permis=
sion change of vma by mprotect(2).


Thanks,
Chenguang
