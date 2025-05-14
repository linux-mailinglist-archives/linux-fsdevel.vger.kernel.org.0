Return-Path: <linux-fsdevel+bounces-48968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA3AAB6E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFF4C1F36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579018A6B0;
	Wed, 14 May 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="hQJI14Jg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6125149C4D
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747233526; cv=none; b=E5G/lNPy4m0Ew/JOfWahfSxlb61jubDQrf5Au0XbBf7b9X5mcWkHv+MaWEbT5gK6mFhWA39d2U5x31ckv/eKPVtUZ6FQSjghcFpl0aFl40ZDrJZ3/T5ULM1Bc3jNfQUDgi+CzZXMkxV/4hcdpEbV8fLGT8xzYHr/EC39Szl9Etg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747233526; c=relaxed/simple;
	bh=6XWdJgSEvyLJSh3QnLL5Y/Q+Mj3leHuMtjRqxY0hleY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=excpa/rvo1sVGwBpji63vqXWzPcXzHtsyTXcfnvTXtVsLWdoHtCwl8RrtO/YgWU9CHJhc9SqwX7EmAH/KXC69bQ3yTYBn9yMx59GvbJI25iBdSAlSHecK3OeWxftE+WDeEu4MaUnV35RPTFyiCV1eH6gjmlslXrLBg7QWIk0xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=hQJI14Jg; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so7962462a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 07:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1747233524; x=1747838324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qj7RgkMhTner4sa4FzvrC5A/c9e3z4cp04U9TUzXCKQ=;
        b=hQJI14Jg5k6lR2DOQ+Z6TCf0foR8FeuNjNG7Wc0P28ChSli0iSUNbKIEP2mzLT2uoB
         bPJEky+om7rxxwJ+ZWTqv8icaMIU/ODf8MNRexn83SCitlCfKDj0FNAnd63wQbiroC7I
         fDVmGFKvMDKFSiyPyDQeRehXGkK2z+MWrZYVV1CiBPk0zFodbonQbWhm4hK/b1frvyBo
         uQH21it3ZczbuXsGHM3VkpcAg4GZh59op4jP7EtxniJcS+dQteG20SoFpKcP5CQS+WF3
         Nt8OAvHtBbPljBTlbJccYky2EPsEXTlUMmTCdMzXB4EFa1025MfFG9QMM+4cpiIPfatO
         X4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747233524; x=1747838324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj7RgkMhTner4sa4FzvrC5A/c9e3z4cp04U9TUzXCKQ=;
        b=FMQ2MzIzmUmNk1gA4EQuXGAwMQi/tKm3EP9ePOG1+ImpDLDFENpFRmuIzL/n69rrEb
         aYbuod2baeLo2gsDkHV2nTW9qkFXzeH/4/MqSLFhfHgXfhnxyEHSRox4oit/XXQQVju1
         +DH8mhgF580l0QtIY8uzRqsfZJj3fgE5+LolpQQ6spba56NPppCrHTktCaNfZqT064r/
         P2RAsYO+FLVmIdJaLuFJVpd6Cb/UC4NMDX51jVrlpI1lasN+ND+PAHZhoAxYMynGsqcI
         1a2RJUDyTX6u9ZrTNAMkKsJ20cqIcawI0vCNg7gdq83fAdgEON0Tj6y312QWj7+c3Fni
         n9DQ==
X-Gm-Message-State: AOJu0YyPuTKHPEQkjARhMh6DjUYy+mG/1ulWYWzZDeEjlMLhEDLuLmSD
	SR8244hi8qDYafeKiyJE7Dhpc4lA4htah0nxjyMazS+cNzsBFcnqsCGUJpBEuWcv7MGD5gAKVKU
	APa4x7k69gtusGLPqoIUK6lI4cVeSGIlD2EmhbgacBN9BBBVZxwV6M2PmTQ==
X-Gm-Gg: ASbGncv+o5HpGu4zfkHxSeCDoh9YjYKfSX7VlISGTxdz17B8aDfRHfN4HBSA83y5PPx
	MSr87JtGvzHGRlgMkEZYRwZe64BLf8+0rrMGOIynuM41HwRwXCRdItrXFlb3P4KqJplh75/S3Ju
	NfmzKm7tWPh0JOPWtHhKyfvSH/UGsTNzvLgqwPDPvNzdPv
X-Google-Smtp-Source: AGHT+IHO56y3whAPbyDBos/nG5P8QVbcKxtQtxBWdOxCDl+TWWVSVhAzjBKh0bUXG+wCV2qXJganXjU7BA7habYytao=
X-Received: by 2002:a17:90b:38c6:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-30e2e62a163mr5644528a91.27.1747233523636; Wed, 14 May 2025
 07:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOg9mSTLUOEobom72-MekLpdH-FuF0S+JkU4E13PK6KzNqT1pw@mail.gmail.com>
 <2040f153-c50e-49ea-acb6-72914c62fecb@intel.com> <CAOg9mSRPok2NR5UNkkyBb8nGgZxQo36dfvL0ZWSpMZ3pT5884Q@mail.gmail.com>
 <86a9656f-211c-4af5-9d19-9565e83fb56d@intel.com>
