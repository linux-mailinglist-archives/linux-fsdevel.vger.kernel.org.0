Return-Path: <linux-fsdevel+bounces-58289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB77B2BEC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0111894513
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 10:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D82798EF;
	Tue, 19 Aug 2025 10:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy9fiBTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49121DED40
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598775; cv=none; b=O3Y38mnB4Ypn+BftTQDc4knKYj7s6bkJgYM9FEd0gazlMXZgNy0IHxwglCLJsIzsu4XBil9G3pHPN0T+4mGRNc3l4LV1pMlYNBFQ40t2Ezm9HmVoiYqQx199xzhkCyai9wnZUZirrfj6+eIEVd2MM8ZaCOJkljg71qM8wc3KWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598775; c=relaxed/simple;
	bh=mbWBlMvN7EuNO2CRn0xw6M90XeFQPpDtRTrW/Ontv4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNsKsx+WFV44ATfIEf2qi2RGLRqyXRafQwo/4mlstdBvYObfjQa0hCEVStksBkyyyvcBzqzeYXvjjcanBcpE3XHTqZq/acwTzvH4BlBWp/bX6g8i7FCCRWSQJzC0mrqiNlAJuxswqcS4HbdHc1fJbNowL+Smv2LbQqVKN3tPLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy9fiBTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725AC113D0;
	Tue, 19 Aug 2025 10:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755598775;
	bh=mbWBlMvN7EuNO2CRn0xw6M90XeFQPpDtRTrW/Ontv4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy9fiBTz6mhZ2ySufGhdtBJIFrXUaDuIRwIpl5o0G6sljcGZGxu0ixOIRUpqfu1WP
	 2wtJpSp/BaEx7dBamYq28Kd6GzZp4Nu1E/ni2UclS1hFq2WsRQYlRQ/D3KeSnEfgai
	 NHuQGOy/RNVwdvuf7I1D3FVuo6tzdTFoz8baM07q16bAoLRn8w6neTQaCvdtWz/88f
	 9OTilLE4DFteGIRrcLY3oIZ4bwTcBRAHF7k1+OvLPTBoV7hxlt4a01jxXtelbmcn68
	 FwMfEjlufP4ooqCwrftfJyoGBn4ZqaLDyaMZDzhOS+Gbxcx4Y3qo42jl7M8HSEYo6d
	 ppjPFrq4PBlEQ==
Date: Tue, 19 Aug 2025 12:19:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Pavel Tikhomirov <snorcht@gmail.com>
Subject: Re: [PATCH 2/4] propagate_umount(): only surviving overmounts should
 be remounted
Message-ID: <20250819-aktenordner-sensor-1d90cc27c9ea@brauner>
References: <20250815233316.GS222315@ZenIV>
 <20250815233450.GB2117906@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815233450.GB2117906@ZenIV>

On Sat, Aug 16, 2025 at 12:34:50AM +0100, Al Viro wrote:
> ... as the comments in reparent() clearly say.  As it is, we reparent
> *all* overmounts of the mounts being taken out, including those that
> are taken out themselves.  It's not only a potentially massive slowdown
> (on a pathological setup we might end up with O(N^2) time for N mounts
> being kicked out), it can end up with incorrect ->overmount in the
> surviving mounts.
> 
> Fixes: f0d0ba19985d "Rewrite of propagate_umount()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

