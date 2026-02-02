Return-Path: <linux-fsdevel+bounces-76071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBapAyHkgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:51:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9CCCFC7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D6A3052629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E072638BC;
	Mon,  2 Feb 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FhaemJHj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5737AA8B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054390; cv=none; b=H9NUwegGUinwdhjqn5vooca8UOUZvNGbGkBZCs4Chtl1oSCXz0De89mkoyR4lnWWhi8ZIYU+V1RLJOCoETw9jWjLHm3lEV27t9a6cmnilFWyV2NH2WPcjokUPpEKGAfQZYDx68PwaIihTLixLZZfegLIqTjJg9U8FIi+zJlyfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054390; c=relaxed/simple;
	bh=gL8uCUJiJhHkiRNkyf53CfWI8RBSbR1NS4lJMuLRlY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=df7QNUjI4FuKJffbZbHRk0BwOZr4lHAJ/w7ydRl0xWFSL26k5Mp4h1LF54UN9q8jl86s4kVLK5m7MrnUfsdA0x/W889cvNg0wlyx5cEQUZCI4z5AH2DYYCSMoYKToXOgyLRQ/0cFpb1kf4uClO9EDbTbQvmtuA/wKkg88mE5pjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FhaemJHj; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946e0884afso79226486d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 09:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770054388; x=1770659188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1wm0NexTqa+iJZbv1CobgpMNsP/JgzOw/JXCIX3sf8=;
        b=FhaemJHj8nP4Xz0vsAeScEVMy7SHVg4mSlhJ59pasSiPnQ5mddAFKvsyV+d2mDoBZA
         eGJbg4Z9pOFim4xE85y0R5Di6iXbDAMFGcf+R2zIIby0Ygf1Owvs8u2+/HW7ILjsxF9g
         G1NeQO4b1NF9FmTXTX9W5w6Dlm7u266be99eQYKILV+t//GFuw2QT1fjyrrItMU44720
         8+SVPhMn522jFPRb8ew86WTIa6NUkmZf1cThnHp78YLtdVMoAsnGnjxrQWugfuPtgMLJ
         79IClZ+ie0w4kg5umbGLa13+m/pBRbCg+muFlFv3iRy9jT1PpVVy83NsQu+xd8IrBgzr
         4IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054388; x=1770659188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1wm0NexTqa+iJZbv1CobgpMNsP/JgzOw/JXCIX3sf8=;
        b=pV7EVn6PzIWy7kDkjxU4dcAGlkWAYdY7WSD5G4Aagu1IqbbXaqvpjCZI0KPyokunhh
         632T7fcupk51Y1evFm/kAbZHJydAds8C03Sb5Loa3KKCEQdPLFF3fR8M4+fZi/XNAoec
         3ieCgxa3MH3qnropNuXDUmWKLWwwSk1iYLmnBgnuFC6403m5pXZL6MyB7GWWWZv8eOlh
         TrwijsVkJokfkzpfcOh4s3wkiGM/ELtwPKtXT4KCgmN10SNCbQfWjJ6xjnn6JYaEtvn1
         gS89hgE0B89XYSNaz5WrSatTtdgexIDelbLfP0ag1KK0IIpgSx6rR02npt+052l/908Z
         CF+A==
X-Forwarded-Encrypted: i=1; AJvYcCVP8cUwPJyC0utdRkbqanf3SP1eiKoIt7bqs/hefogSr5vVSg8jxb3O5rjXpZSyN+eCvja4CC9x4Bh5QDvY@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyMAJnZE/j8At1F6myyh3G2o4eJXmT1QMeVmmFyBd2DPVeIaU
	N9dvmmgIBaoErobh5QIP6Ld9mrppUXjXNHCyRYT1Rtgr4SzHlKZlzbwoXnExek9RJqA=
X-Gm-Gg: AZuq6aK/coEyZp9hAefZJIzDKqJPaEqwvnz6EGtAHwhdTnVxEVfg6pJAQB/xBYo692r
	8aDxSFKyrYZWyrO9fwhKnt1qG0WY+V0AYGiGZWkYm+bHZanY7tHXJxmDdn0CTD9JXSGUCN1nEoY
	lerR2qEUYBd7M1mq+4v2/WpK7lVBWIZS3f/esjr0gmxBvTOt9LyYkQCs2ALbDvBgcBT3U019L5N
	7PrENJHwG8ftNwKI821LIbTTbIaEMhY+kWekDewtujhQDtomX0azru0JI2awpxCUVgOWuKQpWCN
	l4qZa2+MMGd9sABorLsmgaE/34TDFLlBxhexEaFEIZ+JtgFFRqul8BcNXiAuuQ/Z1fXfivoqaDo
	RtUCOFON8Z8jytdl26jGCx/xa1tFt2PPEPFFXzbNSAvfQC13nbagXnyquDg2LUKXpmWFJ4b1/2n
	jcSwgrQYr8VD88rmqGWlLAT8/F+6zO2ekICxjb/PH2eJ/LBaXT7/i6K3NgznlSVNHhQ5C9QkmMl
	oCg5MPm
X-Received: by 2002:a05:6214:c8f:b0:888:4930:82aa with SMTP id 6a1803df08f44-894ea166512mr179211126d6.70.1770054387847;
        Mon, 02 Feb 2026 09:46:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d47e13sm1267680485a.45.2026.02.02.09.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:46:27 -0800 (PST)
Date: Mon, 2 Feb 2026 12:46:25 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	terry.bowman@amd.com, john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: [PATCH 1/9] mm/memory_hotplug: pass online_type to
 online_memory_block() via arg
Message-ID: <aYDi8bhxFnvMWl11@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-2-gourry@gourry.net>
 <20260202171029.00005e80@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202171029.00005e80@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-76071-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,gourry.net:email,gourry.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 5E9CCCFC7C
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:10:29PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Jan 2026 16:04:34 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> > Modify online_memory_block() to accept the online type through its arg
> > parameter rather than calling mhp_get_default_online_type() internally.
> > This prepares for allowing callers to specify explicit online types.
> > 
> > Update the caller in add_memory_resource() to pass the default online
> > type via a local variable.
> > 
> > No functional change.
> > 
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Trivial comment inline. I don't really care either way.
> Pushing the policy up to the caller and ensuring it's explicitly constant
> for all the memory blocks (as opposed to relying on locks) seems sensible to me
> even without anything else.
> 
> >  
> >  	/* online pages if requested */
> > -	if (mhp_get_default_online_type() != MMOP_OFFLINE)
> > -		walk_memory_blocks(start, size, NULL, online_memory_block);
> > +	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
> > +		int online_type = mhp_get_default_online_type();
> 
> Maybe move the local variable outside the loop to avoid the double call.
> 

ack.  will update for next version w/ Ben's notes and the build fix.

Thanks!
~Gregory

