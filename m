Return-Path: <linux-fsdevel+bounces-77704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBeKIQ0Gl2kttwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:46:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4514415EA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 13:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AE08300F10A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2692C11DE;
	Thu, 19 Feb 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F59AzeiC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gseHg9kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F41A9F8D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505160; cv=none; b=shFZ9MwUBCrJFMAdF5y46BpQcQcOJIyK4ezr8j25D38dvYNkytrUIyOp/sev8qCmafdMtnCRPJc35ottDeJoyoeplEyXo0lsQNPxhK27vCoaHUTIa10n1n0Pt8goYP//nTJCSjwh/Jkk0kFsMn5arQQ6ARsS++J4CXNl3xwOn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505160; c=relaxed/simple;
	bh=YZj+GxGcB2P5EaA2DiPIK6jUW8TyBkFDHxcApQg7DBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6dY950kHSwgejyRwJSlMEQR1ZPDy0tmq5lK2n8YuknHgI1khE3dzgfMNf3cQesgkl/FtZenVcIp2XTQd+lsuCKIreuHkWfnHjqnlV6qmqQSGdsNaaCQKG2VTT2VjAzRFPeKUvbT0UBAIQrCriBA6AKhZk/VhVKXdVaantvnF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F59AzeiC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gseHg9kZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771505158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAt8PmrU86SKVM1FRxExfTh0czVVLlWni+dAt41FBrg=;
	b=F59AzeiCk9/XMVaxWOrO+TF2+xKB+1DykIyG60hZM3aIpZlqu7H65pbnCIMh4nOZ5OpXh3
	lTv94NefeRJmx87f71RuSghkQiXlKD187rOw9bjFiNwej7R4TI5jFYPTo6HHxaQmZVzMx+
	GwsO9z/F9l6Eyw+P9DjQLRCK0fHbD+E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-49h5rkHbNsan7tTvWBJiFw-1; Thu, 19 Feb 2026 07:45:57 -0500
X-MC-Unique: 49h5rkHbNsan7tTvWBJiFw-1
X-Mimecast-MFC-AGG-ID: 49h5rkHbNsan7tTvWBJiFw_1771505156
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836abfc742so6164765e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 04:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771505155; x=1772109955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HAt8PmrU86SKVM1FRxExfTh0czVVLlWni+dAt41FBrg=;
        b=gseHg9kZ+w4ihgPM8OLhqC6nc2qnvoBiZOvTFE9i0S9r7ucwgJ+5C+scJRND8sofJs
         VNge/b7a5fcESPOdb3AuOfLWDb0TQ1oWA/9D6CzampsaeFOk9DC3X/D2vIGxMUvRXVm2
         qBB72CFn3rYcej9aDg1PwvxU+JAyhO+u5C5i14dedmkhKV4Al7fkkSYV5RYQMJB9AZj8
         JwsJNWn9z5NFxOpGT2rPamt/PcEbjWIFMKtB2JdORsnUx2I+SypTPM2sKPEiixpXWqIV
         1WuWMq2oF/SkWtbm4S9xpc/XwhaM5dui9Ocd/LlbgTGPQThe+iW8mg7itwqNdeSV9saX
         l0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771505155; x=1772109955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAt8PmrU86SKVM1FRxExfTh0czVVLlWni+dAt41FBrg=;
        b=XWQFsihXA5ywYsMGIinnEV7EvnhVjV488ObZ5mXKz6rrJ7tV4uDZBhOJRd3ia6il3/
         x08CQBh+3xQbsH3yg5ZbvNpE2xBMI1MKqQOywybfFi0OSXIVJ7fLSVuVpG/5eNMu0pEf
         JZTNN1LvOOtD586702FRdLD9U75p1aozhZWHTDI3o8jxwaAKamXXHTMNg/aFo+v/yef/
         Ufgi4Y0FtqXUcZKWrtDC9/KxvEv+O0S5Y7zk1z+zo3JwZQwwnrWAR44mQ2QotFrV3FwT
         9IVaWj9jrIg0LFHIPyo6/pbGD5FM4gdUI4FZnLV9BiINqkqpe5ktC2icLj7NV+Q9hEJa
         NXgA==
X-Forwarded-Encrypted: i=1; AJvYcCX3DlbQhjvulnW4BtYcar1PWdL7qI4CdZSqEepesqYGHYX8g8JKoyIsS/ZhbEI2wKkLipIOOhimSUz2VrQW@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvctFbP/AbthjY4+IKrHd2YGHfMXmonG4xiJ8WcBJ8u1Upb0O
	09u2PLwpb8T9a2YYThEb+Kxbt+jpXTo+Jwsd15+4eoKWA755cpBUPHgvl+FXMSnQ/D42busi4Ma
	QeUnlM6Gff5o3G97b7khyvRhiCqP+l2xqCuvTlo6xrAcgdyW2OfAZWoHwRAhyret7yfH3WZ5/fw
	==
X-Gm-Gg: AZuq6aKqrBQiv0leVbYDjonbdOiTUn7gke3zQBq8b+qinxb+78E+PC8vjPlmv/wEuVW
	GmKPyXuKOezNVO0fDlnkNKxxzAIUrIU5ZEBL+Xy3Xwm3OiyoPuDrCMV7pdvmoFHp17Ut3Y61g4C
	X7AI8QI7oJMYlkJe0BM07nv8dK/yUOZ961O/vtx2dp36BNp7rk3nxt7q3EMIS24et6cD9wVbyfI
	YmEoC9xLPu9+wZ9oMuks3RW9Im8C4vcc0MZXLp9jBIQh7iLl30JU8Ajay+7PoxrWrrLCHPdOHAa
	RtB+BDtyPmAuhBXTlGVrfZfExtftwO7EirHqjlB7Y5KyDyw5ZZCw3Dn4hY6e72BEYIyfaVbHWvL
	47Yj9MfP80xA=
X-Received: by 2002:a05:600c:3496:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-48379bd72a9mr274885795e9.23.1771505154959;
        Thu, 19 Feb 2026 04:45:54 -0800 (PST)
X-Received: by 2002:a05:600c:3496:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-48379bd72a9mr274885405e9.23.1771505154517;
        Thu, 19 Feb 2026 04:45:54 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b1712sm2281905e9.1.2026.02.19.04.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 04:45:53 -0800 (PST)
Date: Thu, 19 Feb 2026 13:45:53 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, linux-xfs@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de
Subject: Re: [PATCH v3 05/35] fsverity: introduce fsverity_folio_zero_hash()
Message-ID: <rxgelentzvfkgygsyapfylqaja4dtpyh5v3yprjw4ay66bmmwc@koduf7u6tfon>
References: <20260217231937.1183679-1-aalbersh@kernel.org>
 <20260217231937.1183679-6-aalbersh@kernel.org>
 <20260218225303.GE6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218225303.GE6467@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77704-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4514415EA9E
X-Rspamd-Action: no action

On 2026-02-18 14:53:03, Darrick J. Wong wrote:
> > +static inline void fsverity_folio_zero_hash(struct folio *folio, size_t poff,
> > +					    size_t plen,
> > +					    struct fsverity_info *vi)
> > +{
> > +	WARN_ON_ONCE(1);
> > +}
> 
> /me wonders if something this deep in the IO path really needs a stub
> version?  Otherwise this looks ok to me, in the "vaguely familiar from
> long ago" sense. :/

I thought warning would be a better option for iomap. I'm fine with
dropping this.

-- 
- Andrey


