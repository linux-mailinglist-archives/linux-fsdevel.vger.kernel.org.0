Return-Path: <linux-fsdevel+bounces-64253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC6DBDFD42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DD294E4BD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028712EBBA4;
	Wed, 15 Oct 2025 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtbOsK9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABA2D2485
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548770; cv=none; b=P2IuCJFabf4mA50pYJMjeROS4HiPCKui8cfGJ7qHEVXZtcixEtECWgJtrnIMpne7KbL53YMTY/TJu0issBW7758kWGkG0QagR+rPt4C0soWRap42rX3xqanOVZe+OqYqighWXMp8PqqmKKdKnUg/uymbSmtNUKD5CqILyiFX99M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548770; c=relaxed/simple;
	bh=TMIy3qhByr4KuTXyATX/wSL3AQldOezxzFv9eiIqO8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY3lMeVwEaqOAEKkIiwnud7vR4zm5qMFjgPwkXxSpQ0MwEKXWcA5IqKaff1qGtc9ulhm+r4Ieh0WWREY9m6tViZXwSynAl1cfxZjWS4ZtPXHPnkWJ6cFyJw0MNHHMnZHJVCcXIybSxY71kHv4MzUE9RB2IXoZA5qoYUMKvxGERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtbOsK9z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-816ac9f9507so170685385a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760548767; x=1761153567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOrazw55riCP/Aur0rBmo9Q0amixGsabgjSNwoheBcY=;
        b=dtbOsK9zX3ftRUWYXOlAcOAq6syAC1JxQAY+h3fEhtKPro8OVp4jw36eyOwjGcnETh
         iOZx2q8dB6+3GBmJ63J9HvqH5OZqZ89j1tEst1rJFd6UKfnk+AZbYLaRAYbuUknYFUA3
         Q9NklHAJi7vnLkmLZp1td/l62XR2dYVRWG8QCdmSmYMoo0qAJRH7e3z5jAR9HvmbB08v
         c/1RNVJVKC3cKqJAhIzjHAhsGrGxXo/5MWO4Q4ZNa6BivV6t17ECYsq44p1I1SyX0fzu
         9PpF3RfLcbfusyogJlqFMff/U0YgVah/yAWYRDJ16eY5cpuQUtTywUYyULWXdJa2WGCg
         2SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760548767; x=1761153567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOrazw55riCP/Aur0rBmo9Q0amixGsabgjSNwoheBcY=;
        b=DnqEV3//2PDizlzwscDXUH2JFKf6jgVIK0/QUpbYUrLCd6LNFcpZt8QHLbMFV533lq
         5abhn6l0CRU/izbK9ARUOTvKRTX0GT2GDPLNatyeHakd4wd545kKy+j4VdXvrG4TKhEz
         Sr80whtBBvQzv1Vh9ZsmTZ9eo/DiWA+Gr3xzLr1nGQPliLPHUqijVBj/TBeiLuqsGrpe
         50HEziJT8NCgEjBJ4JeewHt31ElIjfPPgvOuDUbzARdQ7h2OV4AF3TgIPGDkgrSiZVhj
         kaNxW04nOCcz3+uTUggHAXxTs/4tvgPK3S4Vfqk1TvmgO+Jgf/5t1xrYpWWyf4nRYkX0
         VGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqVPvRX9IAEJ6l1bNumuqH9iLZKa+qEuY7vxy8r90QaQ21vXSqwuqXe5fcYzASsNky36rTsY2hyue/d7Kz@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4Xzn/lsCc4K8fEFvD+FQWc+FveAvjDFVAWdR2+ekdVruO2DV
	1Fc0Gxobx/ig0SieiOiA6Cl7Cm9z4fd9KzPSlB0R90M0MuzXz1Y5JG1ogJP9hNWVwluDZbfoTNE
	2KTaLQwQS47djaNLobhVSpiBZAIe4raI=
