Return-Path: <linux-fsdevel+bounces-49687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A6AC10F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 18:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE851B67F65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A9E23A9B1;
	Thu, 22 May 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de+T5F9l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A269228C9C;
	Thu, 22 May 2025 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931116; cv=none; b=IVR4hgWRRYxxF69mRGi0nGOZ70kVwjzpOGRwpg0pi+q3hjD+R0qBPL4UzoqS0MBNgn7+SpQOjjosXAbl1/0Ihti3Uq6H64iIB+KknoRTv9hXz8zRjUqu+V7WhjCyAd+ueRehiguLldHN9tlOO6FfyhvHlEOkBaPURgQrOvzFyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931116; c=relaxed/simple;
	bh=MGMaBPwspjdO+Cw7HVJESQj99jweSE+KzXhdvW8OErU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrWoAZ+Tq/u3iE4/jpJSVqUzo2psoRynH9u3pEl9ynKl13VCGAkaQRRGfAj5SDjhQ8OwIC42MeT3CG8p5cHw3n/YTrQ8Ejbuben1pmwD+eFy922NirCQD/Y+ckopeZwmXira0T4P0FIsZFtLNF4o7jsuvKk5blVcTdRRzFlPbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de+T5F9l; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-551efcb745eso6385597e87.2;
        Thu, 22 May 2025 09:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747931112; x=1748535912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AScnhgmwXeZrgX8byDb4z77AD0ls8o4kE4xkmsd04fc=;
        b=de+T5F9l9RR0v6pRswEcDQNexoGAb/NvXum3/eEuFlZ4c7Ed69FcSOGvuPI1D7I0oF
         mhEXDJKqyCoS8VGkBjhcuXvpuPDHgFlJisDFm7WoEm9pgYGiJP0ai9nFuBw+NzwtnpCa
         iIKr7WZcdb/MrKlVbhCrElp/LAf1SkuRfkhiOunGqCkgUsq/Suty7MksOPR58J9ji1iE
         GQGBHrYa3UqkJxkVy4LVphVYhXSOTGBlc66ddKPcO66fdmOkbsRVUKUorYP2QE2cAHXA
         NCrm+PvReir8anRhKINi3Rmjf7obEh7syxDnW3ch1b/8ysRpZAiV0egjsWHNOYEKoppc
         VHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747931112; x=1748535912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AScnhgmwXeZrgX8byDb4z77AD0ls8o4kE4xkmsd04fc=;
        b=wsPifReVY/2+sXXmdI0OfJZg4M8fuuS5xl03+f993etcJY0bomt3Cba1Dpq43P0khq
         OMPda38bQusTdyLkgdE59nsEOUWuAxWyIzK1CD0Jmp2n0XnFraO7hwqjxRB1tB1H1w8N
         xFnD3Ha3Lc04DeCh+4Q2TnV1pJGfiK48llkoJ4bLd3kn1gaFHijjDagtCf0ojQ9vbRDN
         49Bz9XCnNpqzOeXsmc7rGdoNOs79xNM/lB0LGiemhve2R9xryWBWlVMd+At+EkeBZnzX
         10+0GQmCNOldR3WKa+P9UEazQuRRH6ha8S4MtXZ+aZ2QNtGOjPmAV4+17HwDq8n3hNoV
         /ZwA==
X-Forwarded-Encrypted: i=1; AJvYcCWUFhiAXDoawfP6YwLWSrFXwgfS6g1oXH5ZicIDHRNR3bpGqqXDhMn+sHOTnJIsN+ch/xJR6AgC19W6@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmC74weQ96ehRgfAd5rdrd93UVjYOa+GGUIQ18B38kls42abG
	toscsKxBG9vekFu4T5ThbwmQvZfEagzyxVAU4MMKp3s9drk7Yn+52h5/46+pKyF4XYKIbxvYIU2
	iKT8K0YDNtCWw6f7aAPktXaijsAZZY1eGzt14XGs=
X-Gm-Gg: ASbGncvm9I4O9AgKCxagZFLyms3S6wNG8kzIZ1beHyKsTy+HcyJB0JNUGaN83vovHny
	rcE/ACtErfY8fRGxJr6AtKZTgyUnIPVCBFxC968puluw2oo2XPlhWU9hRsCtg6L1i8gcHJffjuS
	nBgQJuffJi1aXpTwKM+ovcBI/f7Z339eXp
