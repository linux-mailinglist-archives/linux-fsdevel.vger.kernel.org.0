Return-Path: <linux-fsdevel+bounces-77143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id klHMCkExj2nQMAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:12:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB5136F9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 15:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FF0D30EB7A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04D535F8DD;
	Fri, 13 Feb 2026 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="opSMYtr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147835A93D
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770991495; cv=none; b=SzS4hcCacgJkenbu2cG78oQP0Di8azLkmhRSqYMGgMk5fuoqdSWvTS3muZL5quBmy9w4w3WlbHMX6thRGtDfbmtBq20tQtWsMEXabkp6Ht2aMW5SZgMP/y0XlOSwZjOaT2VwDAy9wP5qUPf8PP1Z5XkNA2hwOaSKvXA9Sb7hHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770991495; c=relaxed/simple;
	bh=UNLPzY8JFs3m+p/4K1jQF1/vnb71y/aulIlYtpFcVHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1yd1eKo89MX0Xu5kpRWd97eOuYUYGaoRltmoUoQ2gS2YT0EhYecKg43neG+Xsgd0ZScQxEXDHs1jU1GFty8zxY2Bg+QaTjGz6DsduSmmxCv6+ZEl4UBZApudNqT/EORwrtmWzJPTNMgMqcYq3dTmaagSbhZQkVqtQxR4mICnxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=opSMYtr5; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-506a1627a09so6125931cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770991492; x=1771596292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=opSMYtr5U9pthmrYKeiGERIP/xyFxclEAcaP1OI8KLpcfOM6szpqW1coA8vMiJOFD/
         06n7VfmcaJMpILAbM6KOJyvEDw9bTfX4sItyI62UfhxXxji4MXJTYpuHkoqqyoHZBOpj
         xprpqIY6aBSZCzU3h2b5HGqCqyoIkC5LU3ijglct/+++ppA0juDNakAhPO9+n5eNDvkK
         j4EoDbcCzsOsqq99SPBdUal2kMZBoDbiDA4ot9Xi2nSZVWXnyXfp9Dm+tygZ+5TTpN0L
         99vU+OSW4W+F1rTEVhqhSaVql7UI6e1dRNL3QT4A00qcWz9kTtUC5M0ac5CE8yMJQFdd
         Zhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770991492; x=1771596292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7HcHHO+WcoSrrQ3nEIW1ykb//ECy2ZkTsyQF8ciVO4=;
        b=X5DfHNq5OMC3vvCh3K+nshulTa17Td3DTAMOaFoq8tD3sOcR7FHT3H06UXhV43UWhd
         b//KSA9upeq33R+spNt6WTxW7zif0Hu+pApSJeS+TIf6Pmf9dDvkAE1h3YKkBbXrdDin
         Uv/lY8uwICo465dXbdnAsVoEQJYWFx9FXHgF+ImoKIV0TMOf7WfO/VkrjD0mcBfU9PCv
         AMw2uZQQPudJJwfQ04+qhMKARxBKZHSOwUYtDCRSuNsqjQTtM7BIttJWV/H3xdfea07d
         XYfvYb4hGNlnUhDNw5dNBld3MjRLAhGoQq314wW8WEjZdE/K8hzRVAD6DLMhSRa6oeiU
         jQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVeSrQUWgEoVLiRA3BzqKyIPCGxPJACENmnrvDpnXr4C6uAh7QnH2mevOFMamCKT3LK7YX/ouTvRnvOtIo8@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRebCCeE9bJU+cjZM7OGO2IULXUJFLTaK6ONIJdNKBBVJ8IIx
	Sj7T+n/Xp6BXivh9OhtA3Np3HO7+Hp43utmRY89qJowbx1QHZu3za0rd2NMIzhpoOTA=
X-Gm-Gg: AZuq6aLmJYEhM8wi/S5vh/Vgz0Coet+U3UUIKkFVlRWX29HtfrOWEazSt35q93KnR5A
	BTAVtcMzk51izJtnpPJe2Fkd13cc089I/OFOQl0HCHqIADsxL8zz7HrvPRrTsMBNHbrt7HajqZ1
	SQH7mDk3kjkMk83l5Wnj8QFG4Rjy5edB0QbTxIvAEBXcoPimNtFYmxa9K4SvYh0CG+6nMG3Tzw9
	75Q6+R6l24LAQTlAo+myw4oqj0UrDu7D56k2R52D5WJIhwGVodnIcMu/O4sjJ+6mKJEjRcfPuTz
	RWw+R21z3XUbzaB3arkg3GTaem9smk24hBfUXruwH3VrBO9BDgKf1Ttuds44cHmrcS7JoibaFMl
	jf8J0FkGPFvUF3fbCfo0UrsZQdSotYHLwyvT2ZxWIVci/jwlGMP3/bMx5mxxvqmaIxiZSzD+Nva
	7JUEF5Qx7D08NsIsi5xQQ23HhcdsmJQsvMd9g5Fxaq7rFOTwT097iglpAdTsc3twllsmq/XNDQT
	zX4YP2tFA==
X-Received: by 2002:a05:622a:204:b0:4f1:ac12:b01c with SMTP id d75a77b69052e-506a825a264mr22509531cf.3.1770991491488;
        Fri, 13 Feb 2026 06:04:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684b94e9fsm60689721cf.24.2026.02.13.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:04:50 -0800 (PST)
Date: Fri, 13 Feb 2026 09:04:47 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Zhijian Li <lizhijian@fujitsu.com>, Borislav Petkov <bp@alien8.de>,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: Re: [PATCH v6 0/9] dax/hmem, cxl: Coordinate Soft Reserved handling
 with CXL and HMEM
Message-ID: <aY8vf75vVQ-poVBN@gourry-fedora-PF4VCD3F>
References: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77143-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,intel.com,huawei.com,amd.com,stgolabs.net,infradead.org,suse.cz,zohomail.com,oss.qualcomm.com,gmail.com,fujitsu.com,linuxfoundation.org,alien8.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35CB5136F9C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:44:52AM +0000, Smita Koralahalli wrote:
> This series aims to address long-standing conflicts between HMEM and
> CXL when handling Soft Reserved memory ranges.
> 
> Reworked from Dan's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/patch/?id=ab70c6227ee6165a562c215d9dcb4a1c55620d5d
>

Link is broken: bad commit reference

