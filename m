Return-Path: <linux-fsdevel+bounces-51070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE46AD28CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43B5189221C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA72222A8;
	Mon,  9 Jun 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPal4bM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26B1E3DF2;
	Mon,  9 Jun 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504547; cv=none; b=DCNquI67ORYtHBbD8YBE5hvUgxnLTvuWbLshwgwzYL1PEviaSm5Vn+8GLVIpX0KNA1mdi4wFoe7nJ4AGYAOdYR1owhdL2Bm/fuFLCvfiyIoG8pZlc4TX2MEi/hxHelmFmIBMHS9sK5z/4yWXf2V/18vMbtFRgdCWNQuiTd0hYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504547; c=relaxed/simple;
	bh=2WAmKO7sJacuDhKuzYDa1Xe60onG3lRKvwzt5EKkAqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNS8uTTrId7K6e+Ughe7BdUca2cy+iXMinIb3gce6kPeSgqg1kdllheTWXNAsLgmI53Hicq3SmsQwmdCZBYD3a5f4ZhzAh/sg/rrPMQuyHxVAmgUdCHvw4EqH9tQaQ9DJxYXqBErzOWPp5qL/F/FP9nBgLCGhT3EQzZHy2bdyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPal4bM6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a43e277198so39536351cf.1;
        Mon, 09 Jun 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749504544; x=1750109344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWLy5jrQgm0xqO3H9E8/noeXy3cl3+xaM4UqtA1//Aw=;
        b=lPal4bM6ff1Bw82msuAReRTkKXqW1DwWE0Lk2VMvPy/dCyk+cx4uslJme0dk6ktNsd
         hfSK1xjCS+YR26/Wm9OcHoTQpzs16XpO+gd54j4kWvnMrfAF72kgBs9Dlj/fEVPem0/A
         IxpGERgmyTNUMmFdWYLWuO1zqeOSl4jNRNVdUfNmmCkLKCQVxE+nfFtvJmQB8kojWAgL
         3ZmYpd30W/QNQpk4PLYk+RYCNYqxa7mTp9zf+Lb394wGRVfYM+94FaIzL88RRQjqo+W5
         /JaJCTVqX+TC7Gpki8Lgl1qolyEcYvdiozJqKGaXGfM4KowC3rHjsuhyb6MJP+vrbMRw
         eFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749504544; x=1750109344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWLy5jrQgm0xqO3H9E8/noeXy3cl3+xaM4UqtA1//Aw=;
        b=YBX9msHCzKqbQdqBRWlFvH1h2fGzysdzTRKI9R8dKMgyjN35wI2rgGqbyEVr45hc6d
         H8ufydu6+CjgETxCJ2M2aZ1OWhZj0PxfjHMGgOQR/jBg2TVkY3ah84zcDYlDZWfguv/s
         xKXJlI2gP+xqqVfnJ4anWKMtXo9dcFyBHcmX2t2ihE+Et+RVvTqDTPgO3muRdAvGUJIP
         Bh4muURxa3Yni7M0hI4eQcIHiVansecgOL8iLWMufVfZZW2+73or4nOZpGeR6xfDiW4W
         JNQdU6B+NHBzzAy1iE8ne5ZMn2GWWm5VvS2VkT0gMoDKk0e8xOBhQ78Y3/t4H554d/Z6
         g7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jTgbyIViSG5hapMf3C9qmhsfS/WmNZ3kxe0Jwjf1V8SJxW214JM9cEKKsOSybFTdEqPFmv9ZHF69NslS@vger.kernel.org, AJvYcCWkajwqCzKrCYGll20k7DLWab8MmosNbtHzNbb0twfa+8myxmJJcPZPaO+FiP6zIQH3WEmMe3CpmNw1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5SA8IaJ5/DO3ZJiYXXL8gEHf5Oq1h/7hlmAefSy3RhpM54wdh
	ENcprwuGDvFcc6RYX3iG/FAUajFnlksiMIylGAtydWtqOWBDHo8xFawxn/68zasNL2G7xYb2DoS
	rzHZw5k4Q9OeLheLqDZXBTID5+sozJEQ=
X-Gm-Gg: ASbGncuUQkfCfpBcTxmRa4v3BmWSTxrz2fSFmy9SEf4JN0MJdSZhmfxFzDCkBUoR8zV
	qWISbaQiLe/Df6BpzrUVwLb7ta68LbwFN1kxEUXauXSHoajgDDwD4Gpfr6b3RVaBZSMDyektCX6
	JAp4/Nh1uJ4d6y45WaWdq/d9mp6XLyzec5qT5SStWb+eTC6IcH9ZqWRg==
