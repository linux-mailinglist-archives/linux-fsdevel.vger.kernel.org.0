Return-Path: <linux-fsdevel+bounces-56003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA5B116A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581173B3C63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD229235C1E;
	Fri, 25 Jul 2025 02:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZqaEqGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D72746C;
	Fri, 25 Jul 2025 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411655; cv=none; b=j1Eftb8HqZPVtK+45HgqyMtQid7N2P8IhJNpY+4vWuuVi+XUhVo4AOvdj1LrYiaeU56pRcotpzQ+hBWgHSvro3rrB2aiSFZFLTCdy8zj4wWBaePfD6vcBBJP8lNhS4sKOuU54vOtEiNG72G/buv6z/ObsgopAv4ot4h16emNe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411655; c=relaxed/simple;
	bh=rdizep0zrpfkZKg0NfdnQ/QLu8dJHEerhVlSIUnwf+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZr4JFmVPGz2gKQwIQfKaOBO9F0aWZ7nX6JIYd1wNw/PvwclQXwN84xvtRAl7K/RKXi+5mGOt4rw8OqjGQGTaSIPJvI3TE+hQ0N4IeUEjFReZJ64u/ZNgIMnLn8pF43GVbYj02Eu1YanWp1gD/z/MvXtzfrDGK5IA0Ypnv3IgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZqaEqGK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so3077972a12.2;
        Thu, 24 Jul 2025 19:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753411651; x=1754016451; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc3hDEGPGsCDebYX51sWpA/bxBMOB24GoB4P11DkIaw=;
        b=GZqaEqGKXOe0ugKfmT52xARzEJCD6mvCoVWkzYveGD3Lu9L/0Rtv9efAo9qZlzKf0r
         JOvWd+xz4cwgmqc1PDohvBGCWGjlutI1TGEuR9T0oeObVpmnQw965M1ALTqPrlDrtWoN
         ciPpAuUNct7AB8c3e4AzTED8/OxotV7FSr9Ci4sunkFMVZhgy7CrWW/3rdHJ9yD+tcTE
         /rMIxONhg/Uo7/uAaeiSl72eO7xw2XVVTakQAaHJjEy0E/sMw4ohKjJWMay4X2KrZSKw
         LM2dk95m7ScXKDgVs4PVOuYuMLnmo4T9RayrCjRI6yocH2KO3GSYUfhaGir3XUF1H4Ov
         O/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753411651; x=1754016451;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xc3hDEGPGsCDebYX51sWpA/bxBMOB24GoB4P11DkIaw=;
        b=b8XOnmmGzl9K9uGFJOrel3LgdBOWCS7inQTaJG0M4BCCE9uCO/TFoa+oFkTYJCWP4l
         /OZUjsUyZsc6mqS0VCirDiraht/4v7/9LKBZgoc+/1PlXMimgSLcl9PqpjahulqeJ1ze
         UW+x5kQjE0bUDjnmS4N8IvM/0GBlSye67lez4Qjf3nQvrGTk/rtEiZMbbJwN8DZDtXq7
         P19N38JyDPAOcPK+DvXiFqFVw5CYy4xJDOl0wKHANm8WgRVHd9EKl8+glg7mfEUMxKrV
         f++JXIoIr/p+4ZNdztC1bORxkr/So6epvtVzXcIXdzkSSVW8AniEnHwJU6Mm/oLIEmp7
         e6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY7hzs0dKuorxCCMTw9l/pGDi8o3fpCXTFii6Ya0HomLtWF6iaHzrZ9d0WrR+28UF4ljvs2fl3i6CMzxYx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PFfvccqgLPwVLvRmhenUdvUdM6xHjwogsjoXaP8Ze3u60+h1
	OUBhKpThDP59h1FYoVXrGgG6PEx+SUY/I9oIzjOM3FKmvXu2m/eCOpqG
X-Gm-Gg: ASbGncvPvMgpUeE7nIu9kRm84Sg+KVHOAWSqU8nFVkSUrBvSLKMCKH69125Y7EHSsU9
	Ih3DRkkG6VbC3ib+NIUooSyfvzgoy8c0eiQSkNddH5gHP8ysNiNPBnOOCnh4MOGdwF4e9BdrBBU
	p9OEknjIUGOTQloSCLjddP0e3zd1VRRAuh6PhK2m0zpg3rMtu7noJcl8+cptD/qBiZGaW+sFcKu
	3pm10sl6imcmOplPTa4zbISG6nnk+TZeRRSR1bck1USexUajXvRVqs9tCPOKJnvuJTl4t4cQkws
	i0S27Q/pCHFw/kfkdn1o8FzFj2aHSETCmjld4iactyFgFXabsQu1gtSpFDN+xKcjDj31HOcYQdW
	k1SuUg22hadp5Pwalmw6U8w==
X-Google-Smtp-Source: AGHT+IHalRLNdYC73lbRRqlIizE8OiCJMhgGy8d4kUNVhjNjBAndWdZO49wygHZRXIZ+3UwJxXytHQ==
X-Received: by 2002:a17:906:f596:b0:ae0:d4f2:dff3 with SMTP id a640c23a62f3a-af619b04c91mr39263566b.58.1753411650558;
        Thu, 24 Jul 2025 19:47:30 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47ff42ce6sm195436866b.129.2025.07.24.19.47.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jul 2025 19:47:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 02:47:29 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 1/9] mm/huge_memory: move more common code into
 insert_pmd()
Message-ID: <20250725024729.emodbzsflthdzyzh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 01:52:04PM +0200, David Hildenbrand wrote:
>Let's clean it all further up.
>
>No functional change intended.
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Reviewed-by: Alistair Popple <apopple@nvidia.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

