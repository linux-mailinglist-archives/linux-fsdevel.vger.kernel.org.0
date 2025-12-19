Return-Path: <linux-fsdevel+bounces-71700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CA5CCE0EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72B6F305B4DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67271F4176;
	Fri, 19 Dec 2025 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHv6lgZz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9235959
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104074; cv=none; b=gQWw1IWirwBBZl+X1Dxi6nqpEJYTfAhJizjOQ8MwHQLeCmwaKXY4Gdw/Jf/yIQMHW6sPX3Qg0Si7jn60hV6DGQS9lcbJ1XiCez19SrTQHbTCsy0DZy1fxPIy0jWxlU1PlWDJaKZoEIhxwuCGcQzO36fLmMjqTasJj5LVqcEYXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104074; c=relaxed/simple;
	bh=3wvD8+jC7ncwOj02pflJCUSlHNypAz5Fr0y4i2dXiBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRuTK114q/S6Fvfrk0wueVUINT9PPm/cemFwTsHPZpKPWujq0n8aelKYff8c8lDVTUBUUw5nAZ708rqejHmQYyXbqcP4wf5v6gbOp06Gxvs80WpZZ6aAa1Nn6ohFimLeZyueMlg4lkhhWbuZ/cIJShuntyKJ8jelsVJcl4OX0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHv6lgZz; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cac8231d4eso725572a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 16:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766104071; x=1766708871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6p92sJSBgMtlDAjO4F33+QmLqegJ9wBIbGZxC3DXP0=;
        b=DHv6lgZz3UIopglcPbvawpMJKeZqNJ9I/uAgOdCk287MZ1L2AsMSpEjJTPTLU8R/X7
         dVKRjwQC4IvdMz798veYOhNWMGXuANeh1nirZ3m/VV2a1RvpzznLjLLLpaXOOYxntecl
         B6IQ5RlQSvb/RyrKqxC7kICJ+p5lGcX+sMbC0caASBrv86m91U1GUEAAZ5EMD8MSAWaz
         jsx8B89/7OEAKFRTU0mRG8b8fdkp9H2l95NxSEXnf2DKGe83z9wObVgIinanKNTP0IRm
         3OnJm86ro/H4JdN/BgCEX434+AAaWAN3W/6OlIuDVIQUfycbMgFcvRv23zi6/FDcGn0j
         iHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766104071; x=1766708871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6p92sJSBgMtlDAjO4F33+QmLqegJ9wBIbGZxC3DXP0=;
        b=B8vROj7QCtSRFDNz+KmJ44oKp9KRSywUvIe0ODFjwMEvlYlFq6LDXYeM7ys1D8Xwl9
         ckiuRoVN+mFoeRoqp5KDJZu7Fifr/XjyDHzwx6K0GA0f5+Z+EAIGT8Q4s0qhbSMmVi+1
         VidShWrTGS5LVFQ+j9SQkKnSItgZEV6VeiFgt7eMo/9rnzki/Bl39ui1RlLRBQtE6iKG
         H2fhudSBnryzLFye+uw8+vrSqicuAlAmhDATy2lLt9crGqe4FlTsgRbLN031WCzJiu6A
         70N9AVtpyYndJQAdY/mR8Qe8lq47IInzWfEqZ1qelg1RB60wAPKJnSEhVpkBePhrRQHw
         MsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+7DX+cZIM4v10nKwSKNncAo9f2yyXEUDNs3y2GdaHVNTgEJXyoKvh9BIXBjLJRwgEmsXmt/n5jIFKuqqr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KWNgWWDv9eYOAeP1NLEQTHjGXe2FdNxhhbykFh77ML/lbGRr
	riY+YBLoOuhO4FrZZ35bUz7078NdiWcTEP6Fycw85HDn6xHz1qjkCWb9
