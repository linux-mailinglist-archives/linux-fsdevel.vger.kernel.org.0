Return-Path: <linux-fsdevel+bounces-76081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GubK7nrgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:23:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7268BD01FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58AB13030EE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9801D2E7F07;
	Mon,  2 Feb 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="InR81NOc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE22E8B64
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056622; cv=none; b=OX7bOiAJfs4eJrsXzZ1WV25DTSZ883rPJ68RaPdcv1dtximN6EVMdNXA2gZcTmn63Zlj1IPvJjzBoZGIo2HtQGLHV4Nii/T3g40ALDPMZ2kr3BDCCuavqwVt3bg7uJlJX0u17ge002lE4b6EE8YpMTISZuaL6ddvI7SASDjUruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056622; c=relaxed/simple;
	bh=ADF7ZKoCipxDP6UUmIGW/IPztV2DncS/DM4/x+XvBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNFAhCc5FmRZqFBUgpXAUvhZ61BiOvSPflAO5fSw7BjY8w9AMWSlHJ4LlicY1ty9ODigcqKaZo5Og/6PNk1vEuEmF7/MkIJ+uIGa9+fdAvtSzC7D0sfOBvMbPuVJ5GgKLf7vjrtIs7Xm13JeKgJik1Va/OfcW7nXOOHjI/HiPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=InR81NOc; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8887ac841e2so42839386d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770056619; x=1770661419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MqsmEA1l4K6M349TDpqaFt5arK8yfZiMH/3re7GUwy0=;
        b=InR81NOc+P/iyRLUJkh38ul0bKeuarPFPiVT8NeFHBjhUd6Vmo6R/C9sN5zRQ28C8M
         hEhdNiuaxy6eA5E4vV7dHMOTxed3M8H6zFl6luU8RTKoll1Y3WqFSnV86JTTkuCuL3jD
         nzt3513DmVtY0QTBkhvh9DMPoVGO5E1o8hbpd0P3sU5NQdQHBmGp2BwRH0p4IdJoALv7
         N2tDwHK9yxaq5iqwv+4itd6iPtnz+/ziKgHAPec2W545IzfQRlR2LEHwsR6DOnF2Pmxx
         S+WGypfw7xh3HvuRDMsP9+ZTeSR5PkQLTaKfuMKd3sdjHJ4kB0zzvrvDgrFBjTmBPp3F
         J2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770056619; x=1770661419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqsmEA1l4K6M349TDpqaFt5arK8yfZiMH/3re7GUwy0=;
        b=gtDbKcka73h2PB+FNZZYblBjstrMQFTs18dhtvgpGuj3+axhCCmX4UlyK0CLi0ORk7
         fxxWsh3CkuuGnOGjN1zOJuIjIPYHZQxOylYD8r3TTkCry2JxMkXAQ0JkbFE68J8XxS1E
         Dh8ibHOenxa5UK23g6yyZeQ66EPl3Mv04+GckUqChGRVwEn3on+qm1I8DATVsvo5o90p
         ySdEVl6U/0y0UC1ePcqqwuzjlpwvCbpCXoIytutOBUGFKeYBcMk0VrXI2Au9p2NHykv+
         gPhQ/3jlNWe8FJlgB1iCGpHRERiLLwvpYd4c8C2BT3NHDBW/dEYlcbfBF8aqCGvytioh
         SRUg==
X-Forwarded-Encrypted: i=1; AJvYcCVXOxF+0UXI5XasY+aWoQClCzKiAOEXJdRpUXkp4ZdP7jHtjFCOBmF+whhqhpWZYk03E54hLtK30z6iaATf@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8fW+BrdEttKhohCVAW8v3qcfleZeqi/YZH4aloLyxaW2LPRm
	5NATM6lWfGVJYJtPM9ee/nMLLRET24qWz7DbWcztJa+7aTACvglVsrjqqyczrk0E85A=
X-Gm-Gg: AZuq6aLtr6FvVBNFonqYh1Cw3TRTRIkoiFg/jXxCaj+hbRClZ/pkuzsVnrc0FPCJ+T6
	htM8rG9j1mfXAzCUtvGjk48oLV3oMa0pL3gXsOWAqSHn0HCcSaHh4kWoQFwV93xI5Put/GxFIjW
	8mfUYMux+AbxOYO7E6AN6St96eqhbhK4NbuftHLkM3ImBXakrd+yFUcyqgyiBH/YhLGWlYawXh9
	kCoq/K1Y4bGLxReTX7ThutNg5M6HW79Q1Ua2jtrEFZI8EZ4daciT9BOVkaGYgga9PlD3gqJN1rQ
	ERDjoe+Zhct4azO+tohtdRquw0r5lc8xZQomFfJ9nibp0L1d7F5BWoKKhwnbUqCqaATJWl2SsuB
	K+IFVCvsaUXz98bjbXUtLII5hL0PmdLr4wBPTCz8ObIgPPtO53CirpG0L4Cb1XsS6WNdot2TVUQ
	y9n2waPl+rtU8op3XjlKR+hnMyz+6xG2O0hXhD3oBQTmBslNMbJgJd6ZwR0R/b8y6jLJ4FnA==
X-Received: by 2002:a05:6214:e87:b0:894:6558:58f7 with SMTP id 6a1803df08f44-894ea167cbbmr166333016d6.63.1770056619523;
        Mon, 02 Feb 2026 10:23:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm1089477985a.46.2026.02.02.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:23:39 -0800 (PST)
Date: Mon, 2 Feb 2026 13:23:37 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
Message-ID: <aYDrqVEOwkGfv2JG@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <20260202182015.0000325b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202182015.0000325b@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76081-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7268BD01FD
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 06:20:15PM +0000, Jonathan Cameron wrote:
> >  
> > +/**
> > + * struct cxl_sysram_region - CXL RAM region for system memory hotplug
> > + * @dev: device for this sysram_region
> > + * @cxlr: parent cxl_region
> > + * @hpa_range: Host physical address range for the region
> > + * @online_type: Memory online type (MMOP_* 0-3, or -1 if not configured)
> 
> Ah. An there's our reason for an int.   Can we just add a MMOP enum value
> for not configured yet and so let us use it as an enum?
> Or have a separate bool for that and ignore the online_type until it's set.
> 

I think the latter is more reasonably, MMOP_UNCONFIGURED doesn't much
make sense for memory_hotplug.c

ack.

~Gregory

