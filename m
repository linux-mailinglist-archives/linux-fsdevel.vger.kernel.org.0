Return-Path: <linux-fsdevel+bounces-67793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D9C4B736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 05:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F3189545D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 04:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90D2F0C69;
	Tue, 11 Nov 2025 04:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoDqYKmz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37B6209F5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762834651; cv=none; b=taM2A793KCLzyBXbCjU+UsXOdwOEEhPXhCHSAZjd6dMKDCE1jhTQBH4IDl5hwpksjyW/LsLJ9QSQIT3gGmMJEOMws9AtR8enm5LUOR2uvpFlRwp8ZXGGGRX2LqweUYxlEXiigvGZcnCd6washRDXkBeHnoVYX5Bcm7f61qhDPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762834651; c=relaxed/simple;
	bh=+HDPvzmDF4pSMrTj/Ew9l4F35FfJ+clQaJCnh0ZMShI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwj/RNt+5v/QtN1oBH46ObQ1U2MLY+58oAze0Anefp4sq6DBUnx0OIoDopxocot9GTjl34xr2Rxt0EgpSfHZGYm7V6CKqmhZ9Rji3eJ3QfpM2lC7c/Ozmbfb24YEE5hj+Nz3tNeZvJfdiGbCHmKTbVmhSeBMfkaY5tbMp2BVLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoDqYKmz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so6297284a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 20:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762834648; x=1763439448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HDPvzmDF4pSMrTj/Ew9l4F35FfJ+clQaJCnh0ZMShI=;
        b=YoDqYKmzGF8bM3YVyapZFCLzJs1aUatVlNiCsfStikT9VR5zqCIWINU7fA1htC3nUS
         UI0gD1qeMAwmT+/quaeiRZxZAFbn+GZ0coRelao3yeEkeX9dBfQn2NF8WQgLS4UkKDoZ
         rZ2/dMJewqkngOgMe9ISCM+2Rfryjru1YUdEs32TfBaCtwuEKd5xFzDASQF78BUDFy2I
         kqHbRhiIJMuKML7/uQq8JdUzsltXQYRj5GOs9wbahxgxuz++xl++yaSr/MOUlNXfbAQE
         U0s4xHhgiYanK2WqhIRiAXfqqhYIP0JbJaL5H9Vdy+KZa9wkimUFx4q+HFnqgRm2paww
         D8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762834648; x=1763439448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HDPvzmDF4pSMrTj/Ew9l4F35FfJ+clQaJCnh0ZMShI=;
        b=TF6zwA5Ylqarh5jqk8XMdCXJNiT02OpHpB8Ya7feEhTcUf6c2zoqQxwrcinf9//xpz
         nzbrUr3MQvlzpJmh1S02hCMfsNxS59/AtNQ4x8JGXk1/PZs5tpwTwxTsAd++/KPOnB9F
         9GNO/QewJe3x5Ap7++99kAaTk8sCYMGYYFtOSXuA9gev4RcVt6F3iROJKwnEDTBoPPX2
         urrT7298PLrly48hz6LLRkne6CP2qQlgZ38ef4VBjpj270D5gj+9kOuB4MWxTj8HOMAB
         x/ysc8T22XLWdGbxKgy2d3KU78zOn63WVohIs644PgDQjR1wYSxHrjTJ0bjHS5Yh4kJ8
         b5dw==
X-Forwarded-Encrypted: i=1; AJvYcCVFXAKShreW5eVTgSnHjN7o5xPCnT6vgAhUcwPBalteLI/Uu5uYa4TFPpRBsWAb4uUyKHkzXZJe5F7hFFEE@vger.kernel.org
X-Gm-Message-State: AOJu0YwygS4RSQX7PO1HHsCIt276oA0j1sHcF9ytPs9emDOChT4wP144
	vWYz13+fEzK06K7Lpt4Yb9uAII3n1Px6k78ExBMNOMtRYZUocK8SpBAY61F0osiy2vAzRDK3VHF
	spWXLXm3LZzHOJpqoNCXsetA5q2lXnrQ=