In-Reply-To: <86a9656f-211c-4af5-9d19-9565e83fb56d@intel.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 14 May 2025 10:38:32 -0400
X-Gm-Features: AX0GCFvV9hEv_DN2oszsfzUa0XcZe0oaBaPATVHKSE2v_h_Ny7B-LPQSIHfESK8
Message-ID: <CAOg9mSS55ocm8G-obQj8C=e7YcMT5nrMAUXAVm6uOfVad7A_Ew@mail.gmail.com>
Subject: Re: [REGRESSION] orangefs: page writeback problem in 6.14 (bisected
 to 665575cf)
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, devel@lists.orangefs.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I believe I have a couple of adjustments to the counters that make
things flow properly again, including through xfstests numerous times on
top of 6.15-rc6.

I guess we had this bug all along, I'm glad Dave's patch uncovered it.
I think Dave's patch probably should have been pulled during a merge
window instead of halfway through rc7 though. Maybe it got talked
about a lot and I missed it.. I don't see where it has caused any other
problems but 6.14 is on Fedora 42... orangefs is broken there.

-Mike

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 5ac743c6bc2e..08a6f372a352 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -32,12 +32,13 @@ static int orangefs_writepage_locked(struct folio *foli=
o,
        len =3D i_size_read(inode);
        if (folio->private) {
                wr =3D folio->private;
-               WARN_ON(wr->pos >=3D len);
                off =3D wr->pos;
-               if (off + wr->len > len)
+               if ((off + wr->len > len) && (off <=3D len))
                        wlen =3D len - off;
                else
                        wlen =3D wr->len;
+               if (wlen =3D=3D 0)
+                       wlen =3D wr->len;
        } else {
                WARN_ON(1);
                off =3D folio_pos(folio);
@@ -46,8 +47,6 @@ static int orangefs_writepage_locked(struct folio *folio,
                if (wlen > len - off)
                        wlen =3D len - off;
        }
-       /* Should've been handled in orangefs_invalidate_folio. */
-       WARN_ON(off =3D=3D len || off + wlen > len);

        WARN_ON(wlen =3D=3D 0);
        bvec_set_folio(&bv, folio, wlen, offset_in_folio(folio, off));
@@ -320,6 +319,8 @@ static int orangefs_write_begin(struct file *file,
                        wr->len +=3D len;
                        goto okay;
                } else {
+                       wr->pos =3D pos;
+                       wr->len =3D len;
                        ret =3D orangefs_launder_folio(folio);
                        if (ret)
                                return ret;

On Wed, Apr 30, 2025 at 5:06=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 4/30/25 13:43, Mike Marshall wrote:
> > [ 1991.319111] orangefs_writepage_locked: wr->pos:0: len:4080:
> > [ 1991.319450] service_operation: file_write returning: 0 for 000000001=
8e1923a.
> > [ 1991.319457] orangefs_writepage_locked: wr->pos:4080: len:4080:
>
> Is that consistent with an attempt to write 4080 bytes that failed,
> returned a 0 and then encountered the WARN_ON()?
>
> While I guess it's possible that userspace might be trying to write
> 4080 bytes twice, the wr->pos:4080 looks suspicious. Is it possible
> that wr->pos inadvertently got set to 4080 during the write _failure_?
> Then, the write (aiming to write the beginning of the file) retries
> but pos=3D=3D4080 and not 0.
>
> > [ 1991.319581] Call Trace:
> > [ 1991.319583]  <TASK>
> ...
> > [ 1991.319613]  orangefs_launder_folio+0x2e/0x50 [orangefs]
> > [ 1991.319619]  orangefs_write_begin+0x87/0x150 [orangefs]
> > [ 1991.319624]  generic_perform_write+0x81/0x280
> > [ 1991.319627]  generic_file_write_iter+0x5e/0xe0
> > [ 1991.319629]  orangefs_file_write_iter+0x44/0x50 [orangefs]
> > [ 1991.319633]  vfs_write+0x240/0x410
> > [ 1991.319636]  ksys_write+0x52/0xc0
> > [ 1991.319638]  do_syscall_64+0x62/0x180
> > [ 1991.319640]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [ 1991.319643] RIP: 0033:0x7f218b134f44
>
> This is the path I was expecting. Note that my hackish patch will just
> lift the old (pre-regression) faulting from generic_file_write_iter()
> up to its caller: orangefs_file_write_iter().
>
> So now I'm doubly curious if that also hides the underlying bug.

