Return-Path: <linux-fsdevel+bounces-61331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC731B579A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A83188554A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EE2FFDD5;
	Mon, 15 Sep 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8C6uLjf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E472D662D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937703; cv=none; b=ezhhftmAtXjk9Wi+QIvALgCa49Y0Refnt0nrsL+XaBuLf3PX6e6gAeGeS+Rpv8N79N/s7/IEY0kyuwI+9eJJ9Pgu/dSjNAOe/1rlSVQbuB2fNsopL9ufO66aGVtS+U/RvBY5FB3Ik6cl1+OkMPHu7biuHlI0avGiR5NlrSEJaMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937703; c=relaxed/simple;
	bh=jYEedmzc6LrnWT6kL3zUwNs9GrOB6CB9dVEvOasj0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTopEdwImdtzd9T2ZYc6lmWuvgNnUe0vBj39/dLXdOK8wK98+RcY2nVAbbdwkOEtNu+7FIwgfslZ2BnrwhPknPWjHLj6Q68CEVbwdgifZ0ZCOlUj4LTlvdu3x78wtzKDjZ4p2n4UgrwkVjeRykuuykcGpQRifOJ1Iwsw7Bjgbd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8C6uLjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FDC4CEF1;
	Mon, 15 Sep 2025 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937702;
	bh=jYEedmzc6LrnWT6kL3zUwNs9GrOB6CB9dVEvOasj0HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8C6uLjfDJGcBVUpiIzYU7xDGY1qO/DbKsG6Pj4yb1AaGTS+R9Q/+BReSisbDHWas
	 fX8HLusWmvzTiJfZd9WHPGefqmxaSpHt1+UABbKhBG2MtTKsv6Tp+LBIMC4qBXwR7B
	 ijno8uT2CToyQAXcCpxm7mpne7raD+fKP1qlb1pRs1YCcNdVXVtiQrFk+4FDrlljpw
	 oMFsOox1kaqyNNkr04yfptf7XF04LWr84LJjuX62Ra/qOp8iIuy4XNNLa1eDwQ/KD1
	 wkUQjQNvypI61DnmcpLAhWHgkpGUMWGRARBlPgpEnxmIKTZ88LUYDmxfe1wMxj3Oad
	 gW2iJ3Ls8yf0w==
Date: Mon, 15 Sep 2025 14:01:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 04/21] done_path_create(): constify path argument
Message-ID: <20250915-losfahren-farbaufnahme-e4429a8aba23@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-4-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:20AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

