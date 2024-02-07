Return-Path: <linux-fsdevel+bounces-10571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E984C57A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82963B25235
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 07:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28AF1F5F0;
	Wed,  7 Feb 2024 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX5skYVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BD1D552;
	Wed,  7 Feb 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289950; cv=none; b=WsvjHswjbPnexpkF6eegchPRRWXWNTYfiwHzXReVhOh7lFfZAYb3g+VhVp0r4tZg78a9eOg9SJ704Gn4k6XEUNJWcPI5krGivIXmIG2pgKPGDQbAtUtC0AyicFZJ80PrX4yO1+TwxLQjmAaExF8VfqeRuVWm4JHJ8VeSFbyYtz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289950; c=relaxed/simple;
	bh=Q4w34Nq9evxL9fqfco3XPJoIayQq2rj0ZU9QikzGy+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/EwAfCWYvQQQ8hGsrQp9SYy31cedM6gi35UFXRUuMUNAqYSM7GVWpCTqL67jQ9Jhyfs2q/Zo7+cw2mHq/rUAkHt3IKlAs6IghCKryarTsg/iJjDNm2OZhvECiyej9E/KNq7v6Lyyn13d7FjdwWKHcmB2jV7iP/0yJ6xrtibTRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX5skYVt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51117bfd452so423947e87.3;
        Tue, 06 Feb 2024 23:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707289946; x=1707894746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfC6FLphsNXfeoJ4NNyLHvlFNAyZlfkB4NIcbqLP8Do=;
        b=YX5skYVtEBWJlDNJdUcPhRW2bIOhLcgBh9rt34KXbNBQJ7WVDxV/feMlumQQMpIzY8
         L2UiFtOAqjj8n21VUZDWAvHT1yJfCSIl+lAQvNX1RRtZ3qyaqSi4gUNITb+dBPk+UJSP
         pUUNQxw9hHXFXBk115R9PPRuvwmacBxhHJK/LotHOS6rpHc2g7gU8jU77P7/4vvD4pKD
         filWWvt3EPILFQZIhORxuvVKg/NLfVhnUMRbSCW+VpDFg3LjSrdaJq7XZCQddIdv0oDr
         l2G+toGVqnaWO6vdG6YWWFePJu4Fr9FlEmCpmjzyCds/yYDqd0HfwYxpBlQlv3ZwJTz6
         cfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289946; x=1707894746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfC6FLphsNXfeoJ4NNyLHvlFNAyZlfkB4NIcbqLP8Do=;
        b=tDXY+5y9lJgKVfWn7Brd8leg3xJo5yDowiR66hO2XYflclfNyBpQP0s8Lg38v22gFH
         TmA4tRF44tz1DnmjG4Q2tbBOwTLV35XG/A7Hjs89XWYQJi5vLDCDbPfgljJsTG8p7kjf
         9V2M1nfHVkQoAhTeDLvGBlg8CDSDN/FalzvVqKJaM+kK0HpIkMdB/FMOntsPff8t8PfS
         52m+Evb5lCcDc0j7imNo3mUt6ineNQEZlmNWud4yRxyC0eeXD8H1i3/ZPLAehz576618
         9QLw97ZFNiw+XVRIc0HKkm0PFR/f7WK/mTiDs0MeE52xphZBZNn956QWYViNdoTopmnZ
         q6TA==
X-Gm-Message-State: AOJu0YyMo+zJh5hFyLcHdedDgeMhVQ1uWdjSy832Zp76FZk7ClcgIUWO
	3fbapew8uKJLVLfWkbypeP0F/Lto8PtzN78yGh6vl1DlVW7hnhJz69cB9NJPASvahL8d3odPMy1
	cDi7DheHKaBbnt+H6Db2Wt9GNUNr91FPG
X-Google-Smtp-Source: AGHT+IH6i8wtD/YBuc3N0SrCXe/3P1mYPXVrILzXoITCbR3G7Zz17CSGSiD01+AVUZLVuYEIRgCmAn5xSsvdd0oo8vw=
X-Received: by 2002:ac2:5617:0:b0:511:509c:ea04 with SMTP id
 v23-20020ac25617000000b00511509cea04mr2985208lfd.55.1707289946218; Tue, 06
 Feb 2024 23:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com> <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
In-Reply-To: <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 7 Feb 2024 01:12:14 -0600
Message-ID: <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, rdiez-2006@rd10.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000c602f40610c56af5"

--000000000000c602f40610c56af5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated patch - now use PAGE_SIZE instead of hard coding to 4096.

See attached

