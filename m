Return-Path: <linux-fsdevel+bounces-51644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2AAD98C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7652A7AE084
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1F128DB56;
	Fri, 13 Jun 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Crxqd27c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BB2E11A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749858134; cv=none; b=RhmsH/lJO42hywTGA9aRNOGgGadw2+9FTtxcpcTIz7jwXQbZejEhKsZOV+8x0FIgLD++ACP3YzUuNGgdrDQ4N2YO/+RRS6RQ1qXZehS0QNmmne4+e8dy6TdGtqWJOvqGwVhrOSVTc07qBr0WHkCVokIuFA8GkBaAIZmq7IW0Ies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749858134; c=relaxed/simple;
	bh=yuyftOPuqXu4Hl2fsZj9SLQ8FlH1PG/hxZC6vtxquJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSXUm5HY0hk0WuAaShNj0hi0gpmWl6IdrZDEhEIFG08NltlYPMWZGXR8/XS9WxcQjF7syhBcYa3ScYVQ9tZ8qBqCtYm7PJu2s0t7si87/IWamGoxDlUnQnW7XNP0AC6PV7QvoFlFxr/oDhvFKBQJml48c0iqjSQuqB/qNPcJfyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Crxqd27c; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58ebece05so29055141cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 16:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749858132; x=1750462932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0MOhBkeNroj1YjiV2fHUXA+J/132csfcB1ERhQzurY=;
        b=Crxqd27cfo9xYjW1xWP5T1HFtFboWP6biKQfd5IZk9Ei3emoHoNRjytDosgLPHmI8m
         5OI+l0YUiOhzVlTQOLqw/OcO0mztmQ7XH7IA1sYEAVloGtd+37Mjr02Hfk0n5LLT1ta0
         uNRdOUpMmjJNN6DZo66yfEC2Y4fCVvgEPbCay4ldpwPe1fJI/zGO1m8YDK5OoClfyqu+
         U7Ivu9JRVuRYeF15vYdH68IZXOI+HAavQvzOCMgXemx75e5QDrSsnnXEuzj//GP73Qfp
         03iASsPfBHCEaqeqWY874zvHeF3eIMU2V7GLJGRyPZ6eIVpBfBnJXKVzWxYjdf0oYWcf
         Bi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749858132; x=1750462932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0MOhBkeNroj1YjiV2fHUXA+J/132csfcB1ERhQzurY=;
        b=pev4/XqBpoY0U5ia1yZ3vciZQb5qwXv9LUIraksp3RM7KTxKXl17Xufljjjv1zYgiy
         CCuY0grfeEwlA3oMDy8KrfKhTZljiC2vqBCC6HWaPOJ+oFsBF2O634+I3eipGxLT0bUI
         arWqU3fUKqMItil8xCXM0yOjIMA3RGkT/PR8a4GEwT85gpW7pFLNdPSLYOM0yvM6LP3U
         Hny/OCeA8zJNSKEZpJXnIR1Z0vN64Ax/gZaVfMb/eUN2FkzzpgPDMP4mLCxXkkBkzg8U
         sY6l5wp60fpoj+cXmHY5AJ70C31Fq6plouZBhxJxACEdni8xjFYd/5x0QmLuIaMBFuQG
         xylA==
X-Gm-Message-State: AOJu0YwhqNdRBOTOOJNW8HyJW+6YsMTZkxZfU+7lw0O1/bpOVXpTYirx
	S9I8K+Cbzm0wvpHzyQ0a3EHp6tzrJPC9UyHs3xb+qA/TCc+zzN6V8FgP1aIDDGkCxg1SNAKxsQ9
	obf3oJ1jTCKpRgHo5bKnzPDPdGs+d39D6Xhb8
X-Gm-Gg: ASbGncvVZpzOVFZ7paFnZfnPWGWDgnr+fZ0sLOc9uwRY5/h4ASf9/zlunsViy53CqlS
	RIC7SPz81wUQYDH8R54iBq589GJp/rmJXnIASylOH+Lucw1ASIJdQ1SLPw25gkcLc8rPyepmffj
	x9PHMI8joaEwQ9IcmV5viD1b/LeXByHLr1iPsVHS+TEefU5p+MWg/dRpJ2f4w=
