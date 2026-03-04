Return-Path: <linux-fsdevel+bounces-79449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJVdAJjFqGlaxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:51:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF19209265
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F8C3011845
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 23:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7C36EAB3;
	Wed,  4 Mar 2026 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuBR1rSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C635E939
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668203; cv=none; b=RUhbm72KKsIqJZhAgo1DOEi8G4dI2uSheaCQVdz54qGxAeSzF0PYTBpMFUd737S1R9Z1rO47SpQgKO5b6tgOBm2G9ekmSmu7LXyIPh4pwHzDHwuMtqs6HgmNQiVYUaa6Poel2HoPDdLh0E9o/M1JuFMDka4t4Y1FWquFRaSywpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668203; c=relaxed/simple;
	bh=mx3kVw3Nce2fnqk8JGthU6qFDOxZAiVzljiCAwnxHqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFR2pXbc+jVxdllPGeLrZ754526Idm5euU6b0f1Ea1gbZFJ85T2fh9Q0fvRl3QnoYnhmnK84wJ1uxLtOUH9adik++PG27G/W1hVKCEQNdBS3/jOWqK9MrgVDR+XBAWmfiwQXC4N2GWgO567G+unwLnRrxetyAzO2pQg6XGrxTI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuBR1rSj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829756f3ee9so1014733b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772668201; x=1773273001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LpT6Ri1JZ7zRc+gH8Ikbp98R6plbM/rAdu+pRzYMoUg=;
        b=CuBR1rSjkdXT4J4RqpAyzCSXKDEswPms6ww5Ld1bIFI57sICITuAAjGFmopS/hRLLo
         qBuufaFUg3JQ+s+SEkUE8I12CAK4uc12DZsLkpkJZatTBbjCyFsJeeiryZaaJHxSO91x
         zwRant/k+6vmbHMBkBiE0Lj4LASMErMmUGOQEr1kUepiaV7/hNoYsnpl2kCTpNl2FIsH
         ANxYwfHKfoB6K5v7EWGbksXEKU/H6Bv0tq8fuZBbmGtCsIi7GgirXpBjBynQMX7ZZwVC
         /NUZgkzZWkYIpmMw1Ylo6BXfzm0DurEV146RlcAUDA7uqQfUKhgFC1Yt01IYw1sC6I/a
         zlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668201; x=1773273001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpT6Ri1JZ7zRc+gH8Ikbp98R6plbM/rAdu+pRzYMoUg=;
        b=BT/0vclHKQu+UOwEd8HWFxqHOmNgOWqU0sSFOik1ss7SjIY/tcSliVmNEUoX1bKXla
         Nv9jm5M9tppg0uKDkmhqJhj8oU2JEjWDHgP7fZTxTMVRonjq9FejdC9wkH9k+LINQBEV
         FRCxQiGySaWOOnR8vN1KA9xAZw89aKVlLC2qzte9eKWPFQ2vz1GDGcwAQnWIImRC8e2u
         L9Flen0EQQ6/c9zGg5RclQGGKSjI0aScQLqpYjLDbnDNvx+9dC3NQOfK80K8P9F4Ig7Y
         ublSSvdpiqNSMcHRqI7IVdWlwSUqayJkrIX2DmCUu4yVzY37miv9uJQYXeOHuQibG2Te
         DVFA==
X-Forwarded-Encrypted: i=1; AJvYcCUHTI7jHs96kE4fV9S0xgvPn1krfiZcpRhDrTYuhTA3JA/lJdWnwgj+HqgGCOaQ77yGSky13UwP7bp229Ht@vger.kernel.org
X-Gm-Message-State: AOJu0YxQw9zCEbDkRUIEWkj7kkRXrJFDDCaxwF6OlcGpuOog5IXDON5X
	cLAuEPzHg1xzFp76MJItUnwQtRJBK9XhWHGa8T3FogTN8LZsypmpnMxd
X-Gm-Gg: ATEYQzyFt7fX/ihUp/729AOFZL+zkZtpmCt2aBmyHJo4E9OgxeRqlfRsM5K9i6cLsVO
	Pt1wPWuQ7hpbulrotHLm+no+RyEOZ2DOJgznlDNwvLOj9PuZeYw3BDDXwDYEsF2q96gsvEXHOwe
	Yf2c+Ck9iNP8fhSDupYhvfEvLviCeV/pvNEkYD6D7CJONrcZXk5UwBUQcurYGlQz+il4f4IPDKM
	RLTtyKjq9RBowNggkil0TuQrxiDGeuGrseXS0VoQwNytVnMOH/dJ9FhnbV6uMe8pR78KnVv7oIH
	icn/4oOLGF2RhwDhPcq8A1S73Kik/OhsX8CEgohRKeute19SYhvdXpasM4KntatI+2BfxHCnPD7
	pLdrGRuX6TLr8Q6ccPkzxnpnFPLJqRJSObPOwZarwJS8FzNnfXV7OBQ5DFavO7DPst0lDi955US
	N+/rHij/CHS1Z62Q==
X-Received: by 2002:a05:6a00:2ea3:b0:81f:9f1d:114b with SMTP id d2e1a72fcca58-829728f04dfmr3382088b3a.12.1772668201369;
        Wed, 04 Mar 2026 15:50:01 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm19312223b3a.8.2026.03.04.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:00 -0800 (PST)
Date: Thu, 5 Mar 2026 08:49:58 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cheol.lee@lge.com
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aajFJu2ev6hAHKuA@hyunchul-PC02>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaguv09zaPCgdzWO@infradead.org>
X-Rspamd-Queue-Id: 5DF19209265
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79449-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:08:15AM -0800, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 05:28:07PM +0900, Hyunchul Lee wrote:
> > s_maxbytes currently is set to MAX_LFS_FILESIZE,
> > which allows writes beyond the partition size.
> 
> The "partition size" does not matter here.  s_maxbytes is the maximum
> size supported by the format and has nothing to do with the actual space
> allocated to the file system (which in Linux terminology would be the
> block device and not the partition anyway).
> 
> >
> > As a result,
> > large-offset writes on small partitions can fail late
> > with ENOSPC.
> 
> That sounds like some other check is missing in hfsplus, but it
> should be about the available free space, not the device size.
> 

When running xfs_io -c "pwrite 8t 512", hfsplus fills the block device
with zeros before returning ENOSPC. I was trying to fix this,
but as you mentioned, I will look for another solution.

Thank for your review and comments.

-- 
Thanks,
Hyunchul

