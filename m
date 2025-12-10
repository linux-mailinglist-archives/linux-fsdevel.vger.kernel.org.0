Return-Path: <linux-fsdevel+bounces-71076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C46CB3F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1072E308B3FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 20:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFCA32BF41;
	Wed, 10 Dec 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9OJp2Ej";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkPgBCEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C0306B21
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765398255; cv=none; b=ot0bWdkfNYhFtYSN0zu4hbSKEbB1WEXt2HH1iRDUsbZvRaMpzBdv5QG7tpwPb4JYZ87GnocdZzXPn0RQ9qSIp59Hv/iFAJVX1GragwaNtPST1MyINQxc1f+HaMPNrKFCjuT3HhhfkkJky3SpkUgWY7SX/sl1bLfFZtq5t8r16Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765398255; c=relaxed/simple;
	bh=qZSauzG0BQxKFnQ99YFS7kpsbt8dX9n5BdSFJ8Uce0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az5DDSCzblnZg/Dse+R0C2B10xQN57NhzZopAl0iLiqWF7tGA6y/XRWjCBNOamfAN42FsxxRtxpTLFh3STD8dOeTGz6dZZZ/2zcXnckc7mj106yPTQRPPqBoEWEveA5LjDWeSvnNnn//LM5uU0FocI6gYajroHkFmmEooru3n4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9OJp2Ej; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkPgBCEj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765398253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxnQ/iEQ1sK58mDVjsOZpAu/QgTIX6mC6WKI+mp0l1A=;
	b=N9OJp2EjGOQNopngZILTcDRiGs7Dd5AXHq7dC8TtbGW6/Nze6RTuAgpYSbKYy3mpiCkEtJ
	6AFGhhFhXCIHtM/Q4AWoh4P5UU5SmBG0e5ZI3ZWGsPaZ+jjIb/MXFCi5Tzr3hRUXxNnDA4
	hMU1dAx0w0oEBGJ5AU8BVstQv6RyZtY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-wJu2l5p2OPOy6lBCAdEcgw-1; Wed, 10 Dec 2025 15:24:12 -0500
X-MC-Unique: wJu2l5p2OPOy6lBCAdEcgw-1
X-Mimecast-MFC-AGG-ID: wJu2l5p2OPOy6lBCAdEcgw_1765398251
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8823f71756dso3202596d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765398251; x=1766003051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxnQ/iEQ1sK58mDVjsOZpAu/QgTIX6mC6WKI+mp0l1A=;
        b=MkPgBCEj5eEmztZqMJg9JwFCdl6+HVX4R9hJfsIyu0LE6mkKUxINQwAu1d/X1/PokH
         D+YqcVYeQjdFCCW5+VeRnLfvvmBjnPa2eSn3iqdWpryiXVxPDyvnFwS3X5jQsvqMpO8E
         H0VAO1Y7hp/tWTXX0hPaX8XBM49AKJC+2/6GbZQQvDvPBYviyKYsIzWtKt4NWRw+YCLE
         NQ5EA+gHK7Ph9a9eD49norBLNomfOTLJw59Hd3ufeql3S2a86sTf2qVdcPYusc/EmB68
         0EMspFn3JKRemgr3yRtL2AxV0P2wgNqHf/aKL3k9Fo31lpyoQT6y6GwOeUZEOyMhnfwK
         GLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765398251; x=1766003051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxnQ/iEQ1sK58mDVjsOZpAu/QgTIX6mC6WKI+mp0l1A=;
        b=bzVmUIqYywaOIFtV0uxxI7NB7jK8t9T0TK++98CMLX6eO2ZTDUkls1VIqKtlvZCRxc
         bZqhyvKkayCCgxfbUCKpgUBqqn4gHJcKJq9qo68S+3+qa21fk4TSbQswX1Pey/VWTyS/
         7lQkzv72HYTMw//eHAiIJEKT2drOxngJGmE5k9hwnXs0sVtd8Futnopb6vt+7qsObInJ
         1AlBabUtD5lpqRA1v4+oSGDwSTIkIzsSUYn/PF9YtfwdMRARK7Vj4TokpwfmXmA6TTAY
         BsH3z/LJUtObgxxCD6QxenmsqjmkjTYuZP+FxAHiCM5mMIDlEOv8ug7acKuNSg0wOoo8
         15dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDj6gWkbFxWNBh8v68kK5Y9TvM6fKmfFVF39Y57QdbpdYock2tJ0/eIlcuHWFILJ3yxlQnRyvlrTHSSjqC@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1+yzvGeO6zRsa/KHYnbeqd8g/CVHOaEo8EY0AiB+miQsTqrf
	zYmgwrzLB80NFUfK4L7fgmABLlM8Lx8xZDtA0bqeAwQmLV7JOAR+inFmmMYcf9BR6z4F5Ct5QVt
	iQFV2yN2ijDyuxpkzHfB1lqgEpAIQvNdekfwJ/4MRGiaFffJuQWvieSJl7jJcn6byDFQ=
