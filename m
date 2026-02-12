Return-Path: <linux-fsdevel+bounces-77067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DdcxHPFojmmdCAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:57:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC17F131D8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 00:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0EB3084BE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC82F25EB;
	Thu, 12 Feb 2026 23:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8dUK+eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CA286D60;
	Thu, 12 Feb 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940648; cv=none; b=m24lo9a8xulCFdm4wp1fzp4IEBipPCmzgvfBSxv+oCVrEivTDRkPJURebyCdUo8adpskrKcTIyOBjXg6TreMLgUhUXl/mwFCfjCDhYieG6ppo6MHp2+dA/RPoGczO7pf5YyEkC52WgWxu7RKYmaagLK8HExBKhS1UD2f7A3pZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940648; c=relaxed/simple;
	bh=qH3sZOAXgsUDZ09GEG/CPzjzapOeWhbOfDETc9hIRVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7HodA4Gpq3tTpBn11+dwPaRsm2flxo7Po0iFvuf4z/9r7Vr6T6Y/oJja+7najYBOTiC6rElnepfXoSlqx95ob0vwVzT+5xYABkc2CMWyiiBomKSacu02dQTRmZWvnxy3XBpOyIENQyuWIAkcEMMQvW6bLMXDVMKu//c0GFveAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8dUK+eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A2C4CEF7;
	Thu, 12 Feb 2026 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770940648;
	bh=qH3sZOAXgsUDZ09GEG/CPzjzapOeWhbOfDETc9hIRVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8dUK+eVatdS5vpKnijzt3yXjpo4a1kisPNMV6Nj89YrPja2m61ACXdWvBHURZEaD
	 BEfYrXT9BR7U1+yaiyVHk4YUOEC0x0h9Qq+md7gpf7By5/rHIhpCQYwTEdS0WZRVHe
	 G9w9+g6xy85JEtNj9JkmpDEyBJlI0gXfU864RlU8t2GcqBezA9IiC83UG8w8rau1by
	 OKGS7m4nBKOcLRflfVy8bS5n+CsDQKjB4VIyokrnxFHkBBnKbuHyC7sRSLjcU1Nzzq
	 uh+MGPtj5UN4kwaQuj8ggpZf+UTg3tHTHMOHQIg2YEF9p/Lc/vwFz0CUpI+GLYYAHq
	 0LuO6W5jzs+8A==
Date: Thu, 12 Feb 2026 15:57:27 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 4/4] selftests/exec: add test for HWCAP inheritance
Message-ID: <202602121557.5C1249F@keescook>
References: <20260209190605.1564597-1-avagin@google.com>
 <20260209190605.1564597-5-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-5-avagin@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77067-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC17F131D8F
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 07:06:05PM +0000, Andrei Vagin wrote:
> Verify that HWCAPs are correctly inherited/preserved across execve() when
> modified via prctl(PR_SET_MM_AUXV).
> 
> The test performs the following steps:
> * reads the current AUXV using prctl(PR_GET_AUXV);
> * finds an HWCAP entry and toggles its most significant bit;
> * replaces the AUXV of the current process with the modified one using
>   prctl(PR_SET_MM, PR_SET_MM_AUXV);
> * executes itself to verify that the new program sees the modified HWCAP
>   value.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

