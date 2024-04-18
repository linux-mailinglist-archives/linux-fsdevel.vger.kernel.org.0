Return-Path: <linux-fsdevel+bounces-17222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F098A91AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 05:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546D0B22402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 03:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B28C1F;
	Thu, 18 Apr 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVtsvFK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662F4F1F1;
	Thu, 18 Apr 2024 03:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713412531; cv=none; b=dgtx9GaEoH2w2fLO5ROnOfUP2piwaZoqzaZWilkZfni9SsXU8a48r2cp47mWwEihLyG1PU7+6LN3ZD4teGVvTrB/y349Atuh65NM1ABRvP7DWxRfj/NjFqP8b3kivhCS2/mVv1AAHQ2BOgV5/uDggSXSgp07+N4B4r3KDKbMRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713412531; c=relaxed/simple;
	bh=uAI/w4LQxKfTnZZ97rhZLaZINNtDNRc6nO5ZqSFmCaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdBAlgFWUslr5ZGLS5qacD6Zza7/WwX16/Ow+qj5WHmyJ26vaBDkEBD9cveVW0MHsbMecoZSRCjV8D+G3p6vkdNTa3M+pLffZGmlIeGP+pVKTc/Z8J36sZQe3sb/eM2kTQKQmFzcGr87feb52czjBKInuMCJYE5uyYt5nelqvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVtsvFK3; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7e05b1ef941so105796241.3;
        Wed, 17 Apr 2024 20:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713412529; x=1714017329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSFVsf7yg9xeJZAC97zFjVf1GebGLbTu3LyPHnS2CXE=;
        b=TVtsvFK3z37PqjZKGy/GF8Oj1oTMe6feiJ0AY9HYWMuMKIZdBwlY1/kQRu6cq/k/38
         NhWWjjNdP8z2vcO1X1b42vEQtQ7pkwCgBkO3HXf8A8k6qA0fBet8dM8gpKdHnGHloaPS
         q4YPF79bHX98ZObieL/phHSaJYnzNvM8bQJgJv9syG1BhHswFfoIp4LGDhKNRVSs7U3Z
         ZuqUWt+qFaRxozfMGZ53JzxF02zUovPzVDAJImode6GSWpVmj58Z19xdY3oQZTOiwQTU
         QtyltmHbKZQV7q7uXVV3eHsamyp10AyMHe5D+jzW8VyWeXW8tHkoFjGTL828pN2Hi0+E
         Civg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713412529; x=1714017329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSFVsf7yg9xeJZAC97zFjVf1GebGLbTu3LyPHnS2CXE=;
        b=jxvV/FXUNVBTEJq84Oua6nmUjzupStfa7+LLCM3Lx4EE0dmh5QFjEh8ThKUBAXnZiB
         SAC0LJsDG1k9AqFgUQsAUY980DKizZ5DR6G3yBou74AiFdllGz4moekpt5TUv3aRkHfQ
         4JVcrtXH2zJa/UTPwFnLwhxt/7nmhBSAKqdpHXlF6gyLGMKVtCAjnQNvZ/tXwocnQO8s
         Fh2v+J8FcTlB5v2+zV6vGnIZYgyYfSE+UPjEyVreSvg2Sn1xbXaDWzYgZrAiaFnmY4dF
         7NuvKWpZmMCqyJGBT1HtiT7nw2Tuv9jVdO1RjkiDawModt4fpf0ShD3cwwqDLxHeLD2D
         gE9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqiMjUrt8IMme2VQ+rHBMfCc3cF4OqGAtn73gacincSjMXrm00uNr5/EkFu5EVh3LMjlsnFUUvCxRM5Te2J5SnMskdxAgJTjqKpxhxPZycCGmqGE5hcEEegZUSnuXqqnH0YuJrz7bryPEiGg==
X-Gm-Message-State: AOJu0YyVzJeEjl/GVwzHa+XtnFa8Rpqhl1zVB28Brbb1OvhRlkDr/MPh
	isgfvxjQGUgn6mNkznhq/PxVwX97vuuzN7hrw2O08bL6It23947hfxa18zYKm/DHh/3Pm2yWuJU
	9rXV4accn0cQKjvt0fslMsMJk0NM=
X-Google-Smtp-Source: AGHT+IEy4zpzc+qCzIoclfV+YTK+u+KL4zMM2pjKTTvV0W79cUczjD9ffc8LsG38t8IzneZ8jhaIkLK3cc5hcpOIQf0=
X-Received: by 2002:a05:6122:a0a:b0:4c9:b8a8:78d4 with SMTP id
 10-20020a0561220a0a00b004c9b8a878d4mr1803881vkn.3.1713412528761; Wed, 17 Apr
 2024 20:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-8-ryncsn@gmail.com>
 <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com> <ZiCT5rNr5oxdFsce@casper.infradead.org>
In-Reply-To: <ZiCT5rNr5oxdFsce@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Apr 2024 15:55:17 +1200
Message-ID: <CAGsJ_4z5R++Fp+rOj08ZJvGpnqbhBDgQ0J6YvctNDvtND2oyEg@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: drop page_index/page_file_offset and convert swap
 helpers to use folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 18, 2024 at 01:55:28PM +1200, Barry Song wrote:
> > I also find it rather odd that folio_file_page() is utilized for both
> > swp and file.
> >
> > mm/memory.c <<do_swap_page>>
> >              page =3D folio_file_page(folio, swp_offset(entry));
> > mm/swap_state.c <<swapin_readahead>>
> >              return folio_file_page(folio, swp_offset(entry));
> > mm/swapfile.c <<unuse_pte>>
> >              page =3D folio_file_page(folio, swp_offset(entry));
> >
> > Do you believe it's worthwhile to tidy up?
>
> Why do you find it odd?  What would you propose instead?

i'd prefer something like folio_swap_page(folio, entry);