On Tue, Feb 6, 2024 at 11:32=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Attached updated patch which also adds check to make sure max write
> size is at least 4K
>
> On Tue, Feb 6, 2024 at 10:58=E2=80=AFPM Steve French <smfrench@gmail.com>=
 wrote:
> >
> > > his netfslib work looks like quite a big refactor. Is there any plans=
 to land this in 6.8? Or will this be 6.9 / later?
> >
> > I don't object to putting them in 6.8 if there was additional review
> > (it is quite large), but I expect there would be pushback, and am
> > concerned that David's status update did still show some TODOs for
> > that patch series.  I do plan to upload his most recent set to
> > cifs-2.6.git for-next later in the week and target would be for
> > merging the patch series would be 6.9-rc1 unless major issues were
> > found in review or testing
> >
> > On Tue, Feb 6, 2024 at 9:42=E2=80=AFPM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > I have bisected the issue, and found the commit that introduces the p=
roblem:
> > >
> > > commit d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > Author: David Howells <dhowells@redhat.com>
> > > Date:   Mon Jan 24 21:13:24 2022 +0000
> > > Subject: cifs: Change the I/O paths to use an iterator rather than a =
page list
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dd08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > >
> > > $ git describe --contains d08089f649a0cfb2099c8551ac47eef0cc23fdf2
> > > v6.3-rc1~136^2~7
> > >
> > > David, I also tried your cifs-netfs tree available here:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git=
/log/?h=3Dcifs-netfs
> > >
> > > This tree solves the issue. Specifically:
> > >
> > > commit 34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > > Author: David Howells <dhowells@redhat.com>
> > > Date:   Fri Oct 6 18:29:59 2023 +0100
> > > Subject: cifs: Cut over to using netfslib
> > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-=
fs.git/commit/?h=3Dcifs-netfs&id=3D34efb2a814f1882ddb4a518c2e8a54db119fd0d8
> > >
> > > This netfslib work looks like quite a big refactor. Is there any plan=
s to land this in 6.8? Or will this be 6.9 / later?
> > >
> > > Do you have any suggestions on how to fix this with a smaller delta i=
n 6.3 -> 6.8-rc3 that the stable kernels can use?
> > >
> > > Thanks,
> > > Matthew
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--000000000000c602f40610c56af5
Content-Type: application/octet-stream; 
	name=".0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch.swp"
Content-Disposition: attachment; 
	filename=".0001-smb-Fix-regression-in-writes-when-non-standard-maxim.patch.swp"
Content-Transfer-Encoding: base64
Content-ID: <f_lsbgc7vq0>
X-Attachment-Id: f_lsbgc7vq0

