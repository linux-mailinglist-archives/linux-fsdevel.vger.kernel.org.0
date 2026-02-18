Return-Path: <linux-fsdevel+bounces-77566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCPADgmulWl1TgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:18:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C201564CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCD3E3040302
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C82311C27;
	Wed, 18 Feb 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDv8+Fqi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI1ZtNtf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2B31064B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417080; cv=none; b=lniFdmInwIIJX5OluSB0exHhpreDmTsSxiTT93TKuU2b9H8lr1f607izA3n3C33A1MkuDPWa09mf48Redj2FzX53TYC6p2Q46iS53eVKIM7lb2IicQeoNnQaznCeJaCmv8rO/6AjD3nhZkM840lVDYqLTMIxihJlSJESGw/beNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417080; c=relaxed/simple;
	bh=oHxq0RfYCSn+Ri7S2yKvntEHV9eX/s1jFiqv1G6pKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1nu54uluaX9LugkpjB1dUl+ICd4qkTcziR3hehXOO/MkU4I1ufanQSGuzfa3/QOUsPMp/Ttg8pKuCgdLfiz2UXP8o1lNBws+caW31EeHLp/BDfK7HxIT3FPsqhTRPxmeQ6QAnIA7iQ92r5+pIDWbv9G4OSJtQyvgFlObPLAZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDv8+Fqi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI1ZtNtf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771417078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A90VfYyBvXYfNQuJ+OjztcCqIsGKTH6zgy48JEKhUi4=;
	b=TDv8+FqiJcqEqLZ5cc4Kv1CVsJ/AMCwP8qEtWQ56bHKRlVIgUJnXoyJtqJ0v9/TvEtCxcW
	5ynNedbs6d6iYrAkOfuWcmZCX+kBE9LgXxAK1BNWVBRayOJjNH/r9tMbEhml1bKhgcUGw/
	fF7C64bwN7x9+q+2SjrT+cMshkaKnsU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-8ga64PKeMWK7sRDLcIqw0w-1; Wed, 18 Feb 2026 07:17:55 -0500
X-MC-Unique: 8ga64PKeMWK7sRDLcIqw0w-1
X-Mimecast-MFC-AGG-ID: 8ga64PKeMWK7sRDLcIqw0w_1771417075
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-437681ecd32so4342589f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 04:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771417074; x=1772021874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A90VfYyBvXYfNQuJ+OjztcCqIsGKTH6zgy48JEKhUi4=;
        b=NI1ZtNtfKq47tfUp7B4B/4Nopd97spFXitrFYrF0CFzMycn8+8OP5dhcujyrXYxO3p
         23b8Co/Btf23OS2ZgD4g0DAraP/ChbUy1qQR6S0eFSrMAX2Q7rh1ctHIrAMhKuUGNEab
         htNb5eKYVEDImgZpU7PwH/ENA5orDYPZnXcwvvzh19L3lWuk++SnAjM2pLFa+CBI3Atm
         qtqc9+0/7qI+vIRQaV3LNKgZXaimJ7Cdb+htcsUtLtqkCQOqUhFiTOTk5v1BTiGNRpmT
         AzcXxSXnkVHb5+h3RLjcTw4E4Egd8nTO2JTNQSLdebAMemIZ+tkU4YYTLuYya4LpvOr0
         qQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417074; x=1772021874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A90VfYyBvXYfNQuJ+OjztcCqIsGKTH6zgy48JEKhUi4=;
        b=aCt1Fb5lPCpY7PGCum4gkmDEuVkoWSdCLQuKoflgSDO8J2OeEq8Um3S2eHAK78tmwJ
         RD+v7q0sM8CDnYBckTLTzLoeM1wIEadmLokJv8G1L/yxyCE7owjsJtVmx7l3AnhsOFLQ
         qu2GBTTJB7HhsoxDuft4k7p1hct+mgFVqSZ7UMV/D4xiiD3cfJPd30BLNvTPOovn0NI4
         4J/86If1Nz0kjITXO4elnK+AhlRAQGpz9BgeP7uzBPePX/06QbW4d256mC1QRc3uHOjf
         wUrEdjrhsDFUJ9jJaOo1QylO+JO8efU8fOIkK0UnB/XgKqlwh9YvgB7YpKubt7iRAzb4
         sL1A==
X-Forwarded-Encrypted: i=1; AJvYcCWY5QGWSw8oT10mfVMdIupGWzxvpFUeQYs/gmNGUSv7Wct6vXYMOYad5sqF2t2qYmgyA7LrymAQD7wJeIoY@vger.kernel.org
X-Gm-Message-State: AOJu0YwutdM1Spi3stefgnXGmHjve7O00/7WMrFQOg2jb2ltjVA5WdKd
	6SWCJT6xAlrTWmMJnZSeG5NREeH4y1W8fT1dPGyKn56ST/FSGjYMrdBS+9f6f/jTkgxd6cEv8GS
	hGRfoczR5ksLPkjrKnofWDBkxn3YTPzW4tlnwZykk/nUR2unfsyG430G+/dpSnkFBEA==
X-Gm-Gg: AZuq6aKr62wVBgqaZ2YWww63oIVRyggIQFy3237wYlU0WVTWvh51nWw6a3u4gophgza
	JgR2ph1UOZxrvMGpucacNKup5vus9I+v2ebllCaOewJ3xciIuw2+sBbrgXcxrU6F+tY73ujfuxW
	iuS9gWqqW0N1DzLClqFBJo1vsIvflrTvqa8LoxPMA4p3QfX7Qwq0f0nDThv4UgtojZwH2oEAB6R
	BrfEz9Vs1BC6qwwNfVFaBXolDyTsS7txsKF8hvLOkIPEQisVRoxFIdqfepRzWx17yoxaA4d0Xg+
	cm/rsEzXPaH2Bl43RAo0Fj34wTgzgxY5NhPU1WX/C3xvroS8rB+WE2RANucMeBboPun5f1Jtbzy
	19pnM+i1MKU0=
X-Received: by 2002:a05:6000:186f:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4379db30f9bmr22128049f8f.7.1771417074481;
        Wed, 18 Feb 2026 04:17:54 -0800 (PST)
X-Received: by 2002:a05:6000:186f:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4379db30f9bmr22127986f8f.7.1771417073862;
        Wed, 18 Feb 2026 04:17:53 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac82f7sm45619590f8f.28.2026.02.18.04.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:17:53 -0800 (PST)
Date: Wed, 18 Feb 2026 13:17:52 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	djwong@kernel.org
Subject: Re: [PATCH v3 06/35] fsverity: pass digest size and hash of the
 empty block to ->write
Message-ID: <wl5dkpyqtmbdyc7w7v4kqiydpuemaccmivi37ebbzohn4bvcwo@iny5xh3qaqsq>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-7-aalbersh@kernel.org>
 <20260218061834.GB8416@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218061834.GB8416@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77566-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7C201564CC
X-Rspamd-Action: no action

On 2026-02-18 07:18:34, Christoph Hellwig wrote:
> On Wed, Feb 18, 2026 at 12:19:06AM +0100, Andrey Albershteyn wrote:
> > Let filesystem iterate over hashes in the block and check if these are
> > hashes of zeroed data blocks. XFS will use this to decide if it want to
> > store tree block full of these hashes.
> 
> Does it make sense to pass in the zero_digest vs just having a global
> symbol or accessor?  This should be static information.

I think this won't work if we have two filesystems with different
block sizes and therefore different merkle block sizes => different
hash.

-- 
- Andrey


