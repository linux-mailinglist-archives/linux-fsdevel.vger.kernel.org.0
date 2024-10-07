Return-Path: <linux-fsdevel+bounces-31216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0B9932E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C58B23AAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A11DACB8;
	Mon,  7 Oct 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuXHKOzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D1A1DAC9F;
	Mon,  7 Oct 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317632; cv=none; b=O3bfN/4QyLI9TiOQcNIMm0EC7gOnOIrGSRLTUPeBSO7O/kUuyInKDQZwUR3MkAembZMjOXXaVBFkMHPkZnv13+Z/QPaPcaiapckjVpcQKwk9AIRBn1mHjapB9ULx9uy7FRYEc9Pq/Gb/eAjqEGFvNZQFYKcW2fDWwcFy04cxHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317632; c=relaxed/simple;
	bh=T7lUJ3R4cF9aAWBcQ84V/rp0o1tcqum0bACUdkSEU+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWPzMNWfR86JHvn4WKXLGF+z8/5R6ZjPIKanKX7x6TaReUH/tPz+Ler/gRCN1ABYAHt8xcqv8RiVDogRw7gI0pNs4hNN/hJdjCc+nobK+Dz2BTaf7KToz6rtEIs9yQMABLUbYu8uqHk2WJMdCZ1AAuq2Bw2ZHfK575b+CVbdp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuXHKOzl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728317630; x=1759853630;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=T7lUJ3R4cF9aAWBcQ84V/rp0o1tcqum0bACUdkSEU+8=;
  b=DuXHKOzlBNQybBoXVkNNYFOZH/QUg40vdmlXqlbLqwjKo7HKr6wASMFd
   +f1Nj8tW9orENMIxz2Cu+MVJ/zf7WmAm6AIs35k3TvLxESb7igLbNbDa6
   p2AYXF6M54jUzRUcdtKL21GnEVp1xn78aayY9zt0L0QCbZSEaAydl9cu9
   CzSoc2NbCbxDkudes3XTKIU+WdZKOt+ybaN1b4QAFy9GWqDkgwcaVvk8O
   WN1DsTlZ2IrgUV20HgfwkEi1rGfeFIbQkgc9dn4JsMm1Icbc7vz5LhFgl
   wbO+CGbdV3MYKNtBbiKAIn2IIjey7rb8lpglcs277tOsG+EPfdtknVAz6
   Q==;
X-CSE-ConnectionGUID: A/pnPHeqQ8eVZEy3Fp4N7g==
X-CSE-MsgGUID: 28ogqBv3QsKJu6TjTggblg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27357250"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27357250"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 09:13:50 -0700
X-CSE-ConnectionGUID: kvy8GJ/tRbKNJAf6jlMkrA==
X-CSE-MsgGUID: We4m2xhFSzu0+TZpg1hwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75779008"
Received: from hcaldwel-desk1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.222.43])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 09:13:49 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, hu1.chen@intel.com, malini.bhandaru@intel.com,
 tim.c.chen@intel.com, mikko.ylinen@intel.com,
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds()
 operations
In-Reply-To: <CAOQ4uxhuvBtSrbw2RAGKnO6O9dXH2DZ-fHJ=z8v+T+5PariZ0w@mail.gmail.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-5-vinicius.gomes@intel.com>
 <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
 <87wmk2lx3s.fsf@intel.com> <87h6a43gcc.fsf@intel.com>
 <20240925-umweht-schiffen-252e157b67f7@brauner> <87bk0b3jis.fsf@intel.com>
 <CAOQ4uxhuvBtSrbw2RAGKnO6O9dXH2DZ-fHJ=z8v+T+5PariZ0w@mail.gmail.com>
Date: Mon, 07 Oct 2024 09:13:48 -0700
Message-ID: <87o73vuc03.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Amir Goldstein <amir73il@gmail.com> writes:

