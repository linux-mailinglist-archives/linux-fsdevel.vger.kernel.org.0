Return-Path: <linux-fsdevel+bounces-77706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GLQAfoLl2lEuAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:11:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FE615EF14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BD95305F655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F633B6E3;
	Thu, 19 Feb 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+M+Et0Z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwR4ppbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08433B6E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506601; cv=none; b=I6EX7z8Z0cDfrdWNaLK0Tkarr0G18rrv1Y/MPdo8VTbSe7xrc76bdTppTzmppkZFG0kGLd+BfawAzolcgx+9rGRV2H642gyzBSTE3ijyknUVmS7xPrVZEXW3XBxhtvc1pgtjbybmN6x190OdJIO6WjaS1jtFbhOAd77rRpIxhQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506601; c=relaxed/simple;
	bh=H6GbZk5mdMnT9e3o9j/Gu86s2cpxHt7MmO2p6vvqV9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6BSY2tQQ4VVH4tCfbKYxSk4kNUSPcWLeogIi1fTouQwigMPg3X2nA2Va84Az9lFA0sS1t2kHhraOuY8HMvmJQgObv1oTfTNhhpRoIbhkH8Q8Es0wsjNtznO+T+EHUuQb9epegPo5ddyTkaBpO3RYWXrTkmg3zjZlmkILEjTzs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+M+Et0Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwR4ppbz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771506598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=86TIrp4laa0pBu7H21TRyyRDI/9QW6qy9OH6ZIij+k8=;
	b=P+M+Et0ZnVCC2psPRg3hE1rV86bhZRyVR129HdRRmct+ze5GHKjv0p4xDZ41nI+tAU4c9v
	zZiaUuwrXB4kqjlT7nGASt8jCe6608x7gQjN5mwUA/zXz6RRYWTscj74nn8/e0YEpm0LMO
	Wao/UrJ2AmYwwZBikeNBt35zlRA4ksk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-6g368lAOPQO3yCVS0WAeKw-1; Thu, 19 Feb 2026 08:09:57 -0500
X-MC-Unique: 6g368lAOPQO3yCVS0WAeKw-1
X-Mimecast-MFC-AGG-ID: 6g368lAOPQO3yCVS0WAeKw_1771506596
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48379489438so9525055e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 05:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771506596; x=1772111396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=86TIrp4laa0pBu7H21TRyyRDI/9QW6qy9OH6ZIij+k8=;
        b=IwR4ppbz1DiQyh5chN/KLNiihSCjPiAo8XuzG10Nu3zKxjP1DQSxSxidNWeT+jFLwR
         ats8HPFwBkKE2zjsjm2P8C64UHkndEAne/7BGqnvPyLf8lALyUTDG67T5SWF0gUgwM6H
         CXgO6Q6RVcx3Yet7BYjK75Hosx0UrLXBOXkj+DLKutSwxyRyYgm36x3/ES87cPT8Q1r4
         MiqySScgVx9+htiYV4Xnm3dcSNif0xrioHzHnkvQUk6vuL69PmRfzE9cgXrXwAP/ZSr4
         cOM4/n6BAzYag1AnKv5LVIk4EXsFXD1pR1WYK8q4KsDprCiDkasF02TIr1kbMasjHEzA
         CurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506596; x=1772111396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86TIrp4laa0pBu7H21TRyyRDI/9QW6qy9OH6ZIij+k8=;
        b=YiYJogFLjMnR0BVrF8p4ZUbHXyMW/EaHsSpdgYK3VNzjA/PATQIvKqUGCNRpER+CIr
         8426JJzw10VtnRvCf+RmgEvRMPuYDz7x6ZVUg2RsZH/SEw+uglXPnv2JE3fSHqTA3uX9
         G0+nudFCQBQA148KzcStzhtCZdnuV8hnrPVXx6A602U+fIq/Dxbg4xJtPS4OQSezw/Rj
         h6w8xXFU8H1zc6luk9jVap4GitlsCPSrgyi+QSwu7055R7+0gSRPA0ZjBAmW5hJDGjED
         Xssmk+0eLa0ER1SlgdK2UsAZeKgWojxZF5UyIBOFWHsVKiIdm+TBAIKHqEGDj6cgEFjs
         eTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKgFXDDgKLHdvc4uuEzjy9i2ptfKTeiFSDVIWaBfX+aemVsZNFeN9u4dPAEZE8GCtfmDbbbB5xcmYKIMGg@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvbgbBDX3y3K7gCNxfnGc8aPfj02icyH02MDETSl0ob7ajVwk
	elGIToO8x7SSq/0B+fLssVLKASCwWyAugtDuWYRnOQjV1ZeaiwICPqMQPy0VVqpIVLBDLzjYtAc
	86GU5ZB70KpKsWsKBRQbMIrTkTGzbWicR8IOMfsTIzaI270Gr5sy5E0lFG4bujxLD9g==
