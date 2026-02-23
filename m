Return-Path: <linux-fsdevel+bounces-77968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOgzKgtvnGmcGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:15:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEA61789B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F88313C605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E68366044;
	Mon, 23 Feb 2026 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b77f9FKl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="evBfy0fw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6681313E36
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859430; cv=none; b=NGoXNwVo4B02AHtG7etl5C9YjlsaBSQOEhPhkkiqJ0EEbIoBs7exTPjhyclZsy67LIHemgonj5tF1LANS0QqLJqrADW68E6BkhZkqx67WYcF2lOzMeTzTHPdL3+5CHyI5wUgUR27fHbp8BdrFhhnOORE+RQIWz+V+/pAlitS0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859430; c=relaxed/simple;
	bh=ajbFxcQIg7kiK+LNtaEKR4J6yZsldAS3Pd3wK1n42zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsuFkvclbshRg4nJLdpfBdUjQ2xmziMmSMEu9k/1yZiPu6WX9L4es6cjUCwk9HHhmeBMwo1uKfoMY1S6Pc86uBuhbbwOOsYMPaTK8GEHoEtvdiRpMbYINN7+LfLgGQm5rpH/ozFW5TCK0/uNuRjoB7k3yp70S7165mQRs46UN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b77f9FKl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=evBfy0fw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771859427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7toYPkkmoQQ1IjdzTLbC2+SMDXKjnI0hCgkq/dBEBHU=;
	b=b77f9FKl3b6wsDciH2kTNG9nensYxmEzeMpljaMpD6EQq8taCIyh4T12uB7Idhi8nsOtDQ
	kvPgN5yirujSNnTkLXgxWzPE7u5vIQ9iOr0UrorDsTY6ycOcXsJ7HUO5lfHfT9LvJHBOS1
	RsVaNUOyIMj+OWl3m00cIcC39JilhYk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-3olLMxIQOKaq5Ye_P2_nEg-1; Mon, 23 Feb 2026 10:10:26 -0500
X-MC-Unique: 3olLMxIQOKaq5Ye_P2_nEg-1
X-Mimecast-MFC-AGG-ID: 3olLMxIQOKaq5Ye_P2_nEg_1771859425
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso37430445e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771859425; x=1772464225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7toYPkkmoQQ1IjdzTLbC2+SMDXKjnI0hCgkq/dBEBHU=;
        b=evBfy0fws96FzP2lwLkAs0u90azno9jSAvnysYphzwz7Ta0qxSBeQu7qUmO5kg9TU/
         Tvi+2kmyViJFT8tHsZ8PGhEheZt16trncDmdEqgpr+/CvgOGBJ5/qmbtkPY0kC/JBuHO
         pT0KMUjXnDtDk38FIvJQ1obf4N1geN6m4VyVNL06T6wpWbrxfwgWHZOo9ZFqqRO5B6ep
         3M+SV7wjSUW8I0GuuhRYC5xl+0RgXExYzwL6I2rt1i4Ao7VOr2LitSK7LOk4qf+GyJoi
         VhVL4edfd0w3tAYGcWrRtzr3fHZa6qV2urgosc9vkOkyQbXL3HCVXSrX4VwtsUTh5FzZ
         eAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771859425; x=1772464225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7toYPkkmoQQ1IjdzTLbC2+SMDXKjnI0hCgkq/dBEBHU=;
        b=eFg7uTrUYD9DGxWv39O+ce54a6rTz8Et3lSGQoRsUX4l8rFqxKO+h80mjRBi5D9vxz
         f5Ydc+ydnFAoiZyyGUBRFOOZPAWHATFMn1oLZOxWadt8WjS7/xJZLqnqz4DKrOtGn1+R
         PQ3H3w1/p6ODqIw9nSwb28JRCJWpQNYzbUo8mkKLD5IPaV4jjn5XkKVQqy9xD30PffWM
         NXZZiQ8XNOM61BZHaCK9PhwKt3PZuVN7F0PXpPIAxQBiU6NKtD8+KjCIVZ+DcsJaWmOi
         UJ18ekINs+HvNWgq+FCdDBnQmQ3uUEY663m2qxreVpKgVKE/o/9U+5mk0Xxpc7g6GKum
         IpDw==
X-Forwarded-Encrypted: i=1; AJvYcCXi5qmaw7fnx/b/gNi1EHqVuUuWDS5JhaSi8WMRjoVqMZAfBIR9liLV+g6m2gMCjktcigOBVF2LX1IDqSR7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MDfOPCAx/gpFy02DAQxNtPUiTYlgjngrPGYDkJY74jTlECNx
	ww53ibb6gY+qgKNUVHWxfPdsbc9eS88Vmn7CekuwiGeAfBMxibuvwK0lMZ7xd0vQp+6NJOaFqzV
	flYF+YK1aYU2oxPEIg16g1j6PMT8eiMwjvHDpAXAjSKgJWS8T5InJjmxVYWxh4M7gtg==
