Return-Path: <linux-fsdevel+bounces-77705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKNvEX8Jl2nvtwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:00:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4E15ECC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 14:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1903D304C076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A9433AD9A;
	Thu, 19 Feb 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOEglM03";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCa5jAhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED443093D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771506017; cv=none; b=IyMEpxd86EUaPzM1V635o6B+jw6GKLhkhXpeAk6jMoDq2+83Hi4q0Sy5U3jvMz0VlmHglDeZz5e8MEewurj4erSP/C+LkT+dcInGbQf8/rli8l9KVJVDJqvmwV7pLLIxwQspLqf3ay5Xl6BGNuPRNldg9+w1CQe5tRz4yxy27lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771506017; c=relaxed/simple;
	bh=hlu4srWB7+MTqqrrEztAIVIK0Nl3yD8y6slEbQdtLUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4dEyEOl7RZnw7EwKN/mf9HyVQKvO2NHWRMkaj9dspB9/vmO2c5gX7JAcfokIHJMRVZLxMkcpOG43ZvB7Y6OzgFr8xhEYOMMFEZhX2PnuRx0Qbp9X54Jwt0VbIScyKfREopxW70bhBCiyleoPKbj4hu6YK5XuTSkfklS1mKNqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOEglM03; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCa5jAhK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771506015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRdmcSb5fRzx6pFuColKu/1eTpEZSmutbO/RV80LleY=;
	b=YOEglM03njEkyNNheIA3lWvSyRMPyPtVfyaHlito7O3mcFwvk4SY9ZcyhTAv7oPA7bUaQs
	TERtOCVak21RcoC1dO7zPEVW6idwDEJOCVmHShd0nl581XSWVndbSq3nKfXNe5w0iMDiwd
	b2OyKXl9w7YXb/gpC6l+iyZfJJSciII=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-t6HQcbtQNset5GCSLdGLAw-1; Thu, 19 Feb 2026 08:00:14 -0500
X-MC-Unique: t6HQcbtQNset5GCSLdGLAw-1
X-Mimecast-MFC-AGG-ID: t6HQcbtQNset5GCSLdGLAw_1771506013
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4837a71903aso5725735e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771506013; x=1772110813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YRdmcSb5fRzx6pFuColKu/1eTpEZSmutbO/RV80LleY=;
        b=GCa5jAhK+QWrPhYS6nxhEgWcPuYIyTc4deUx0+ECJREvSEkdTyZbPUUdE01DXQ8/ei
         hnNWRPr9LN/DEvJ+1lcR/KVKvHsEsu2sOGktv1g0mA48Dh9FyQGiiKPZvpMwwqL4vz6x
         RzCgCSU0gaXfffhqoeAS4OZA78IYti9wt7tPHGOgQj4jNFcuRNM5NHFhBXl2I3P+qYMv
         bjEXZ1wUZvYbYrqS7VyJd38XXAbnpZ8EIZ8DRfFwr4jlFTwmbY3qdYDCQByOw8E9ViGW
         OtKNlOJ3kawVveMOyeoVkqNnfpJJQFJAoVUyjTqxZ/hTACaQn9nbgXEsypIrKmZPyIHv
         FRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771506013; x=1772110813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRdmcSb5fRzx6pFuColKu/1eTpEZSmutbO/RV80LleY=;
        b=tJv1pwb6MkMs9R7prIgaZoi98fnDfuNLS7kfrNA9KjZohkyw5ltatfuVQmQoYQM4+X
         nv25ygEeeqCyEwvhyIKoajBJfYtx1NqqSASoKezyVOZXqMwxXKBHep2mzWfcd+6HoAN1
         vdwdJ73/HYR3W3CkvXhjEbuzyCnse51u8nPsiRz8IJEkCcltObjV68B1ptR47FytOJuC
         5DLe+9rWneHNW08ZZu3jy3pIjsPWPIbHN/lFmMaART92Xx46VZBLJWHATqfDn/Lw43ZW
         k4Ho7mytI9npvzL5P9ncBqUjAqvnh+FywFEarlIdeZfu8I9f3UeAwEzEDck6g7nv05RD
         7tXg==
X-Forwarded-Encrypted: i=1; AJvYcCXu82ftKDrngNknxT8pb4x1nbzrdyeq7iDooKF7aCL/adCWGbimesLBk4aEyrXQ3OGfwloI5XD+maGTIfh8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XEmOSfwhEndducwXbDgYjU1Cwlx5e30BNxjzB3l9alsRff0x
	44+aNczTbKEIV80H7/r3QuXYlR1IIDyx8klLJuPGu4dJ1cFxFommPDZTiFu+kE/SIc8+KeENaa8
	qFiKKWMnzmovUB4d3KL9KIL2NTZjw2cD0Mwr63X5HFD0dIDFqqbgTyyRiWavQEdAh7w==
X-Gm-Gg: AZuq6aKCBKsJ11irUQYNHvSWuohKR8Z0y07Z0JVUtqHG4/hd6Oh7lbiS2c2sGlG38Mu
	2ZxctPwHC1v066Ju7WsuT0nY72b1KuaTvjPQrRFFaj7tX2I1CZ3HWuCwCGfVIUGQiuQksG+cz+0
	NpQSC+S6LZ39pMMwat12MgJ6at/xWzaAWw3t57lnviWKJjli0loKmXt6KbLjyYLkFMFnd8Xtpft
	P2NkVoF2VSDoQgVrqALA3G6M+lL/icexgc9viD3kRtIdrzaxs9OfPoRKZGcFvUwNybCDppnZBXr
	Euwpb56hlVtoJVO3c31mniXmINS0nAjWf9yIm3y23CPX0ziqySZ9NuuVh9/Sp7PAl8ehbFDzgCN
	T0Vdqhn1sW6U=
X-Received: by 2002:a05:600c:8189:b0:483:6f37:1b61 with SMTP id 5b1f17b1804b1-48379bac876mr281468035e9.4.1771506012853;
        Thu, 19 Feb 2026 05:00:12 -0800 (PST)
X-Received: by 2002:a05:600c:8189:b0:483:6f37:1b61 with SMTP id 5b1f17b1804b1-48379bac876mr281467615e9.4.1771506012330;
        Thu, 19 Feb 2026 05:00:12 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f9835f9sm16027655e9.19.2026.02.19.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:00:12 -0800 (PST)
Date: Thu, 19 Feb 2026 14:00:11 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 04/35] fsverity: generate and store zero-block hash
Message-ID: <uty67fmpx24hs7ecrgb5ewjhdwl6gxcwm7mosfsfstl5ir47qr@52amkzbbvilv>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-5-aalbersh@kernel.org>
 <20260218220433.GD6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218220433.GD6467@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-77705-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 9AB4E15ECC5
X-Rspamd-Action: no action

> >  
> > +	fsverity_hash_block(params, page_address(ZERO_PAGE(0)),
> > +			    params->zero_digest);
> 
> Hrm.  At first I thought "Now that xfs supports blocksize > pagesize
> you actually need to compute this with a zeroed folio."  But then I
> remembered that merkle tree blocksize != filesystem blocksize.  So I
> guess as long as *fsverity* doesn't support merkle tree blocksize >
> pagesize then this is still ok?
> 

yes and this is hashes a single merkle block from the page, so only
zero_page will need to be updated to fit merkle block size

-- 
- Andrey