X-Gm-Gg: AZuq6aIfLf6y7iIelzvMYxGdHKhuJ5zuO7YHrsqet0Nk6AxpaMcRA3OQS5lQMX7KZwr
	p+HCOkscehb5SYU1DDLj6hEF3qILCsri4RRe+HDD5xLEm/vsnPk8I9s1dWfXe7o6FraI4BxKd9q
	MK5v0nh8RBaUn6SyngawDGgfcCXYsN63nCsbPj3DxLDGYrN7iHiYfFo1i/CD/x3ONlnCSlvS7AW
	5FHZ18Md2mwcrCxt81VaH5m3RHuMqAJumN59tFkPQYmPaS+1v4TR/O5upzanlFsHjTzcq2m4mw3
	fBsJumCXx3zYtgzQy9H/ia/vP5T9mrW59w3i5KTUKgw+q1Nl4Ht+vN+R4uDhov0n4UT+0GgQ/mi
	vd0i/NT2dO20=
X-Received: by 2002:a05:600c:8b70:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-48398a548c5mr100843285e9.9.1771506595885;
        Thu, 19 Feb 2026 05:09:55 -0800 (PST)
X-Received: by 2002:a05:600c:8b70:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-48398a548c5mr100842775e9.9.1771506595304;
        Thu, 19 Feb 2026 05:09:55 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f978328sm20400695e9.14.2026.02.19.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:09:54 -0800 (PST)
Date: Thu, 19 Feb 2026 14:09:54 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v3 03/35] fsverity: add consolidated pagecache offset for
 metadata
Message-ID: <xxpvkb5cmadxkifi3onmfmnaorw3emfzr32ha5n6kma2kvg54a@ueu4zhhzrglc>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-4-aalbersh@kernel.org>
 <20260218061707.GA8416@lst.de>
 <20260218215732.GC6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218215732.GC6467@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77706-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99FE615EF14
X-Rspamd-Action: no action

On 2026-02-18 13:57:32, Darrick J. Wong wrote:
> On Wed, Feb 18, 2026 at 07:17:07AM +0100, Christoph Hellwig wrote:
> > On Wed, Feb 18, 2026 at 12:19:03AM +0100, Andrey Albershteyn wrote:
> > > Filesystems implementing fsverity store fsverity metadata on similar
> > > offsets in pagecache. Prepare fsverity for consolidating this offset to
> > > the first folio after EOF folio. The max folio size is used to guarantee
> > > that mapped file will not expose fsverity metadata to userspace.
> > > 
> > > So far, only XFS uses this in futher patches.
> > 
> > This would need a kerneldoc comment explaining it.  And unless we can
> > agree on a common offset and have the translation in all file systems,
> > it probably makes sense to keep it in XFS for now.   If you have spare
> > cycles doing this in common code would be nice, though.
> 
> fsverity_metadata_offset definitely ought to have a kerneldoc explaining
> what it is (minimum safe offset for caching merkle data in the pagecache
> if large folios are enabled).
> 
> and yes, it'd be nice to do trivial conversions, but ... I think the
> only filesystem that has fscrypt and large folios is btrfs?  And I only
> got that from dumb grepping; I don't know if it supports both at the
> same time.
> 
> OTOH I think the ext4 conversion is trivial...
> 
> static struct page *ext4_read_merkle_tree_page(struct inode *inode,
> 					       pgoff_t index,
> 					       unsigned long num_ra_pages)
> {
> 	index += fsverity_metadata_offset(inode) >> PAGE_SHIFT;

I don't think it's that easy as ondisk file offset will be the same
to this. So, this will require some offset conversion like in XFS
and handling of old 64k offset.

-- 
- Andrey


