Return-Path: <linux-fsdevel+bounces-33377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D122A9B85C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 22:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6201C21478
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 21:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E221CDA0E;
	Thu, 31 Oct 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKBL9jLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E101CCEE8
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411595; cv=none; b=D9P+lCCmHVm2qiZBFwnoT1QePAZglIC5ds/q4c9rQLsr0jhTvDNlp0rmClstd2qjrd0YN0/ExsXTDgbnuua8JjaEEWqkP2OzTc150Npl7QJ94eyotAaM5QJkdhirGceJVgKo67hsVkBTU5TY7ywWUzEViyIKgl9r1jbl4UMRUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411595; c=relaxed/simple;
	bh=F27qB7pqs4B+H6rgwMgg110YnYCYCyECaYMkJQesej4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDGOWa1ho+8TLa00RyF4m9aYzZisW7WTWmHbeLqxKFJsGdYMQwroORUfHxPgcEw7ZsA49frIUFugFcauWYiJTfIcd+wbw7suGgBRIrFNzgr7KFBmIQuj+nm5bxiKRwXIe70Zp9729NQd3jQcbeWTbJyZD2aA3IWrHw+01N7XzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKBL9jLx; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1347013276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730411588; x=1731016388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F27qB7pqs4B+H6rgwMgg110YnYCYCyECaYMkJQesej4=;
        b=XKBL9jLxSoguRbBEZf8oa6Uc9bcprOxBnuO59VCwVN3QmpPWoVallY1kDPHp/Uhh3+
         J6l8v4zVWP93Q79ivmNmKm6+PuARNCqgiuqKnMart04Yndtd1jsRJ7h4cjD4A9ALqHwG
         7mG3zUprzlQLfcA8p04qqA2SopOPA5IZ03U9zK+Pd5e72h7ZI8s9a9AXc81+RGEdOlLI
         NkIXHvQJmPHvDv1hr0nNvl+pViw8rBuV4AJu4NuCahgineZzwGSaoBGqSo52RWZ1rIe4
         e966v+3aGqXGfsedvhZ/wMhiuwc32sSjnU8MHMmFb1u/x8HslfeiJqSgqmis6ECfZsBn
         ilNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411588; x=1731016388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F27qB7pqs4B+H6rgwMgg110YnYCYCyECaYMkJQesej4=;
        b=NcO8fwYCy6Kuxva5ktztf6G7fekpPYN5+rW5T4SjpjRArtnskxM16KZx3OmJ+CjD5E
         J98mjA90qG01mEESkO2hDlck1huIVMxCH5Wu1h+0/ZYKRF3BzkZWC8zNMTaEz1f6J4y+
         nIeGKuhqyISZowpn3fB2TDY5svvYs7PcsPPb/EH3PUBUGwrrf3C9t0RLlPcRi53VDtBw
         GISeY45t8eCsfCbBDziVmfDx+238lIeDskq51MZF9eLLD9pdtbin5wf1vqesFBKATHAz
         8/Er4WLYTfW8f0RKoYPS820dYxAmk8KQpbNfcUsPoPgqWCvIZ0O2yi7b0nksrIuG4BDE
         djdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkVlCc0HxNDrbe2KswB8xQHIk6qqd/rnvYFiIOtSWlTDdE3I9Q+nPKETGIsYW6CxqV1zJ9D3tQHbcrjJwU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+y/39GfFXbvsalmKrmvj1ITYx9q9hBP3j7bQR9QqX3LL2tpSo
	vNKsv5NfJccXO3/5UJaWSpHfncoL73U2S/nAOSAWmqVjAZszDpvHuVZhYTBnGJqjjdGz7fl0/q+
	aYdRd2V0C+jdI2KhIqHT3k7iDYjyB1jWeC+k=
X-Google-Smtp-Source: AGHT+IHqMc8D1fTcJBHC56Bby5MV6Wwd0AQM0m6uLJ3UMWC4kMsq8PIQR4kUOKsExi9cp8mFoCadMXsDzzN7l83LUiw=
X-Received: by 2002:a05:6902:2b0a:b0:e29:6571:b107 with SMTP id
 3f1490d57ef6-e33025b5d7emr1532044276.32.1730411588315; Thu, 31 Oct 2024
 14:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1b=ntstDcnjgLsmX+wTyHaiC9SZ7cdSRF2Zbb+0SAG1Zw@mail.gmail.com>
 <023c4bab-0eb6-45c5-9a42-d8fda0abec02@fastmail.fm> <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm> <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm> <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com> <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
In-Reply-To: <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 31 Oct 2024 14:52:57 -0700
Message-ID: <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> > On Wed, Oct 30, 2024 at 5:30=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> [...]
> > >
> > > Memory pool is a bit confusing term here. Most probably you are askin=
g
> > > about the migrate type of the page block from which tmp page is
> > > allocated from. In a normal system, tmp page would be allocated from =
page
> > > block with MIGRATE_UNMOVABLE migrate type while the page cache page, =
it
> > > depends on what gfp flag was used for its allocation. What does fuse =
fs
> > > use? GFP_HIGHUSER_MOVABLE or something else? Under low memory situati=
on
> > > allocations can get mixed up with different migrate types.
> > >
> >
> > I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> > fuse doesn't set any additional gfp masks on the inode mapping.
> >
> > Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> > instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin()
> > where we pass in the gfp mask to __filemap_get_folio(). I think this
> > would give us the same behavior memory-wise as what the tmp pages
> > currently do,
>
> I don't think it would be the same behavior. From what I understand the
> liftime of the tmp page is from the start of the writeback till the ack
> from the fuse server that writeback is done. While the lifetime of the
> page of the page cache can be arbitrarily large. We should just make it
> unmovable for its lifetime. I think it is fine to make the page
> unmovable during the writeback. We should not try to optimize for the
> bad or buggy behavior of fuse server.
>
> Regarding the avoidance of wait on writeback for fuse folios, I think we
> can handle the migration similar to how you are handling reclaim and in
> addition we can add a WARN() in folio_wait_writeback() if the kernel ever
> sees a fuse folio in that function.

Awesome, this is what I'm planning to do in v3 to address migration then:

1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)

2) in the fuse filesystem's implementation of the
mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
under writeback.

Does this sound good?


Thanks,
Joanne

