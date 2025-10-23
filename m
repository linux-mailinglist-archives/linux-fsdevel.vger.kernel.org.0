Return-Path: <linux-fsdevel+bounces-65338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E929C023DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 17:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039A03ACB74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3494D8CE;
	Thu, 23 Oct 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="JrIYCLdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FC1FC7C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234547; cv=none; b=l/zVaz8bjWLRIlCXvOLrRlWmImyVypcraCEAadEGukEx81UlRTLwRHdFPmns4ldXX2z9m0q/KKDxQgvshWNIFtK33lBn7R5e4HebohQwyhxle9LNsNtpY4ZqIyAjax/wdi3zrnkmK28rKv9og8P/O6yRErPe6aYwqoWV1tAo4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234547; c=relaxed/simple;
	bh=TR0vyrIj5zOAmrWtxwLaf9B/tGNGrD4OYYiP6WG1Udc=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=cI+3L6GMb4QkCiq6mB4yM1EFKlaKIBAQdrHGggwkK8f3eo+NRe+5NFUu6PnHTnYDGWe2Y1Q1pAJPLZr36+43wIwXsSADo2jVUzzlN/wLoKbAcz2Alg/+jcocOlcw+W3jlRMONUGxxCN0FUeIJXqBVjqUjPPnXqusHAuqxsm6PGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=JrIYCLdr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so1139398a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1761234544; x=1761839344; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6l6v5GKhdHV57QLrRcfX0OseV//0wL094GM3Lc9kONI=;
        b=JrIYCLdrrQi3ahtK48HYqNZOktXIXOwDg/XD/YrSkNwKbbWxVpEAjHDZ7apWAM2rUA
         wzr2+FQu9q1EL5TUQOy5qRUJngDnp878XToShB7p6graYiBlQ0P7ilSVPr8YanLcCfA2
         7Vq+TJio+1qbqkTcZPeJOIXUwzrmtq4e/JORW1qCz2dmZ+1iA/OeVauUWB7C8/d9Zq+f
         LpDJfD/5MfrtzKpmE1BNOqeDDobImMYKcq/eLrJQhV0H1j7nInY0nwHOmhIarCAUX7nm
         l7s8T7gIGUfekTrWwShX7Y7RiJM6m7UH2686hmUxKBz6L1J9LsYBVVaK8ZQgAQdNynZr
         BAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234544; x=1761839344;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6l6v5GKhdHV57QLrRcfX0OseV//0wL094GM3Lc9kONI=;
        b=I+ko+r81mlr23sBaaWIAzvQzP2shuQlvSGrclluqofZlZuiVty8OQGeGb31uwJ6H9P
         YSx+5D19tAnguVLhvoXbtOex9u18MBo7WJZSjdoLVxKtORVuUyhC5v9sEGJGvj61zbdK
         sXHzij5MffwJZO370LJbE2gMzMgFoMC8e56Y6OUFfZvM6goIYxEcSOb1aFSUeslsnRdm
         GEQ75Y+9w+mD4mhqBVWdzSkAG3cIUljJLi7O3FkOx6/jsMdxhBC3qFxamNCS4WUqL4Wn
         AJXAnwTVz6JzC1ytWaWTm4KuZEMxo0rHP09Jqp5O9FmC0KVTawW/dbNM5di63JDYfap/
         gpDA==
X-Forwarded-Encrypted: i=1; AJvYcCWNSXMoX9+lJCn+Hw5IOieknSWcmWrd5X4Ml4iO+kiBx7KfD9ZAijhcC/AKLrmHvSC0xFdbXRiI+C9tfhiP@vger.kernel.org
X-Gm-Message-State: AOJu0YxN30z8bsAi/QtvPRtttE1O1G+dnu57C7mQYKYuA2S4/6JyJbZN
	KDkIVPvTqtJAbpPtZArpKP7c4hJl4+tsyfHiJa4pr5D3Zfeem+gloM6NyKqjz2XGKUY=
X-Gm-Gg: ASbGncs8W5dE+Rs/gk3IOMuuiXJa56cO6niE91J28rzW4U/3hbFgHRkelHJurYLPUJS
	wk8MbCRz9ZwfdtoJL99CVuV10+Ycz5MagDGXxauOIhrICgzOghSL2Dl8sU8GEXGA/aFa7YZwJBi
	1rLDcbkhSaj12L9p+sEku8v699AqOK9D+1ahMP4qs8YrhX+f5MG+/Jz/mQVDuxPqgrfNHwwOjnd
	tA8KXKPFg7dgIjxgT8yh07OFZWF3LSBQ2IkgiiVSpiKyG917llfLHCd9Bu/GHua1YJ9L80EfvOR
	A+AUon2KVfTkd/9l5q2F0zsf67S33cRptHtMOmOr8EH6pk5GKGBiMh5+jg5SIgbAdD7X9HMwnqk
	y045UtN0y1hXeg0vzob+PQO8v3Ga5PU4oRxstpiZVf30o1+076I92T6JtIYSqd7uzG5YP2KANKm
	wXEqGj5prXdoUZrIyNAYe6S53sbNt19lv7ncqwm6/DqhwX1M9L