X-Google-Smtp-Source: AGHT+IG0L64xsvDUpFxLKor8iWSxntHRfDPhqRjhLeVl3iOLa9y17nEFXQo1mwgYngkJR8n1IMl5ujNS5m1zgyRjf34=
X-Received: by 2002:ac8:7dc1:0:b0:4a4:4165:ed60 with SMTP id
 d75a77b69052e-4a73c4fceb4mr19508451cf.3.1749858131778; Fri, 13 Jun 2025
 16:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEq4haEQScwHIWK6@bfoster> <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
 <aEwPNxjEaFtnmsuR@bfoster>
In-Reply-To: <aEwPNxjEaFtnmsuR@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 13 Jun 2025 16:42:00 -0700
X-Gm-Features: AX0GCFuJ9HgUQCg5tF5Z3itfRLNRAENYP7VE5MlofAtGMKFwn2AOkBQj7hGFeHs
Message-ID: <CAJnrk1ZOP60By0XozFy+6zXYzbkEznye6rGSet16-g-JQoGfTw@mail.gmail.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 4:41=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Jun 12, 2025 at 02:56:56PM -0700, Joanne Koong wrote:
> > On Thu, Jun 12, 2025 at 4:19=E2=80=AFAM Brian Foster <bfoster@redhat.co=
m> wrote:
> > >
> > > Hi folks,
> > >
> > > I run kernel compiles quite a bit over virtiofs in some of my local t=
est
> > > setups and recently ran into an issue building xfs.ko once I had a
> > > v6.16-rc kernel installed in my guest. The test case is a simple:
> > >
> > >   make -j N M=3Dfs/xfs clean; make -j N M=3Dfs/xfs
> >
> > Hi Brian,
> >
>
> Hi Joanne,
>
> > If I'm understanding your setup correctly, basically you have the
> > v6.16-rc kernel running on a VM, on that VM you mounted a virtiofs
> > directory that references a linux repo that's on your host OS, and
> > then from your VM you are compiling the fs/xfs module in that shared
> > linux repo?
> >
>
> Yep. Note again that I happen to be using the same repo that I was
> bisecting, so technically the test case of recompiling the kernel module
> is targeting different code each time, but the failure was so consistent
> that I believe it to be a runtime issue.
>
> > I tried this on my local setup but I'm seeing some other issues:
> >
> > make[1]: Entering directory '/home/vmuser/linux/linux/fs/xfs'
> >   LD [M]  xfs.o
> > xfs.o: warning: objtool: __traceiter_xfs_attr_list_sf+0x23:
> > unannotated intra-function call
> > make[3]: *** [/home/vmuser/linux/linux/scripts/Makefile.build:501:
> > xfs.o] Error 255
> > make[3]: *** Deleting file 'xfs.o'
> > make[2]: *** [/home/vmuser/linux/linux/Makefile:2006: .] Error 2
> > make[1]: *** [/home/vmuser/linux/linux/Makefile:248: __sub-make] Error =
2
> > make[1]: Leaving directory '/home/vmuser/linux/linux/fs/xfs'
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > Did you also run into these issues when you were compiling?
> >
>
> I don't recall seeing that specific error, but TBH this kind of looks in
> line with what I'm seeing in general. My suspicion is that this is not
> actually a source code error, but something is corrupted somehow or
> another via virtiofs.

This is indeed the same issue as the one you saw. I was able to repro
it on that commit you pointed to  (more details below)

