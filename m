Return-Path: <linux-fsdevel+bounces-77695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEySNCXdlmlJpgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 10:51:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214615D8A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 10:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D41301D073
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A8E30B533;
	Thu, 19 Feb 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjGY/HPM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIGswDF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518A1E8320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494684; cv=none; b=sn6sNJrS/n6q4/LBHp8h5UfwDnIiq9EuUnzRGFUfBvefX9BYe/NCJec0qn3Y+Kobow2+RLVo6n/cKNsZwnV9zk0U9b+2VVrQ8Y96ooIoCtbSoP17NmoqOc5ynTzMxtU7QUP3SlMNlQr9u+r3XbiUFNVJ/RMhEXkDD5bczUCJz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494684; c=relaxed/simple;
	bh=qzaET1Zy37x+a+KIo6FvgZb076ajIH6u8Jf7ivmPbBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvDMCeqbIJmY+V8fva+zkjxw9ZXHWueznz8U4L41EX4gW/qWSJJznafB0fEciwPkG69UABGUKOEAcWc8lcLfzOWKXQWtyN4q6AYtC64UJn0/b3QAkkAKDg29YsKvpPBZBgMpbLKoKTMmTHn5HROtzEMnNTaQnIPfPJheCDq0vHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjGY/HPM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIGswDF1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771494682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K33V4rOOwYLW15X+o+vqv2I81VqZ2aMaDFF+pr+8/b4=;
	b=QjGY/HPMHSxe4Zvt6wV1pK9bVYeyonNEH+kUeOc1dDmiOqqE9GxgQVpMk5hSZwhLd0SY37
	vXKLCDs8mDNnUNyEkki1/pazADeUyrI5ouphg6S6TYlnKdEzvEszqAscFy1NyCxwu4wU26
	stLe1rSIqPN901vptMsBT5RwfSM75gU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-oJOzUNYqMiaytEnWRSSfXg-1; Thu, 19 Feb 2026 04:51:18 -0500
X-MC-Unique: oJOzUNYqMiaytEnWRSSfXg-1
X-Mimecast-MFC-AGG-ID: oJOzUNYqMiaytEnWRSSfXg_1771494677
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435db9425ebso795249f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771494677; x=1772099477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K33V4rOOwYLW15X+o+vqv2I81VqZ2aMaDFF+pr+8/b4=;
        b=aIGswDF1Np8mHRifm/A9yfQ4bb75R7ov99adkycpJOwhu6sJH3xwxQXLPygSRP/RnD
         FDc6DkoRBb8B6YwbuW08lW6zKBLLHnSG6HUVza0hPcYnY+U07mZjJEXrk4AsozdBb504
         4cXR+x8+TxjdT7SNxyS28oem7R+xDwl+ywU9i5vIF/wSz/SOlIpMXU/IsatgGhwui43v
         WxCvirjtr96+4y4awUjPvvPQo1b96Pdkm0yc9WxT2MpUONpb+wNHJOS50NWhPGEUrYpm
         rxWs6B4EeV08dKRg8ngqEi5BSS/5KppAlUl3vKfHLGO+BbnWX4LdWPos0Eq7AfGUIE6p
         tlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771494677; x=1772099477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K33V4rOOwYLW15X+o+vqv2I81VqZ2aMaDFF+pr+8/b4=;
        b=ZyDKrqpt1iBbQo0XXr4kfORtU9me2yjkMJdi4kpP6rNdlozlUn5iEQwTLKhaSIMy7q
         BHljpE5wU+KA7Ra5aJLlWRTdUXo+QV5ULMLhcFA+e8IRjatQc06I8GJWLpzUTHds2Yr+
         1GOCG8xjUlBUVhvP42nP4cNJSwO8wqBSJu9qYgCxziPqSl8vDu3903QOOPGfC+M5ubwB
         JX3/iS00tqRu//5+zWzZWABAI87q2BMi+W2kEFdVCV0cT1V2SCA0Dwx9suir9lbGwWvs
         7Q8ethfby4LDF0iA9t1D5VQSgD5mADaLAoK6d+win/4Ppqrn3XV9lHYa0PiKjvKP17bw
         5K8A==
