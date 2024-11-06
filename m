Return-Path: <linux-fsdevel+bounces-33840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A119BFA3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FE71C21E66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD720CCF9;
	Wed,  6 Nov 2024 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re6vanH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3181917D7
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936245; cv=none; b=JGSvMA+yHf8JRXsg3pPCDuiIm4pWcC3bOXmbW+BWL5yRTcqe77B1p17CYE/qCO3II7CHEePhdnftowIXYN/ZnZl6bLK8AGVoTBQGeaP15RwTDwm+gz/ieXeeRnqg3HLKXYXKsa6nKAcxU+PDBQYpeXKmeBaIOOZzBUEf+0MTgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936245; c=relaxed/simple;
	bh=lz3gYzQ4n32I4z58BHzCmszK35FiX3Yy6HdDdCI5+KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3tiYl99BcdPLAZvfkEuObvHf8AqozvMG2fxuDyDGAscec1chV3I1uDQ96vKEmh1ov73WEp8nUd37phf6L7B5e1A6Hq/bxtREtuhCJeymsDH+Phvlz+LUAWt3SvKxv5fmHCTNTDLU8UiYhKRWXcRNdkxtMgKdRfa2H4Ue1gDi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re6vanH1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460e6d331d6so2010331cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 15:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730936243; x=1731541043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz3gYzQ4n32I4z58BHzCmszK35FiX3Yy6HdDdCI5+KM=;
        b=Re6vanH1vnnpJ9GLgxBDzr1NUeQm88kOzAf78MD13CD0YY2lGyciJi0hWm8AXo/4RN
         8hmGoK8wsh7AgGlKM9wIecvkujS1rqLgcechJdX7UYdxAu6j+kzxpzro0hkXDuFtqhu3
         sGs5FFeyxNUOV2xadas1YJq7azFTDowPigc/KhceqA7giVLy6gl+bsp/wOLpu1GI3u7D
         rfBE6PpuRlQ1n7MfiMBF2JP2aKIGZY6vUTibZ0bYADTlu0SpRrMwqb6doSyR8919t2Fr
         ZSWpMmykmahnwSEL/d4s7KfXxnrTjxek9UnSFBgliYTrR3cEgRnOkDwLqc7CnXwhL/nO
         lttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936243; x=1731541043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz3gYzQ4n32I4z58BHzCmszK35FiX3Yy6HdDdCI5+KM=;
        b=WLvlqBvqrcnhMUFCtDqCbx+bYPk2TQ5HUEHyfFL6oVe9RXZ4TN4UIAX4NHUInhx0O7
         BfmmdDliGoWsdBy0YkSXE/ZBviMDGaNBquwAeJxMXtWTBLM0kyjscSNHaih47JBHHZcI
         CwIDPccWqz0Dov8+TAWA1hN+PLVyGtBvcfrp21QyoZlmYuPTvfcXWFP664VdL1E5Y+TU
         AWvWrbRNwX/Hw7V1lQGFFui3iIv+KolRmsaPJeCTWzDEypF95ediltVHZf0EyrO5zAIm
         E81MCltGcED3WSy6yzdO6KSuTRK2vGyE9WyylIfRdalSCPI4kGn/ldSR+GDDuLGShu/r
         yhCA==
X-Forwarded-Encrypted: i=1; AJvYcCW/dsM0CcdC7N8dd7pUoeghZbgbKiX6gIK9MrzmBCNklyt/camFhHqpLJjXWmDoYexDATcBjyITYCzNQPjh@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLgLIfv7OhTQzT+UdgYo12SNe1AOcr95DNAcC4Ud0AePDACNG
	JSs4MNB9FnD5g7rePP9Jq8CKHCAgrEYEAMjn3aN+nyWKVyYQjUBkql+W3UAW4IGzma2VAv980TN
	5gBr7I1Akd7ZNLYX99DQOso877iE=
