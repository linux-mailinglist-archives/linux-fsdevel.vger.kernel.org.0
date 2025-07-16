Return-Path: <linux-fsdevel+bounces-55112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4426B06FD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 10:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE84B3B9729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAF289E3D;
	Wed, 16 Jul 2025 08:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC881E3762;
	Wed, 16 Jul 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653107; cv=none; b=YvxoScal8yimNeocFGK57pA9sD+WBAK6gCBO1HMlSVEUANrVdee9Ena0geY7YRBeb1l2EByrcZgO/cWxM2fy9T7n07HGaAvILAJkCAX7wf6cfvDl2JtZ96PM97yBfdknuEiKMJIhuhZ5EEW/lgTMr92FJvacV4NoHlLTABYND8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653107; c=relaxed/simple;
	bh=Drijb9KcyLwFGqdDOC3lxQjDczhb6cWYaWgPIl6wBFI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=CtkxctClser3Iwu0ZBJdKHHmYxhOaCOnhl07uj741enBG40Ps7mMaFXr2/GI92+sFbpZJQbe7AsIOvyFJoTn0Oec2LI8TqLkxD77N+0b9hOOTljyIvnbA1eVDu+guayI0qvrPtG2ifpuM23d6lTe0xY2MzYOST0q/1a+eWkTRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubx8P-002CKy-Dr;
	Wed, 16 Jul 2025 08:05:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Miklos Szeredi" <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
In-reply-to:
 <CAOQ4uxiHNyBmJUSwFxpvkor_-h=GJEeZuD4Kkxus-1X81bgVEQ@mail.gmail.com>
References:
 <>, <CAOQ4uxiHNyBmJUSwFxpvkor_-h=GJEeZuD4Kkxus-1X81bgVEQ@mail.gmail.com>
Date: Wed, 16 Jul 2025 18:05:02 +1000
Message-id: <175265310294.2234665.3973700598223000667@noble.neil.brown.name>

On Wed, 16 Jul 2025, Amir Goldstein wrote:
> On Wed, Jul 16, 2025 at 9:19=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
> >
> > On Wed, 16 Jul 2025, Amir Goldstein wrote:
> > > On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wro=
te:
> > > >
> > > > More excellent review feedback - more patches :-)
> > > >
> > > > I've chosen to use ovl_parent_lock() here as a temporary and leave the
> > > > debate over naming for the VFS version of the function until all the =
new
> > > > names are introduced later.
> > >
> > > Perfect.
> > >
> > > Please push v3 patches to branch pdirops, or to a clean branch
> > > based on vfs-6.17.file, so I can test them.
> >
> > There is a branch "ovl" which is based on vfs.all as I depend on a
> > couple of other vfs changes.
>=20
> ok I will test this one.
>=20
> Do you mean that ovl branch depends on other vfs changes or that pdirops
> which is based on ovl branch depends on other vfs changes?

ovl branch depends on

Commit bc9241367aac ("VFS: change old_dir and new_dir in struct renamedata to=
 dentrys")

Thanks,
NeilBrown

>=20
> Just asking because I did not notice any other dependencies in ovl branch,
> so wanted to know which are they.
>=20
> Thanks,
> Amir.
>=20


