Return-Path: <linux-fsdevel+bounces-77749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IQzKCiUl2k81QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:52:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9D163635
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9342302B389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F863009E4;
	Thu, 19 Feb 2026 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiAbiB/n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69EE247280;
	Thu, 19 Feb 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771541535; cv=none; b=D8p16gfert1npeW8W4rsN0iSpmsX3DXgcmCL9Upq2HPccBAxM9z06eINNEG8xSvQIEdL5uy8EXQH2Hj0OTFVe/jZ7sCChRhcVVul/fphqezRP9vICfS/vQnQiTWxPJRUch3P8KQEDqXKPPnQVYCobDgozAqYAqJauBoIJLOYUwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771541535; c=relaxed/simple;
	bh=7eMEdZbUmR16KtSQRvUUh7y5VeK7ls2QS8IQzjkJstA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WImIQscvgz61s5Pa5kmnWLaialobNrnWzYO+D/rq/+dDoSD/sp9wwKNjnEyoV12YRkvisb55Cfr19Glk35j5bTbctwIhP9IG/OhiCMNSU6BvZphRlHV4cN4/e5CIerRDbsIYWlByMQGzZwuC65z/kQ8HXvl52Tz0ykdTMzj5j48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiAbiB/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A6CC116C6;
	Thu, 19 Feb 2026 22:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771541535;
	bh=7eMEdZbUmR16KtSQRvUUh7y5VeK7ls2QS8IQzjkJstA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiAbiB/nXrc/VfXKY/PIXdvsoS04NB8VHTMjDEi7rkWL0uOeUvcvZ52K83Xeu32HM
	 VP7vgTEDv1q/7OeE11wsG2OFMvd6HFFfzaHVD/D2l653NLZzk5WdbaocCL2szsRfK/
	 EbV2PAZZehqXNCMwC3MDyYpS0ij6qfBkmWdiZtsE6e/LcmNj247xMfR8sjkUs9IWXI
	 wQf2R3kxyJKgCD/6TSZHhD07WpQYuE+AneRzBMzbKsSA8bXd6YR7Yr4D7WVvmG7H0v
	 tnHU8gOScslFwhK3UcU7zBOxUvrGQhH/gsF6AiyjoK7NNkys5R6CzOZI9LswK9cYYZ
	 3ASwOge1lF01w==
Date: Thu, 19 Feb 2026 14:52:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: cem@kernel.org, brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fserror: fix lockdep complaint when igrabbing inode
Message-ID: <20260219225214.GT6490@frogsfrogsfrogs>
References: <177148129514.716249.10889194125495783768.stgit@frogsfrogsfrogs>
 <177148129564.716249.3069780698231701540.stgit@frogsfrogsfrogs>
 <aZa0XkylrjTYR5pg@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZa0XkylrjTYR5pg@infradead.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77749-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2DA9D163635
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:57:34PM -0800, Christoph Hellwig wrote:
> Allright, this is basically a dumbed down version of the XFS ioend queuing
> just for errors.  I don't particularly like it, but it's probably good
> enough to fix the regression:

Yeah, let's hope so.  Thanks for hodling your nose. :)

--D

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> 

