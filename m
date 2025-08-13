Return-Path: <linux-fsdevel+bounces-57795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC1B255F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39B47B8532
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B9B2F0C4D;
	Wed, 13 Aug 2025 21:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp44tlU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E02E716C;
	Wed, 13 Aug 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121968; cv=none; b=gRQ4bn9H2GpjhoM5huI08zP+p9lzxuRebUFnFAGGF4EPwilqtlaaRtLJKcSJ+t7V5Ikr1VxQ8OtJv779mvTJ3vmssBxQrSmdPc1tTY3FOpBDmFza0Ff90PDGdJcecvQWGZ5LEDqLv7r7NJJ63nUd02/EQnZO8Aclbb+Ovc958kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121968; c=relaxed/simple;
	bh=QCmL0ynHnVBGWOAhms5dAzdQRKx9eDzPiYMQVaipuE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Idv22ShUZrZ+zCTwgFJGETsfLtsGeUjXeN17egHgXzrKszQy034/oABaUXvUr8HOn+Vo0V61+b90ifQ5NBymrenZbtTKGeMrm4OjeTfEaPI+upwJkR1tgMqpR1xpgJ/mM775TyIp9QYqnV7aXXK7UecvjQqtp2qsyJDHVST08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp44tlU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1895FC4CEEB;
	Wed, 13 Aug 2025 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755121966;
	bh=QCmL0ynHnVBGWOAhms5dAzdQRKx9eDzPiYMQVaipuE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kp44tlU8/SSNASM0IeEdPM5EbOr7oeuLYPXA0rq49SQjgnMse63Xq5A+n21gET1Q4
	 4zb0yEwVv0oRxQK7gEXwpZ6oUFmQtcYI677iJiKjA/E9Y8hGXp66zocdtIhqd5+2rZ
	 sn9cRJL6sQIIPgbe36Ik3feKUBB5PIEhVHlKocmc0lt7plta5RXCATPEZ2Ab3mjw1T
	 YX9bxv7fSVT15PeLmBMo3GsaTZgP3nxXnPnSPFPBwVGYGx1mBMIhneXsnGMpS+C15T
	 i8HlwtMPAoq/WRlVCYWaGK6K/ojCA5ywK2zni800Nop8tkv08oz9HwPJN10CZZLqDV
	 60ZpIzS/dCh6g==
Date: Wed, 13 Aug 2025 15:52:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJ0JLLWrdfR5cRaW@kbusch-mbp>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
 <aJzwO9dYeBQAHnCC@kbusch-mbp>
 <yq11ppf2bnf.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq11ppf2bnf.fsf@ca-mkp.ca.oracle.com>

On Wed, Aug 13, 2025 at 05:23:47PM -0400, Martin K. Petersen wrote:
> dma_alignment defines the alignment of the DMA starting address. We
> don't have a dedicated queue limit for the transfer length granularity
> described by NVMe.

Darn, but thanks for confirming. I'll see if I can get by without
needing a new limit, or look into adding one if not. Worst case, I can
also let the device return the error, though I think we prefer not to
send an IO that we know should fail.