X-Gm-Gg: ASbGncuubEpLsa7NuIYME0AtdmCxqU+rzIsanMr607O6hnQFohx9o69ibbTi//zvPDl
	0aNNxTPLo5/6yQ8hUK7+d0xk4mCxPgPonF9pxKi/T77MH/+8icj4WUq8fdPCLab2qDiCUF08NTk
	ygL6/zopadnCmyk8bnu0L1jN1xixBkLQ2TNU8VSPbgkxu5U2uA3fpNzf3aZAqfmCC+5YctM7Rsh
	d0CvoDl5XLY9yh/tg4zLu3UQS+Dzu1QrfFnOgyOgemcOLbmDUAfAxyxM4rk596cE/8PdEOqeKkh
	WqJEyApUjlWZJACwQCXm1AbRnhxFJR8yLyvTUQ==
X-Google-Smtp-Source: AGHT+IFxtJ5LUfVYMfACvoc6qLigR2M037K7mxtxeAfO+UoGi5MaKsWG6FcjLFJ3BqqcytYnHVwzOPfWzu221I34nu0=
X-Received: by 2002:a05:6402:510e:b0:63b:f22d:9254 with SMTP id
 4fb4d7f45d1cf-6415e6edc1cmr8920410a12.23.1762834647589; Mon, 10 Nov 2025
 20:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <CACePvbVq3kFtrue2smXRSZ86+EuNVf6q+awQnU-n7=Q4x7U9Lw@mail.gmail.com>
 <5b60f6e8-7eab-4518-808a-b34331662da5@lucifer.local> <CACePvbUvQu+So7OoUbJTMLODz8YDAOgWaM8A-RXFj2U_Qc-dng@mail.gmail.com>
 <3c0e9dd0-70ac-4588-813b-ffb24d40f067@lucifer.local> <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
In-Reply-To: <c9e3ad0e-02ef-077c-c12c-f72057eb7817@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 11 Nov 2025 12:16:51 +0800
X-Gm-Features: AWmQ_bmvt7re6_XRmXvUlAJCOhI6cJA0pVFvbyH2-3YOeH3XrYzunQCqAT7qyRY
Message-ID: <CAMgjq7BT8+Vs+7=G5PUS5wsxAhWVzDTGLX5g3mXMpTJ8PFSbxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] mm: remove is_swap_[pte, pmd]() + non-swap
 entries, introduce leaf entries
To: Hugh Dickins <hughd@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, SeongJae Park <sj@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Pedro Falcato <pfalcato@suse.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 8:09=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> On Mon, 10 Nov 2025, Lorenzo Stoakes wrote:
> > On Mon, Nov 10, 2025 at 03:04:48AM -0800, Chris Li wrote:
> > >
> > > That is actually the reason to give the swap table change more
> > > priority. Just saying.
> >
> > I'm sorry but this is not a reasonable request. I am being as empatheti=
c and
> > kind as I can be here, but this series is proceeding without arbitrary =
delay.
> >
> > I will do everything I can to accommodate any concerns or issues you ma=
y have
> > here _within reason_ :)
>
> But Lorenzo, have you even tested your series properly yet, with
> swapping and folio migration and huge pages and tmpfs under load?
> Please do.
>
> I haven't had time to bisect yet, maybe there's nothing more needed
> than a one-liner fix somewhere; but from my experience it is not yet
> ready for inclusion in mm and next - it stops testing other folks' work.
>
> I haven't tried today's v3, but from the cover letter of differences,
> it didn't look like much of importance is fixed since v2: which
> (after a profusion of "Bad swap offet entry 3ffffffffffff" messages,

I also noticed the 0x3fff... issue in V2:
https://lore.kernel.org/all/CAMgjq7AP383YfU3L5ZxJ9U3x-vRPnEkEUtmnPdXD29HiNC=
8OrA@mail.gmail.com/

The issue is caused by removing the pte_none check, that could result
in issues like this, so that check has to stay I think, at least for
the swap part.

It seems V3 has fixed it, I can have a try later.

I also hope we can keep the swap entry part untouched, Overloading
swap entry for things like migration looks odd indeed, but setting and
getting a PTE as swap entry seems clean and easy to understand.
Existing usage of swap entries is quite logically consistent and
stable, we might need to do some cleanup for swap but having a
standalone type and define is very helpful.