YjBWSU0gOS4wAAAAABAAAPQqw2X+qAcA9mMIAHNtZnJlbmNoAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAABzbWZyZW5jaC1UaGlua1BhZC1QNTIAAAAAAAAAAAAAAAAAAAAAAAAAfnNtZnJl
bmNoL2NpZnMtMi42L3RtcDYvMDAwMS1zbWItRml4LXJlZ3Jlc3Npb24taW4td3JpdGVzLXdoZW4t
bm9uLXN0YW5kYXJkLW1heGltLnBhdGNoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA0AMzIxMAAAAAAjIiEgExJVAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHRwAQB/AAAA
AgAAAAAAAABMAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABhZAAAegEAAMICAAAAEAAA
TAAAAAAAAAC5DwAAjQ8AAGgPAAAZDwAAAg8AAAEPAAC+DgAAdg4AADIOAADsDQAAqw0AAG0NAAAr
DQAAKg0AAOsMAACmDAAAcQwAAHAMAAAxDAAA7wsAAK8LAABzCwAAUQsAAFALAAAlCwAAxwoAAI4K
AABZCgAANgoAAA4KAADZCQAA1QkAAKYJAACCCQAATwkAAE4JAAAPCQAA5wgAAMkIAACrCAAAXAgA
AEUIAAA/CAAAGwgAANQHAACSBwAASQcAAPAGAADqBgAAkgYAADsGAAA0BgAAEQYAAOwFAACXBQAA
kgUAAI4FAABqBQAAIwUAAOEEAACcBAAAdAQAAFMEAAAyBAAA3gMAAMwDAACsAwAAkgMAAFwDAAAV
AwAACwMAAPYCAADOAgAAygIAAMMCAADCAgAAwQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAADIuNDAuMQAtLSAAIAkJY3R4LT5hY3JlZ21heCA9IEhaICogcmVzdWx0LnVpbnRfMzI7
ACAJY2FzZSBPcHRfYWNyZWdtYXg6ACAJCWJyZWFrOwArCQkJY2lmc19kYmcoVkZTLCAid3NpemUg
c2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgNDA5NiAoUEFHRV9TSVpFKVxuIik7ACsJCWlmIChyb3Vu
ZF91cChjdHgtPndzaXplLCBQQUdFX1NJWkUpICE9IGN0eC0+d3NpemUpACAJCWN0eC0+Z290X3dz
aXplID0gdHJ1ZTsAIAkJY3R4LT53c2l6ZSA9IHJlc3VsdC51aW50XzMyOwAgCWNhc2UgT3B0X3dz
aXplOgBAQCAtMTExMSw2ICsxMTExLDggQEAgc3RhdGljIGludCBzbWIzX2ZzX2NvbnRleHRfcGFy
c2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZjLAArKysgYi9mcy9zbWIvY2xpZW50L2ZzX2Nv
bnRleHQuYwAtLS0gYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYwBpbmRleCA1MmNiZWYyZWVi
MjguLjYwMGE3NzA1MmMzYiAxMDA2NDQAZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvZnNfY29u
dGV4dC5jIGIvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMAIAkJY2lmc19zYi0+Y3R4LT5yc2l6
ZSA9IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfcnNpemUodGNvbiwgY3R4KTsAIAkgICAgKGNpZnNf
c2ItPmN0eC0+cnNpemUgPiBzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3JzaXplKHRjb24sIGN0eCkp
KQAgCWlmICgoY2lmc19zYi0+Y3R4LT5yc2l6ZSA9PSAwKSB8fAArCX0AKwkJfQArCQkJY2lmc19k
YmcoVkZTLCAid3NpemUgdG9vIHNtYWxsLCByZXNldCB0byBtaW5pbXVtIGllIFBBR0VfU0laRSwg
dXN1YWxseSA0MDk2XG4iKTsAKwkJCWNpZnNfc2ItPmN0eC0+d3NpemUgPSBQQUdFX1NJWkU7ACsJ
CWlmIChjaWZzX3NiLT5jdHgtPndzaXplID09IDApIHsAKwkJICovACsJCSAqICh3aGljaCB3b3Vs
ZCBnZXQgcm91bmRlZCBkb3duIHRvIDApIHRoZW4gcmVzZXQgd3NpemUgdG8gYWJzb2x1dGUgbWlu
aW11bSBlZyA0MDk2ACsJCSAqIGluIHRoZSB2ZXJ5IHVubGlrZWx5IGV2ZW50IHRoYXQgdGhlIHNl
cnZlciBzZW50IGEgbWF4IHdyaXRlIHNpemUgdW5kZXIgUEFHRV9TSVpFLAArCQkvKgArCQljaWZz
X3NiLT5jdHgtPndzaXplID0gcm91bmRfZG93bihzZXJ2ZXItPm9wcy0+bmVnb3RpYXRlX3dzaXpl
KHRjb24sIGN0eCksIFBBR0VfU0laRSk7ACsJICAgIChjaWZzX3NiLT5jdHgtPndzaXplID4gc2Vy
dmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpKSkgewAtCQljaWZzX3NiLT5jdHgt
PndzaXplID0gc2VydmVyLT5vcHMtPm5lZ290aWF0ZV93c2l6ZSh0Y29uLCBjdHgpOwAtCSAgICAo
Y2lmc19zYi0+Y3R4LT53c2l6ZSA+IHNlcnZlci0+b3BzLT5uZWdvdGlhdGVfd3NpemUodGNvbiwg
Y3R4KSkpACAJaWYgKChjaWZzX3NiLT5jdHgtPndzaXplID09IDApIHx8ACAJICovACAJICogdGhl
IHVzZXIgb24gbW91bnQAQEAgLTM0MzgsOCArMzQzOCwxNyBAQCBpbnQgY2lmc19tb3VudF9nZXRf
dGNvbihzdHJ1Y3QgY2lmc19tb3VudF9jdHggKm1udF9jdHgpACsrKyBiL2ZzL3NtYi9jbGllbnQv
Y29ubmVjdC5jAC0tLSBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jAGluZGV4IGJmZDU2OGY4OTcx
MC4uNDZiM2FlZWJmYmYyIDEwMDY0NABkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jb25uZWN0
LmMgYi9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYwAAIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkAIGZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5jIHwgIDIg
KysAIGZzL3NtYi9jbGllbnQvY29ubmVjdC5jICAgIHwgMTMgKysrKysrKysrKystLQAtLS0AU2ln
bmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgBDYzogRGF2
aWQgSG93ZWxscyA8ZGhvd2VsbHNAcmVkaGF0LmNvbT4AQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcgIyB2Ni4zKwBBY2tlZC1ieTogUm9ubmllIFNhaGxiZXJnIDxyb25uaWVzYWhsYmVyZ0BnbWFp
bC5jb20+AFN1Z2dlc3RlZC1ieTogUm9ubmllIFNhaGxiZXJnIDxyb25uaWVzYWhsYmVyZ0BnbWFp
bC5jb20+AEZpeGVzOiBkMDgwODlmNjQ5YTAgKCJjaWZzOiBDaGFuZ2UgdGhlIEkvTyBwYXRocyB0
byB1c2UgYW4gaXRlcmF0b3IgcmF0aGVyIHRoYW4gYSBwYWdlIGxpc3QiKQBSZXBvcnRlZC1ieTog
Ui4gRGlleiIgPHJkaWV6LTIwMDZAcmQxMC5kZT4AAHdlIGRvIG5vdCByb3VuZCBpdCBkb3duIHRv
IHplcm8pLgBhIG11bHRpcGxlIG9mIDQwOTYgKHdlIGFsc28gaGF2ZSB0byBjaGVjayB0byBtYWtl
IHN1cmUgdGhhdABtYXhpbXVtIHdyaXRlIHNpemUgaWYgdGhlIHNlcnZlciBuZWdvdGlhdGVzIGEg
dmFsdWUgdGhhdCBpcyBub3QAYSBtdWx0aXBsZSBvZiA0MDk2LCBhbmQgYWxzbyBhZGQgYSBjaGFu
Z2Ugd2hlcmUgd2Ugcm91bmQgZG93biB0aGUAQWRkIGEgd2FybmluZyBpZiBhIHVzZXIgc3BlY2lm
aWVzIGEgd3NpemUgb24gbW91bnQgdGhhdCBpcyBub3QAAHdlIGNhbiBub3Qgc3VwcG9ydCBub24t
c3RhbmRhcmQgbWF4aW11bSB3cml0ZSBzaXplcy4AbmV0ZnMgY2hhbmdlLCBidXQgdW50aWwgdGhh
dCBwb2ludCAoaWUgZm9yIHRoZSA2LjMga2VybmVsIHVudGlsIG5vdykAVGhpcyBzZWN0aW9uIG9m
IGNvZGUgaXMgYmVpbmcgcmV3cml0dGVuL3JlbW92ZWQgZHVlIHRvIGEgbGFyZ2UAAHBhZ2Ugd2hl
biBkb2luZyBsYXJnZSBzZXF1ZW50aWFsIHdyaXRlcywgY2F1c2luZyBkYXRhIGNvcnJ1cHRpb24u
AG11bHRpcGxlIG9mIDQwOTYgdGhlIG5ldGZzIGNvZGUgY2FuIHNraXAgdGhlIGVuZCBvZiB0aGUg
ZmluYWwAaXMgbm90IGEgbXVsdGlwbGUgb2YgNDA5NikuICBXaGVuIG5lZ290aWF0ZWQgd3JpdGUg
c2l6ZSBpcyBub3QgYQB3cml0ZSBzaXplIGJ5IHNldHRpbmcgbW91bnQgcGFybSAid3NpemUiLCBi
dXQgc2V0cyBpdCB0byBhIHZhbHVlIHRoYXQAbm90IGEgbXVsdGlwbGUgb2YgNDA5NiAoc2ltaWxh
cmx5IGlmIHRoZSB1c2VyIG92ZXJyaWRlcyB0aGUgbWF4aW11bQBtYXhpbXVtIHdyaXRlIHNpemUg
aXMgc2V0IGJ5IHRoZSBzZXJ2ZXIgdG8gYW4gdW5leHBlY3RlZCB2YWx1ZSB3aGljaCBpcwBUaGUg
Y29udmVyc2lvbiB0byBuZXRmcyBpbiB0aGUgNi4zIGtlcm5lbCBjYXVzZWQgYSByZWdyZXNzaW9u
IHdoZW4AACB3cml0ZSBzaXplIG5lZ290aWF0ZWQAU3ViamVjdDogW1BBVENIIDAxLzI2XSBzbWI6
IEZpeCByZWdyZXNzaW9uIGluIHdyaXRlcyB3aGVuIG5vbi1zdGFuZGFyZCBtYXhpbXVtAERhdGU6
IFR1ZSwgNiBGZWIgMjAyNCAxNjozNDoyMiAtMDYwMABGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJl
bmNoQG1pY3Jvc29mdC5jb20+AEZyb20gZjJjYTg2MmRlYmQ4Yjk4NzViNTQ0ODU1M2JlMGYyMTc4
ZmM0MjMxZiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEA
--000000000000c602f40610c56af5--