X-Google-Smtp-Source: AGHT+IGvugyVfeM1HThyBImtsu/AaR/aZpZDSIjM4wJB+KxgAkOfuIbqI8F7li1oa4RDxXAYycDRK9oOPZOLe931dSo=
X-Received: by 2002:ac8:7fc4:0:b0:461:1532:d769 with SMTP id
 d75a77b69052e-4613c19a90amr590681841cf.54.1730936242690; Wed, 06 Nov 2024
 15:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1aqMY0j179JwRMZ3ZWL0Hr6Lrjn3oNHgQEiyUwRjLdVRw@mail.gmail.com>
 <c1cac2b5-e89f-452a-ba4f-95ed8d1ab16f@fastmail.fm> <CAJnrk1ZLEUZ9V48UfmXyF_=cFY38VdN=VO9LgBkXQSeR-2fMHw@mail.gmail.com>
 <rdqst2o734ch5ttfjwm6d6albtoly5wgvmdyyqepieyjo3qq7n@vraptoacoa3r>
 <ba12ca3b-7d98-489d-b5b9-d8c5c4504987@fastmail.fm> <CAJnrk1b9ttYVM2tupaNy+hqONRjRbxsGwdFvbCep75v01RtK+g@mail.gmail.com>
 <4hwdxhdxgjyxgxutzggny4isnb45jxtump7j7tzzv6paaqg2lr@55sguz7y4hu7>
 <CAJnrk1aY-OmjhB8bnowLNYosTP_nTZXGpiQimSS5VRfnNgBoJA@mail.gmail.com>
 <ipa4ozknzw5wq4z4znhza3km5erishys7kf6ov26kmmh4r7kph@vedmnra6kpbz>
 <CAJnrk1aZV=1mXwO+SNupffLQtQNeD3Uz+PBcxL1TKBDgGsgQPg@mail.gmail.com> <fqfgkvavsktbgonbdpy766bl3c2634b4c7aghi4tndwurxqhp2@qphspeeemlzg>
In-Reply-To: <fqfgkvavsktbgonbdpy766bl3c2634b4c7aghi4tndwurxqhp2@qphspeeemlzg>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 6 Nov 2024 15:37:11 -0800
Message-ID: <CAJnrk1bdJ7E1z_fWpXe1VHk6o-ZYdN+WaVpS4W0oz_6MZNPacA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:38=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Oct 31, 2024 at 02:52:57PM GMT, Joanne Koong wrote:
> > On Thu, Oct 31, 2024 at 1:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 12:06:49PM GMT, Joanne Koong wrote:
> > > > On Wed, Oct 30, 2024 at 5:30=E2=80=AFPM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > [...]
> > > > >
> > > > > Memory pool is a bit confusing term here. Most probably you are a=
sking
> > > > > about the migrate type of the page block from which tmp page is
> > > > > allocated from. In a normal system, tmp page would be allocated f=
rom page
> > > > > block with MIGRATE_UNMOVABLE migrate type while the page cache pa=
ge, it
> > > > > depends on what gfp flag was used for its allocation. What does f=
use fs
> > > > > use? GFP_HIGHUSER_MOVABLE or something else? Under low memory sit=
uation
> > > > > allocations can get mixed up with different migrate types.
> > > > >
> > > >
> > > > I believe it's GFP_HIGHUSER_MOVABLE for the page cache pages since
> > > > fuse doesn't set any additional gfp masks on the inode mapping.
> > > >
> > > > Could we just allocate the fuse writeback pages with GFP_HIGHUSER
> > > > instead of GFP_HIGHUSER_MOVABLE? That would be in fuse_write_begin(=
)
> > > > where we pass in the gfp mask to __filemap_get_folio(). I think thi=
s
> > > > would give us the same behavior memory-wise as what the tmp pages
> > > > currently do,
> > >
> > > I don't think it would be the same behavior. From what I understand t=
he
> > > liftime of the tmp page is from the start of the writeback till the a=
ck
> > > from the fuse server that writeback is done. While the lifetime of th=
e
> > > page of the page cache can be arbitrarily large. We should just make =
it
> > > unmovable for its lifetime. I think it is fine to make the page
> > > unmovable during the writeback. We should not try to optimize for the
> > > bad or buggy behavior of fuse server.
> > >
> > > Regarding the avoidance of wait on writeback for fuse folios, I think=
 we
> > > can handle the migration similar to how you are handling reclaim and =
in
> > > addition we can add a WARN() in folio_wait_writeback() if the kernel =
ever
> > > sees a fuse folio in that function.
> >
> > Awesome, this is what I'm planning to do in v3 to address migration the=
n:
> >
> > 1) in migrate_folio_unmap(), only call "folio_wait_writeback(src);" if
> > src->mapping does not have the AS_NO_WRITEBACK_WAIT bit set on it (eg
> > fuse folios will have that AS_NO_WRITEBACK_WAIT bit set)
> >
> > 2) in the fuse filesystem's implementation of the
> > mapping->a_ops->migrate_folio callback, return -EAGAIN if the folio is
> > under writeback.
>
> 3) Add WARN_ONCE() in folio_wait_writeback() if folio->mapping has
> AS_NO_WRITEBACK_WAIT set and return without waiting.

For v3, I'm going to change AS_NO_WRITEBACK_RECLAIM to
AS_WRITEBACK_MAY_BLOCK and skip 3) because 3) may be too restrictive.
For example, for the sync_file_range() syscall, we do want to wait on
writeback - it's ok in this case to call folio_wait_writeback() on a
fuse folio since the caller would have intentionally passed in a fuse
fd to sync_file_range().


Thanks,
Joanne

>
> >
> > Does this sound good?
>
> Yes.

