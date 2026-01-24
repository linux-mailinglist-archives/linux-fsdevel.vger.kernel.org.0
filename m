Return-Path: <linux-fsdevel+bounces-75357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ofNWNa0PdWluAQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:30:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2E7E740
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0766E300C811
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4922157E;
	Sat, 24 Jan 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuhC8Tt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF8243376;
	Sat, 24 Jan 2026 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769279402; cv=none; b=ZNPHr2Pa+O7ZW64KYek0k3gsMQeNL+oqMLs78R49Jc4FT69yti7j3ca5K17BN0imm7Hr2igLb5GrwTAtkH6SvqoQRYmCVHfFqGnd3V+koSxZe3FO/O0A+F5R/zW9uRg5Ifxl4zU+GMr2FwgLmLNtVxrswsiq/HvyU7SyJmdcAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769279402; c=relaxed/simple;
	bh=s8IKxwWsXucua6wqhxMUTVDlcpMQSm0GFKQUHS7XJds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSRBmr40hHT3pB5SeK6w+Ni9NpYR5N73ftpLzVLXcKFUILbTdN3UU63XD3OaaSm6rgen/zLBITAOd09/gFLMbFFEk/kbFWpWPiXp5dW6kQEt4Z8YjgjqGolr9FGyYpCMhJEOXKrGdQKAECfaal2goh9JqzKcW8FQKXQqOe5gEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuhC8Tt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BAFC116D0;
	Sat, 24 Jan 2026 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769279402;
	bh=s8IKxwWsXucua6wqhxMUTVDlcpMQSm0GFKQUHS7XJds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuhC8Tt3hj1WbSVBnwGm6BFupmZXA8scX85bpBL+4acd35ImGyF8o3lDbZY2gcBEf
	 gkKzjSzUuSGu8hCipjlAStfBLwBdnIRixd1VqzxZneY4hgs4UIfpjbAOmliT9yh1yp
	 UQgwc9UGFobAEhiS9nTcNZwfevs6qziDHUHy0CtuKFeqD/MF9CBotvN9KL+2gxqT4P
	 20D17IiQIV1w/Yu4/rfjq3G6cB4kty24gcjKzH898/MjY2dusYkg8u4WCl9Catlefj
	 N2EHwAF4I1jFmnjtvERiL4fQRi/e2l1UprmacBNpCnSBBV/ofWBAT00Djv0aijIgQI
	 DMLoVrmYdtH0w==
Date: Sat, 24 Jan 2026 10:29:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: reset read-only fsflags together with xflags
Message-ID: <20260124182959.GB2762@quark>
References: <20260121193645.3611716-1-aalbersh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121193645.3611716-1-aalbersh@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75357-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42F2E7E740
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 08:36:43PM +0100, Andrey Albershteyn wrote:
> While setting file attributes, the read-only flags are reset
> for ->xflags, but not for ->flags if flag is shared between both. This
> is fine for now as all read-only xflags don't overlap with flags.
> However, for any read-only shared flag this will create inconsistency
> between xflags and flags. The non-shared flag will be reset in
> vfs_fileattr_set() to the current value, but shared one is past further
> to ->fileattr_set.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
> 
> The shared read-only flag is going to be added for fsverity. The one for ->flags
> already exists.
> 
> [1]: https://lore.kernel.org/linux-xfs/20260119165644.2945008-2-aalbersh@kernel.org/

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

