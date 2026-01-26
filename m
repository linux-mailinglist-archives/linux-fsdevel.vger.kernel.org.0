Return-Path: <linux-fsdevel+bounces-75441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLQvNnYJd2lGawEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:28:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 358EC8486B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 07:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08214300EAA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13F2749DF;
	Mon, 26 Jan 2026 06:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpZTa/zB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95C526CE2C;
	Mon, 26 Jan 2026 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408861; cv=none; b=sRO9ZIlsDtvRf/6jeI/hMPaXNYX8pJAVUxdVZvlloatcDDAg6P4tK2R02lG2cARD2Y8SKyZXHPfNG8997Nq2A+lBJElRA6cKND1VEk71ilGpYmqNySitsGCCt8hYK/nCm80i0n/f4ZvZJEjmq607QTzkLuLckEvPZ1sYBrbXiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408861; c=relaxed/simple;
	bh=/kf/oXd15i8L0oU03puYD2Y5rXqBCXVI/t/XGRND0Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxMuSfd6XsyuC2qBFbmDxiWplVXqcttVy2HyBFz4ygb4OzANAvA42iynl/pZkEd215hI+K8Jo0NAaCRjZ2y/DyJfTQbRE79vK6VDKHZ8O4r8ez33Zb5H5svq5UfaVloEvB1EzMvnZGV3/w7S1jsbZDnKe7Rsadu7l5MpVOrG8x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpZTa/zB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB49C16AAE;
	Mon, 26 Jan 2026 06:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769408861;
	bh=/kf/oXd15i8L0oU03puYD2Y5rXqBCXVI/t/XGRND0Nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MpZTa/zBaWtmyUkLA7d+P1ExGicwBaAJcTnvILY+ERkWfr/NEc7FkAdPaIEYEv9ze
	 qtKgk0wIAOX9q7PqO4hHzbAjUuncqzDn+kdc2/1NHYkbofCJXMMJDdSopxzCs/U78W
	 peZtXSuk9nmRLdV5WEMSRvhGgKq0sX47+dq9HJRP1D7cGqgdeVs6v4f3z7xqVa059t
	 l0zufJmI09xa+04xyy2+mxoWuLpxQSp2MTN1OXYIxBMDtvjFT8b5FRCH39zkxIoGBG
	 WoYoSQegVBe5j3mDEYkh93GJLTyKEG+XghaCdJFEwSl5Mebxlnkl9Uz2NxvxKu8L4O
	 HLgssgRvMXSfw==
Message-ID: <3360b495-b66d-40af-9274-bdb614455f6d@kernel.org>
Date: Mon, 26 Jan 2026 15:22:41 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] iomap: free the bio before completing the dio
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
References: <20260126055406.1421026-1-hch@lst.de>
 <20260126055406.1421026-12-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260126055406.1421026-12-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75441-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 358EC8486B
X-Rspamd-Action: no action

On 1/26/26 2:53 PM, Christoph Hellwig wrote:
> There are good arguments for processing the user completions ASAP vs.
> freeing resources ASAP, but freeing the bio first here removes potential
> use after free hazards when checking flags, and will simplify the
> upcoming bounce buffer support.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Repeated tag...

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

(which I think I already sent :))


-- 
Damien Le Moal
Western Digital Research

