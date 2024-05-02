Return-Path: <linux-fsdevel+bounces-18501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4358B99C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 13:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8689F1C21E2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 11:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5C60882;
	Thu,  2 May 2024 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggPUlGS5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681605FEF2;
	Thu,  2 May 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648153; cv=none; b=LmHEfCYy9olkLoTlreJ+rDuv6mfsCulOjjWEpRUaiwRpyDfy9MMVZP/Fgi3Tf+ZnehHZRWCM+0X8F1Oj52BEekqpCX1892qfFk/PSs3pljGGco5VbKeRQseUdw4f1sbE2hRtz+UVIvvr+1I+Ngak0YdhOQAhnAbpMZZj4MyDldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648153; c=relaxed/simple;
	bh=+IRrrwOe4QgFdY3yImZdYa8atZq/92Cz6xNWsXzEkvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3QwT9WERssXWxelQSCre3Wby417kFYabjAcCXR1w6Mg48KKNnr21+6MofT2Ch8jvNeBR7kynsTvmToVgtfc+TTx44GknN32R9/87ZAMPpgoJWx0mazzlFUFwC5RVUoBg7iObEZIt18BDoWDTwnxZ32rizJ+/HhFVnz0FBSLUEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggPUlGS5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1d6166521so4879911fa.1;
        Thu, 02 May 2024 04:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714648149; x=1715252949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhA8VLambKpb9wjap82p3kDvxUZ8xK7ATrERgvWkdSA=;
        b=ggPUlGS5z05O3QoSuiVve3uYom6UXE347AiX8VQeMyUgySzci4qPNWoIAcidqwwDfN
         mhIK2tymRXwSR99tsoSSXEoTe3dikZLue9Mhuz2glLNC8nIg/crkiuY4agw4mtXeMjNq
         z7PBUf4dfGnjz+SlbtKQiuZfRBMIOw2ZyQqEU4tYUu/ARMyB/iwWodH7ewffAUDrZdJm
         fq3GJe8AdDqEWkVWtMuYUul0fHW6nklEwSOgezXsmqLiWAgqfPdkXLWSyKYf11WQNest
         YvMwWhmpxKGO9Da49nW+fJAc0pttP+IiIIYPXRyq/1a0bgpsjqw9n2AJi79Ta3WaMosF
         xGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714648149; x=1715252949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhA8VLambKpb9wjap82p3kDvxUZ8xK7ATrERgvWkdSA=;
        b=dYgmHo2aa24Q0ZEAxpgbpToburxR8vzh+J+ZqWsq9CRj8FZ7V17fxl0PyyhpbqClvJ
         b+ZaaOFzKbBem7vhztNWrL4eHFTcRyLgNhB0ySCAXAXc2h7zTpqLEHQUbGwkJvgpKBrr
         RpKGeB+StcCsuF+lybUVvcNhzpeiQVthpgmTDZhTVpBzVrUX3jRFVIMTlucOOoHKg7CX
         TXzJs0HaBN0SavPNZ8GqbwOUOUqsc6MC4ighmJb1F+YdidlM17dA/BVqcOXIEdTzWsA6
         gOshUJHy3z3vYwToV2ebdlEbf69ejHvYUvRu1UluAk+ecD/RGAmvafR1HmnJ2LozWBn1
         XztQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGZWi39E9wzNJ+C9ghnw+jnRnXiasmM1Tyr8GPWN8Diz5EULn4PdxpTD7Y6AtPhNBZRdjHW6v10w+rN9V2qMouF4jUmcJuFsd6zF0aeYOcC16rUR6N5lJNaqIv7Tao8B5AuTEUWrBmJQe68T6ZDA5YhOpTluSKh0FEdRjk7MMLLgoZCDeQ+3OP
X-Gm-Message-State: AOJu0YyzkRd0GGc1D5NEKLuzOBpeqHo+UIRdxnHjKGO0hksCulsx1UX0
	QVOU/OSVwKgK8ypYpES19EHW3ESApp9sUMcunYKtfBBhCGFa4H75sw+1kjJUnHlqH+0byc0VmoR
	f2xiNMq+5RdxUp2h777UbmUxmIMk=
X-Google-Smtp-Source: AGHT+IEMqK/WlDTzQp+B69oJEqZmK62x8gnRdcu9h34/zfAEjG64PWrWjN5DkS+XDB04HBNlIAxP40Qo4poXOKyiDtA=
X-Received: by 2002:a2e:9cd3:0:b0:2e0:298d:6605 with SMTP id
 g19-20020a2e9cd3000000b002e0298d6605mr606951ljj.4.1714648149273; Thu, 02 May
 2024 04:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502084609.28376-1-ryncsn@gmail.com> <20240502084609.28376-3-ryncsn@gmail.com>
In-Reply-To: <20240502084609.28376-3-ryncsn@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 2 May 2024 20:08:52 +0900
Message-ID: <CAKFNMom8pX4J3EzgOzpJuU1Q9r6eHLNY4Dn3TOnya4K_2XWK_w@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] nilfs2: drop usage of page_index
To: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:47=E2=80=AFPM Kairui Song wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> page_index is only for mixed usage of page cache and swap cache, for
> pure page cache usage, the caller can just use page->index instead.
>
> It can't be a swap cache page here (being part of buffer head),
> so just drop it. And while we are at it, optimize the code by retrieving
> the offset of the buffer head within the folio directly using bh_offset,
> and get rid of the loop and usage of page helpers.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: linux-nilfs@vger.kernel.org
> ---
>  fs/nilfs2/bmap.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
> index 383f0afa2cea..cd14ea25968c 100644
> --- a/fs/nilfs2/bmap.c
> +++ b/fs/nilfs2/bmap.c
> @@ -450,15 +450,9 @@ int nilfs_bmap_test_and_clear_dirty(struct nilfs_bma=
p *bmap)
>  __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
>                               const struct buffer_head *bh)
>  {
> -       struct buffer_head *pbh;
> -       __u64 key;
> +       loff_t pos =3D folio_pos(bh->b_folio) + bh_offset(bh);
>
> -       key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> -                                        bmap->b_inode->i_blkbits);
> -       for (pbh =3D page_buffers(bh->b_page); pbh !=3D bh; pbh =3D pbh->=
b_this_page)
> -               key++;
> -
> -       return key;
> +       return pos >> bmap->b_inode->i_blkbits;
>  }
>
>  __u64 nilfs_bmap_find_target_seq(const struct nilfs_bmap *bmap, __u64 ke=
y)
> --
> 2.44.0

Looks good.  Feel free to add:

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Just to be sure, I also tested this change in different environments,
including 4k (page size) and smaller block sizes.  And of course it's
working as expected and so far hasn't broken anything.

Thanks,
Ryusuke Konishi