X-Gm-Gg: ASbGnctX8jp17HyzkKQtQvhvnbO0PNBBZOUGEc4FQetO7qC5+Dq2pGBOgKkURHJOMGi
	hI8xzeT6hvLwrF6eycBiJPXLZ0nxnI/C399mF4nDrAZed4PMVfcGfA9lA3WR84A9YVvVcI/AOaD
	PkejlwgiHHykdabwzeoSGq/xIxow8QYiISRUwjXWvWgSk44QcjLqxExCIcn742q5HB9FwY9Vclg
	/voDJP+no4oBvurFIacitzALhJKNZEl0OmdRTXXEWQjWBC1g5IRLj1cyLd10NDq/wg5
X-Google-Smtp-Source: AGHT+IHMj8/0q217RxAjVF44oXg9hw5QCyqlGhPqFPzXru4QZfXmi2OzppAQuQ/NtBJj1yQoYjWFFacwFm5yovuLvqY=
X-Received: by 2002:ac8:588c:0:b0:4b6:cbd:8c91 with SMTP id
 d75a77b69052e-4e890dc9f08mr13347691cf.5.1760548767352; Wed, 15 Oct 2025
 10:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <CAJfpegt-OEGLwiBa=dJJowKM5vMFa+xCMZQZ0dKAWZebQ9iRdA@mail.gmail.com>
 <CAJnrk1Z26+c_xqTavib=t4h=Jb3CFwb7NXP=4DdLhWzUwS-QtQ@mail.gmail.com>
 <aO6N-g-y6VbSItzZ@bfoster> <CAFS-8+Ug-B=vCRYnz5YdEySfJM6fTDS3hRH04Td5+1GyJJGtgA@mail.gmail.com>
 <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
In-Reply-To: <CAJfpegsiREizDTio4gO=cBjJnaLQQNsmeKOC=tCR0p5fkjQfSg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Oct 2025 10:19:15 -0700
X-Gm-Features: AS18NWBU-7oqcttbWL37aBsF3LCTdQr-uxEvWrZ9A49oBhcJ3MZfXn2aiHE1LH4
Message-ID: <CAJnrk1b=UMb9GrU0oiah986of_dgwLiRsZKvodwBoO1PSUaP7w@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 7:09=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 15 Oct 2025 at 06:00, lu gu <giveme.gulu@gmail.com> wrote:
> >
> > >  Attaching a test patch, minimally tested.
> > Since I only have a test environment for kernel 5.15, I ported this
> > patch to the FUSE module in 5.15. I ran the previous LTP test cases
> > more than ten times, and the data inconsistency issue did not reoccur.
> > However, a deadlock occur. Below is the specific stack trace.
>
> This is does not reproduce for me on 6.17 even after running the test
> for hours.  Without seeing your backport it is difficult to say
> anything about the reason for the deadlock.
>
> Attaching an updated patch that takes care of i_wb initialization on
> CONFIG_CGROUP_WRITEBACK=3Dy.

I think now we'll also need to always set
mapping_set_writeback_may_deadlock_on_reclaim(), eg

@@ -3125,8 +3128,7 @@ void fuse_init_file_inode(struct inode *inode,
unsigned int flags)

        inode->i_fop =3D &fuse_file_operations;
        inode->i_data.a_ops =3D &fuse_file_aops;
-       if (fc->writeback_cache)
-               mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_dat=
a);
+       mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);


Does this completely get rid of the race? There's a fair chance I'm
wrong here but doesn't the race still happen if the read invalidation
happens before the write grabs the folio lock? This is the scenario
I'm thinking of:

Thread A (read):
read, w/ auto inval and a outdated mtime triggers invalidate_inode_pages2()
generic_file_read_iter() is called, which calls filemap_read() ->
filemap_get_pages() -> triggers read_folio/readahead
read_folio/readahead fetches data (stale) from the server, unlocks folios

Thread B (writethrough write):
fuse_perform_write() -> fuse_fill_write_pages():
grabs the folio lock and copies new write data to page cache, sets
writeback flag and unlocks folio, sends request to server

Thread A (read):
the read data that was fetched from the server gets copied to the page
cache in filemap_read()
overwrites the write data in the page cache with the stale data

Am i misanalyzing something in this sequence?

Thanks,
Joanne
>
> Thanks,
> Miklos

