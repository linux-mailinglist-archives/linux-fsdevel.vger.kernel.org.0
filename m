Return-Path: <linux-fsdevel+bounces-47637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EEAA1AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983DF4A283C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1B253F1C;
	Tue, 29 Apr 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rUIoXCC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5A42528ED
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952938; cv=none; b=uL0oNtk+j84cglkW7LAYaOMlEnZDIoaVecMNj2obFdZTxf2KtfLJ7OepvohiUH/X2g8CKiaECMqVXshmBm53wn9daP8KWTmm5TR5QbFUsvSXU3HB3TVZJ+0CUWfphAJqLiQvhlEAzndzZVH+M6XeM1WWFAtwp6963HcFt6aYw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952938; c=relaxed/simple;
	bh=XYUI5WXpzx0xPmEQg3HaL+TpJqxqzJ1kWzqo7gOYD8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAzarCL7E4TqGP02T6EnPndEkWtaXWSPq43v9lpQYNFodYKb5qwK7qqAR+ofCah9sKRCpCR4au5YNVl08clsb/wNr4275tmi8L3HNbESLDqZf6ftFK3eiO01vqvmDpwpCZ/QnkzPtHT2xGQZlPh2P8bhFNMk0X3URHg0llEYliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rUIoXCC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so1879a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745952935; x=1746557735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGnPHWb56pcSnBYhY15/Vh6WYCrspAIDxl9o83SLKTU=;
        b=3rUIoXCCAcYlK4zQX3uuxppII8MoU+Vh7W2Kn5WbqG1+oRpYY62HYmn9SABCipzs4v
         VAhz+OpngyprNRbVo8y8g7WQXQ38Qq3j0DyYPaALzhPURhNu6fc/kBeQ0OBIFdwBelZF
         tglLZuaThsKPpMLdQe+8R9n2YbCr2BscTk3pFFGGw1d4b8mDxIq6mSa+6lDqoygOWnry
         pKZAUp/2ZCDfTyngHAvpGLUl4yYmyjldotfkFs0nyHK0fKezcZ20p/RkK0Bdx5qfqywB
         rva0FRNRYZDSrAu2Eg6+rFs0lzYJvV7cgLZYNuYwAcR1FhR07KDK6fSQzk0f6998a/+H
         jDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952935; x=1746557735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGnPHWb56pcSnBYhY15/Vh6WYCrspAIDxl9o83SLKTU=;
        b=ct0XzKDja+fmLhrIEGPdnFAs5J5dAUXl6CVy9A7hjyyTTRzKV/wzwwktkeTEE+mPkY
         YhtG//VuAehfjGiMiXyN6cxvkWQDIIjEIIDvkF++Dp/QFcX6c0zj76gzGaKp1epSdb6R
         PKY78b+wtiRhWPnR1qMrl5eMw6S/msdp4bLQFEhR23LvhUJmUlI7VgzBfR+tgkTe51U1
         2i6GwQiytrG1agX4VOFH1WSm3JqGAWKDDDOXm9o/OfjrY3IQQ5ogri9U6UVWqRvewQKs
         84KNHkWEhU74fMfAL/YxaxrLtHxe3CD99zJb9stfNyMyfOySJTwFHje18XCZ0Py4kv0W
         fIlg==
X-Forwarded-Encrypted: i=1; AJvYcCXzO5ciw3+aYgtiel0Wp8RuDCjNJs2J7BTxi6GfjRf6fWeMgsq/Zh56sgXUf21yNwsE5xi5gTe76B6hx1Sf@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBYYOMLlypC4y42pQFr4uNqddgDM2sQyWtuiLiVTVRoQFK6GN
	m52tERw4G+1Uk3JBoGJJ4LWHfsSa98yUN2kK49l3MY6EJRL/6vMKcwMtmCPXxy3n04/rGdLnO2J
	tdiEobMKvauBLBWNtNyC01m522I7qpvB1w9VtnjVNli8SLK3k+0j2k5Q=
X-Gm-Gg: ASbGncsVROYQ5EDb+vK3ab4SLv9SrJ5SdgovieeJ4sGyx7CZ8cXcaPX91fR9kkdevQl
	FR79aC/ObEPLmXMeG3gBjRtWa/wtSJYJH9DQ/sgkZyxMbFn5VIFkdNUxDIquLBWt9nrORR/M++j
	dwebguWIy0r5IWI5AL6eqFYOf3NUE5LOgW07oOLAPZBPZYAQ0bLA==
