Return-Path: <linux-fsdevel+bounces-18372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC78B7B89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A12C1F236CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831517B4EC;
	Tue, 30 Apr 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXPQ4YgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB317A922;
	Tue, 30 Apr 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490860; cv=none; b=g5lKkfNQqMGCweU9vzmbeQY2Y7+g4Y7CaNbY0Uij8imF6RT46cXJGNXxsNy/VIHILD8AIhXDFIqf4X3tbScNImtGKBohA0nIfB/FD5LCUxTYZ/vNU+xJCeT+shYOyZ3Awg8HU7flWEQEGkuJYpR3C+Rc55QBLwNfNy/Tel6cwoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490860; c=relaxed/simple;
	bh=0lUvNEoZzpGwwKad5l5LPVFc4Ky2PspYcmcv3+a9bsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFziMq3EDii7kjWQ7IGujj5UJGh39jAO1h23A5oai2LYxCkA0PCjHVmK0iHLNxiJKsQjc0jRNeKTIplmH3EkkCeMxxFyvl5v7jcmsitX3DKtURZR+X3kczPe2tUZDx00UArabsK3BIzS5blnuVgTf5+B/2O78Usw97Zk8JeymIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXPQ4YgI; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2de232989aaso70456161fa.1;
        Tue, 30 Apr 2024 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490856; x=1715095656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z0uYLrmo+RQNsrVNRCYQ80LU2B7TKkW9AZwBgm7Igg=;
        b=lXPQ4YgIlY+RiusRDhjLdRIxNxCARE9tIYAr/Mz+HjQoZdAlV7TMIYHLuJtA93fB1J
         j6TqqsEfVMAmxhmiocwi3jeLTP6AmTIia1NIsLdVnJtNSYdkbIkUROy8dZ9wfruE1jOl
         AHwK6E9Rpo6nelwi+Yr2PE4aU/7b1gCyNa3ojKuP1OaQzFeBWMVGZKRqg/hhXC3dtuGK
         Rlz/MYzm+ca72OQzmEd6JRQgFsle5FX0qYjzWSgYDvMzizlsnL8GsUMABSpxF2TB+EG1
         6fdsxMTmHtWbJkEjCpk4TjyuEBqQ12ukp+M9PB2SKnWrOBKJ2X+ax3cC+35RrFOy3spc
         Ihuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490856; x=1715095656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z0uYLrmo+RQNsrVNRCYQ80LU2B7TKkW9AZwBgm7Igg=;
        b=YYnZLtZrStxd5FWAdPZkgjslUVsJfQSmldpFRIa7lRVz+bndN7YuVszZBT8GMqs6sb
         o9sW+b0RfxoZxVCQOfQwU4PnGEY2XlEliVBlgWHXRC67Bo225Mxwc8Dt+1AMvz8pVG6G
         3aq9pLlmqIetkXoR+O0GmCRhYbK7DY/gGl7LXQWrQsFNYwXQBuc0MVmO4NANLrzDU9Ne
         g2Z9X+yLrcOOnIMXFyHG61D+XAeDGzN2K8Hyq+iPpzpiap8SC7QBwH+MCdyVosm1qM41
         N/3lxNHc12o5L9LGcEt4hwCarK+7+v4dHOX7xs9VMAGSsKkAlgZNNT1hHIpVdfuVUTp2
         ypaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZw7X/SIbuKGZMHRrDOwQMwlk+NBcS0zzDHzBX4fprMDKN3KStMd6lrwFDqQSoCIOf3ZIf+VW16976yVvKTAXOshSYpz6YuEyfNiw+ETV+3YJmLv9dGemtOBIAphvp6+HOkngkY35z4UlnkA==
X-Gm-Message-State: AOJu0Yx2bBmpkC6My1ySjPht1AhFGdGKUobvXdM9pOqV08w85U3pAys1
	j6LsclkdsE9OW2swooiiS1wjeXTxeWp7hW04zUJnYGlpQ8Q77IYt736WlfhYdMhD1x9TMUDek5B
	qZ8onPZTgA9oo2+9h7iZjHLWo3bA=
X-Google-Smtp-Source: AGHT+IErQbSLUt/YpGlibFWHxAfNy9szYPfD5nGHlN8PsQLyIxU3N9pbgQdETZm+8xNM3hOh66/YaVRbgQ3WbhEuXkk=
X-Received: by 2002:a2e:9a89:0:b0:2df:6cb8:c911 with SMTP id
 p9-20020a2e9a89000000b002df6cb8c911mr41484lji.24.1714490856431; Tue, 30 Apr
 2024 08:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429190500.30979-1-ryncsn@gmail.com> <8734r3muvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734r3muvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Apr 2024 23:27:18 +0800
Message-ID: <CAMgjq7AbsvWnpoEFtXixgMN-qqcG_tsGbH7qOizjw-E7f9_HTg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/swap: clean up and optimize swap cache index
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:47=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > This is based on latest mm-unstable. Patch 1/12 might not be needed if
> > f2fs converted .readahead to use folio, I included it for easier test
> > and review.
> >
> > Currently we use one swap_address_space for every 64M chunk to reduce l=
ock
> > contention, this is like having a set of smaller swap files inside one
> > big swap file.
>
> I would rather to say,
>
> "
> this is like having a set of smaller files inside a swap device.
> "
>
> To avoid possible confusing in this series.  I suggest to avoid to say
> "swap file".  Instead, we can use "swap device".

Good suggestion, will update this part.


> [snip]
>
> --
> Best Regards,
> Huang, Ying

