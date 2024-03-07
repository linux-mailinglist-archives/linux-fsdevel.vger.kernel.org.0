Return-Path: <linux-fsdevel+bounces-13925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DFD875830
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3078D28250A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104E138499;
	Thu,  7 Mar 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ixsystems.com header.i=@ixsystems.com header.b="HNulIO+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B651369A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842968; cv=none; b=aZodLxyCsnc2ItBf5a/+xLyDenZYLdMfh1TGVbkTCke82esn5oMaj9tVEGpFXGNvg9WlZ4HNk5HqhMiual/rEhhm4CXg4d0izCzWTFHAd9WqNhaw6qyoRRjPUOisUNckutYyu8ftStAEImcwxchD8/sU0T8TYTBZxH8StuUxgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842968; c=relaxed/simple;
	bh=S6EjqYZbVHVsXmxxGSgDL80W1cCUfSlo4xpvkbM3H94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYWNV0vgGnvyGSX1EJIpIEyRDyWeHQiLrL3Y/Y1Ka0ijoGQWt069HirHjRu6Hd7ZdYjZra+GflhpiEm92yJ9CjsSmTUhi03adzusgxeELssCSIDT3fo6nJKwk2hQbTdtRkkUjWxZKq9Go36RwLItgbE/IrtWelVgFeIDCJGjeQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixsystems.com; spf=pass smtp.mailfrom=ixsystems.com; dkim=pass (2048-bit key) header.d=ixsystems.com header.i=@ixsystems.com header.b=HNulIO+l; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixsystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixsystems.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4729da13d05so399887137.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1709842965; x=1710447765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xbj6kfKYFycADPkyqjTomsxdR3myyejYOVqL9Ut/k0=;
        b=HNulIO+lXCx6DHzYOd/iuDd2s4rn96Nhm+dmaiw55otojMhY1gIVySnJEGGoHjzbHe
         SNbSXO0YhxfZBSwj+cq9T9Qo3K6pCm0FqwEk7y+pZ4oh0w/nULaKQ/qFVHRmZ5m5qUAw
         kG/fANKAdx1KS/wewux9YTwjB4lvnXqReIDLDYlSgX/G9kgwi1WzfjGo9n0veynNFK71
         DsPQU5fpQvBQzXD4pTX/qVwERYazdQ1hHflZNUKH+0xl3qjDu5l3df+IA80ASYpxUGvl
         5pedzc4hKSIJT+JRTZwCKgVPXmZlTUDLleWm4iitOCEZh1lwAF+7JK45bHlzul69+uJP
         bnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842965; x=1710447765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xbj6kfKYFycADPkyqjTomsxdR3myyejYOVqL9Ut/k0=;
        b=BS/PRR1yU0sxQy8S4BmD4UMyLgfc+PlfGf2Lo2Lx5OSSEK1KDUW6ukCsYJxQkkNiXa
         wojRshrjUP6FK5fUWK35mxzEhV3zaYaDF+ND2AmuYHyNgnkYK9ITJ5bBF2O0RXyBlGlV
         kmhvSChI4Dr55a5tkbpR6jC8R6GDiz4oNpltGdMhTNhp0zecIcYlCR1DLjOVs2+06bKG
         RFQBeo4XepBemYIJB1I3ENMVAfCoY3lg6M3kV8it5dqUxctKFgkTTw+towVrUcB6eyl+
         gA1ck0XR4/1i85Vgk0tw7Bq+utVwv5nV/dNJrXs5UfH9Acjem66DXTDsprbgouZo7fUJ
         B+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIlqgEGECTvuLodd2j7RtiV4ZkbgSRo3usoaYRUurMPFBu5hSKruA1xe5gQTrbGixOLHeWkKDTuNX1rRkhb4Izl9OIz9OBuiBaw7YmyQ==