X-Google-Smtp-Source: AGHT+IHmxauoWVK69ZX6csxpCjfd6+3DMPgSaiSiQF85VSZQGO77OL31TmN1qQanU5zZwaCdMYGDle7ECMfNccgth5k=
X-Received: by 2002:aa7:d1cf:0:b0:5f8:6068:a45 with SMTP id
 4fb4d7f45d1cf-5f89720c6c9mr13377a12.4.1745952934761; Tue, 29 Apr 2025
 11:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418174959.1431962-1-surenb@google.com> <20250418174959.1431962-8-surenb@google.com>
 <CAG48ez3YLWh9hXQQdGVQ7hCsd=k_i2Z2NO6qzT6NaOYiRjy=nw@mail.gmail.com>
 <CAJuCfpGGiwTbMeGAeYNtQ5SsFenUw8up6ToLy=VstULM_TSoXA@mail.gmail.com>
 <CAG48ez15g5n9AoMJk1yPHsDCq2PGxCHc2WhCAzH8B2o6PgDwzQ@mail.gmail.com> <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
In-Reply-To: <CAJuCfpG+YjyVE-6TaAQEjwc0iixqN8Epf25jo2awtL=gqY=afA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 29 Apr 2025 20:54:58 +0200
X-Gm-Features: ATxdqUGSx2jmcnf6ztX09dbGC0pwTc-91Nr3Oa-BIYmoIdsaikOVBQ9Xr0kogDA
Message-ID: <CAG48ez0ntTH_sOaPiqML715jyTCujwyh3Og1wBq9RNLbu55C5Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
To: Suren Baghdasaryan <surenb@google.com>, Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, josef@toxicpanda.com, 
	yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org, 
	osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:04=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Tue, Apr 29, 2025 at 10:21=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> >
> > Hi!
> >
> > (I just noticed that I incorrectly assumed that VMAs use kfree_rcu
> > (not SLAB_TYPESAFE_BY_RCU) when I wrote my review of this, somehow I
> > forgot all about that...)
>
> Does this fact affect your previous comments? Just want to make sure
> I'm not missing something...

When I suggested using "WRITE_ONCE(vma->vm_file, NULL)" when tearing
down a VMA, and using get_file_rcu() for the lockless lookup, I did
not realize that you could actually also race with all the other
places that set ->vm_file, like __mmap_new_file_vma() and so on; and I
did not think about whether any of those code paths might leave a VMA
with a dangling ->vm_file pointer.

