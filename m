Return-Path: <linux-fsdevel+bounces-51268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE6AD5086
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891A77A36CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2791A25F980;
	Wed, 11 Jun 2025 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlzV+7n6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845232AD2C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749635361; cv=none; b=nJL7h3a5xsNwfEf5huiQvpyB2aaJjibuM82tXRWxcR6eFWVj5RLPxhvi6lEkDef98I46UMSwPohaJ5gK2YO9/PNaC5K7JMwMgubFFqOyBMApMl9xFjZ6iimotfz4s+wsTqvXJy3+rZXxy3s/JrprVAOS7XeqZ3qwAMBGN8zVn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749635361; c=relaxed/simple;
	bh=zGOGn4swKZKx/1wIQ6WzJCa7vvv/Yv46ApbsEF07Ar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuVPZLn3L04SAxR+Rt/RORPxT3o95PTYFNeT6TbHG8sOC3i7SABs6EuICkzWukBl5Uhw/Ztg3vkblPR9WrzhtQC/RCbTVSiyutSdux1bopPHHlRh8DUeQg5qyuAmeIcMbfS8zKyce1jyTSG0BJVd2MpQzE3HkEhrAXvlnoT5QlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlzV+7n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E66BC4CEF2;
	Wed, 11 Jun 2025 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749635361;
	bh=zGOGn4swKZKx/1wIQ6WzJCa7vvv/Yv46ApbsEF07Ar8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlzV+7n60mK9Fl4Pi5aES1I299cTau6EMl5VNGkkhXh8QH0JOsFFgjTjImHREmasu
	 ms/tyGBfSjeb6txpHEIpYiX5+cWYCWYIkiVePtBL3+QJ1JwDyjr/tqWhOatscZbHWE
	 c4Fkhwiqo8maui1Q7djPdkN1Gdi6kIYEtBc2TH2eiWG8H1z2179yC1tB6m5wqsEAQ8
	 0lczrvgBpc3rvtQsGneOQgeCfnaY9NLUtEbtO4JLv/CFfBQe/K9UoTV3yl/GFu3TzZ
	 fQWD7jJt0Lne2IAUUxzBs4+KAK9VclRPgpYpq9+0QGt3tlsv62lEpkfQWCOnXTZnAv
	 B75Z55oVCCmaQ==
Date: Wed, 11 Jun 2025 11:49:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, miklos@szeredi.hu, 
	neilb@suse.de, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 08/21] correct the set of flags forbidden at
 d_set_d_op() time
Message-ID: <20250611-zugegangen-kurzreisen-e372a2c9f2e8@brauner>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
 <20250611075437.4166635-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611075437.4166635-8-viro@zeniv.linux.org.uk>

On Wed, Jun 11, 2025 at 08:54:24AM +0100, Al Viro wrote:
> DCACHE_OP_PRUNE in ->d_flags at the time of d_set_d_op() should've
> been treated the same as any other DCACHE_OP_... - we forgot to adjust
> that WARN_ON() when DCACHE_OP_PRUNE had been introduced...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