X-Gm-Gg: AZuq6aJQiWuBuoFV2emV+1ucDHNCeMs8gNc8kM9hhdkicyOe8dM+vwuTz9A6Lkpy3Yn
	c7elpM/+eDL7e4GV2UfhMkLh9IDq38W0TPue9AVPpbHnlM2ivi5eVi/lFMNdQHDRqYHGJ3CUVLt
	tIjO0RkAEK57EDLbDasrPHPzQTaHMTfVS4Wonna2utMhksX1J3v3lfuAm5DtFJ08z191813BiGP
	F3zNPj4JGogJ2Y9R61cfKKb81IYvx3rrbfP8mUL5mUmmtzlhl8okWH5CO6dSZzGiUx2dD9TMS1L
	u6MGxrdX7VR9B5fkptpo7gOGd4jWxNJt/RkRMQ5NrdA/yG8sJIvjvT/xHAFQp4duF1l0G1iZJNt
	Uqy/oh/zSdTI=
X-Received: by 2002:a05:600c:3f14:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-483a95e2563mr126160915e9.22.1771859425038;
        Mon, 23 Feb 2026 07:10:25 -0800 (PST)
X-Received: by 2002:a05:600c:3f14:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-483a95e2563mr126159955e9.22.1771859424262;
        Mon, 23 Feb 2026 07:10:24 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31f9475sm249120765e9.14.2026.02.23.07.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:10:23 -0800 (PST)
Date: Mon, 23 Feb 2026 16:10:23 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 11/35] iomap: allow filesystem to read fsverity
 metadata beyound EOF
Message-ID: <ujwgs5xb6rienyskr7qbekmsbyn5qea2ew4untas5drqdufirp@2qea2ndmnchs>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-12-aalbersh@kernel.org>
 <20260218063606.GD8600@lst.de>
 <hfteu6bonpv7djecbf3d6ekh56ktgcl4c2lvtjtrjfetzaq5dw@scsrvxx5rgig>
 <20260219060420.GC3739@lst.de>
 <qheg77kxcl4ecqdrsnmz4acfvszjlamlb7ilgxxyf3pmt4r7ah@5fzzmcpurdfp>
 <20260219133829.GA11935@lst.de>
 <bltgc6uliclhzkuqd4la2tzp6x7vsww73nvjedxh7s624tby3k@jw4ij5irh6ni>
 <20260220153113.GA14359@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220153113.GA14359@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77968-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 0FEA61789B1
X-Rspamd-Action: no action

On 2026-02-20 16:31:13, Christoph Hellwig wrote:
> On Thu, Feb 19, 2026 at 03:23:11PM +0100, Andrey Albershteyn wrote:
> > On 2026-02-19 14:38:29, Christoph Hellwig wrote:
> > > On Thu, Feb 19, 2026 at 12:11:18PM +0100, Andrey Albershteyn wrote:
> > > > > > fsverity descriptor. This is basically the case as for EOF folio.
> > > > > > Descriptor is the end of the fsverity metadata region. If we have 1k
> > > > > > fs blocks (= merkle blocks) we can have [descriptor | hole ] folio.
> > > > > > As we are not limited by i_size here, iomap_block_needs_zeroing()
> > > > > > won't fire to zero this hole. So, this case is to mark this tail as
> > > > > > uptodate.
> > > > > 
> > > > > How do we end up in that without ctx->vi set?
> > > > 
> > > > We're reading it
> > > 
> > > Did a part of that sentence get lost?
> > 
> > I mean that to have ctx->vi we need to read fsverity descriptor
> > first. When iomap is reading fsverity descriptor inode won't have
> > any fsverity_info yet.
> 
> So for ext4/f2fs the pattern is that it is set by:
> 
> 	if (folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
> 		vi = fsverity_get_info(inode);
> 
> i.e., only for reading the data.  OTOH, for iomap we do:
> 
> 	if (fsverity_active(iter.inode)) {
> 		ctx->vi = fsverity_get_info(iter.inode);
> 
> which means it now is set for all I/O on fsverity files, which
> is subtly different.

I see, I will clarify this.

> 
> (You don't actually need the fsverity_active chck, fsverity_get_info
> already does that, btw).

Sure, will drop this

> 
> I'm still not sure what "When iomap is reading fsverity descriptor
> inode" means.

"When iomap is reading fsverity descriptor, inode won't have any
fsverity_info yet."

sorry, missing comma

> 
> > > Another overly long line here.  Also we should avoid the
> > > fsverity_active check here, as it causes a rhashtable lookup.  F2fs
> > > and ext4 just check ctx->vi, but based on the checks above, we seem
> > > to set this also for (some) reads of the fsverity metadata.  But as
> > > we exclude IOMAP_F_FSVERITY above, we might actually be fine with a
> > > ctx->vi anyway.
> > 
> > Don't you confused this with fsverity_get_info()? I don't see how it
> > could cause lookup.
> 
> Yeah.  Still, having ctx->vi implies fsverity_active, and follows
> what we're doing elsewhere.
> 
> > 
> > > 
> > > Please document the rules for ctx->vi while were it.
> > > 
> > 
> > Hmm, the vi is set in iomap_read_folio() [1] and then used down
> > through I/O up to ioend completion. What info you would like to see
> > there?
> 
> See above, unlike ext4/f2fs we set it for all I/O on fsverity inodes.
> And afaik we don't actually need it, the only use in the fsverity
> metadata path is the fill zeroes hash values check (which I'm still
> totally confused about).

Yeah, for metadata the only use is to fill zero hash blocks. I will
try to split it so lookup happens for data and holes in fsverity
metadata. This way we would have less lookups for metadata.

-- 
- Andrey


