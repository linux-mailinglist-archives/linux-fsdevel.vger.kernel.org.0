Return-Path: <linux-fsdevel+bounces-45047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE54A70AA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 20:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6828116F84E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AE71F03E6;
	Tue, 25 Mar 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB0+yvto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2CB198851;
	Tue, 25 Mar 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931786; cv=none; b=uUfSqKrYnLbuks2X/67thv0JJRvujCPfBOOiUd+sxQPYU25viSgIN9YJmk7eCF68BYvXwkAE4g/U+xnqZKBPSuk6O94dMzhVnnL1eX7Zrqe3XQ34URKt/cVJb/M7OYcsArTQ517n+HeVTHo6lpSONCM0YqQ9Hk5GYJVrh+DANhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931786; c=relaxed/simple;
	bh=PQ1ykelCUvUiP0SCP/hX9Nj/59NCnq4VPDmBUPAiC6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ravS18sy0NjdoOZ8Xmfw66nvAIIVQVpo+EJtivFXQVSutdSUuLMc6nYGNIZ+AMFzMtqc5KWqm1PQRUAh8i5aCjcW4ZLMeFmbHjwm06OJDxbAmCjwdaaMTtHDg5NsQSA0zx9r1B2C5lkWwdmpT/n5FgPoNhsIZDaJZM7Zq5w9dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB0+yvto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1F1C4CEE4;
	Tue, 25 Mar 2025 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742931786;
	bh=PQ1ykelCUvUiP0SCP/hX9Nj/59NCnq4VPDmBUPAiC6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AB0+yvtoZVeX1qyRTwFC+uoPgTEiEArH2wAVXoj/9agIBovYT5kLL9fTdXCYMox3a
	 OFMyW6n5DYKr/Y2KTX8/V+y/pjy7WolTpx00slq98q34aeVmjc79BnGIqptWZx5PW3
	 1KTw4ww14hcuT/iw/2KGjyx7gZjNrMj/1phssAjLzuz+W9+TM+6RCwg3nxA1OXxDTm
	 OIVruxKFD17tG67AktrhBBa0Rr6l77vPyIQZaYrvmGvYI0yqNGV0ot+BC99yCY+ebT
	 VieNRESw3709zC+hHr0jx9+SlgW8zCrO0zzfl8DzgJdrDohKWZViZ4IWfDCUT7Hwha
	 0TjK0ZV4rtYMQ==
Date: Tue, 25 Mar 2025 12:43:00 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to
 sized_strscpy()
Message-ID: <202503251242.FFDB6940@keescook>
References: <20250325015617.23455-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325015617.23455-1-pcc@google.com>

On Mon, Mar 24, 2025 at 06:56:13PM -0700, Peter Collingbourne wrote:
> This series fixes an issue where strscpy() would sometimes trigger
> a false positive KASAN report with MTE.

Thanks! Should this go via string API (me) or KASAN?

-Kees

-- 
Kees Cook

