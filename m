Return-Path: <linux-fsdevel+bounces-75822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGuHKkSnemnF8wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:18:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4BAA350
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F85302710C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647350276;
	Thu, 29 Jan 2026 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm6WfdYj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2135966;
	Thu, 29 Jan 2026 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645685; cv=none; b=LpUyeBIsNq++uVE6lDDHeXkedsKw7zMA+XcYLWl3Cb3KlUqgROeLi52dbUADcX1lbnS+cA+mXbgP6lbPf/XwSG6jqVjeo9g97OdM6pbCEjHAEAFxVVL/qjSBdCIVpVmffOBC2gGYTUY7qDMDLTaiyfb02F5O4nqfZbOL7eNh97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645685; c=relaxed/simple;
	bh=2tc/8PcyhmX/k+UBvvg7WV4hvCtnGQcPMINO5QNARo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDeHtMIdrmXbBWNfvFnBKHY89ukFaM7jestufVjumP4SVj3PrKSWYySYPkCNI25beP9mYKHoBFF5UjAktn4g5NndAZwGElbc/kAs+avP1Didz0J13QYtBO525lFYb1hYeFCtRd05W9kobNHCuAZ+7YSCjV8Aq4cLs3KhQCkx10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm6WfdYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A234C4CEF1;
	Thu, 29 Jan 2026 00:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769645685;
	bh=2tc/8PcyhmX/k+UBvvg7WV4hvCtnGQcPMINO5QNARo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bm6WfdYjrGc37RnqLkZa9/BWupFS3e0HysX8i/0qwF7+MDGf8GL2QS5CizuTtpMBk
	 vfZTOKjOpDoW85LKa16ayaafhKuSA7t85tkudd7Qt6t2A85Fut/lBe/wjJcCNj4h7d
	 +pPlOlBwgM3T3XtIG9ei/8wxV5zawmqIe7WQjir0VkY++3+oidlDXMi6SMLdgsmWW3
	 rX8d1qg5yD+6JlPb1q01QitA8Pwb0Huk+7HtgtupAQKpubZAucxzf5aAoqyYKWTmEa
	 la9XI5Izfq1GoeyIX0QrralA4kDuYZESj8qBmi6zO2uDfEGjg/nx56bdW3ie21DSxP
	 W0mssBmCUM3LA==
Date: Wed, 28 Jan 2026 16:14:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Qing Wang <wangqing7171@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 3/3] ovl: use name_is_dot* helpers in readdir code
Message-ID: <20260129001443.GE2024@quark>
References: <20260128132406.23768-1-amir73il@gmail.com>
 <20260128132406.23768-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128132406.23768-4-amir73il@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-75822-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EB4BAA350
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:24:06PM +0100, Amir Goldstein wrote:
> +		if (name_is_dot_dotdot(p->name, p->len)) {
> +			goto del_entry;
>  		}
[...]
> +		if (name_is_dot_dotdot(p->name, p->len)) {
> +			continue;
>  		}

Should drop the braces in the above two places, as noted by checkpatch.

- Eric

