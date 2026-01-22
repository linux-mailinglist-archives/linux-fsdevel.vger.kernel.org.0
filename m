Return-Path: <linux-fsdevel+bounces-75136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHSuKSJtcmlpkwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:32:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808786C76A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00F443069D5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 18:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380932ED54;
	Thu, 22 Jan 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC5Kj0Lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26535029D;
	Thu, 22 Jan 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104949; cv=none; b=dtb5BPhLp+mJJTys5UoJMjCD7bQSfdVdy5tOMeIVSdffVVHXidp/UJA+2otSdtISc05khqmbOFve3oR54POfabUurXWdaP2Z5XhhTOT7TCVhkYniznxt6iQ8WVyZovz5+cyctRJUUePkl+BVuufgaxmh997gsyxS1t4L27wtTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104949; c=relaxed/simple;
	bh=CH83nVbv8pe69poTeVmWvk4K7nkSvE2shqYV4ZdwS28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMy8D4aAbbcRTflX3FfEqe6e5H/84i/9VEm9Pd7nr0VD+tQ0sxLvJD5Qxz3sIQhaOezsHxF/+a3yoVNLrKSmji45iTl6PUHthWR+Cm37LBU0x1YAk8f75l0VfTBqq6pQV5US/vu6Ngr9LV/cNtf5gMVseQFWpHYpnGQeiIzWbjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC5Kj0Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BEBC116D0;
	Thu, 22 Jan 2026 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769104949;
	bh=CH83nVbv8pe69poTeVmWvk4K7nkSvE2shqYV4ZdwS28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC5Kj0LjKUd4cUSFjtArBhgJvrgYRugpo9nmGRyVJu6N6UAECo1g49jORZv41R9o8
	 7SxrVUvtGmx4AagoBoDNeSx12hqxNEy8zaKChDFe2ey9zCq4XWoIi8MLGpwXnDCoyr
	 d0ntukAW5/+UqQxY1uYbCTvZ/omPSwdGBM5v4K6TRwQYljROzQKFFA5biRBawj5mEL
	 iXM6N6tpjW/fnbSFZLxKRqjT4VW9ehoORQmvpmfxGfhJWEoE/jauS0rgvHOlrJ78+L
	 qjz/FHU68c6Fd921N2hI2aunJsyjQYOuaWOaESxEkjfwL7dt7XTvJrRPlUu1rJhqdR
	 qEUo2df1HZxvA==
Date: Thu, 22 Jan 2026 10:02:28 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 07/15] block: pass a maxlen argument to
 bio_iov_iter_bounce
Message-ID: <20260122180228.GA5945@frogsfrogsfrogs>
References: <20260121064339.206019-1-hch@lst.de>
 <20260121064339.206019-8-hch@lst.de>
 <20260122010440.GT5945@frogsfrogsfrogs>
 <20260122060400.GD24006@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122060400.GD24006@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75136-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 808786C76A
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 07:04:00AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 21, 2026 at 05:04:40PM -0800, Darrick J. Wong wrote:
> > >  	if (dio->flags & IOMAP_DIO_BOUNCE)
> > > -		ret = bio_iov_iter_bounce(bio, dio->submit.iter);
> > > +		ret = bio_iov_iter_bounce(bio, dio->submit.iter, UINT_MAX);
> > 
> > Nitpicking here, but shouldn't this be SIZE_MAX?
> 
> bi_size can't store more than UINT_MAX, so I think this is correct.

Fair enough, I was just surprised that this later gets turned into a
min() involving SIZE_MAX.

Practically speaking, they're the same value so it doesn't matter much.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

