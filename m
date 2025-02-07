Return-Path: <linux-fsdevel+bounces-41248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C8A2CBA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 19:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FF73AAC84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825E1AE003;
	Fri,  7 Feb 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQMBVDg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC61AA1D5;
	Fri,  7 Feb 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953650; cv=none; b=MpWZc8s8F5sZiwGF5364Jzp6mdSfwHnETzpQj7NiHBnAVawK98i/x/d6UXomLcDdejMbMsA8wt5VGKjcbbfDBRmKzXr5QIAcsqcZDMgBgp54Y2VQmB2qwz3/o+lGdDeAB3bLRevNMPQGR0CbahePVrRIvFnVua+LMp7db8/qz2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953650; c=relaxed/simple;
	bh=tUad5obh1sGKnZ1z6Mhnxwc9ebc79vt8oTrv7jdMbaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxQBZ/Xinv564V3hdQTX0zJWHB8Kn+/OzZTdpfSkdFbfqwCqYDrFqde3Vnl+THzIJgvIZ3GLEoHXmnLH5aaMp99Qpmb7tROaT4SOOSaELAADHSvara+yj9+CkDEn9RrlNAO+gwCUOsWMru14dsQVfv3+uTOzggPOVtv/bPGJycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQMBVDg1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46c8474d8daso18567431cf.3;
        Fri, 07 Feb 2025 10:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738953646; x=1739558446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUad5obh1sGKnZ1z6Mhnxwc9ebc79vt8oTrv7jdMbaM=;
        b=bQMBVDg18h/J2Q7vsile03PIBqJHveCDBefASZE9i8VbOEHOyXCkNKwca9we0zEN8k
         q4KjJ7wbhM/VwgKQp47UBOFPDoQdkInWYv10jMDmZhK75lrjNqQPWKBHvJDaDCSdGF1a
         edK8+OUicUaMX03gntgKxou7Qi8ZMk0oHcOgpiS43HcV+9+zf23BhTSwODH48cX4tcHp
         VoqA5km7epiVgL/QIcUfIDdMFK+qRzGd21ihgYy/PRVrZ3m75kl/iyU3D3wkIrvjbdDX
         +Jt8N0YSxDmirekA0vBXrwA2PP3Wr1THSS4qVj6Icn7Vx7iJVhw623DiJLBEOgigW5aG
         ErxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953646; x=1739558446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUad5obh1sGKnZ1z6Mhnxwc9ebc79vt8oTrv7jdMbaM=;
        b=g44Yc3XCY+pWoT1+PSi2d8JvFn1LReNTxNTUt2yherO1nStjmapr8C0rPvNfFrePj3
         g7kMGWl1XAegThW0JvWv/Me83IpQMGAuyit53UD7XVN/BtftM9Puiq6mBx3VJKtXcSGb
         CkjIgFNYRFsV5vtl6C+m9T58V8YX0Td7NrgA7J3NXjPN2u42MI67YKtitnEsJU7TsEAv
         nLSUyjFoFDKm0ohu6twTiiP5ZUU3XsKx6RTdmyDZgdhb+V6DshKG3IESOsXsqbIuHYJb
         7U/ohb/y2wmzWDSCqpR6Nv/yHFJebKDmxX5MhwGgdQB3ghr/OdKh2GAdyejcapOV6PsJ
         bAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfN3+YgacFZSBM7Dj9jJF04R9pCs7qqPSyV1OfvMLazzu2HPgB41Uq5STmm/Myg/e5E7guf122YmulKhpf@vger.kernel.org, AJvYcCWiaPwu56pj76CU2vxyHi8vyC1fEZKpPD4sBQA128bRg2y6AXXIOAUKaYxpqULXnXz1XOB27bwbgtSNR7HP@vger.kernel.org
X-Gm-Message-State: AOJu0YxpG6VVhjzkxS89VQQy+k1UTQI1X/LnCFNVbH+S2rapjycDbnaA
	y1j0cOWInlzg8Km5gOeCGCnh+a9xpBNmS7iOQUMN0IhJlHNnPa02uONFGVJenxlcsBmV2bPFlJk
	G3bSTufY+fNnPZSoKha22O1qP0cs=
X-Gm-Gg: ASbGncsMCJhzuMVcWry3mdXpHE6ZJvbL6KaxgYjPx2EKdqFNWFPu+s50Wg4dWjfQ8Vg
	5zmFAUs+fFyZwcHplWq/Y/U+TF83bYnhfh/aWopf128Wv0+8kBSFQGj7QxhP1rPFTkhL7C7adtQ
	==
X-Google-Smtp-Source: AGHT+IFpWMWqwooQlduaHSefPEdDLXhN9MxWGpYS18PqjtFEZCMhIa8KHRBDKNK+utCkNE15zRjZXTH49Crp2j726b4=
X-Received: by 2002:ac8:5856:0:b0:46e:25ed:1601 with SMTP id
 d75a77b69052e-471679ead7dmr52946611cf.14.1738953646572; Fri, 07 Feb 2025
 10:40:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org> <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
 <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz> <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
In-Reply-To: <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Feb 2025 10:40:35 -0800
X-Gm-Features: AWEUYZlUKF3uMuKxv0gUMyubbyPvOYLv_SrV7TmDhm4xS-0PwcRiRKnubnUKYwY
Message-ID: <CAJnrk1atv4N-BDWnwmESvczJhkayXyQqnLEypkmuJNKBa6gq8A@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	Matthew Wilcox <willy@infradead.org>, Christian Heusel <christian@heusel.eu>, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 3:16=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 2/7/25 11:55, Vlastimil Babka wrote:
> > On 2/7/25 11:43, Miklos Szeredi wrote:
> >> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >>> Could be a use-after free of the page, which sets PG_lru again. The l=
ist
> >>> corruptions in __rmqueue_pcplist also suggest some page manipulation =
after
> >>> free. The -1 refcount suggests somebody was using the page while it w=
as
> >>> freed due to refcount dropping to 0 and then did a put_page()?
> >>
> >> Can you suggest any debug options that could help pinpoint the offende=
r?
> >
> > CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch=
 the
> > underflow (modulo a tiny race window where it wouldn't). Worth trying.
>
> I typically run all of my tests with these options enabled
>
> https://github.com/bsbernd/tiny-qemu-virtio-kernel-config
>
>
> If Christian or Mantas could tell me what I need to install and run, I
> could probably quickly give it a try.
>

Copying/pasting from [1], these are the repro steps that's listed:

1) Install Bottles: flatpak install flathub com.usebottles.bottles
2) Open Bottles and create a bottle
3) In a terminal open the kernel log using dmesg/journalctl in follow mode
4) Once the bottle has been initialized, open it, select "Run
Executable" and point it at any Windows executable
Note that at that same moment a BUG: Bad page state in process fuse
mainloop error message will appear and the system will become
unresponsive (keyboard and mouse might still work but you'll be unable
to actually do anything, open or close any application, or even reboot
or shutdown; you are able to ping the device and initiate an SSH
connection but all it does is just display the banner)


Thanks,
Joanne

[1] https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issue=
s/110

>
>
> Thanks,
> Bernd

