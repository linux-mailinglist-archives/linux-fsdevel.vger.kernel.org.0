Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB33F28F14F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgJOLaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 07:30:23 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25318 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726996AbgJOLaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:30:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602761381; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=niWdd9rQClBSzHvqVGhcJKvA1GCOMNcixwILuyKpbVp+gMCG+YGVlZz+l1raECeMKErK5vXCAcmCMJsuZBKC8ciW+LwPi4k02oio7vDSLW+9pRVD2IsTgCzP1YMRLJUyUibVpJd2iXj4RVZJU9TUjFH9LZ9tSY7JF+ELy+APG0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1602761381; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=MurGVT8Vqd1xEV+hIbeyqx+eUvgC1DfVmPaFVZPv2e0=; 
        b=G9hQ/HCyPhOByYdLtaG92TTdYGcwg00t+fAoRHkm3Td+fVZPhs4iyQ5HSXG5xZYe3QOMzqFBsu5Yv+PXNp+dx0ZbQqsbDW4rlUZnKmVPTS29g1gZpfYuPqFKKjrBs12roxazPlMDmpUf+Av+t3UAsEqBFDmyikqab/1vkKSu3O8=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1602761381;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=MurGVT8Vqd1xEV+hIbeyqx+eUvgC1DfVmPaFVZPv2e0=;
        b=cIg44+yFwW/nAWo2O1cPromtytbz6OuERJog9QnTV4vqVXB39aEw06GOjOl4eEoK
        c613OjEEr6MKUtlI87bx3WAMU8LoSo8RMfTkiKlbakmsfZiXgDtNZFdBoQ/8zQbUpsg
        Y7wo1Ni36MWPvx6Y5nEusJtyehk3df+8jw8kRMWk=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1602761378792678.9441999715667; Thu, 15 Oct 2020 19:29:38 +0800 (CST)
Date:   Thu, 15 Oct 2020 19:29:38 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "Jan Kara" <jack@suse.cz>, "miklos" <miklos@szeredi.hu>,
        "linux-unionfs" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "cgxu519" <cgxu519@mykernel.net>
Message-ID: <1752c05cbe5.fd554a7a44272.2744418978249296745@mykernel.net>
In-Reply-To: <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
References: <20201010142355.741645-1-cgxu519@mykernel.net> <20201010142355.741645-2-cgxu519@mykernel.net>
 <20201014161538.GA27613@quack2.suse.cz> <1752a360692.e4f6555543384.3080516622688985279@mykernel.net> <CAOQ4uxhOrPfJxhJ1g7eSSdO4=giFJabCCOvJL7dSo1R9VsZozA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] fs: introduce notifier list for vfs inode
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 14:11:04 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Thu, Oct 15, 2020 at 6:03 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2020-10-15 00:15:38 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Sat 10-10-20 22:23:51, Chengguang Xu wrote:
 > >  > > Currently there is no notification api for kernel about modificat=
ion
 > >  > > of vfs inode, in some use cases like overlayfs, this kind of noti=
fication
 > >  > > will be very helpful to implement containerized syncfs functional=
ity.
 > >  > > As the first attempt, we introduce marking inode dirty notificati=
on so that
 > >  > > overlay's inode could mark itself dirty as well and then only syn=
c dirty
 > >  > > overlay inode while syncfs.
 > >  > >
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  >
 > >  > So I like how the patch set is elegant however growing struct inode=
 for
 > >  > everybody by struct blocking_notifier_head (which is rwsem + pointe=
r) is
 > >  > rather harsh just for this overlayfs functionality... Ideally this =
should
 > >  > induce no overhead on struct inode if the filesystem is not covered=
 by
 > >  > overlayfs. So I'd rather place some external structure into the sup=
erblock
 > >  > that would get allocated on the first use that would track dirty no=
