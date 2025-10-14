Return-Path: <linux-fsdevel+bounces-64126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F783BD951E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 390864E79F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B631354B;
	Tue, 14 Oct 2025 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jc8MMyJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E7313532
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444620; cv=none; b=iPqBN4744BFSb3OX2GJRKaUWFSHss37c00NHE+ou87HndpLfvmAh49vyldIz8vLbRS7wev8uAXIKgDVzWXXiXSEy9TJQLp53mFq2NMoNW+o0MbQLB42vyTov2XzobBoHGf7sldi865n/DFMdERKYuGSczLhbHqYM6AkdvHRlQxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444620; c=relaxed/simple;
	bh=trw3erKcBrmCOtT2DE5wAFGrqWHQObe9Vw1+YmbQxYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8kHkIFwABlj02vUiVPaCpkarbXUzOj9x8uxdzQ513+Wx5XdARbhNpLPM8dDzOm/KAnyVViz1uz6Rq/T6PV4vbG43vSdJI5buPZ6aBjFWZfUf2rkU1SCotlVoFzcG6ixgcmzsCp3t31HdnX7fJmTO04RgVqXr7n0BgibQbLwX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jc8MMyJ/; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b456d2dc440so862497166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760444617; x=1761049417; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=Jc8MMyJ/UeRfPsHTc2O/vVOKfChumvUkphUUc0Yt29Oc4uNhLrkKroREHOW007AgsF
         LQs8rB55fCRWUTPBk8goujK5NS4RW+tmYd8M9TjHH6J3iSPfVW3WFQuXGjSBfnYdxB97
         SrivieCmlJgJ9YPSDxhUxGqZn+YFRE809SXXk4Azw2i7L9FDnCnFtdOuMLnLMCX9uqV4
         oH/byr3DHo4EAjrCdVmzWFTvART0VChXazqVj3bjWtQzRb3V19NPhY42NcAmOU5MhtTb
         s/Ko0LDMTkhQWPW6lke8YNwYIRCHou14iZ7uq9BPw8OQ+Fc9eriOLY6D4gGnfDRePPSp
         HhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444617; x=1761049417;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G4zpYT42/pWjG2wOiPoPN8UFfIlZHUseBg40P2GM6ks=;
        b=hrD1dyBcT3PTxPgRCk8MXS0lVEJSBveKh/cCTEG6wafiMfLTKaCtUTNVLJvfwGzUfH
         n6zU1jgOlSfaafZPFFfFPMNSzDn3IEo6QioF0ELFHbMvURAFF/EV1uawmaG627lwvB+N
         7pXqyWgzpF8kD/Gkh9qlFHbqra4V1O3g6c8R+x+1rEFqYJdLH3OkRbnnYGb4xn798i1+
         EqogtaYATMAdfq+uvcS8LnT/A3uwY6iQ2Lj2iEAZGSXEX3RwCAfK+xbdmYUjR2scUNip
         ce4IQ80HryqGX/T/yn55qCh3JEn5cVdr5YH4p4H/tuUzxqSEJkNP6txNfUUBEkmAgzrr
         UCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyHcldrWldcNjNdGmR6sQNSJO6Ca844JZGqcR4CXPUY7Gr2lEUTzG99ePyuKvmdj4YMOsmXbySsJ78rPSM@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPF6fatC3TmXStYWnUOh/HAgb4VPFoAWWKCNtH8m4JZ1IW4ra
	J0i+CSt4ZEu+JnbaktMyxAIGUhp51kmkGXMehC6r6jc8F8NsK830RaYu
X-Gm-Gg: ASbGncvSl+rFyZFiZBb8IN05SJ4s8aEx0k6zT8CeACch1FA0UMHyaKmUnrfXfUCdu8d
	8yYiKkRFpGqtjuPj5RXnkACzhxqr4jgepkBrp3deliIxQXggUY0SUwoCfYUdeTEJonrT8IhEzfT
	CdRLPbww4jvlSNVF1qoiewaFAWet+kkGdJmgptRLwRgc8XPNN3LInfPJdIjZ4L+UAsTWlKtf+BJ
	erYYYw/JCO1od4fER1L8uAVwpEZgP9y0h4JkB7PEHpQtEMCH/z8YJALdObn0SrDSaAndWmC+pym
	ohVOK3p/zXRmM+sTkc+RmHlT+F6JNET9CAyQBBADs0+gnsrAMhtactlh3u7QeS1n9TpU+Az6Fcq
	jsR+lFBoURuyLC1rbSiMJ5ySe2qjdFiaybrV5fr/kQ3Pvkk/bmSQ=
X-Google-Smtp-Source: AGHT+IHDOAfe4JNqhFSA9gUX7LcGwhfmUpTtqm0hZRNoZ9LOkkInOSpqZhVqzK5eUfW8u4Wf52cxuA==
X-Received: by 2002:a17:906:730a:b0:b0b:20e5:89f6 with SMTP id a640c23a62f3a-b50ac5d07b5mr2495753366b.60.1760444616765;
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b715ffsm11262090a12.22.2025.10.14.05.23.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Oct 2025 05:23:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:23:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of
 large folios (CONFIG_NO_PAGE_MAPCOUNT)
Message-ID: <20251014122335.dpyk5advbkioojnm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303163014.1128035-21-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303163014.1128035-21-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Mar 03, 2025 at 05:30:13PM +0100, David Hildenbrand wrote:
[...]
>@@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
> 		break;
> 	case RMAP_LEVEL_PMD:
> 	case RMAP_LEVEL_PUD:
>+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
>+			last = atomic_add_negative(-1, &folio->_entire_mapcount);
>+			if (level == RMAP_LEVEL_PMD && last)
>+				nr_pmdmapped = folio_large_nr_pages(folio);
>+			nr = folio_dec_return_large_mapcount(folio, vma);
>+			if (!nr) {
>+				/* Now completely unmapped. */
>+				nr = folio_large_nr_pages(folio);
>+			} else {
>+				partially_mapped = last &&
>+						   nr < folio_large_nr_pages(folio);

Hi, David

Do you think this is better to be?

	partially_mapped = last && nr < nr_pmdmapped;

As commit 349994cf61e6 mentioned, we don't support partially mapped PUD-sized
folio yet.

Not sure what I missed here.

>+				nr = 0;
>+			}
>+			break;
>+		}
>+
> 		folio_dec_large_mapcount(folio, vma);
> 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
> 		if (last) {
>-- 
>2.48.1
>

-- 
Wei Yang
Help you, Help me

