Return-Path: <linux-fsdevel+bounces-54691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40680B02416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE8E16E81B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA501DE2A0;
	Fri, 11 Jul 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ky03GOuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1301D54E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259797; cv=none; b=NZsY+fl6chK+MCufWl3z+t8QZjobdDI0RnKBcrUNAQmX23M+8w/Q9jibi0SVko3kOMV3Agcc6S96UYE33QM2e1X4Da3zR3DDNl+OWhsvUskeCMvlrCRm8LrU30xoqBuC9yhDsXYJCG+XBkSYRoCQQhVbP1A9i6AHjicxnrQkQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259797; c=relaxed/simple;
	bh=nbSjpgGOdBK1AyMAVCG4xKmRigRZohta54oD8PEn5yU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pKDxLzQFBsZ0H/LttBLxDlU5jXEKqyEJWFfQs7yqx4vVmNpw6Xm9bIpYP5IVevMEkilOeqaFYqW9NK5+A/EIGCMec1v1BuGwgJl+X406dJ9r+CJD2dUyAjMLT/hrwML2uf5I4rT9QhjEhZ5jKR18nQ5kV6REeHtaf6FGN6hmAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ky03GOuF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so2010587276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752259794; x=1752864594; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uep3oUhxpHoW2J+JxDGwSw4zGQmgpsL58UQXesiGys=;
        b=Ky03GOuFxmK2vdfc9V+CakRIq6cIktXZhyDPUjR9z5rnI2eavL1EbybAmFkTwJL12m
         tHDnMtV0zctwxR/iEres20cZf3oPoevEQrFbFRDk8Fv/NRL04UeEPzGOc+U0SOgNrdDf
         s+FuMtUkQm9E1Xyuu1YZbHyomwUSybMRry6FhOr113HmjR3HFBe0N4pwdpZIT8xXwgpF
         dG5KM8ixNEQEvOliebdvQjzsL1xv9oWBQ5nK68YqWj34oXySgSRH39Fgk+3QlRvkf3T+
         9jQfpIMlcgDnKEFxysIA3isQyClmkM8LlZ/OSMtPtZYHmqWg08LE/Uyic2HNdAdQGc//
         pNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259794; x=1752864594;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uep3oUhxpHoW2J+JxDGwSw4zGQmgpsL58UQXesiGys=;
        b=vTfxSw5vQoohUVOzpm2teOtSYwDNHVjIVD89DFXNLcUsvZTbeJ4tlFI7Lu32xA5Zl5
         gLVLn4M6xhhQnOFUprxHiT4H30eehsqrNfZHjY6rtYZHn9YbEw58GZz0IpkbqFs+ciuH
         BE3BlHoL0tN1PyZKyovK6CQ6r96ijgWu+JR8PxxhgoM/YoWuCRH5GUU5iS7RQUW8YT0G
         sBCSXMiA/ACljXnHEzHtHYCvTccwwnVzukpqyQzCKxZEr4Qj9EPY9wg8DuwlZEJtuasZ
         tDZpOeZCRPDos9fT014/Eo3qfzficKfop/x/Pv+YOPp0vJYR/TrBf+Ap97o4EL6DGlO/
         9sog==
X-Forwarded-Encrypted: i=1; AJvYcCVRoTmELeMo+v2P8Ma8edtFzSvkXjd30SLfjSt15lIYPktc20KtcWze0XsMYaQol3ApYpec72pH2l9aY0SO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+tjPUTKLTsX/sviIL9QGCrvJBiDvlsj3n8AZV2AyJqV71Dmx
	QtVRrtEhVshfDPY/OTWyenFKf6q0B/7hZpnKjHJqDK79azEIdstrxe20yql0YShstQ==
X-Gm-Gg: ASbGncvGC2KlbynGXpVDrIYJEcQrFYFV8ktUzA5WL+ZIcNtHztGge9/iSCuBl8N2l0J
	XDgfzFndhSA1AzVpxQgywBtr0CI4rELk/71o666BxXTcuL742XYfWbw8XmkrSk3TbjT5glsDEtz
	fd4q7vM3w+axIh08qknKCrpbtztWJ2if8PAxaETIRLWZG17rV/YQIxaEqy3TkHAJMJabgsMphNY
	CTHNU6GITMpvNIw5ryOEd1ZMLK3krXlZVm4C/fHW1sGKK0DOvxGoyUOjA9BdImrc+Wq7cAN1D/H
	T0oMXvMFLZ25S0ky3Xr3XN6NTN9eFHdV9EN2hYatEglO5vR7YJD6z36/Mgfbm4tORn4xO8quEKT
	bUhl2Nej8tTjzL3YimYZxHZxQ/o+n1ktL6an7wmCQQfbysmSyULOArk/7xOX3dPynKtE9qzeWoM
	3HYGL72/c=
X-Google-Smtp-Source: AGHT+IGvwK4cqP6d4d0tDMpHq9UunLQhfUNAyIw9HuYDsHjNMvJlEOHyXdidbQDEQly7uE88Fgsoeg==
X-Received: by 2002:a05:6902:478b:b0:e82:24ae:c3ae with SMTP id 3f1490d57ef6-e8b85ae2af5mr5779939276.21.1752259794230;
        Fri, 11 Jul 2025 11:49:54 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7af9cd06sm1266310276.30.2025.07.11.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:49:53 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:49:37 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Lance Yang <lance.yang@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev, 
    Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Dan Williams <dan.j.williams@intel.com>, 
    Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
    Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
    Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
    Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity
 check in vm_normal_page()
In-Reply-To: <056787ba-eed1-4517-89cd-20c7cc9935dc@redhat.com>
Message-ID: <5e439af4-6281-43b2-cbd2-616f5d115fdf@google.com>
References: <20250617154345.2494405-1-david@redhat.com> <20250617154345.2494405-2-david@redhat.com> <aFVZCvOpIpBGAf9w@localhost.localdomain> <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com> <CABzRoyZtxBgJUZK4p0V1sPAqbNr=6S-aE1S68u8tKo=cZ2ELSw@mail.gmail.com>
 <5e5e8d79-61b1-465d-ab5a-4fa82d401215@redhat.com> <aa977869-f93f-4c2b-a189-f90e2d3bc7da@linux.dev> <b6d79033-b887-4ce7-b8f2-564cad7ec535@redhat.com> <b0984e6e-eabd-ed71-63c3-4c4d362553e8@google.com> <36dd6b12-f683-48a2-8b9c-c8cd0949dfdc@redhat.com>
 <0b1cb496-4e50-252e-5bcf-74a89a78a8c0@google.com> <056787ba-eed1-4517-89cd-20c7cc9935dc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Jul 2025, David Hildenbrand wrote:
> On 08.07.25 04:52, Hugh Dickins wrote:
> > 
> > Of course it's limited in what it can catch (and won't even get called
> > if the present bit was not set - a more complete patch might unify with
> > those various "Bad swap" messages). Of course. But it's still useful for
> > stopping pfn_to_page() veering off the end of the memmap[] (in some
> > configs).
> 
> Right, probably in the configs we both don't care that much about nowadays :)

I thought it was the other way round: it's useful for stopping
pfn_to_page() veering off the end of the memmap[] if it's a memory model
where pfn_to_page() is a simple linear conversion.

As with SPARSEMEM_VMEMMAP, which I thought was the favourite nowadays.

If you don't care about that one much (does hotplug prevent it?), then
you do care about the complex pfn_to_page()s, and we should have worried
more when "page++"s got unnecessarily converted to folio_page(folio, i)
a year or two back (I'm thinking of in mm/rmap.c, maybe elsewhere).

Hugh

