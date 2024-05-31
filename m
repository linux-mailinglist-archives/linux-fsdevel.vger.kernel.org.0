Return-Path: <linux-fsdevel+bounces-20671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561D8D6B61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 23:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E59282C75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 21:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B024E12F592;
	Fri, 31 May 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwVjSWrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089368286B;
	Fri, 31 May 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190045; cv=none; b=Yn3l2PO3C0VSlRPN7wyWbAi99tMT7mzaeWUlwAzMW+6yXl8/Ovo1OUSiTtZYcguN7ZHJNj7IOhhi4asA1ptNx6d9ic6TW0XOZdR+zjjLNN3skQq/opWoZ6+JXAiKauzvYFjlNwH/0bqoJdprATqheimL1ZsaesTYMURFcmyr4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190045; c=relaxed/simple;
	bh=adcGqVW2UvBtdH178ghT0VtsdZKk0LvV3foBZFisFvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oyvx/Hphi5nTxZHvgB2OLFJOM/HIKGafSr3Jz7QVYVtqPG0+Fcwu4WriKZQ//XUJmmbPwdoTkslN4gcbkbTjvrfijXdtNqFHxml+Rt1LDr/3O9FXlhgEfgK8ihB7Bz86TGJbSrJLuMUwidn6dvMmYTuOCzUQ+RONePb4LuPu/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwVjSWrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7B1C116B1;
	Fri, 31 May 2024 21:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717190044;
	bh=adcGqVW2UvBtdH178ghT0VtsdZKk0LvV3foBZFisFvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwVjSWrKXGPuSQjpIChdAY5ufSTBn3v+zt08V9iOrzMZ9PRS1cjFZezX41v+4Luu4
	 7aRvnfgWUCxogZiVlOMWMh26SFzxAQvNStNqWUKF/i6oobvcI0srxxse2a0pLem05T
	 tpwALGI6Stvs6VBO4On/1ingmaW52ItW4VfHPHeMhmJ3+aVB4wReVV1KNif1/NFGUd
	 XUB9qTO9VInOIsvcdMrlZgXJ3yJoFx3lMSmwcQTEsM9Cca8biZ60rz//LdlbO+WsbT
	 B65Sb+yjkik0MUQhynwFTbkIjxIJtYFHFISUJtd0+iT/RPZCX04hcmLlVO3oOyRJQC
	 KzG/hj78Jl4ww==
Date: Fri, 31 May 2024 14:14:04 -0700
From: Kees Cook <kees@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel@collabora.com, gbiv@google.com,
	ryanbeltran@google.com, inglorion@google.com, ajordanr@google.com,
	jorgelo@chromium.org, Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 1/2] proc: pass file instead of inode to proc_mem_open
Message-ID: <202405311413.DF87BBE491@keescook>
References: <20240524192858.3206-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524192858.3206-1-adrian.ratiu@collabora.com>

On Fri, May 24, 2024 at 10:28:57PM +0300, Adrian Ratiu wrote:
> The file struct is required in proc_mem_open() so its
> f_mode can be checked when deciding whether to allow or
> deny /proc/*/mem open requests via the new read/write
> and foll_force restriction mechanism.
> 
> Thus instead of directly passing the inode to the fun,
> we pass the file and get the inode inside it.
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

With the nommu errors pointed out by 0day fixed:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

