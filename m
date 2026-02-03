Return-Path: <linux-fsdevel+bounces-76215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QA2bOvc6gmmVQgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:14:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E8DD65E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BD33061981
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E9B35CBB3;
	Tue,  3 Feb 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Rk+l257Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FD2798ED
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142406; cv=none; b=tZ5GW/gXgedb5rlSDsyYHbxWIlqlOTVLEX8VKv3Hirm8+HO3ycRKCEAbzAsLtw5guJAk6eVOUbrXZcSDB9Uzoa2ftPUr2zeU4+jHGTFDk3/O/x6YVtmWyu+E3Fenkl3R5pCxKHI0BlM3hPJTp62UUPELO39e7J0PXxBsXBebP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142406; c=relaxed/simple;
	bh=RgOdFHuomUx5cdPp0JGsemA2d5RVP7tNLyg3IMDaEeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJrMFKKTS+z6bqIe2mKiIxvLN7AujuTtmQqigEDqf7PZ0dpkLjxapB30OjgvU65PqPrD3V2zztbOT8aJ21zMUfdFGgXiqyVFlwNh44Irw3Chj3x27YrlIujaZMMwCK+gnGbF7UDXC7AhXKLXd9bUP0ccX+qr+31trgrzozKlRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Rk+l257Y; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a26e8711so35222861cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Feb 2026 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770142403; x=1770747203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rLJUepMBePw2/6rYXVBVUlKVexPKPCi+MRpKxp95Xc=;
        b=Rk+l257YovzbL95b0JDd+4LMj5HOYKihyDBLvwfNoTQwh7NAISq7jhwnDhFLvGWlvi
         CpyMq4yMF+anTL/9SOnSdXRBNA0n/f4hZNcxZ5Ir9a6+99u5sOCxOswCkt6euq35RpL/
         wHZ067Xx2mzc4NML95y/mntvRxePEQg/1fDTyZADzxNUOm3d+QfvM0XgVUUOb7PrLQFM
         8IAln35SLF4Ap24/1RMI8joFPnxoH3YtApA31JVZmMZ4hxaTigXPbrc+nopp04QQJHlZ
         30H8pSaU2pZP8BXue4jWMlYsk4nepcXFViPK92zSj40H6RkBNcNnF3MxdovxMVc/KxSh
         BE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142403; x=1770747203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rLJUepMBePw2/6rYXVBVUlKVexPKPCi+MRpKxp95Xc=;
        b=oZCts1gC4KDFKloZ4JTroz6j/Rzx59jWOcGnpyMUG1fMvjojuZDQBQQPRNb2os9+11
         5uJKKZphYUyhKFBI2xv2wm9nAvm0znZGo29oYyCcH5OPM/mrgyvvbBvnLgOT/n7/3Fw7
         FJiPe/TaRSHp+yoNplDMJX4iEtzJTJyNqzm3eCXopDkhpL7f7gkGM7FKQ8I4FoQwOm9t
         pRpxefrc+pMEF5UwuyaFhw7TLKrWbTeWBv7Bttl+b8KKOsqLFTdrXLj19thtvJo4p4vm
         b2QaC3yneIAqV8/Oyko7UKPhXZJE5AfRsJmQsVItsahD5ZR4JpzjUMmUsU0iwAo3mpTb
         QOAw==
X-Forwarded-Encrypted: i=1; AJvYcCX8v9WelFtzNjcwYpcLD8ahbzDqR6cPkF93MRzJwe4JLnaDqy6iMAj5JiSEEX6B6jy8+VtvuAOx/DjcThVe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6iGUtYlZqhERWli85eQ/snJduulbTAFYBN0GWP2pLmG/2kbZL
	W6lS3KCf1MdAAROOn8qFilVWbdPuzcGmj8IgIv4b7Nlf1HbdzQmho/0oO9fMIVMF9ko=
X-Gm-Gg: AZuq6aJKlAVEZ8U3l9V+23G5/kk0CkeQNJ6OWLt1MwdOyZzDsmvVVwS0pG26CBh6EuS
	jRJflj1sKSmX26jCgUzMHN9zu2dl8K9u/d60Og37bgDkMMUfgn+0iPNP91cI/6MDNrlQxrRWznx
	ENFziGEXaVYXEfDMlYz5ABzhi/6vjY+uqZYqIEDnD5hbfvkJ+7Q8gytIm+Vh59S68dZMLv9lLPP
	+pQsYa/rYL3l7sn2ENbgCa35sXBXWag9ilfMy/sa9SzuVDOTWlx85y3XEBRl7MQIdyrZo51cPQH
	/Q+hWHDQNgmJbHMupVpRLTsFjoV88EYE7YnG+1pa8ZfFOYHlXgCyJdVI6xcFoxl0Qpvwh5w+CV/
	Kdjv3LVb7Kq3OTvVzY60vkiYunxz+cM9++JeU2ffGwF4Yx5LhhLMVLUMYjJnx2Iol0dMdoi4K26
	0T+TtxxSHmkdk/m1trpdFecBmjPWGGO2PaA+Jv8J5erIsSS8fUPmMvR4YYmBaZaWgAfdg=
X-Received: by 2002:ac8:1402:0:b0:4ee:42e6:a5 with SMTP id d75a77b69052e-5061c1ae28dmr1930741cf.57.1770142403217;
        Tue, 03 Feb 2026 10:13:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa55983sm22226185a.10.2026.02.03.10.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:13:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnKtt-0000000Gaft-0KdL;
	Tue, 03 Feb 2026 14:13:21 -0400
Date: Tue, 3 Feb 2026 14:13:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com,
	hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com,
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com,
	jack@suse.cz, james.morse@arm.com, jarkko@kernel.org,
	jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
	keirf@google.com, kent.overstreet@linux.dev,
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com,
	mail@maciej.szmigiero.name, maobibo@loongson.cn,
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org,
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com,
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au,
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz,
	qperret@google.com, richard.weiyang@gmail.com,
	rick.p.edgecombe@intel.com, rientjes@google.com,
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
	wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
	yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
Message-ID: <20260203181321.GX2328995@ziepe.ca>
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca>
 <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
 <586121cf-eb31-468c-9300-e670671653e1@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <586121cf-eb31-468c-9300-e670671653e1@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76215-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 561E8DD65E
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 12:07:46PM +1100, Alexey Kardashevskiy wrote:
> On 29/1/26 12:16, Jason Gunthorpe wrote:
> > On Wed, Jan 28, 2026 at 05:03:27PM -0800, Sean Christopherson wrote:
> > 
> > > For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
> > > is all or nothing, and can never change, then the only entity that can track that
> > > info is the owner of the dmabuf.  And even if the private vs. shared attributes
> > > are constant, tracking it external to KVM makes sense, because then the provider
> > > can simply hardcode %true/%false.
> > 
> > Oh my I had not given that bit any thought. My remarks were just about
> > normal non-CC systems.
> > 
> > So MMIO starts out shared, and then converts to private when the guest
> > triggers it. It is not all or nothing, there are permanent shared
> > holes in the MMIO ranges too.
> > 
> > Beyond that I don't know what people are thinking.
> > 
> > Clearly VFIO has to revoke and disable the DMABUF once any of it
> > becomes private.
> 
> huh? Private MMIO still has to be mapped in the NPT (well, on
> AMD). It is the userspace mapping which we do not want^wneed and we
> do not by using dmabuf.

Well, we don't know what the DMABUF got imported into, so the non-KVM
importers using the shared mapping certainly have to drop it.

How exactly to make that happen is going to be interesting..

Jason

