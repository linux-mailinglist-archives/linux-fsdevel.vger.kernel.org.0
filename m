Return-Path: <linux-fsdevel+bounces-66421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8777C1E7C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A613D404FC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BB314B90;
	Thu, 30 Oct 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSX/v238"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E56A17736
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761803990; cv=none; b=cZAfeNZhnM+ubbzA+HWbCFzfRrRKOQzHtHya239jha/JoVNV7A+v3+dvQFMLTskXeRGvXFzSW+rkQWRWqYOntCH/Z0JchzZEMU/5e5eoDYnA7MVJBkxRDMdEx76BnKEBpdzqBE1h4svVAk7BKZ6alEakl0dkBZLa9yoQqaL4O2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761803990; c=relaxed/simple;
	bh=Fo8cm+XrUSwYf3Uitve4r+vVNnLUs+e4tzLAtKY9pvA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ivprcYIFZz5Xyx3U04JBJjjSLqJsey9hf6ORMVcgw0XV+UQekB96BzbFAgD3RPWzjoGxREVx7II1pB9Fwkg+PIKhyzty1U3qkMJpwJSTl8ug/JdruEsyKsRt9zmAHcPAdZh2BQtPKIiaKBCifOaB3yhiGtW9CzOIcF9rj4KWMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSX/v238; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e3804362cso760811d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 22:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761803986; x=1762408786; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChsXC22GEEipb+m9hP846LdbfZpqHSDexm/9GSfJLYw=;
        b=jSX/v238TUmfKL7Mrx3azwMuuLzQpnqNyO0PJ6b3JeXZWX/0gv9dIyti/vegXRmrbB
         OFGhQ6hDYRr9TbYBzZX1qXt7gmVxp0Q8WJ+Dc1CKqulumUBL8sRtZJBoEBGRFB3IsUj1
         jxhkOe3qt6wkyE1n2mV57Octa0T30KfQU+enNlcsm7kEgZ/eZCfO3PyaxpLTtTfvAFw3
         m0+Hm4Jp1gZwyeP+ose2rd+1doIfa/PMhrLAVcrtVwxZu7+2wkaeXZW8EyYJoiomEiAa
         6J2W+d9mQDE2dnxwOtPT/igtvap5nyrQw8LyQ6H7H90FbkhM+SF/iy8kzKamxVkjkaja
         c/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761803986; x=1762408786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChsXC22GEEipb+m9hP846LdbfZpqHSDexm/9GSfJLYw=;
        b=WXH2cr8lcbfSiF4sTKUdVWC9kfRrzqHJJm/IhIbtAfr1vBSMRtzQVitEAVXpSnKDXn
         7SiTftrjUgC8eK0V7qCFZcEc6w0UCDs/WhDFj0PKSJy9UWuuWqTLPXUBO6Uqc6bOOpK8
         XWxcSo4JDyYTqcJhAOCtmP+JlsPD9atRCe6RS/9UPwnqBbeglkBu6F9GRbslhdTAYtPb
         BE+fK1wjkWwLKHwYMqHG0/EYaqDO4F3ezGcxWDBUkfGlTU8H9+3BzyBEZ+/mwlZvftjS
         yzxyfySOmVqbFfvbRYd9ROwcydgSGt14SUx58tgDDa/nQqdLiEviXvqwy/KqF3rjScif
         QoOg==
X-Forwarded-Encrypted: i=1; AJvYcCX3e8s6UpRVkKsKK8Uj8pZWPKBX0ecZgFR9maeyTXMO5TkhfnDrsGthXNP9TbrrlwA9h8yLbMwsCP9W/mn4@vger.kernel.org
X-Gm-Message-State: AOJu0Ywde6U6WygHtdQ9Qg22bW5LnFojQArDSF8y0f6HYvWIkyXRNxrb
	AsK44fz/6IUUHwzXyOeMmLh2ET1Do5NFcd0Ee+q1/w2lOZeK/QXocufgAQma5mrw2Q==