X-Gm-Message-State: AOJu0Yz/pkf9xGBND4NVX9JQW4750TiTFS3I1WRvtQdYtXBgvbH/z3qx
	KXWUQqYy9in+izeFSwtBrumPAdUdMOn9eVRMMvwniIx9jvszMc+cXFr0UPzS5TC9x7x2EXpEKXP
	5vhZVKupdN4Jx4csSfbg53+MuKEtX7LPcTGnJ
X-Google-Smtp-Source: AGHT+IFronwxMMHkcckLT9rFBLjnZhvZHnpYrjZvP+dDG/QrNH6L26ofm9YjWXE2n0J7F43BCIlvZW8mc35ZPNBPzAA=
X-Received: by 2002:a05:6102:242f:b0:473:886:5616 with SMTP id
 l15-20020a056102242f00b0047308865616mr1518189vsi.5.1709842965693; Thu, 07 Mar
 2024 12:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
 <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
 <CAH2r5msvgB19yQsxJtTCeZN+1np3TGkSPnQvgu_C=VyyhT=_6Q@mail.gmail.com>
 <nbqjigckee7m3b5btquetn3wfj3bzcirm75jwnbmhjyxyqximr@ouyqocmrjmfa> <CAH2r5mt_FY=9Dg6_K1+gYMAKuyPAPO0yRZ9hKcLkyypmUjxQZA@mail.gmail.com>
In-Reply-To: <CAH2r5mt_FY=9Dg6_K1+gYMAKuyPAPO0yRZ9hKcLkyypmUjxQZA@mail.gmail.com>
From: Andrew Walker <awalker@ixsystems.com>
Date: Thu, 7 Mar 2024 12:22:32 -0800
Message-ID: <CAB5c7xrnE=egCK3iD1=OSNTaAvRqQRJK_wWXdogfGN5TDCHq_Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] statx attributes
To: Steve French <smfrench@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Amir Goldstein <amir73il@gmail.com>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 2:04=E2=80=AFPM Steve French <smfrench@gmail.com> wr=
ote:
>
> On Thu, Mar 7, 2024 at 11:45=E2=80=AFAM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Mar 07, 2024 at 10:37:13AM -0600, Steve French wrote:
> > > > Which API is used in other OS to query the offline bit?
> > > > Do they use SMB specific API, as Windows does?
> > >
> > > No it is not smb specific - a local fs can also report this.  It is
> > > included in the attribute bits for files and directories, it also
> > > includes a few additional bits that are used by HSM software on local
> > > drives (e.g. FILE_ATTRIBUTE_PINNED when the file may not be taken
> > > offline by HSM software)
> > > ATTRIBUTE_HIDDEN
> > > ATTRIBUTE_SYSTEM
> > > ATTRIBUTE_DIRECTORY
> > > ATTRIGBUTE_ARCHIVE
> > > ATTRIBUTE_TEMPORARY
> > > ATTRIBUTE_SPARSE_FILE
> > > ATTRIBUTE_REPARE_POINT
> > > ATTRIBUTE_COMPRESSED
> > > ATTRIBUTE_NOT_CONTENT_INDEXED
> > > ATTRIBUTE_ENCRYPTED
> > > ATTRIBUTE_OFFLINE
> >
> > we've already got some of these as inode flags available with the
> > getflags ioctl (compressed, also perhaps encrypted?) - but statx does
> > seem a better place for them.
> >
> > statx can also report when they're supported, which does make sense for
> > these.
> >
> > ATTRIBUTE_DIRECTORY, though?
> >
> > we also need to try to define the semantics for these and not just dump
> > them in as just a bunch of identifiers if we want them to be used by
> > other things - and we do.
>
> They are all pretty clearly defined, but many are already in Linux,
> and a few are not relevant (e.g. ATTRIBUTE_DIRECTORY is handled in
> mode bits).  I suspect that Macs have equivalents of most of these
> too.

MacOS and FreeBSD return many of these in stat(2) output via st_flags.
Current set of supported flags are documented in chflags(2) manpage on both
platforms.