X-Forwarded-Encrypted: i=1; AJvYcCXQynDwpiSDBqPQcE7OpkxeAsqCqSMR+lj7X88PV4pszBMbQoy0K7zeNHlbM/2oznkmAkqaEBmRS6hf/yxr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+zsN9ysPg0eGNCe9tujZ17ZDz62Xj4Sajty9/MV2KW2aOVTS
	BrSJmzU04FotXG5E3QdtusOkpv14rv44gPsemUkeSLNTC0K2Ocm782zCiuasIiYkyozOiJrCYWZ
	UveLrRynhq5aCtVE9cWF07bb8+nF0RGQDO2OGyW8ryTglwJB9DAyvocsoYzBfqvHDuQ==
X-Gm-Gg: AZuq6aIIEfu3EBNOp3zAzbZCpQlnsMxT9sLJ3UAifWMttVWin/96EcyHTDxaxAEsOOi
	hkY+fyKmUt+ZrGeoSnQR/nWm42nrimkNq28A9iddpNrqPnxbEousQDzK3MjBw3RaLb/NGyPI1WN
	yb2fopmw1Hc7RWfYZTOQWfnqTinC1QKxOJihHTEO4SBBQq0KP1zRDX1XTZbOcKTq901UL5as33M
	zqgElwyBtY8B8OGsCXCdfPw8RWjMKceR7sklfF9Q+hiVfzpcZo1UZiYCMtvQD44OccuXjhCb7DK
	T69gogs9QTdJAVyaE6QxPnrnGiW7lIISoonBSU0jPzG+bMO6vYdG1c5OI3m9mHixT+WTgQnGJF6
	H0uRSO65i2jM=
X-Received: by 2002:a05:6000:40dc:b0:437:7010:1d0b with SMTP id ffacd0b85a97d-43958df17a3mr7223987f8f.6.1771494677307;
        Thu, 19 Feb 2026 01:51:17 -0800 (PST)
X-Received: by 2002:a05:6000:40dc:b0:437:7010:1d0b with SMTP id ffacd0b85a97d-43958df17a3mr7223941f8f.6.1771494676703;
        Thu, 19 Feb 2026 01:51:16 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5b07fsm48227142f8f.2.2026.02.19.01.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:51:16 -0800 (PST)
Date: Thu, 19 Feb 2026 10:51:14 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 28/35] xfs: add fs-verity support
Message-ID: <4cmnh4lgygm4fj3fixsgy3b7xp2ayo3jirvspoma6qxusdgluu@nyamffhaurej>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-29-aalbersh@kernel.org>
 <20260218064429.GC8768@lst.de>
 <mtnj4ahovgefkl4pexgwkxrreq6fm7hwpk5lgeaihxg7z5zdlz@tpzevymml5qx>
 <20260219061122.GA4091@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219061122.GA4091@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77695-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5214615D8A2
X-Rspamd-Action: no action

On 2026-02-19 07:11:22, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 10:57:35AM +0100, Andrey Albershteyn wrote:
> > > > +static int
> > > > +xfs_fsverity_drop_descriptor_page(
> > > > +	struct inode	*inode,
> > > > +	u64		offset)
> > > > +{
> > > > +	pgoff_t index = offset >> PAGE_SHIFT;
> > > > +
> > > > +	return invalidate_inode_pages2_range(inode->i_mapping, index, index);
> > > > +}
> > > 
> > > What is the rationale for this?  Why do ext4 and f2fs get away without
> > > it?
> > 
> > They don't skip blocks full of zero hashes and then synthesize them.
> > XFS has holes in the tree and this is handling for the case
> > fs block size < PAGE_SIZE when these tree holes are in one folio
> > with descriptor. Iomap can not fill them without getting descriptor
> > first.
> 
> Should we just simply not create tree holes for that case?  Anything
> involving page cache validation is a pain, so if we have an easy
> enough way to avoid it I'd rather do that.

I don't think we can. Any hole at the tree tail which gets into the
same folio with descriptor need to be skipped. If we write out
hashes instead of the holes for the 4k page then other holes at
lower offsets of the tree still can have holes on bigger page
system.

Adding a bit of space between tree tail and descriptor would
probably work but that's also dependent on the page size.

-- 
- Andrey