> On Wed, Sep 25, 2024 at 4:17=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Christian Brauner <brauner@kernel.org> writes:
>>
>> > On Tue, Sep 24, 2024 at 06:13:39PM GMT, Vinicius Costa Gomes wrote:
>> >> Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:
>> >>
>> >> > Miklos Szeredi <miklos@szeredi.hu> writes:
>> >> >
>> >> >> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
>> >> >> <vinicius.gomes@intel.com> wrote:
>> >> >>>
>> >> >>> Add a comment to these operations that cannot use the _light vers=
ion
>> >> >>> of override_creds()/revert_creds(), because during the critical
>> >> >>> section the struct cred .usage counter might be modified.
>> >> >>
>> >> >> Why is it a problem if the usage counter is modified?  Why is the
>> >> >> counter modified in each of these cases?
>> >> >>
>> >> >
>> >> > Working on getting some logs from the crash that I get when I conve=
rt
>> >> > the remaining cases to use the _light() functions.
>> >> >
>> >>
>> >> See the log below.
>> >>
>> >> > Perhaps I was wrong on my interpretation of the crash.
>> >> >
>> >>
>> >> What I am seeing is that ovl_setup_cred_for_create() has a "side
>> >> effect", it creates another set of credentials, runs the security hoo=
ks
>> >> with this new credentials, and the side effect is that when it return=
s,
>> >> by design, 'current->cred' is this new credentials (a third set of
>> >> credentials).
>> >
>> > Well yes, during ovl_setup_cred_for_create() the fs{g,u}id needs to be
>> > overwritten. But I'm stil confused what the exact problem is as it was
>> > always clear that ovl_setup_cred_for_create() wouldn't be ported to
>> > light variants.
>> >
>> > /me looks...
>> >
>> >>
>> >> And this implies that refcounting for this is somewhat tricky, as said
>> >> in commit d0e13f5bbe4b ("ovl: fix uid/gid when creating over whiteout=
").
>> >>
>> >> I see two ways forward:
>> >>
>> >> 1. Keep using the non _light() versions in functions that call
>> >>    ovl_setup_cred_for_create().
>> >> 2. Change ovl_setup_cred_for_create() so it doesn't drop the "extra"
>> >>    refcount.
>> >>
>> >> I went with (1), and it still sounds to me like the best way, but I
>> >> agree that my explanation was not good enough, will add the informati=
on
>> >> I just learned to the commit message and to the code.
>> >>
>> >> Do you see another way forward? Or do you think that I should go with
>> >> (2)?
>> >
>> > ... ok, I understand. Say we have:
>> >
>> > ovl_create_tmpfile()
>> > /* current->cred =3D=3D ovl->creator_cred without refcount bump /*
>> > old_cred =3D ovl_override_creds_light()
>> > -> ovl_setup_cred_for_create()
>> >    /* Copy current->cred =3D=3D ovl->creator_cred */
>> >    modifiable_cred =3D prepare_creds()
>> >
>> >    /* Override current->cred =3D=3D modifiable_cred */
>> >    mounter_creds =3D override_creds(modifiable_cred)
>> >
>> >    /*
>> >     * And here's the BUG BUG BUG where we decrement the refcount on the
>> >     * constant mounter_creds.
>> >     */
>> >    put_cred(mounter_creds) // BUG BUG BUG
>> >
>> >    put_cred(modifiable_creds)
>> >
>> > So (1) is definitely the wrong option given that we can get rid of
>> > refcount decs and incs in the creation path.
>> >
>> > Imo, you should do (2) and add a WARN_ON_ONC(). Something like the
>> > __completely untested__:
>> >
>>
>> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
>> > index ab65e98a1def..e246e0172bb6 100644
>> > --- a/fs/overlayfs/dir.c
>> > +++ b/fs/overlayfs/dir.c
>> > @@ -571,7 +571,12 @@ static int ovl_setup_cred_for_create(struct dentr=
y *dentry, struct inode *inode,
>> >                 put_cred(override_cred);
>> >                 return err;
>> >         }
>> > -       put_cred(override_creds(override_cred));
>> > +
>> > +       /*
>> > +        * We must be called with creator creds already, otherwise we =
risk
>> > +        * leaking creds.
>> > +        */
>> > +       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dent=
ry->d_sb));
>> >         put_cred(override_cred);
>> >
>> >         return 0;
>> >
>>
>> At first glance, looks good. Going to test it and see how it works.
>> Thank you.
>>
>> For the next version of the series, my plan is to include this
>> suggestion/change and remove the guard()/scoped_guard() conversion
>> patches from the series.
>>
>
> Vinicius,
>
> I have a request. Since the plan is to keep the _light() helpers around f=
or the
> time being, please make the existing helper ovl_override_creds() use the
> light version and open code the non-light versions in the few places where
> they are needed and please replace all the matching call sites of
> revert_creds() to
> a helper ovl_revert_creds() that is a wrapper for the light version.
>

Seems like a good idea. Will do that, and see how it looks.

> Also, depending on when you intend to post your work for review,
> I have a feeling that the review of my patches is going to be done
> before your submit your patches for review, so you may want to consider
> already basing your patches on top of my development branch [2] to avoid
> conflicts later.
>

Thanks for the heads up. Will rebase my code on top of your branch.

> Anyway, the parts of my patches that conflict with yours (s/real.file/rea=
lfile/)
> are not likely to change anymore.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-unionfs/20241006082359.263755-1-amir73i=
l@gmail.com/
> [2] https://github.com/amir73il/linux/commits/ovl_real_file/


Cheers,
--=20
Vinicius

