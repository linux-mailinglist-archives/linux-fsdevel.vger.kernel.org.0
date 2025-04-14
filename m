Return-Path: <linux-fsdevel+bounces-46410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D6DA88D20
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 22:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468BE3B5EA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFF31DFDAB;
	Mon, 14 Apr 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy3TFMLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92711E0DD8
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662541; cv=none; b=Jlj7KGjBEn17By/cncQx2TYzH9NuoLUCXzto0OEwnXdIPrd2CVR8FMwlzMNEHZ3DfR3rGnl7TK4D/97RIMzNxhPeQk4G0OcyTOcE6+5Enq7I1jZibey4i7zAlcXDsZ/zXPSeHNdABDkqcJmFzZ7urcDd7Keua/+sNNagfzjoUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662541; c=relaxed/simple;
	bh=WhnqGSVtwGcw2eNmjdqE77WUvfyLwjk2DzdlYBKh/pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNVoDkuyE9JWKcVw90e3LfS0XU/wgzrUUTQ8y7MvtpN2r8aTa0tTLAmBm2/Uk1MsCUcX37gG4RqCvIKVQ7H8hqJULH3vYO4NgtcBPhgwDl0jk0ugPZ52QKC+s6FYbuwvuxdeAHep9iqyFS+Vsyxim43BDYIUb8wzVbeNA5ijqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy3TFMLF; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47692b9d059so61827131cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744662539; x=1745267339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttWdWafouB0HD66F1+3TDOUDb5fuNwcS4l2VvOPoK1Y=;
        b=Iy3TFMLFhi3ng39PA8/g1OW/XxbPiQBZx9b21JQRpcS7imCaw3jO882Nw4c25xzkHE
         3HC0UW54gVDn1wqt2a8mcwj4/ADFMId5Vz5ZgxHqxv8H441btV9B3jAfUPAfbY8NnfVZ
         LQorFox7PY5MGSaUzbu6hMoebjLzrJCEEnXvexVSg0f3MLg1kI8s5wsJwDgODd7hDWFm
         xtExPr3/tnu3cH6HN5wasIf1hUUMenn20YEzVTXiFLnN1xfkrfFPAx2btR/LC6cT+0DP
         GMsvOfDbE9P+w3oUv6fEGLzCBQo8RzETnxyy3eUSMZn0HwlmQeLHuNVdwFOEK32r8zbD
         ccrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662539; x=1745267339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttWdWafouB0HD66F1+3TDOUDb5fuNwcS4l2VvOPoK1Y=;
        b=ZPyTGTOwi/W/uBvZmsZ1ass7Egk+aKNKQXFTKOIcja8NGA+37omj1+Wcee71oHSRsJ
         FPCVAadpsKqcIZzjQIsC6Hh9+gCSYqg2DLAfDML9gzm6sX275E7CBjwCHTRej62pDAF+
         jIjtLjYmu8jWpDDfdrxkFvU9QtI89zh8L0BMv77dTw8ZJfOWSQSgAnkKtoxqtbKwgw8T
         uKHVoN+v7GFTsa4CTYQJtVikOkusfPeJsmaMuncby2KynyatMhpE2/SHQM2Ibp/soe5Y
         xfjybfjZX9/6VEzPA//oZnAy5PoOhUQCuyYW9kMpFn8MT/nrO87rDB1YqaqeJDqw0CS6
         5aTA==
X-Forwarded-Encrypted: i=1; AJvYcCXJhH6lpfnn1e8v967mOxDN4Jzw1Cj7iWO25OH0Dccj9lKpkaqIMaS5V+SdxjYMljmJXO67yNpQi1LNihB+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sO0PbeyYR/QRqA0O0ncagKEwrioyEBFvmT/tYn5RuF55ytzY
	+yCOqoK7Uz6eLdKwMPZnMut+fuJp0ta6piwct3Dys+4xIvU7OsHnXbVBOB1J2xbamH27UiZlLq+
	JyHfwGs1R/N+5W5IEamKYVGroMH0=
X-Gm-Gg: ASbGncsajGBHNJQF7cQ+ji2oy7dBi+Xs/sM0AVlG8f25xkqAwlh9NV1CPTjTCRaYBhs
	CcrvfQszBee0GJVDSsLNmBLr49ooU88gSV3uL9fu66A/SL6R83uvTeKmUivRymrKIMEkVhhjAls
	or+ET53s2Enyx7VoP88f0hZHtlbP08hdKK7L6hWQ==
