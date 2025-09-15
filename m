Return-Path: <linux-fsdevel+bounces-61346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07DB579DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7D03A561B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A340D303C88;
	Mon, 15 Sep 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cua7frLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8FD2F0C58
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937943; cv=none; b=t5fhTvR+1yspTl2dvHI4jrbl5TLJziYMag50AnnGY/F2Ib1mUd2OssY/4GiHWGrM4G0MigQ06Kbr1xX6IQyuV1YmkCRBzafjQ0dwYnQ5uKYKlekUR2kbe4tO+0ucFp0ha3EaS44yODDIrK/+FkN2fDPKPsmSvF9rIdn74/dQ6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937943; c=relaxed/simple;
	bh=ItcY6Yt9Dj+Oz6kMXYM98Tf3ijNtHWn/Tz6B70NVgP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKZhHNHSqQZIVsGaXWavzJd4ENFXfOhMmnTiQWzYz/9hZ9JZFubqT2gVOwaqYG0NAY0U5/m6nBIlDE76ppnnCSaroO4chuZUBaLWhRXktfV0mLYw3emr0FTVGRY0POCUrDLorNokekCP4t1BGD0ad97ga7zFASxaAw3DYPPcWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cua7frLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88D3C4CEF1;
	Mon, 15 Sep 2025 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937942;
	bh=ItcY6Yt9Dj+Oz6kMXYM98Tf3ijNtHWn/Tz6B70NVgP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cua7frLm4bXRDqBk5lIQP9gf4ajxzpg03g6nhHuuqFbokleJWPB2UDQV643fN6cWX
	 kqT2wWxkr41NndV7DfkmtR+P88F9uF6zqg82zKJxbsp08hWbt1HmlvgQ3ZIvF1JMVb
	 ex0EiN4NR0wMrTt5wb+mtv3NBHwYGbTzql9ColBeh9cR/j8gFEZfo45boV2GKFMDgT
	 RExmP4t1O0rCFBFqNlhdKbxKv+eusONX07kXRtgNCJtHGe6sVtgBWf7E/xCuxs3IFj
	 p32xe37U4XgCAQlORDdIidTRC8eDctZgu0Kjd6XDOSbPOWVdtj33EP8+uJNsXGTUfE
	 MkDLNe2Wm7cew==
Date: Mon, 15 Sep 2025 14:05:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 17/21] ovl_lower_dir(): constify path argument
Message-ID: <20250915-andauern-pumpwerk-c93b540c9337@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-17-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-17-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:33AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