X-Google-Smtp-Source: AGHT+IE92buhdHobNQeD3HoFHnGW1oGy0nqDBaMZBgPGW/d5Jquv9qL+QNPlH1sEgoEfLrGf+9RRlPtMgvw0NoT1UgU=
X-Received: by 2002:a05:622a:4d96:b0:4a4:3963:1e05 with SMTP id
 d75a77b69052e-4a5b9a2ac64mr283457531cf.14.1749504544153; Mon, 09 Jun 2025
 14:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <20250609162432.GI6156@frogsfrogsfrogs>
In-Reply-To: <20250609162432.GI6156@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 14:28:52 -0700
X-Gm-Features: AX0GCFtwkCRxRVUzNG0jnd56ixNJUcBkxS114AHm1TQc_gB6cu6zY8hFUeDPWJQ
Message-ID: <CAJnrk1aUJzN-c-jd0WzH8rb1R5rYdcnq=_RWMNobbQEk9_C7Wg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:24=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Jun 06, 2025 at 04:37:57PM -0700, Joanne Koong wrote:
> > Add a new iomap type, IOMAP_IN_MEM, that represents data that resides i=
n
> > memory and does not map to or depend on the block layer and is not
> > embedded inline in an inode. This will be used for example by filesyste=
ms
> > such as FUSE where the data is in memory or needs to be fetched from a
> > server and is not coupled with the block layer. This lets these
> > filesystems use some of the internal features in iomaps such as
> > granular dirty tracking for large folios.
>
> How does this differ from using IOMAP_INLINE and setting
> iomap::inline_data =3D kmap_local_folio(...)?  Is the situation here that
> FUSE already /has/ a folio from the mapping, so all you really need
> iomap to do is manage the folio's uptodate/dirty state?
>

I had looked into whether IOMAP_INLINE could be used but there are a few is=
sues:

a) no granular uptodate reading of the folio if the folio needs to be
read into the page cache
If fuse uses IOMAP_INLINE then it'll need to read in all the bytes of
whatever needs to be written into the folio because the IOMAP_INLINE
points to one contiguous memory region, not different chunks. For
example if there's a 2 MB file and position 0 to 1 MB of the file is
represented by a 1 MB folio, and a client issues a write from position
1 to 1048575, we'll need to read in the entire folio instead of just
the first and last chunks.

b) an extra memcpy is incurred if the folio needs to be read in (extra
read comes from reading inline data into folio) and an extra memcpy is
incurred after the write (extra write comes from writing from folio ->
inline data)
IOMAP_INLINE copies the inline data into the folio
(iomap_write_begin_inline() -> iomap_read_inline_data() ->
folio_fill_tail()) but for fuse, the folio would already have had to
been fetched from the server in fuse's ->iomap_begin callback (and
similarly, the  folio tail zeroing and dcache flush will be
unnecessary work here too). When the write is finished, there's an
extra memcpy incurred from iomap_write_end_inline() copying data from
the folio back to inline data (for fuse, inline data is already the
folio).

I guess we could add some flag that the filesystem can set in
->iomap_begin() to indicate that it's an IOMAP_INLINE type where the
mem is the folio being written, but that still doesn't help with the
issue in a).

c) IOMAP_INLINE isn't supported for writepages. From what I see, this
was added in commit 3e19e6f3e (" iomap: warn on inline maps in
iomap_writepage_map"). Maybe it's as simple as now allowing inline
maps to be used in writepages but it also seems to suggest that inline
maps is meant for something different than what fuse is trying to do
with it.

> --D
>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/iomap.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 68416b135151..dbbf217eb03f 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -30,6 +30,7 @@ struct vm_fault;
> >  #define IOMAP_MAPPED 2       /* blocks allocated at @addr */
> >  #define IOMAP_UNWRITTEN      3       /* blocks allocated at @addr in u=
nwritten state */
> >  #define IOMAP_INLINE 4       /* data inline in the inode */
> > +#define IOMAP_IN_MEM 5       /* data in memory, does not map to blocks=
 */
> >
> >  /*
> >   * Flags reported by the file system from iomap_begin:
> > --
> > 2.47.1
> >
> >

