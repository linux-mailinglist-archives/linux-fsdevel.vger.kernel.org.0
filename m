Return-Path: <linux-fsdevel+bounces-75246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBr+GPk2c2lItAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:53:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0234C72C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7E80301BF62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB75A311C27;
	Fri, 23 Jan 2026 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU3An0jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A3E139D0A;
	Fri, 23 Jan 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158381; cv=none; b=sV8X6QB16R0eiyXN7Lc3ubMFltZcrkNkTDJrq4ha021sUYTLrrD2pJfq2ZzTCVMGVBaZltSKDhfTMn9q6OUCa9Ia5h4Q7Y1ykeV1GQ40gmLwe7PZGAUML6VNXBnOlSeRtcvlUlWGo6EulOzMV5Y2MujG7lnHNPordFHIxhdnqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158381; c=relaxed/simple;
	bh=qo3UsY3y5HgUDAGBo4qGNMaYnFwk6DjirtDtuS1Ax18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si6qq6ts3Dz+rPBh9gxoG616zcjH2eoyBoW83Ndb/TDiYIRAo4fkXZCFFmrimUmk/hEq2rlZkxpMCHa6zWnORFx6OCiQQssdKbVrLCGy1/0j8Ak/0jTfcqJr/m9BOSB6z+5KJfApynW/zFilx9FOetesQFU0MOCnEj8MdXh3f9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU3An0jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5A6C4CEF1;
	Fri, 23 Jan 2026 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158380;
	bh=qo3UsY3y5HgUDAGBo4qGNMaYnFwk6DjirtDtuS1Ax18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sU3An0jyAEfHUXwe0PIpSmBfTa/snvyPfx/DLkWTqSxIhoNzzUbQugT5WfzkGOyeN
	 Z+pgO49++Jbe8Pif47BEB6ccW2X7BSb+cqPg20WD/3Uhhvks96Ht3zlzULT9xBi48n
	 YVYUVg8rAuEUJa2ifSuzjyHXKgvCAcnGQdM8hFEuhzHSyYJBNLwjpBwEDDotonxlFn
	 wyke1n0AfQLLwBe9k2pUYyFA494KMWwo+nGYSNNxGKvBJFMUZfrbXyJ1rs0cLXWh7G
	 tUqeh/JhjX5GV9JcVGRo0iz46qeP37XLC4axuu3wdKqK/A/d9MEjWezKgq0kJnrH3W
	 y7Vxo1xrTk25w==
Message-ID: <75f9dbe3-7034-42e7-9589-2214163d77e8@kernel.org>
Date: Fri, 23 Jan 2026 19:52:56 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-6-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260119074425.4005867-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75246-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0234C72C05
X-Rspamd-Action: no action

On 2026/01/19 18:44, Christoph Hellwig wrote:
> Add helpers to implement bounce buffering of data into a bio to implement
> direct I/O for cases where direct user access is not possible because
> stable in-flight data is required.  These are intended to be used as
> easily as bio_iov_iter_get_pages for the zero-copy path.
> 
> The write side is trivial and just copies data into the bounce buffer.
> The read side is a lot more complex because it needs to perform the copy
> from the completion context, and without preserving the iov_iter through
> the call chain.  It steals a trick from the integrity data user interface
> and uses the first vector in the bio for the bounce buffer data that is
> fed to the block I/O stack, and uses the others to record the user
> buffer fragments.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me, modulo one nit below.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> +	/*
> +	 * Set the folio directly here.  The above loop has already calculated
> +	 * the correct bi_size, and we use bi_vcnt for the user buffers.  That
> +	 * is safe as bi_vcnt is only for user by the submitter and not looked

s/for user/for use

> +	 * at by the actual I/O path.
> +	 */
> +	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
> +	if (iov_iter_extract_will_pin(iter))
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
> +	return 0;
> +}



-- 
Damien Le Moal
Western Digital Research