X-Gm-Gg: AY/fxX7M2ulXopbU6wOBSnjLAY6beze9oUIfJj4XbMcHTnH0LK6Hg2UtU/FxzRarhW0
	fwCenaJPwavhlSowvIk9Jw0ISF1mJBK9kIdAOcZ8gWGiC+ASe+4qw4cbs/BkdjkxVRxL3mmhGEk
	a57lh6otidDPw89bm2Tpe1nAZ1uBoMCE/np9SRIzlsLAnaItjYdOOlgkE9uDGdds5aRkJ8EHhb5
	CLdywXQ+OclAaOLsv5v0SeJDCeR9eJD5ecceQykok1sc74wlYK5xOLpJf/r1qNClQQ9D4im12aW
	a1xMv20h8lOKH0EE56oDwv8G8RY6P4GGSiADPC58Bhx83XPUJ8EN0XcYvaFdZQlUZhXWGps7QJk
	CzyMfc+2fol/huyrZA4IO/B8w+DCTLoHCdUYf+tjJOZ8D5GnMIVNkqJl5VinldzIMtcT6EOA5hq
	+mq5OsH+E6M3QojS3PWVZnHbBeGCyg8Q==
X-Google-Smtp-Source: AGHT+IERKL4ZyEN7B1vAl3Y9MxIRuqPuP38LufUNlUV7SjP9oOO1keMwPqMl/xHbJbHq7VDkgiFPgw==
X-Received: by 2002:a05:6830:438d:b0:7c6:b6da:e2ad with SMTP id 46e09a7af769-7cc66ac1f03mr555005a34.33.1766104071510;
        Thu, 18 Dec 2025 16:27:51 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:7cbc:db2c:ec63:19af])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673ccc2sm663236a34.12.2025.12.18.16.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 16:27:50 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 18 Dec 2025 18:27:49 -0600
From: John Groves <John@groves.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	John Groves <jgroves@micron.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gourry@gourry.net>, 
	Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Message-ID: <lxwhxzpuffky4hkw4qgiavv2x5pctb7ka3pnqdyci6w2wd5xch@bt3ehidvftnk>
References: <20251217211310.98772-1-john@groves.net>
 <74npmrpzagba2bbye7kmwwoguafbpvnkxarprp3txy4wmu6gxp@japia7ysaisi>
 <20251218160332.ee5b1c9b2ac7aebabbabfa45@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218160332.ee5b1c9b2ac7aebabbabfa45@linux-foundation.org>

On 25/12/18 04:03PM, Andrew Morton wrote:
> On Thu, 18 Dec 2025 09:58:02 +1100 Alistair Popple <apopple@nvidia.com> wrote:
> 
> > On 2025-12-18 at 08:13 +1100, John Groves <John@Groves.net> wrote...
> > > From: John Groves <John@Groves.net>
> > > 
> > > This patch addresses a warning that I discovered while working on famfs,
> > > which is an fs-dax file system that virtually always does PMD faults
> > > (next famfs patch series coming after the holidays).
> > > 
> > > However, XFS also does PMD faults in fs-dax mode, and it also triggers
> > > the warning. It takes some effort to get XFS to do a PMD fault, but
> > > instructions to reproduce it are below.
> > > 
> > > The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
> > > free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
> > > when PMD (2MB) mappings are used.
> > > 
> > > FS-DAX legitimately creates large file-backed folios when handling PMD
> > > faults. This is a core feature of FS-DAX that provides significant
> > > performance benefits by mapping 2MB regions directly to persistent
> > > memory. When these mappings are unmapped, the large folios are freed
> > > through free_zone_device_folio(), which triggers the spurious warning.
> > 
> > Yep, and I'm pretty sure devdax can also create large folios so we might need
> > a similar fix there. In fact looking at old vs. new code it seems we only ever
> > used to have this warning for anon folios, which I think could only ever be true
> > for DEVICE_PRIVATE or DEVICE_COHERENT folios.
> > 
> > So I suspect the proper fix is to just remove the warning entirely now that they
> > also support compound sizes.
> 
> So I'm assuming we can expect an updated version of this fix.

I'll send an update Friday morning

<snip>

Thanks Alistair, Dan and Andrew!

John


