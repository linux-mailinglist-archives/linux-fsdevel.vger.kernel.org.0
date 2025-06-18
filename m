Return-Path: <linux-fsdevel+bounces-52044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A75BADEDFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255E017DAA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403122E9732;
	Wed, 18 Jun 2025 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+D0gLRE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1C2165E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750253918; cv=none; b=GTcWp6T3DWj73SX6EKzE960H9d0DubT+fV1RP5TQMQ5bsbYGL6hwqm68/ux56mlwb9Qnu4IAN2bimYvXqdhyqfJB27g6qbRQINzjbrMiUGZySFVsi/s5zPZuwetKWzMSN5U0gb5MTeEbxNurAdkz65+6OjwzItEdxP9cgjethO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750253918; c=relaxed/simple;
	bh=P6v3zMIMdAzO8sXCoJt+xB2i3aByuTVZmdDk2/QEs84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEpKB5gyaa8gh3aS9Xg+W52JLhnqlHPjc67/tPnvvheQhqQRQ+dTvynFtNNuci8heksZDm5MQIzte8ohnBxOjtTgozrHe1BuZzMQmbtpW/xtPJFjKSz4Wag1X5sKkGKu2V21mlcMUUpFDcCqziPywt/Eq+CKOSJucZmNDGSfN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+D0gLRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C093C4CEE7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750253918;
	bh=P6v3zMIMdAzO8sXCoJt+xB2i3aByuTVZmdDk2/QEs84=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J+D0gLREIP4p6ch8wFZdE2FxNgVnJp0PAbj42JLMuUl8tSXem1E1V7uTQht+AdCdm
	 gOABnIdaXkVg9sEhP+94zBokvnSAtI9OStjujNaBwcsiDkEc0+hkrOvwUbz90TWNZg
	 xrRXAEpqCGLK7JYEVm44bymMQW1rLhZNMuYmIRsrnvE3u/gl7U5ufaHZQSugJrRS6k
	 lp/b6KV56jdCnfXkqMFIcMQZYFgxsxsgCxQdqC2I1PBvGDpeo1HGNtWYa+bSKeB2FU
	 hgTCE5d3p5mb89+PPSANue1S7fW5d2LyoInofGr82PDdIEkOJn7WU3mahkyO0gJLfN
	 zN6Ok9N+/Ordg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adf34d5e698so156078666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 06:38:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRTSLuv0UWromAn3B+GcQmICFr5/+jgS8AP3l0D2cBJcUEwmu7WkOjKdt7YumeMN0apv4mdt4VMlHi1WDs@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWJjARySi/+mQmJVfY5+mg7djNKIgTgOogZS/yFLLFrKUXcl7
	6nOjGSwxAVAIOTNi2Xgtwy50MBMyZwZo6r0eT2W/nVhNgQmoIluoA49fiUUOsom/SDdIPMwnKXS
	ZDLdLAZ1pN+t1tVNd/f64ycZPTLVcZeM=
X-Google-Smtp-Source: AGHT+IGy76oFQtVDb/G3nLtR5vVHognCAnEZLpUggFoZCMgr52+CLqzapahD84x2tCP5sDdMUoa2az8iN5im83nbAYo=
X-Received: by 2002:a17:907:7ea1:b0:add:fb5f:75b with SMTP id
 a640c23a62f3a-ae01f4b63b6mr290308566b.2.1750253916669; Wed, 18 Jun 2025
 06:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613103802.619272-2-Yuezhang.Mo@sony.com> <CAKYAXd_TFNnbJLNsYFW4=mCzVyx1ZqhuLD58aLD5cWu2uk2+Qw@mail.gmail.com>
 <PUZPR04MB6316B26325B23BD49C3DC97C8173A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-p6-HcjS4ZZHJ4YDsYgynBLczWKLJbh-5ATHyDHLCwGw@mail.gmail.com> <PUZPR04MB63162AAAE1128A915F966E388172A@PUZPR04MB6316.apcprd04.prod.outlook.com>