X-Gm-Gg: ASbGncsjxGPtSVcDbopwRJTUJMKVKmw+AmqSIuiAbzyL79R/mSelCi6ObdK52emQUNp
	xX47SBd/6wS8X2T+DONeP0hcRhRXoen193u3Ot9mU3b/fL9Jb9gCSQRrP6gyOgUMhhzqcLEz6r0
	WfwSFP36ccsvn7+spAa8rJ33jdJ2NPVWXRuT8493q/ndR9zTZ8CtjtARVGxV0tqMoJYZpkrCUY8
	7BGyrLB4eVP6ztrIiZgEq1hrY+CEcOD2LiiwS9p4OZnXTnp+tC3zASnqtTNGNOBlLKPjHbfejAV
	ojnmY8w9oHfho3UcysivD99BIzue4BznXIipGeWs3SwAiXWHu6UPzXgpYyHngjwqzHYUGVf6nLW
	l7lpwvZaM58Rdx21/jkgFwDiHpqa6IVpkrmty6L9S6bI1sIZxJOjTN4U2tfhaa1J19C3ANVbkHV
	ywMKBDDTgbf4V954UGEyGn9dc6a3UCjTO01/+VmpKPuQ5CFaZHdG6hupY7e4uM
X-Google-Smtp-Source: AGHT+IHtaoa/Pxq5oxH85sshVOTI9spxw9LUpe10KGGpGL4M8OEIeW0CHTrJ2BtAjboq/8BNzA5j1Q==
X-Received: by 2002:a05:690c:3512:b0:784:94d5:847b with SMTP id 00721157ae682-78638e2fa9dmr35267717b3.20.1761803986131;
        Wed, 29 Oct 2025 22:59:46 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c4423d1sm4861208d50.17.2025.10.29.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 22:59:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 22:59:24 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
In-Reply-To: <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
Message-ID: <24aa941e-64b2-14cd-6209-536c1304cf9d@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-2-kirill@shutemov.name> <96102837-402d-c671-1b29-527f2b5361bf@google.com> <8fc01e1d-11b4-4f92-be43-ea21a06fcef1@redhat.com> <9646894c-01ef-90b9-0c55-4bdfe3aabffd@google.com>
 <xtsartutnbe7uiyloqrus3b6ja7ik2xbop7sulrnbdyzxweyaj@4ow5jd2eq6z2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, Kiryl Shutsemau wrote:
> On Wed, Oct 29, 2025 at 01:31:45AM -0700, Hugh Dickins wrote:
> > On Mon, 27 Oct 2025, David Hildenbrand wrote:
> > ...
> > > 
> > > Just so we are on the same page: this is not about which folio sizes we
> > > allocate (like what Baolin fixed) but what/how much to map.
> > > 
> > > I guess this patch here would imply the following changes
> > > 
> > > 1) A file with a size that is not PMD aligned will have the last (unaligned
> > > part) not mapped by PMDs.
> > > 
> > > 2) Once growing a file, the previously-last-part would not be mapped by PMDs.
> > 
> > Yes, the v2 patch was so, and the v3 patch fixes it.
> > 
> > khugepaged might have fixed it up later on, I suppose.
> > 
> > Hmm, does hpage_collapse_scan_file() or collapse_pte_mapped_thp()
> > want a modification, to prevent reinserting a PMD after a failed
> > non-shmem truncation folio_split?  And collapse_file() after a
> > successful non-shmem truncation folio_split?
> 
> I operated from an assumption that file collapse is still lazy as I
> wrote it back it the days and doesn't install PMDs. It *seems* to be
> true for khugepaged, but not MADV_COLLAPSE.
> 
> Hm...
> 
> > Conversely, shouldn't MADV_COLLAPSE be happy to give you a PMD
> > if the map size permits, even when spanning EOF?
> 
> Filesystem folks say allowing the folio to be mapped beyond
> round_up(i_size, PAGE_SIZE) is a correctness issue, not only POSIX
> violation.
> 
> I consider dropping 'install_pmd' from collapse_pte_mapped_thp() so the
> fault path is source of truth of whether PMD can be installed or not.

(Didn't you yourself just recently enhance that?)

> 
> Objections?

Yes, I would probably object (or perhaps want to allow until EOF);
but now it looks to me like we can agree no change is needed there.

I was mistaken in raising those khugepaged/MADV_COLLAPSE doubts,
because file_thp_enabled(vma) is checked in the !shmem !anonymous
!dax case, and file_thp_enabled(vma) still limits to
CONFIG_READ_ONLY_THP_FOR_FS=y, refusing to allow collapse if anyone
has the file open for writing (and you cannot truncate or hole-punch
without write permission); and pagecache is invalidated afterwards
if there are any THPs when reopened for writing (presumably for
page_mkwrite()-ish consistency reasons, which you interestingly
pointed to in another mail where I had worried about ENOSPC after
split failure).

But shmem is simple, does not use page_mkwrite(), and is fine to
continue with install_pmd here, just as it's fine to continue
with huge page spanning EOF as you're now allowing in v3.

But please double check my conclusion there, it's so easy to
get lost in the maze of hugepage permissions and prohibitions.

Hugh