X-Google-Smtp-Source: AGHT+IH3PwWqpiI3zcpwER2AyB/rp+AS9Y6D6TVLAKwCB2BvEfgzPHpJN6qvv4GuH89JR9PFSabRKQ==
X-Received: by 2002:a17:90b:5291:b0:32e:859:c79 with SMTP id 98e67ed59e1d1-33bcec1ab25mr31330207a91.0.1761234544113;
        Thu, 23 Oct 2025 08:49:04 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c13d58sm2446777a12.15.2025.10.23.08.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:49:03 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <AF891D9F-C006-411C-BC4C-3787622AB189@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Date: Thu, 23 Oct 2025 09:48:58 -0600
In-Reply-To: <aPoTw1qaEhU5CYmI@dread.disaster.area>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
 <d7s4dpxtfwf2kdp4zd7szy22lxrhdjilxrsrtpm7ckzsnosdmo@bq43jwx7omq3>
 <aPoTw1qaEhU5CYmI@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


> On Oct 23, 2025, at 5:38 AM, Dave Chinner <david@fromorbit.com> wrote:
> 
> On Tue, Oct 21, 2025 at 07:16:26AM +0100, Kiryl Shutsemau wrote:
>> On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
>>> In critical paths like truncate, correctness and safety come first.
>>> Performance is only a secondary consideration.  The overlap of
>>> mmap() and truncate() is an area where we have had many, many bugs
>>> and, at minimum, the current POSIX behaviour largely shields us from
>>> serious stale data exposure events when those bugs (inevitably)
>>> occur.
>> 
>> How do you prevent writes via GUP racing with truncate()?
>> 
>> Something like this:
>> 
>> 	CPU0				CPU1
>> fd = open("file")
>> p = mmap(fd)
>> whatever_syscall(p)
>>  get_user_pages(p, &page)
>>  				truncate("file");
>>  <write to page>
>>  put_page(page);
> 
> Forget about truncate, go look at the comment above
> writable_file_mapping_allowed() about using GUP this way.
> 
> i.e. file-backed mmap/GUP is a known broken anti-pattern. We've
> spent the past 15+ years telling people that it is unfixably broken
> and they will crash their kernel or corrupt there data if they do
> this.
> 
> This is not supported functionality because real world production
> use ends up exposing problems with sync and background writeback
> races, truncate races, fallocate() races, writes into holes, writes
> into preallocated regions, writes over shared extents that require
> copy-on-write, etc, etc, ad nausiem.
> 
> If anyone is using filebacked mappings like this, then when it
> breaks they get to keep all the broken pieces to themselves.

Should ftruncate("file") return ETXTBUSY in this case, so that users
and applications know this doesn't work/isn't safe?  Unfortunately,
today's application developers barely even know how IO is done, so
there is little chance that they would understand subtleties like this.

Cheers, Andreas

>> The GUP can pin a page in the middle of a large folio well beyond the
>> truncation point. The folio will not be split on truncation due to the
>> elevated pin.
>> 
>> I don't think this issue can be fundamentally fixed as long as we allow
>> GUP for file-backed memory.
> 
> Yup, but that's the least of the problems with GUP on file-backed
> pages...
> 
>> If the filesystem side cannot handle a non-zeroed tail of a large folio,
>> this SIGBUS semantics only hides the issue instead of addressing it.
> 
> The objections raised have not related to whether a filesystem
> "cannot handle" this case or not. The concerns are about a change of
> behaviour in a well known, widely documented API, as well as the
> significant increase in surface area of potential data exposure it
> would enable should there be Yet Another Truncate Bug Again Once
> More.
> 
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
> 


Cheers, Andreas






--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmj6TmsACgkQcqXauRfM
H+CY1w/+JoC6DHdgP5p4CEVNhByOccTqDc9/xK5kbk0cN1d/jNA0jaz3s/jLATWn
DMDa3ZsuYDyYNk1KhlbLNZ/k1MJEh8mxq4pqUrmu4PpMFrO2037t0lkPdYxcakkW
+idSJxoIYQcCGS42vOUZ6gL40RIRLDdY/5zgCvysIF4aIbYyp/NJj58BBuzHahC4
MlejI5KKvqxYtvhCeCt0lGbSc4a/rmoI02hhKngMZ865oM2sEdSNQpjE6/J9COz7
XwbWqa9mth0aa5vuUt/RcL9jkFshItIUmhs4DxUtdHfXPSG4hDwM0jsJnNdRD/SM
RQY30IoDVBoefkwdhs+fvGbUivgw0LSgba56P+AjLChp6FAX1ASh3ML+4zxspqs4
fPxiX7BS7+ojkg0VtKEKJPk5Q6+4a1T3flIBq6tDE4UwISC63Vb4qA1CPCVbyVeU
zKAkfNMzSOlOMOYKAj51Nx9mj6NxZXLJvrS7jMCKiWh1m7B6a9GuDs7yQ5QQ+Q5v
PfheQd2jmcYXXRZpyzu3qhzJzPGpJ6seMJCZHwBQ3jg2zfiv+7gyGwedVKy/xb+j
Cd2xi0wN9hrGFKO2Ya2Zd7VIHkkWnjErwOm1x4QNsiqj9D6Hc9yJkHCG0dRb1Lwv
4064fTxGFyNuIujVcvPB6rXpKVJGhLEayMqrVtDjuzoJtA9vQJ4=
=kl6f
-----END PGP SIGNATURE-----

--Apple-Mail=_48E99939-A914-48C4-B30B-0EEA6EDDC0B0--

