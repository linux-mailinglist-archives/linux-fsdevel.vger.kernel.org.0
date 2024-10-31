Return-Path: <linux-fsdevel+bounces-33368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC69B8311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3395A282516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A80A1C9EB3;
	Thu, 31 Oct 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1CUvdAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481813C8FF
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401624; cv=none; b=kRvIlKzkBT/IkZDBX+fL4394UdW7lZtjFDVVAOqt9c+U77o1cFLO4Y6JD4nkJVNvvfp7j0+gJSkCG+fRdoJVVMFImO7OiINii0F5wR6sy5Dq+i/2qCztHSKvVoNfQphXqoh6MtYZnNHx6IP1o81mn4TkHDLkEvfUiWFHkP+sEBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401624; c=relaxed/simple;
	bh=+RBphthZTBzrNiL2LY0HGqi6z0QMZ9zMdxDe6rHMSog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIOlGi70fI4tiUDRkTjw4rINat0ijFQJWzZgl64e/SY7Be0NMDK9NMZ+Tpg3DNrbULQtpznYsY20NFzjU69LaOPCWPX1K1RyVJ4Zfkhv+MFaMOBy1vYjH4Pj22NGThzc6RgK+gfLbD5xiXm6yfUHZ1DXMF3Ldf4PsDRwC3D5l7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1CUvdAs; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4608e389407so15626451cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730401621; x=1731006421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RBphthZTBzrNiL2LY0HGqi6z0QMZ9zMdxDe6rHMSog=;
        b=X1CUvdAs0ZmlL1A2kbVelC3334Hc08FScXa1fuuFSZtxeOI/6LG0xjCCxMW0z+ySRO
         XbCxJcPTEjPU8z86tQ0xMou/FNbSYIW7LMVAP5GPXizbjm7OG5iITtCUg9qEa/uXFTHf
         a81xGvJmPhEgqKY1svgypAUd6zsea8Yl/jjN4T3yZo3Ev2CEZlArcr+fFS3diX8CWgAm
         Dk2TTXidHaZaGUgFDU1FKPyHR14+pFxCn0GJW/nkt/IY33saNu8jTDIJLvYxJmvIeXCB
         hTyrdFVt4kUJQk7ubYJ9Bz9rFiNt+BSxxoufE49LuqnoJ5emt2wrFehuUdbQIOVMx81v
         Hrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730401621; x=1731006421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RBphthZTBzrNiL2LY0HGqi6z0QMZ9zMdxDe6rHMSog=;
        b=ZvmWOxsZPJ/TOPVxMx/yuktos1mQ8/bDfeGooB2FfunHEI/4VHRnwchByoi9mg7fvC
         +lm3Bhw0cKTlWUXK9sdYYo5caEJ0D3X3aV0nAoJdOL6WhoK/Hm0vsq9TFceBVzWIcy16
         mNFl12oCU0rO4tFIyp+JK5SCZkEPy29Y35YAwiR+urll3GUzQk38au5/oIr0mOLwoyo7
         4CPnpbjEhyUcMHblSqJVj7oz6KKTrfxE74frr/rss+qiW0Cwg2UUmffPxmuErhE53lB8
         G4+7fqLCbYifXiG6xw/a2OJzGZo/L/WHyUm1L7kli+R9AnqvY0UXlTdVkPZVPLGA6PJ3
         p7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUy2I+Yd0hVNmbRmOqbDvhZc7bA/yxUE5ZPV/0sfronEbdK7Kfb7e90JqQMOAnWZnfQ/5ByRYRiBW9uyewl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5lHbLcXHx+pWDkSN56CQHVtN4iHbmcjNf5HNO98oq+J1/UoCM
	aGT7QFzsmlPRGtpkCI7XOYqMpgzdJFE8wd2h1Z/Arif4g7aRrpIsKVphwhFvWPLRW9nmc7YKgWV
	tv2gB3m81mgWGjelG7nvKILFXtL0=