X-Gm-Gg: AY/fxX5ie6Lr6o9Z9SS5H7/p7T8CxYmc1Vqcn/Vu1l2RdmSrCj5tSI9OQtHGbRuqHXg
	8A9t8GOjX+E/GHbmG6K+vsEBtHUK+Qri72u+1J5WFrCPg+WiXgcrz1+vPDfWKI1VCrIdjPbqyup
	pdTHWib6sh2YV1D6u9FyEnIUG+UofYRFUGqv8RiN7/BxGQOWfSRaiv3zldiVWiCwBQUBPS1FIv1
	NAo0b9jSBCxU27sAbYvE/DlH3TJPfpXqcaVm2TeVgj9ML2bK0cs45gL1JjC7h8wCaGxwKKDAJr3
	SzzvY3KC0jVdwmObVdGKhWbNNqwF8Itl4Yi3o5DI/zJBn4/Sw0wN2QVce7wQC9AWnNHc3P17Z9z
	zkuQ=
X-Received: by 2002:a05:6214:768:b0:880:501f:5e8 with SMTP id 6a1803df08f44-88863a2ab3amr50896676d6.13.1765398251198;
        Wed, 10 Dec 2025 12:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp/TCjQkjo9IXEU5scwVWKecCDQSTmMb8hfAZZ6nq5cmvChNS/S1r8YuGRQNN9gNusvbUp7Q==
X-Received: by 2002:a05:6214:768:b0:880:501f:5e8 with SMTP id 6a1803df08f44-88863a2ab3amr50896356d6.13.1765398250715;
        Wed, 10 Dec 2025 12:24:10 -0800 (PST)
Received: from x1.local ([142.188.210.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8886ef0d241sm5052596d6.42.2025.12.10.12.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:24:10 -0800 (PST)
Date: Wed, 10 Dec 2025 15:24:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>, Nico Pache <npache@redhat.com>,
	Zi Yan <ziy@nvidia.com>, Alex Mastro <amastro@fb.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Zhi Wang <zhiw@nvidia.com>,
	David Laight <david.laight.linux@gmail.com>,
	Yi Liu <yi.l.liu@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: Add file_operations.get_mapping_order()
Message-ID: <aTnW6OorSRmn1SqI@x1.local>
References: <20251204151003.171039-1-peterx@redhat.com>
 <20251204151003.171039-3-peterx@redhat.com>
 <aTGmkHsRSsnneW0G@x1.local>
 <aTaYtlTdhxKx2R24@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTaYtlTdhxKx2R24@casper.infradead.org>

On Mon, Dec 08, 2025 at 09:21:58AM +0000, Matthew Wilcox wrote:
> On Thu, Dec 04, 2025 at 10:19:44AM -0500, Peter Xu wrote:
> > > Add one new file operation, get_mapping_order().  It can be used by file
> > > backends to report mapping order hints.
> 
> This seems like a terrible idea.  I'll look at it after Plumbers.

Sure, no rush, please feel free to go through discussion in v1 when it
comes, that's where we landed to this API based on suggestions from Jason.

I'm open to other suggestions.

-- 
Peter Xu