tifications
 > >  > for each inode. I would not generalize the code for more possible
 > >  > notifications at this point.
 > >  >
 > >  > Also now that I'm thinking about it can there be multiple overlayfs=
 inodes
 > >  > for one upper inode? If not, then the mechanism of dirtiness propag=
ation
 > >
 > > One upper inode only belongs to one overlayfs inode. However, in pract=
ice
 > > one upper fs may contains hundreds or even thousands of overlayfs inst=
ances.
 > >
 > >  > could be much simpler - it seems we could be able to just lookup
 > >  > corresponding overlayfs inode based on upper inode and then mark it=
 dirty
 > >  > (but this would need to be verified by people more familiar with
 > >  > overlayfs). So all we'd need to know for this is the superblock of =
the
 > >  > overlayfs that's covering given upper filesystem...
 > >  >
 > >
 > > So the difficulty is how we get overlayfs inode efficiently from upper=
 inode,
 > > it seems if we don't have additional info of upper inode to indicate w=
hich
 > > overlayfs it belongs to,  then the lookup of corresponding overlayfs i=
node
 > > will be quite expensive and probably impact write performance.
 > >
 > > Is that possible we extend inotify infrastructure slightly to notify b=
oth
 > > user space and kernel component?
 > >
 > >
 >=20
 > When I first saw your suggestion, that is what I was thinking.
 > Add event fsnotify_dirty_inode(), since the pub-sub infrastructure
 > in struct inode already exists.
 >=20
 > But I have to admit this approach seems like a massive overkill to
 > what you need.
 >=20
 > What you implemented, tracks upper inodes that could have
 > been dirtied under overlayfs, but what you really want is to
 > track is upper inodes that were dirtied *by* overlayfs.
 >=20
 > And for that purpose, as Miklos said several times, it would be best
 > pursue the overlayfs aops approach, even though it may be much
 > harder..
 >=20

IIUC, that solution was raised to solve mmap rw-ro issue.
That maybe is an ultimate goal and I'm wondering whether we must
implement that if we have easier approach to solve mmap and syncfs
issues.

 > Your earlier patches maintained a list of overlayfs to be synced inodes.
 > Remind me what was wrong with that approach?
 >=20

I think the main concerns are the complexity and the timing of releasing
ovl_sync_entry  struct.


 > Perhaps you can combine that with the shadow overlay sbi approach.
 > Instead of dirtying overlay inode when underlying is dirtied, you can
 > "pre-dirty" overlayfs inode in higher level file ops and add them to the
 > "maybe-dirty" list (e.g. after write).
 >=20

Main problem is we can't be notified by set_page_dirty from writable mmap.
Meanwhile, if we dirty overlay inode then writeback will pick up dirty over=
lay
inode and clear it after syncing, then overlay inode could be release at an=
y time,
so in the end, maybe overlay inode is released but upper inode is still dir=
ty and
there is no any pointer to find upper dirty inode out.


 > ovl_sync_fs() can iterate the maybe-dirty list and re-dirty overlay inod=
es
 > if the underlying inode is still dirty on the (!wait) pass.
 >=20
 > As for memory mapped inodes via overlayfs (which can be dirtied without
 > notifying overlayfs) I am not sure that is a big problem in practice.
 >=20

Yes, it's key problem here.

 > When an inode is writably mapped via ovarlayfs, you can flag the
 > overlay inode with "maybe-writably-mapped" and then remove
 > it from the maybe dirty list when the underlying inode is not dirty
 > AND its i_writecount is 0 (checked on write_inode() and release()).
 >=20
 > Actually, there is no reason to treat writably mapped inodes and
 > other dirty inodes differently - insert to suspect list on open for
 > write, remove from suspect list on last release() or write_inode()
 > when inode is no longer dirty and writable.
 >=20
 > Did I miss anything?
 >=20

If we dirty overlay inode that means we have launched writeback mechanism,
so in this case, re-dirty overlay inode in time becomes important.=20



Thanks,
Chengguang