I guess maybe that means you really do need to do the lookup from the
copied data, as you did in your patch; and that might require calling
get_file_active() on the copied ->vm_file pointer (instead of
get_file_rcu()), even though I think that is not really how
get_file_active() is supposed to be used (it's supposed to be used
when you know the original file hasn't been freed yet). Really what
you'd want for that is basically a raw __get_file_rcu(), but that is
static and I think Christian wouldn't want to expose more of these
internals outside VFS...
(In that case, all the stuff below about get_file_rcu() would be moot.)

Or you could pepper WRITE_ONCE() over all the places that write
->vm_file, and ensure that ->vm_file is always NULLed before its
reference is dropped... but that seems a bit more ugly to me.

> > On Tue, Apr 29, 2025 at 7:09=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > On Tue, Apr 29, 2025 at 8:40=E2=80=AFAM Jann Horn <jannh@google.com> =
wrote:
> > > > On Fri, Apr 18, 2025 at 7:50=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > > With maple_tree supporting vma tree traversal under RCU and vma a=
nd
> > > > > its important members being RCU-safe, /proc/pid/maps can be read =
under
> > > > > RCU and without the need to read-lock mmap_lock. However vma cont=
ent
> > > > > can change from under us, therefore we make a copy of the vma and=
 we
> > > > > pin pointer fields used when generating the output (currently onl=
y
> > > > > vm_file and anon_name). Afterwards we check for concurrent addres=
s
> > > > > space modifications, wait for them to end and retry. While we tak=
e
> > > > > the mmap_lock for reading during such contention, we do that mome=
ntarily
> > > > > only to record new mm_wr_seq counter. This change is designed to =
reduce
> > > > > mmap_lock contention and prevent a process reading /proc/pid/maps=
 files
> > > > > (often a low priority task, such as monitoring/data collection se=
rvices)
> > > > > from blocking address space updates.
> > > > [...]
> > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > index b9e4fbbdf6e6..f9d50a61167c 100644
> > > > > --- a/fs/proc/task_mmu.c
> > > > > +++ b/fs/proc/task_mmu.c
> > > > [...]
> > > > > +/*
> > > > > + * Take VMA snapshot and pin vm_file and anon_name as they are u=
sed by
> > > > > + * show_map_vma.
> > > > > + */
> > > > > +static int get_vma_snapshot(struct proc_maps_private *priv, stru=
ct vm_area_struct *vma)
> > > > > +{
> > > > > +       struct vm_area_struct *copy =3D &priv->vma_copy;
> > > > > +       int ret =3D -EAGAIN;
> > > > > +
> > > > > +       memcpy(copy, vma, sizeof(*vma));
> > > > > +       if (copy->vm_file && !get_file_rcu(&copy->vm_file))
> > > > > +               goto out;
> > > >
> > > > I think this uses get_file_rcu() in a different way than intended.
> > > >
> > > > As I understand it, get_file_rcu() is supposed to be called on a
> > > > pointer which always points to a file with a non-zero refcount (exc=
ept
> > > > when it is NULL). That's why it takes a file** instead of a file* -=
 if
> > > > it observes a zero refcount, it assumes that the pointer must have
> > > > been updated in the meantime, and retries. Calling get_file_rcu() o=
n a
> > > > pointer that points to a file with zero refcount, which I think can
> > > > happen with this patch, will cause an endless loop.
> > > > (Just as background: For other usecases, get_file_rcu() is supposed=
 to
> > > > still behave nicely and not spuriously return NULL when the file* i=
s
> > > > concurrently updated to point to another file*; that's what that lo=
op
> > > > is for.)
> > >
> > > Ah, I see. I wasn't aware of this subtlety. I think this is fixable b=
y
> > > checking the return value of get_file_rcu() and retrying speculation
> > > if it changed.
> >
> > I think you could probably still end up looping endlessly in get_file_r=
cu().

(Just to be clear: What I meant here is that get_file_rcu() loops
*internally*; get_file_rcu() is not guaranteed to ever return if the
pointed-to file has a zero refcount.)

> By "retrying speculation" I meant it in the sense of
> get_vma_snapshot() retry when it takes the mmap_read_lock and then
> does mmap_lock_speculate_try_begin to restart speculation. I'm also
> thinking about Liam's concern of guaranteeing forward progress for the
> reader. Thinking maybe I should not drop mmap_read_lock immediately on
> contention but generate some output (one vma or one page worth of
> vmas) before dropping mmap_read_lock and proceeding with speculation.

Hm, yeah, I guess you need that for forward progress...

> > > > (If my understanding is correct, maybe we should document that more
> > > > explicitly...)
> > >
> > > Good point. I'll add comments for get_file_rcu() as a separate patch.
> > >
> > > >
> > > > Also, I think you are introducing an implicit assumption that
> > > > remove_vma() does not NULL out the ->vm_file pointer (because that
> > > > could cause tearing and could theoretically lead to a torn pointer
> > > > being accessed here).
> > > >
> > > > One alternative might be to change the paths that drop references t=
o
> > > > vma->vm_file (search for vma_close to find them) such that they fir=
st
> > > > NULL out ->vm_file with a WRITE_ONCE() and do the fput() after that=
,
> > > > maybe with a new helper like this:
> > > >
> > > > static void vma_fput(struct vm_area_struct *vma)
> > > > {
> > > >   struct file *file =3D vma->vm_file;
> > > >
> > > >   if (file) {
> > > >     WRITE_ONCE(vma->vm_file, NULL);
> > > >     fput(file);
> > > >   }
> > > > }
> > > >
> > > > Then on the lockless lookup path you could use get_file_rcu() on th=
e
> > > > ->vm_file pointer _of the original VMA_, and store the returned fil=
e*
> > > > into copy->vm_file.
> > >
> > > Ack. Except for storing the return value of get_file_rcu(). I think
> > > once we detect that  get_file_rcu() returns a different file we shoul=
d
> > > bail out and retry. The change in file is an indication that the vma
> > > got changed from under us, so whatever we have is stale.
> >
> > What does "different file" mean here - what file* would you compare
> > the returned one against?
>
> Inside get_vma_snapshot() I would pass the original vma->vm_file to
> get_file_rcu() and check if it returns the same value. If the value
> got changed we jump to  /* Address space got modified, vma might be
> stale. Re-lock and retry. */ section. That should work, right?

Where do you get an "original vma->vm_file" from?

To be clear, get_file_rcu(p) returns one of the values that *p had
while get_file_rcu(p) is running.