>
> As a quick additional test, I just built my same repo from my host
> system (running a distro v6.14 kernel) without any issue. Then if I do
> the kernel module rebuild test of the same exact repo over virtiofs from
> the guest, the error occurs.
>
> What is interesting is that if I try the same thing with another module
> (i.e. fs/fuse, fs/nfs), the build seems to work fine, so maybe there is
> something unique to XFS going on here. As a followup to that, I set my
> repo back to v6.15 but still reproduce the same phenomenon: build
> failure when compiling over virtiofs and not from the host.. :/
>
> > Taking a look at what 63c69ad3d18a ("fuse: refactor
> > fuse_fill_write_pages()") does, it seems odd to me that the changes in
> > that commit would lead to the issues you're seeing - that commit
> > doesn't alter structs or memory layouts in any way. I'll keep trying
> > to repro the issue you're seeing.
> >
>
> Apologies I haven't really had a chance to look at the code.. It's
> certainly possible I botched something in the bisect or misunderstood
> some tooling differences or whatever, but I'm pretty sure I at least
> tried the target commit and the immediate preceding commit after the
> bisect to double check where the failing starts to happen.
>
> That said, I suspect you are actually reproducing the same general
> problem with your test above, regardless of whether the analysis is
> wrong. If you're able, have you tried whether that same compile works
> from a host (or non-virtiofs) env? Thanks.

You didn't mess up the bisect, I was able to verify that it is that
commit that causes the issue. I misunderstood the error message and
thought it was complaining about alignment in a struct being broken
somewhere.

This fixes the commit:
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1147,7 +1147,7 @@ static ssize_t fuse_send_write_pages(struct
fuse_io_args *ia,
 static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
                                     struct address_space *mapping,
                                     struct iov_iter *ii, loff_t pos,
-                                    unsigned int max_pages)
+                                    unsigned int max_folios)
 {
        struct fuse_args_pages *ap =3D &ia->ap;
        struct fuse_conn *fc =3D get_fuse_conn(mapping->host);
@@ -1157,12 +1157,11 @@ static ssize_t fuse_fill_write_pages(struct
fuse_io_args *ia,
        int err =3D 0;

        num =3D min(iov_iter_count(ii), fc->max_write);
-       num =3D min(num, max_pages << PAGE_SHIFT);

        ap->args.in_pages =3D true;
        ap->descs[0].offset =3D offset;

-       while (num) {
+       while (num && ap->num_folios < max_folios) {
                size_t tmp;
                struct folio *folio;
                pgoff_t index =3D pos >> PAGE_SHIFT;


The bug is that I incorrectly assumed that I could use max_pages <<
PAGE_SHIFT as the upper limit for how many bytes to copy in, but
there's the possibility that the copy_folio_from_iter_atomic() call
that we do can copy over bytes from the iov_iter that are less than
the length of the folio, so using max_pages << PAGE_SHIFT as the bound
for max_pages is wrong.

I ran the fix locally on top of origin/master (commit 27605c8c0) as
well and verified that it fixes the issue. I'll send this fix
upstream.

Sorry for the inconvenience. Hope this bug didn't waste too much of
your time. Thanks for reporting it.

>
> Brian
>
> > >
> > > ... and ends up spitting out link time errors like this as of commit
> > > 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
> > >
> > > ...
> > >   CC [M]  xfs.mod.o
> > >   CC [M]  .module-common.o
> > >   LD [M]  xfs.ko
> > >   BTF [M] xfs.ko
> > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_u=
nit or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
> > > error decoding cu i_mmap_rwsem
> > > error decoding cu
> > > ...
> > > error decoding cu
> > > pahole: xfs.ko: Invalid argument
> > > make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko]=
 Error 1
> > > make[3]: *** Deleting file 'xfs.ko'
> > > make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
> > > make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
> > > make[1]: Leaving directory '/root/repos/linux/fs/xfs'
> > > make: *** [Makefile:248: __sub-make] Error 2
> > >
> > > ... or this on latest master:
> > >
> > > ...
> > >   LD [M]  fs/xfs/xfs.o
> > > fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 214596492=
4 for .rela.text
> > > make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
> > > make[4]: *** Deleting file 'fs/xfs/xfs.o'
> > > make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
> > > make[2]: *** [scripts/Makefile.build:554: fs] Error 2
> > > make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
> > > make: *** [Makefile:248: __sub-make] Error 2
> > >
> > > The latter failure is what I saw through most of a bisect so I suspec=
t
> > > one of the related followon commits alters the failure characteristic
> > > from the former, but I've not confirmed that. Also note out of
> > > convenience my test was to just recompile xfs.ko out of the same tree=
 I
> > > was bisecting from because the failures were consistent and seemed to=
 be
> > > a runtime kernel issue and not a source tree issue.
> > >
> > > I haven't had a chance to dig any further than this (and JFYI I'm
> > > probably not going to be responsive through the rest of today). I jus=
t
> > > completed the bisect and wanted to get it on list sooner rather than
> > > later..
> > >
> > > Brian
> > >
> >
>

