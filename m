Return-Path: <linux-fsdevel+bounces-46126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44591A82D99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754264673F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D738277016;
	Wed,  9 Apr 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERtOeort"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889A277002;
	Wed,  9 Apr 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744219758; cv=none; b=e8uN/fy3ycHsGFJyUnHI8FHB1u86MX2feYoZK7N1PN4nAoX+1beUUnmNjJp6QOvq7ScaIRknRxDTRC/CwxcWlBVxdIza8PafGNaNTvYYv0TAqna3BCDFcXgU2WuQysHmVrv6YQlXozOA+Jxdym5Nu68ByTXhmiGEPfkSERsP6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744219758; c=relaxed/simple;
	bh=A+bB1DZsszr3mEMdSanadJ8r7dtLodals5XrsqQKGH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZ2Dp4UlDcMCy6rN9RVr6rZWzFRP+MAkDay7Bo7JE63PzVh82oHR9QwtZSssICkBLc1+VcEodxGhjmH8FrbVBY1BbONqVq2G4iYNmWmERP3Vnu+k4DtJNCWsi2lIpB39/qIgAhdKVnEp86pog5N5YkWKpua/fnPSvoO9LYTxfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERtOeort; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E6C4CEE7;
	Wed,  9 Apr 2025 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744219757;
	bh=A+bB1DZsszr3mEMdSanadJ8r7dtLodals5XrsqQKGH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ERtOeorti1ay22wP0CyVuM7noG1ao/vanSSBcKqGlK3xlsRn1EMiJ8WpadVPRxtPi
	 dM+gYJF6brwVKELfHDNx3nRLOvfL+MtRJkze6+Jcdb5gsudDdBfbn0N3DkZFBv0aoH
	 xlUX2+++9NlK6UztUFManDSSPobCztmAeiCsdwVQE9SsMGAyPbJ2+OqReyf2uH9ndn
	 mneNAqcx9fwRmPSk3Ne8GQWQtQZgqRc0OizIGYvScjWNAy4BdQfroL6370K0GZsbpl
	 vNBneqw2BSS6MByoagD84XiQS2LGa8ihTX1o+x4hZcZdwLNJJfQvejyZjg9GzcvRhy
	 Ws4SgJvgRZMcA==
Date: Wed, 9 Apr 2025 10:29:14 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/4] sysctl: Close test ctl_headers with a for loop
Message-ID: <202504091029.BC5258A58@keescook>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
 <20250321-jag-test_extra_val-v1-4-a01b3b17dc66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-jag-test_extra_val-v1-4-a01b3b17dc66@kernel.org>

On Fri, Mar 21, 2025 at 01:47:27PM +0100, Joel Granados wrote:
> As more tests are added, the exit function gets longer than it should
> be. Condense the un-register calls into a for loop to make it easier to
> add/remove tests.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

Much cleaner too. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

