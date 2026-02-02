Return-Path: <linux-fsdevel+bounces-76086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHUCMrv4gGmxDQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:19:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5CD076B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D558B301AEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 19:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49A2FDC55;
	Mon,  2 Feb 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U2qNsPFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107C2FD675
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059955; cv=none; b=FSjPNFWwMl0iKn75a/pILLq/xE/uu3ukQipgusdyJOYXzdr+35GIWxwgpScFMVQe9T3vdoqaBLgnttfzcZKzqAhhmW+OoYAsiefH6eKnVmi3AmAU45+eSUBmkkW/6PJwRx5YC3Z6WefXxfRO9DBdNpclMOD++BJsNKDcULDqsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059955; c=relaxed/simple;
	bh=0x7jvlrx5XFJyx/jKqbZh9Z1RPvxu1cgo/tyO/MM6oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R15/n+nF7hkcuI9vygesnmCfi4cw4HVE5t6dE6GNhWcOOVA3+XK3IpEJm0Sad1VwxsQwPtfWMl9EYtl/jvr97ee7w3TijO4RbjTbxfG9skwWUIOmLmwSks/9hgSHZ3QkDT1MO4lG6Uq6h1Q/015aLmIi3z2Zv1qqLmDe+iFHKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U2qNsPFN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-894638da330so49170206d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770059953; x=1770664753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=asmdN+eKpioswtzM18Womc5lL+dXDrk6p42YTES7X6Y=;
        b=U2qNsPFNBQhv24mlITltEayI08i1maVSDm8ByplOD+la0RGDSjY8Mv2H9n2daDnKOl
         xFGqK6Nb/SYf/KFQV9g5T0gvLgrWXOj0rxnNJHB5sOxcIP+uYUeTjRn/gdAeb7GLnWwn
         7HycReeNfTp2wqqE/Tfi3ogmFcyzVfMfWgVOyj/zWwFEN7elO76wfdRDZdPfhnnsMaXr
         FiWQpHKejx40v20H5vZ12+Z5NhinnT3aCZeXMaWsoQnruq6PiIKMdLczMmxPpszpCTxj
         KQfbsDGCEIgB0R96PatMSsngQ6AxnEQ0DmeIQ6Z5vAXVdsJHEoMaBEQ/SbsWFlsDrIeC
         6INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770059953; x=1770664753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asmdN+eKpioswtzM18Womc5lL+dXDrk6p42YTES7X6Y=;
        b=Mh0CK81PfozwBz/3ngHI9YKAomHTHg4wjm4iUCq1jL+HWgAyHFLGyY1qtBZDtYE29J
         G2a2wGDhdc9ohsju7m8KwXrufvQazN9s8KJ5Lo35i/gmDLkWPhLfDtF2pz6RbbPmQaJT
         doBZYkG+0LB5n3ZlqObjLOkQN/d9TMZiT7dF0LQsjHYSHRneRcgCtrzg9pm807oG3WQi
         VPkp1HOd1rG5f3QcCybFu1K9rU/3OJ21BQDGP6/vvIh4yoLSlaSjWwnhuF1/Jjnrb2gu
         AYMzt1rAw8WVU2LpTWMsG006UeMe+QL+LKjoBEKAjlLZ3h3WFADpXRn80TFhRYhtSODj
         ZOpw==
X-Forwarded-Encrypted: i=1; AJvYcCUr1RDyUiAjG0qte0/910FMSHih8pki5NLmphtU0g5+PDKMxY6/vYy/VRezjmQSFisQWGAKw7rtKZmu56K3@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJd1ka+IUvRBxsmMhNzDnUgOhUT1YlvpMtQlMeHYRc+hpwwNS
	PC0sCoy4MBtTd3DLXmo3k3H4GJOv7r8DpvkbtthsPcIssz6wTOVElcbBtbKvKiD4u/U=
X-Gm-Gg: AZuq6aLOXJWyaBLVYlxuACyd0np0NF7d6cz48jyZPp9o1bRmczMOeHCu5ylJYOq1j7z
	IFk2THK61hwSO2drO0f9qna2OsyFqVCAxACL9JfzS+uLXuW/Lt1XAfifdjl0gGxtyET9IsRV5XO
	BcCsB7finUW+AHeOEGsee60u/cL7DqF6uQWFfpP+u9meyv3G9Tc2dyRu1OfUDZTPW8dXs0SKtpZ
	18eBGi63YknlsH8UjC4HTAqDt0IweBx8mcQbX5ZV3An0e/Tkv1h68JK2lvreWUf50gVHxg+dNop
	0o4JSLqnMvdsJC+wxGzjgkF3tec8eu3T4KJhS1woymHAkJOK3GsoS0cPNXHb+p/uFHXmU7R/lqk
	XfJfuoaVY8A5Y5lmcxfSa6J02WVD56dswaQaipRBCjma07vo3m5+wLuNhD4T3D/H+zK01Kd2Ym4
	4zc3olshyxmS58xw9lKaDJdYSZjzw9W9dyv7iNEf/m66uEw7X63ZZMx/fmkhngrfmbcnEE6w==
X-Received: by 2002:a05:6214:1311:b0:87d:c7ab:e5d0 with SMTP id 6a1803df08f44-894ea096c06mr178827036d6.55.1770059953093;
        Mon, 02 Feb 2026 11:19:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d2889asm1253553485a.27.2026.02.02.11.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:19:12 -0800 (PST)
Date: Mon, 2 Feb 2026 14:19:10 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, willy@infradead.org,
	jack@suse.cz, terry.bowman@amd.com, john@jagalactic.com
Subject: Re: [PATCH 8/9] cxl/core: Add dax_kmem_region and sysram_region
 drivers
Message-ID: <aYD4roMbjyBkK9l5@gourry-fedora-PF4VCD3F>
References: <20260129210442.3951412-1-gourry@gourry.net>
 <20260129210442.3951412-9-gourry@gourry.net>
 <c1d7d137-b7c2-4713-8ca4-33b6bc2bea2b@amd.com>
 <aX0s4i5OqFhHkEUp@gourry-fedora-PF4VCD3F>
 <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9652a424-6eb1-462f-8cbd-181af880f98b@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76086-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFC5CD076B
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:02:37AM -0600, Cheatham, Benjamin wrote:
> Sorry if this is a stupid question, but what stops auto regions from binding to the
> sysram/dax region drivers? They all bind to region devices, so I assume there's something
> keeping them from binding before the core region driver gets a chance.
> 

I just grok'd the implications of this question.

I *think* the answer is "probe order" - which is bad.

I need to think about this a bit more and get a more definitive answer.

~Gregory