X-Google-Smtp-Source: AGHT+IHSrB0T2DSpx1i97VmlExtNn2cE0h2L2ynxckzNpsTKqgOJnQSvOClkgH89lh2tz57ZyQwh8KelEHDZaSixoAg=
X-Received: by 2002:a05:622a:130b:b0:479:1a3d:25c2 with SMTP id
 d75a77b69052e-479775e8daamr183165711cf.44.1744662538486; Mon, 14 Apr 2025
 13:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404181443.1363005-1-joannelkoong@gmail.com> <0e00e8b306620c781868f375a462127d72b26289.camel@kernel.org>
In-Reply-To: <0e00e8b306620c781868f375a462127d72b26289.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 14 Apr 2025 13:28:47 -0700
X-Gm-Features: ATxdqUEkQqC5DZ8gLVnvizomRcaBVulIbgqiiVX2ATJ_Ss03yHY8PIOw2e2eH6I
Message-ID: <CAJnrk1a6QoLWPOvoi4vakGOWTp9xDU=SCiPHx+cEg_Kdf6rYLA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fuse: remove temp page copies in writeback
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jefflexu@linux.alibaba.com, 
	shakeel.butt@linux.dev, david@redhat.com, bernd.schubert@fastmail.fm, 
	ziy@nvidia.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 9:21=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2025-04-04 at 11:14 -0700, Joanne Koong wrote:
> > The purpose of this patchset is to help make writeback in FUSE filesyst=
ems as
> > fast as possible.
> >
> > In the current FUSE writeback design (see commit 3be5a52b30aa
> > ("fuse: support writable mmap"))), a temp page is allocated for every d=
irty
> > page to be written back, the contents of the dirty page are copied over=
 to the
> > temp page, and the temp page gets handed to the server to write back. T=
his is
> > done so that writeback may be immediately cleared on the dirty page, an=
d this
> > in turn is done in order to mitigate the following deadlock scenario th=
at may
> > arise if reclaim waits on writeback on the dirty page to complete (more=
 details
> > can be found in this thread [1]):
> > * single-threaded FUSE server is in the middle of handling a request
> >   that needs a memory allocation
> > * memory allocation triggers direct reclaim
> > * direct reclaim waits on a folio under writeback
> > * the FUSE server can't write back the folio since it's stuck in
> >   direct reclaim
> >
> > Allocating and copying dirty pages to temp pages is the biggest perform=
ance
> > bottleneck for FUSE writeback. This patchset aims to get rid of the tem=
p page
> > altogether (which will also allow us to get rid of the internal FUSE rb=
 tree
> > that is needed to keep track of writeback status on the temp pages).
> > Benchmarks show approximately a 20% improvement in throughput for 4k
> > block-size writes and a 45% improvement for 1M block-size writes.
> >
> > In the current reclaim code, there is one scenario where writeback is w=
aited
> > on, which is the case where the system is running legacy cgroupv1 and r=
eclaim
> > encounters a folio that already has the reclaim flag set and the caller=
 did
> > not have __GFP_FS (or __GFP_IO if swap) set.
> >
> > This patchset adds a new mapping flag, AS_WRITEBACK_INDETERMINATE, whic=
h
> > filesystems may set on its inode mappings to indicate that writeback
> > operations may take an indeterminate amount of time to complete. FUSE w=
ill set
> > this flag on its mappings. Reclaim for the legacy cgroup v1 case descri=
bed
> > above will skip reclaim of folios with that flag set.
> >
> > With this change, writeback state is now only cleared on the dirty page=
 after
> > the server has written it back to disk. If the server is deliberately
> > malicious or well-intentioned but buggy, this may stall sync(2) and pag=
e
> > migration, but for sync(2), a malicious server may already stall this b=
y not
> > replying to the FUSE_SYNCFS request and for page migration, there are a=
lready
> > many easier ways to stall this by having FUSE permanently hold the foli=
o lock.
> > A fuller discussion on this can be found in [2]. Long-term, there needs=
 to be