In-Reply-To: <PUZPR04MB63162AAAE1128A915F966E388172A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 18 Jun 2025 22:38:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9tWd1sycqsBUWZMiZXgxnDK5k4yH2Xe8M=YvmYErrynw@mail.gmail.com>
X-Gm-Features: Ac12FXwQ7hPeqju4Dkp9jLc33426y3eNYPwoQvVE0QoMshwRyrZZP61XWnvSo3k
Message-ID: <CAKYAXd9tWd1sycqsBUWZMiZXgxnDK5k4yH2Xe8M=YvmYErrynw@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: add cluster chain loop check for dir
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 8:10=E2=80=AFPM Yuezhang.Mo@sony.com
<Yuezhang.Mo@sony.com> wrote:
>
> > On Tue, Jun 17, 2025 at 2:38=E2=80=AFPM Yuezhang.Mo@sony.com
> > <Yuezhang.Mo@sony.com> wrote:
> > >
> > > > On Fri, Jun 13, 2025 at 7:39=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@so=
ny.com> wrote:
> > > > >
> > > > > An infinite loop may occur if the following conditions occur due =
to
> > > > > file system corruption.
> > > > >
> > > > > (1) Condition for exfat_count_dir_entries() to loop infinitely.
> > > > >     - The cluster chain includes a loop.
> > > > >     - There is no UNUSED entry in the cluster chain.
> > > > >
> > > > > (2) Condition for exfat_create_upcase_table() to loop infinitely.
> > > > >     - The cluster chain of the root directory includes a loop.
> > > > >     - There are no UNUSED entry and up-case table entry in the cl=
uster
> > > > >       chain of the root directory.
> > > > >
> > > > > (3) Condition for exfat_load_bitmap() to loop infinitely.
> > > > >     - The cluster chain of the root directory includes a loop.
> > > > >     - There are no UNUSED entry and bitmap entry in the cluster c=
hain
> > > > >       of the root directory.
> > > > >
> > > > > This commit adds checks in exfat_count_num_clusters() and
> > > > > exfat_count_dir_entries() to see if the cluster chain includes a =
loop,
> > > > > thus avoiding the above infinite loops.
> > > > >
> > > > > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > > > > ---
> > > > >  fs/exfat/dir.c    | 33 +++++++++++++++++++++------------
> > > > >  fs/exfat/fatent.c | 10 ++++++++++
> > > > >  fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
> > > > >  3 files changed, 52 insertions(+), 23 deletions(-)
> > > > >
> > > > > diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> > > > > index 3103b932b674..467271ad4d71 100644
> > > > > --- a/fs/exfat/dir.c
> > > > > +++ b/fs/exfat/dir.c
> > > > > @@ -1194,7 +1194,8 @@ int exfat_count_dir_entries(struct super_bl=
ock *sb, struct exfat_chain *p_dir)
> > > > >  {
> > > > >         int i, count =3D 0;
> > > > >         int dentries_per_clu;
> > > > > -       unsigned int entry_type;
> > > > > +       unsigned int entry_type =3D TYPE_FILE;
> > > > > +       unsigned int clu_count =3D 0;
> > > > >         struct exfat_chain clu;
> > > > >         struct exfat_dentry *ep;
> > > > >         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > > > > @@ -1205,18 +1206,26 @@ int exfat_count_dir_entries(struct super_=
block *sb, struct exfat_chain *p_dir)
> > > > >         exfat_chain_dup(&clu, p_dir);
> > > > >
> > > > >         while (clu.dir !=3D EXFAT_EOF_CLUSTER) {
> > > > > -               for (i =3D 0; i < dentries_per_clu; i++) {
> > > > > -                       ep =3D exfat_get_dentry(sb, &clu, i, &bh)=
;
> > > > > -                       if (!ep)
> > > > > -                               return -EIO;
> > > > > -                       entry_type =3D exfat_get_entry_type(ep);
> > > > > -                       brelse(bh);
> > > > > +               clu_count++;
> > > > > +               if (clu_count > sbi->used_clusters) {
> > > >                     if (++clu_count > sbi->used_clusters) {
> > >
> > > Well, that's more concise.
> > >
> > > > > +                       exfat_fs_error(sb, "dir size or FAT or bi=
tmap is corrupted");
> > > > > +                       return -EIO;
> > > > > +               }
> > > > >
> > > > > -                       if (entry_type =3D=3D TYPE_UNUSED)
> > > > > -                               return count;
> > > > > -                       if (entry_type !=3D TYPE_DIR)
> > > > > -                               continue;
> > > > > -                       count++;
> > > > > +               if (entry_type !=3D TYPE_UNUSED) {
> > > > > +                       for (i =3D 0; i < dentries_per_clu; i++) =
{
> > > > > +                               ep =3D exfat_get_dentry(sb, &clu,=
 i, &bh);
> > > > > +                               if (!ep)
> > > > > +                                       return -EIO;
> > > > > +                               entry_type =3D exfat_get_entry_ty=
pe(ep);
> > > > > +                               brelse(bh);
> > > > > +
> > > > > +                               if (entry_type =3D=3D TYPE_UNUSED=
)
> > > > > +                                       break;
> > > > Is there any reason why you keep doing loop even though you found a=
n
> > > > unused entry?
> > >
> > > There are unused directory entries when calling this func, but there
> > > may be none after files are created. That will cause a infinite loop =
in
> > > exfat_check_dir_empty() and exfat_find_dir_entry().
> > Isn't the infinite loop issue in this patch improved by checking
> > clu_count and ->used_clusters?
> > If it reaches an unused entry, how about returning right away like befo=
re?
> >
>
> It reaches an unused directory entry and exits the loop, but it does not
> find that the cluster chain includes a loop. After using up these unused
> directory entries, an infinite loop will occur in exfat_check_dir_empty()
> and exfat_find_dir_entry(). To avoid this, it continues traversing to ens=
ure
> that the cluster chain does not include a loop.
>
> For an un-corrupted file system, unused directory entries will only in th=
e
> last cluster, so this only makes FAT is read one more time. What concerns
> do you have about this?
You described there is a potential infinite loop when there is no unused en=
try
in the patch description. There is an unused type check to break a loop in
exfat_check_dir_empty and exfat_find_dir_entry. I can not understand how
there can be an infinite loop if there is an unused entry. So there is no n=
eed
to strictly check the self-linked chain in exfat_count_dir_entries when the=
re
is an unused entry. It can be treated as an error even though it can be
handled normally.

