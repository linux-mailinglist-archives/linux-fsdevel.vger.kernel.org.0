Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE7463B4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbhK3QON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:14:13 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25301 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244293AbhK3QN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:13:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1638288556; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SBY1/pLmOX7pw9gnrP64yI13o3y3rwmACsQT6miGYjao3G43Pib5aSAtBCpUoYfQWpEoVmb39qccy3O7M6YGX4tIcBWFpfpf9M9orCLS08KxaI6DPSHW6KCoNiJgmFQbfYlS1+1anaGIkwSMHvaBYdR5FG1c65mM88r6r3U61io=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1638288556; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=le2jP4zZr2Oj/4+xBXN47Nj05pQ6pMRytJX82KSxAyM=; 
        b=aR802JcHFkC1xkEUtgF7cxnZFIZLOQLItak+uJEY9BOalqEpCY70pCz6P2rh/SO8ItnFeosxsOw/do1aQfaphIWHc3k9EdUec/Mg8RWPjKSsEUxvE7hEUgDI3RIRn4gIrnV86QrdDgmHys+k80Yj6rgoo+px3TWtnH0cK1/m5gs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1638288556;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=le2jP4zZr2Oj/4+xBXN47Nj05pQ6pMRytJX82KSxAyM=;
        b=EA/2d5A0lj8e2QXiC2ibVVjLV0cCtPbMbbT+HwtBbmlv+Z6cPt/gb2qFi7q/2vAT
        xLfowkislQHJVFiE3L5fJnZN4kvVAhM0163TjHZywYfSmr3e+FNjq3/dRMy64XAsLpw
        8sOP89rVeSEgqCe5dDPd0plG/OdW3rO6RQA0ofnY=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1638288554514727.797018234731; Wed, 1 Dec 2021 00:09:14 +0800 (CST)
Date:   Wed, 01 Dec 2021 00:09:14 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "Miklos Szeredi" <miklos@szeredi.hu>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "ronyjin" <ronyjin@tencent.com>,
        "charliecgxu" <charliecgxu@tencent.com>
Message-ID: <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
In-Reply-To: <20211130112206.GE7174@quack2.suse.cz>
References: <17c5adfe5ea.12f1be94625921.4478415437452327206@mykernel.net>
 <CAJfpegt4jZpSCXGFk2ieqUXVm3m=ng7QtSzZp2bXVs07bfrbXg@mail.gmail.com>
 <17d268ba3ce.1199800543649.1713755891767595962@mykernel.net>
 <CAJfpegttQreuuD_jLgJmrYpsLKBBe2LmB5NSj6F5dHoTzqPArw@mail.gmail.com>
 <17d2c858d76.d8a27d876510.8802992623030721788@mykernel.net>
 <17d31bf3d62.1119ad4be10313.6832593367889908304@mykernel.net>
 <20211118112315.GD13047@quack2.suse.cz>
 <17d32ecf46e.124314f8f672.8832559275193368959@mykernel.net>
 <20211118164349.GB8267@quack2.suse.cz>
 <17d36d37022.1227b6f102736.1047689367927335302@mykernel.net> <20211130112206.GE7174@quack2.suse.cz>
Subject: Re: [RFC PATCH v5 06/10] ovl: implement overlayfs' ->write_inode
 operation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-30 19:22:06 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Fri 19-11-21 14:12:46, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-11-19 00:43:49 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Thu 18-11-21 20:02:09, Chengguang Xu wrote:
 > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-11-18 19:23:15 =
Jan Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > >  > On Thu 18-11-21 14:32:36, Chengguang Xu wrote:
 > >  > >  > >=20
 > >  > >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2021-11-17 14:1=
1:29 Chengguang Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 > >  > >  > >  >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2021-11-16 2=
0:35:55 Miklos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > >  > >  >  > On Tue, 16 Nov 2021 at 03:20, Chengguang Xu <cgxu519@m=
ykernel.net> wrote:
 > >  > >  > >  >  > >
 > >  > >  > >  >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-10=
-07 21:34:19 Miklos Szeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
 > >  > >  > >  >  > >  > On Thu, 7 Oct 2021 at 15:10, Chengguang Xu <cgxu5=
19@mykernel.net> wrote:
 > >  > >  > >  >  > >  > >  > However that wasn't what I was asking about.=
  AFAICS ->write_inode()
 > >  > >  > >  >  > >  > >  > won't start write back for dirty pages.   Ma=
ybe I'm missing something,
 > >  > >  > >  >  > >  > >  > but there it looks as if nothing will actual=
ly trigger writeback for
 > >  > >  > >  >  > >  > >  > dirty pages in upper inode.
 > >  > >  > >  >  > >  > >  >
 > >  > >  > >  >  > >  > >
 > >  > >  > >  >  > >  > > Actually, page writeback on upper inode will be=
 triggered by overlayfs ->writepages and
 > >  > >  > >  >  > >  > > overlayfs' ->writepages will be called by vfs w=
