Return-Path: <linux-fsdevel+bounces-76365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBAnLoEbhGmyywMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 05:24:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFDEE859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 05:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D5BC3027971
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 04:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE82E888C;
	Thu,  5 Feb 2026 04:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MLDTEQO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537F2E8B8A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 04:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265424; cv=none; b=SCS81nFNrdxaWSawxfm2RbYkmWusd6Obd1Pflp1sALTs4GfG8M1Ybc85TyMONIlOl0cGo4HhHFG8TkViXrPogD8aQMtMLzGYCcSSwqCMNecSdCh2COFOOUs0y8Y8nLRjpP6X8uRliD+fhD3dN/aB4ACdyrHGafffGNHmrkNdoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265424; c=relaxed/simple;
	bh=L03384jtDexDfzkRHHtzPIVJ4BKFBQWzJGNmJuCR4wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/DQ87ZEdqGY/2/bderNZBzf6JT2n9IcEmHTd2DjUUYiNML33VOn5N0ARbs67Si9xZx2cFGqV70OpLpAQNMFBFYbdzPqFpXLECYyLoPDfIU1JMRx/6aKZW0CZMUvBH9LaTaSMWqb80WalJtrPpMHd5oxN9Q7bSxbwowbHrwp+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MLDTEQO6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c5349ba802so45189085a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 20:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770265423; x=1770870223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qW0+moZctApASOdwQkaNncsGOVFnNExxcEZS6yJkS4M=;
        b=MLDTEQO6exn21nK7WldrR1aIYxSKV0SetMJnEH6Pq9GFGudIeAuYOU2mKG4qNXd77p
         njiQp3vvn/XwQGj8U/pVscEkN7VUqTj/4rs6WF2nJh7NVgxPJOUGQ65Wpllt+WITmwjp
         L4Kd/7cFByLsMZuqVWlCALtotsWYWhVqrhtPsk97ZKxM60Fx+PuD440tbELBKDsFEN72
         fujBWqAsGz2bl14GxXX0stTlfIAFczr+vIq6muJQpN0ZtMa3P4RF2TiteF1IFNrsYK9q
         YTEQxJGJSJPn+21BExh4UjvWTHw4NwtQp5EX21CrP/UolEeBumKNm9SaUOFpUdNo3amE
         aUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770265423; x=1770870223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW0+moZctApASOdwQkaNncsGOVFnNExxcEZS6yJkS4M=;
        b=oXQq8SOv3h+92pZQvioctrYO5UNWD1MTPNuvlPYyDQEBhakZN52IE1COv8Q0XZfbAo
         EciL7xjZtrFmixzOKqqQIbR6HyI2MSbQHwLhotDYEzOk8TDLPViYIljUW9Vgt6P2mniU
         T0pPQACYnSYDxzNnIqFpdG8CZ6gbJMTDdWXOx/MPkBTDFzZ1mAm1em/HMSQf2hlMtkZj
         ESLEJJkMiMw15K3H/UvkercfJRDJGtPjlvuEFC1t3Zf2/sj04nGgXhkB/93/efaWXHBq
         MhD9GXzxbL1bYPSKZjMbOYK6HD9qZ61AHcS9a1LjsI4Q+Rs+JYHM8f2PmDaSuCS3bIb9
         1SNw==
X-Forwarded-Encrypted: i=1; AJvYcCVegpO7yeMS/JXPNRK5YfN0Tj4Xyh8p2/9j2pFH8dequdTNchf286oTL5jVHWdYCBBD0f7d1UNeAffwzIaT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjz5M7WizExlBXkdDDWiKqX4ta6Pwfeb1bFPk0+57FSUCuBp7F
	+cTb1CXhooe5IcbxnQ++vb0nBnUwxQoe5ZgVctJxE+3cKe7ZhFJS4uCHi/d83ckGHUM=
X-Gm-Gg: AZuq6aL1jkuI7LpWtbG9DjgbImRbAu2eSi3O/rRz1jGd6BmJ6csi63+KG4cjjTlG/1E
	ZENxn9s/eQnBVFBY6lXBAfpc9z5JB28NpoicAR8ck7rRj1KiDhcgYbax7qrYPP00AwgZjQhKXC1
	bv2DY8Z3LbLl0JeIEmU50OAvu6Lv8VKbOgTt8NguEyr2HaFP+LPdGbwzJCb59RfxJpj5igoFHyE
	q9FLPq7vHuOvf5ADRBQQE8WGk8Dj8vHSBPvJBuWByn/oUgOj6nYLnDZIHcDmpMD+BAoSIqM+Ulp
	quktX6o+RxDpy62DIfcPlQIjuHRz4QVd3PMpOlFWYYvynv0M9/VDi5+hSgA34ypiOIfCRGQ/lKS
	9SEr2zKH84X3vvdqBOYKZMcUwlYSOEZH6ju4jp8MpJHVxoxPAhaiMmSyUa22Ln4Xa7K92dp3YaZ
	YyMGitf6T1yY14jnBjE+XqTpN5jNCOpqv7sE3Cdx/q0m+SCUl7Lgk+o029kKLALccnYkmXog==
X-Received: by 2002:a05:620a:c4d:b0:8c6:f74f:9b69 with SMTP id af79cd13be357-8ca2fa5e50cmr701545185a.83.1770265422854;
        Wed, 04 Feb 2026 20:23:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521cf8619sm34240906d6.32.2026.02.04.20.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 20:23:42 -0800 (PST)
Date: Wed, 4 Feb 2026 23:23:40 -0500
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/9] mm/memory_hotplug: add __add_memory_driver_managed()
 with online_type arg
Message-ID: <aYQbTFLTRHiAnrKr@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-3-gourry@gourry.net>
 <20260202172524.00000c6d@huawei.com>
 <aYDmor_ruasxaZ-7@gourry-fedora-PF4VCD3F>
 <20260202184609.00004a02@huawei.com>
 <aYEZAUJMLWvaug50@gourry-fedora-PF4VCD3F>
 <3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3424eba7-523b-4351-abd0-3a888a3e5e61@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76365-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66AFDEE859
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:08:45PM +0100, David Hildenbrand (arm) wrote:
> > 
> > David do you have thoughts here?
> 
> I guess we should clean that all up where easily possible, but I don't
> expect you to do that.
> 
> For online_types I used it, obviously, to save memory. So I'd expect it to
> stay at least there, but cast it to the proper type once we take it out the
> array.
> 

I can do it pretty easily and pull it out ahead.

~Gregory