X-Google-Smtp-Source: AGHT+IFQe7YwwYiFUuHl5+J6TIsFIBFvRkpXHd95086JeoaxLvFNgOwrDrya6Od0dp3CA0yY4qX/c1etlFDIihwWveo=
X-Received: by 2002:a05:622a:1a85:b0:460:ac0c:8589 with SMTP id
 d75a77b69052e-4613c1971b5mr273002781cf.52.1730401621024; Thu, 31 Oct 2024
 12:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bzuJjsfevYasbpHZXvpS=62Ofo21aQSg8wWFns82H-UA@mail.gmail.com>
 <0c3e6a4c-b04e-4af7-ae85-a69180d25744@fastmail.fm> <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm> <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm> <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm> <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
In-Reply-To: <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 31 Oct 2024 12:06:49 -0700
Message-ID: <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:30=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Oct 30, 2024 at 03:51:08PM GMT, Joanne Koong wrote:
> > On Wed, Oct 30, 2024 at 3:17=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> > >
> > >
> > >
> > > On 10/30/24 22:56, Shakeel Butt wrote:
> > > > On Wed, Oct 30, 2024 at 10:35:47AM GMT, Joanne Koong wrote:
> > > >> On Wed, Oct 30, 2024 at 10:27=E2=80=AFAM Bernd Schubert
> > > >> <bernd.schubert@fastmail.fm> wrote:
> > > >>>
> > > >>>
> > > >>> Hmm, if tmp pages can be compacted, isn't that a problem for spli=
ce?
> > > >>> I.e. I don't understand what the difference between tmp page and
> > > >>> write-back page for migration.
> > > >>>
> > > >>
> > > >> That's a great question! I have no idea how compaction works for p=
ages
> > > >> being used in splice. Shakeel, do you know the answer to this?
> > > >>
> > > >
> > > > Sorry for the late response. I still have to go through other unans=
wered
> > > > questions but let me answer this one quickly. From the way the tmp =
pages
> > > > are allocated, it does not seem like they are movable and thus are =
not
> > > > target for migration/compaction.
> > > >
> > > > The page with the writeback bit set is actually just a user memory =
page
> > > > cache which is moveable but due to, at the moment, under writeback =
it
> > > > temporarily becomes unmovable to not cause corruption.
> > >
> > > Thanks a lot for your quick reply Shakeel! (Actually very fast!).
> > >
> > > With that, it confirms what I wrote earlier - removing tmp and ignori=
ng
> > > fuse writeback pages in migration should not make any difference
> > > regarding overall system performance. Unless I miss something,
> > > more on the contrary as additional memory pressure expensive page
> > > copying is being removed.
> > >
> >
> > Thanks for the information Shakeel, and thanks Bernd for bringing up
> > this point of discussion.
> >
> > Before I celebrate too prematurely, a few additional questions:
>
> You are asking hard questions, so CCed couple more folks to correct me
> if I am wrong.
>
> >
> > Are tmp pages (eg from folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0)) and
> > page cache pages allocated from the same memory pool? Or are tmp pages
> > allocated from a special memory pool that isn't meant to be
> > compacted/optimized?
>
> Memory pool is a bit confusing term here. Most probably you are asking
> about the migrate type of the page block from which tmp page is
> allocated from. In a normal system, tmp page would be allocated from page
> block with MIGRATE_UNMOVABLE migrate type while the page cache page, it
> depends on what gfp flag was used for its allocation. What does fuse fs
> use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situation
> allocations can get mixed up with different migrate types.
>

I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
fuse doesn't set any additional gfp masks on the inode mapping.

Could we just allocate the fuse writeback pages with GFP_HIGHUSER
instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
where we pass in the gfp mask to __filemap_get_folio(). I think this
would give us the same behavior memory-wise as what the tmp pages
currently do, and would solve all our headaches regarding writeback
potentially blocking page migration/compaction.



Thanks,
Joanne

> >
> > If they are allocated from the same memory pool, then it seems like
> > there's no difference between tmp pages blocking a memory range from
> > being compacted vs. a page cache page blocking a memory range from
> > being compacted (by not clearing writeback). But if they are not
> > allocated from the same pool, then it seems like the page cache page
> > blocking migration could adversely affect general system performance
> > in a way that the tmp page doesn't?
>
> I think irrespective of where the page is coming from, the page under
> writeback is non-movable and can fragment the memory. The question that
> is that worse than a tmp page fragmenting the memory, I am not sure.
>