riteback function (i.e writeback_sb_inodes).
 > >  > >  > >  >  > >  >
 > >  > >  > >  >  > >  > Right.
 > >  > >  > >  >  > >  >
 > >  > >  > >  >  > >  > But wouldn't it be simpler to do this from ->writ=
e_inode()?
 > >  > >  > >  >  > >  >
 > >  > >  > >  >  > >  > I.e. call write_inode_now() as suggested by Jan.
 > >  > >  > >  >  > >  >
 > >  > >  > >  >  > >  > Also could just call mark_inode_dirty() on the ov=
erlay inode
 > >  > >  > >  >  > >  > regardless of the dirty flags on the upper inode =
since it shouldn't
 > >  > >  > >  >  > >  > matter and results in simpler logic.
 > >  > >  > >  >  > >  >
 > >  > >  > >  >  > >
 > >  > >  > >  >  > > Hi Miklos=EF=BC=8C
 > >  > >  > >  >  > >
 > >  > >  > >  >  > > Sorry for delayed response for this, I've been busy =
with another project.
 > >  > >  > >  >  > >
 > >  > >  > >  >  > > I agree with your suggesion above and further more h=
ow about just mark overlay inode dirty
 > >  > >  > >  >  > > when it has upper inode? This approach will make mar=
king dirtiness simple enough.
 > >  > >  > >  >  >=20
 > >  > >  > >  >  > Are you suggesting that all non-lower overlay inodes s=
hould always be dirty?
 > >  > >  > >  >  >=20
 > >  > >  > >  >  > The logic would be simple, no doubt, but there's the c=
ost to walking
 > >  > >  > >  >  > those overlay inodes which don't have a dirty upper in=
ode, right? =20
 > >  > >  > >  >=20
 > >  > >  > >  > That's true.
 > >  > >  > >  >=20
 > >  > >  > >  >  > Can you quantify this cost with a benchmark?  Can be t=
otally synthetic,
 > >  > >  > >  >  > e.g. lookup a million upper files without modifying th=
em, then call
 > >  > >  > >  >  > syncfs.
 > >  > >  > >  >  >=20
 > >  > >  > >  >=20
 > >  > >  > >  > No problem, I'll do some tests for the performance.
 > >  > >  > >  >=20
 > >  > >  > >=20
 > >  > >  > > Hi Miklos,
 > >  > >  > >=20
 > >  > >  > > I did some rough tests and the results like below.  In pract=
ice,  I don't
 > >  > >  > > think that 1.3s extra time of syncfs will cause significant =
problem.
 > >  > >  > > What do you think?
 > >  > >  >=20
 > >  > >  > Well, burning 1.3s worth of CPU time for doing nothing seems l=
ike quite a
 > >  > >  > bit to me. I understand this is with 1000000 inodes but althou=
gh that is
 > >  > >  > quite a few it is not unheard of. If there would be several co=
ntainers
 > >  > >  > calling sync_fs(2) on the machine they could easily hog the ma=
chine... That
 > >  > >  > is why I was originally against keeping overlay inodes always =
dirty and
 > >  > >  > wanted their dirtiness to at least roughly track the real need=
 to do
 > >  > >  > writeback.
 > >  > >  >=20
 > >  > >=20
 > >  > > Hi Jan,
 > >  > >=20
 > >  > > Actually, the time on user and sys are almost same with directly =
excute syncfs on underlying fs.
 > >  > > IMO, it only extends syncfs(2) waiting time for perticular contai=
ner but not burning cpu.
 > >  > > What am I missing?
 > >  >=20
 > >  > Ah, right, I've missed that only realtime changed, not systime. I'm=
 sorry
 > >  > for confusion. But why did the realtime increase so much? Are we wa=
iting
 > >  > for some IO?
 > >  >=20
 > >=20
 > > There are many places to call cond_resched() in writeback process,
 > > so sycnfs process was scheduled several times.
 >=20
 > I was thinking about this a bit more and I don't think I buy this
 > explanation. What I rather think is happening is that real work for sync=
fs
 > (writeback_inodes_sb() and sync_inodes_sb() calls) gets offloaded to a f=
lush
 > worker. E.g. writeback_inodes_sb() ends up calling
 > __writeback_inodes_sb_nr() which does:
 >=20
 > bdi_split_work_to_wbs()
 > wb_wait_for_completion()
 >=20
 > So you don't see the work done in the times accounted to your test
 > program. But in practice the flush worker is indeed burning 1.3s worth o=
f
 > CPU to scan the 1 million inode list and do nothing.
 >=20

That makes sense. However, in real container use case,  the upper dir is al=
ways empty,
so I don't think there is meaningful difference compare to accurately marki=
ng overlay
inode dirty. =20

I'm not very familiar with other use cases of overlayfs except container, s=
hould we consider
other use cases? Maybe we can also ignore the cpu burden because those use =
cases don't
have density deployment like container.



Thanks,
Chengguang