> > a more comprehensive solution for addressing migration of FUSE pages th=
at
> > handles all scenarios where FUSE may permanently hold the lock, but tha=
t is
> > outside the scope of this patchset and will be done as future work. Ple=
ase
> > also note that this change also now ensures that when sync(2) returns, =
FUSE
> > filesystems will have persisted writeback changes.
> >
> > [1] https://lore.kernel.org/linux-kernel/495d2400-1d96-4924-99d3-8b2952=
e05fc3@linux.alibaba.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joann=
elkoong@gmail.com/
> >
> > Changelog
> > ---------
> > v6:
> > https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelko=
ong@gmail.com/
> > Changes from v6 -> v7:
> > * Drop migration and sync patches, as they are useless if a server is
> >   determined to be malicious
> >
> > v5:
> > https://lore.kernel.org/linux-fsdevel/20241115224459.427610-1-joannelko=
ong@gmail.com/
> > Changes from v5 -> v6:
> > * Add Shakeel and Jingbo's reviewed-bys
> > * Move folio_end_writeback() to fuse_writepage_finish() (Jingbo)
> > * Embed fuse_writepage_finish_stat() logic inline (Jingbo)
> > * Remove node_stat NR_WRITEBACK inc/sub (Jingbo)
> >
> > v4:
> > https://lore.kernel.org/linux-fsdevel/20241107235614.3637221-1-joannelk=
oong@gmail.com/
> > Changes from v4 -> v5:
> > * AS_WRITEBACK_MAY_BLOCK -> AS_WRITEBACK_INDETERMINATE (Shakeel)
> > * Drop memory hotplug patch (David and Shakeel)
> > * Remove some more kunnecessary writeback waits in fuse code (Jingbo)
> > * Make commit message for reclaim patch more concise - drop part about
> >   deadlock and just focus on how it may stall waits
> >
> > v3:
> > https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-1-joannelk=
oong@gmail.com/
> > Changes from v3 -> v4:
> > * Use filemap_fdatawait_range() instead of filemap_range_has_writeback(=
) in
> >   readahead
> >
> > v2:
> > https://lore.kernel.org/linux-fsdevel/20241014182228.1941246-1-joannelk=
oong@gmail.com/
> > Changes from v2 -> v3:
> > * Account for sync and page migration cases as well (Miklos)
> > * Change AS_NO_WRITEBACK_RECLAIM to the more generic AS_WRITEBACK_MAY_B=
LOCK
> > * For fuse inodes, set mapping_writeback_may_block only if fc->writebac=
k_cache
> >   is enabled
> >
> > v1:
> > https://lore.kernel.org/linux-fsdevel/20241011223434.1307300-1-joannelk=
oong@gmail.com/T/#t
> > Changes from v1 -> v2:
> > * Have flag in "enum mapping_flags" instead of creating asop_flags (Sha=
keel)
> > * Set fuse inodes to use AS_NO_WRITEBACK_RECLAIM (Shakeel)
> >
> > Joanne Koong (3):
> >   mm: add AS_WRITEBACK_INDETERMINATE mapping flag
> >   mm: skip reclaiming folios in legacy memcg writeback indeterminate
> >     contexts
> >   fuse: remove tmp folio for writebacks and internal rb tree
> >
> >  fs/fuse/file.c          | 360 ++++------------------------------------
> >  fs/fuse/fuse_i.h        |   3 -
> >  include/linux/pagemap.h |  11 ++
> >  mm/vmscan.c             |  10 +-
> >  4 files changed, 46 insertions(+), 338 deletions(-)
> >
>
> This looks sane, and I love that diffstat.
>
> I also agree with David about changing the flag name to something more
> specific. As a kernel engineer, anything with "INDETERMINATE" in the
> name gives me the ick.
>
> Assuming that the only real change in v8 will be the flag name change,
> you can add:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>
> Assuming others are ok with this, how do you see this going in? Maybe
> Andrew could pick up the mm bits and Miklos could take the FUSE patch?


Thanks for the review. The only thing I plan to change for v8 is the
flag name and removing the unneeded fuse_sync_writes() call in
fuse_flush() that Jingbo pointed out.

With v8, I'm hoping the mm bits (first 2 patches) could be picked up
by Andrew and that the 3rd patch (the one with FUSE changes) could be
taken by Miklos, as the FUSE large folios patchset [1] I will be
resending will depend on patch 3.

Thanks,
Joanne

 [1] https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelk=
oong@gmail.com/

