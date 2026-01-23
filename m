Return-Path: <linux-fsdevel+bounces-75250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN0WHnw4c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:59:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0299B72DC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F46302FA89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6434D91C;
	Fri, 23 Jan 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9v06MoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F54341AC0;
	Fri, 23 Jan 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158728; cv=none; b=MUEkcgTpf83fus6u8zs7HJL8KB2Mzyc6R5mEcUQ5GdRHWO3ZLGDjERgh+8HqTZKIftU/rHgnn7zoMZKTcafEhF+P+Vxz/tWHVgxcNMztL30f4IqgMUT/CT/tzsil3+a/4coLpECzBd/vueo+1f8kUc4HK7Npao7Hx5GHsch8i1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158728; c=relaxed/simple;
	bh=S46zZhYUynee6Ht/PF/JzHVrx1QV2QE+nQGKCu7eYxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geGfaP7jLKd7THldZag9s7HRs1YvIB2l+e1yZghMjbNHeF7Dq1MDLhVJNCJjEThTgO/ElSlac/hSQiqTafSwZhrK75C9566zHWVioDNUSppymmOSqlQzOR1FZPyfHLYUCyvbJJfQVLmooZhfaGJnaIFsQp3OT+EqbJAQhi63MrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9v06MoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECCBC2BCB8;
	Fri, 23 Jan 2026 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158727;
	bh=S46zZhYUynee6Ht/PF/JzHVrx1QV2QE+nQGKCu7eYxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J9v06MoA4PnHn0TC/mInCIuTZmMn7ZgzxmjNhMuX8e0gkEeShxBmtQEcOxrprcEaf
	 np3kemv1HQrecrmiRs6POU3EEtcmNW+zCmoaL80nFGiSIP/lyGkEqkpm1ChgQZk0In
	 rG7/H0VrlkoWVX9niXAHul8DjePjgxGfSXS3e7zfyieFmPkJgpXrDCgpTHxhEdPLeV
	 OqvA/tgfv4HmYg2kVLwTI6caMB0GyPJ14WhvcaToUL2ptqZU6GzsPuVppDzecDOW0k
	 rvRHUHA2+unWmB5T8YXwtiqUdFrZIp0UceyvJMSHeOZWZUQVFq+uTsbA2mdMpufWC2
	 B0vO5v1qotQrQ==
Message-ID: <d2c4d23c-e3eb-4264-b687-86a76414da8d@kernel.org>
Date: Fri, 23 Jan 2026 19:58:42 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] iomap: share code between iomap_dio_bio_end_io and
 iomap_finish_ioend_direct
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-10-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75250-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0299B72DC2
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Refactor the two per-bio completion handlers to share common code using
> a new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