X-Google-Smtp-Source: AGHT+IHFA3v2ucsMVwhIJwbtjT8bp8pc/0ysED2W0ZNCz6w1/X6DI6K7+XVj8QLkh+U/lJenj9vJ11Z6HbHWpLn3QrU=
X-Received: by 2002:a17:907:7f8b:b0:ad5:55db:e411 with SMTP id
 a640c23a62f3a-ad555dbfdefmr2031800866b.27.1747931101539; Thu, 22 May 2025
 09:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs>
In-Reply-To: <20250521235837.GB9688@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 18:24:50 +0200
X-Gm-Features: AX0GCFtG0ZvPfxpdlc2X67s2FKyAK5ZAjJR94iM36M5BCfha7x5wkalEQmZ_gf0
Message-ID: <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:58=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi everyone,
>
> DO NOT MERGE THIS.
>
> This is the very first request for comments of a prototype to connect
> the Linux fuse driver to fs-iomap for regular file IO operations to and
> from files whose contents persist to locally attached storage devices.
>
> Why would you want to do that?  Most filesystem drivers are seriously
> vulnerable to metadata parsing attacks, as syzbot has shown repeatedly
> over almost a decade of its existence.  Faulty code can lead to total
> kernel compromise, and I think there's a very strong incentive to move
> all that parsing out to userspace where we can containerize the fuse
> server process.
>
> willy's folios conversion project (and to a certain degree RH's new
> mount API) have also demonstrated that treewide changes to the core
> mm/pagecache/fs code are very very difficult to pull off and take years
> because you have to understand every filesystem's bespoke use of that
> core code.  Eeeugh.
>
> The fuse command plumbing is very simple -- the ->iomap_begin,
> ->iomap_end, and iomap ioend calls within iomap are turned into upcalls
> to the fuse server via a trio of new fuse commands.  This is suitable
> for very simple filesystems that don't do tricky things with mappings
> (e.g. FAT/HFS) during writeback.  This isn't quite adequate for ext4,
> but solving that is for the next sprint.
>
> With this overly simplistic RFC, I am to show that it's possible to
> build a fuse server for a real filesystem (ext4) that runs entirely in
> userspace yet maintains most of its performance.  At this early stage I
> get about 95% of the kernel ext4 driver's streaming directio performance
> on streaming IO, and 110% of its streaming buffered IO performance.
> Random buffered IO suffers a 90% hit on writes due to unwritten extent
> conversions.  Random direct IO is about 60% as fast as the kernel; see
> the cover letter for the fuse2fs iomap changes for more details.
>

Very cool!

> There are some major warts remaining:
>
> 1. The iomap cookie validation is not present, which can lead to subtle
> races between pagecache zeroing and writeback on filesystems that
> support unwritten and delalloc mappings.
>
> 2. Mappings ought to be cached in the kernel for more speed.
>
> 3. iomap doesn't support things like fscrypt or fsverity, and I haven't
> yet figured out how inline data is supposed to work.
>
> 4. I would like to be able to turn on fuse+iomap on a per-inode basis,
> which currently isn't possible because the kernel fuse driver will iget
> inodes prior to calling FUSE_GETATTR to discover the properties of the
> inode it just read.

Can you make the decision about enabling iomap on lookup?
The plan for passthrough for inode operations was to allow
setting up passthough config of inode on lookup.

>
> 5. ext4 doesn't support out of place writes so I don't know if that
> actually works correctly.
>
> 6. iomap is an inode-based service, not a file-based service.  This
> means that we /must/ push ext2's inode numbers into the kernel via
> FUSE_GETATTR so that it can report those same numbers back out through
> the FUSE_IOMAP_* calls.  However, the fuse kernel uses a separate nodeid
> to index its incore inode, so we have to pass those too so that
> notifications work properly.
>

Again, I might be missing something, but as long as the fuse filesystem
is exposing a single backing filesystem, it should be possible to make
sure (via opt-in) that fuse nodeid's are equivalent to the backing fs
inode number.
See sketch in this WIP branch:
https://github.com/amir73il/linux/commit/210f7a29a51b085ead9f555978c85c9a4a=
503575

Thanks,
Amir.

