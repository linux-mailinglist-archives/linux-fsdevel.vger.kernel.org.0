Return-Path: <linux-fsdevel+bounces-59180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5893B358BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA62A189EF8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 09:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC82FF159;
	Tue, 26 Aug 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYUDQbqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95949286D50;
	Tue, 26 Aug 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200238; cv=none; b=s20hRcj1t+2Vim1Qrq3ik5c2fjczpCUCsEwoS4frYApoC1hUhyIJc0k5JV6otdo4TFYFOCzBGi05I5l/wpoE0AguIm0HTFLWSrAfvd4HmSys+wiGweyS1ZespR12LzLn5FP8h7H5+K8iuPi9Sfv/RF7V4fK1iwsTLjKgsxeYq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200238; c=relaxed/simple;
	bh=qWSXMhkADiFYB6kPfeITxRWtYQrf3ANim0u4qWpuZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdEHTiAWmkvwtF/VhWTZCGId1xgky2agP1q1MFdxTjO18MijT9XI92ovWfWkclCTQJDdlwgm1Ll40JHDk3l/yR+4UT8ma2b9fNmyDYABDBuIyjUS+k6OVk9p74ZmeS5Ci3bLooG8KT8ZrZWfNXdk4gYhXpf5ciVU+hKmVndlDns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYUDQbqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F6BC4CEF1;
	Tue, 26 Aug 2025 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200238;
	bh=qWSXMhkADiFYB6kPfeITxRWtYQrf3ANim0u4qWpuZxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYUDQbqq7EJlxNqOgafp40fDOjqyIc9U/PLa2h1o+pBx6KMtOtVdhTNs7e1cPpVFW
	 t8Mte61Io7s+7aVlyowVnOym6sF42tubXDe/fXtbEKgTvBTQrIzdt7Ud4n+8Ry0OE1
	 mXmGQWyvH/EWZohts4MB1kgoMwIaBFJpgiYCPXMb3ZL9cp28Rz84UhOy9PLTX7LVqm
	 /qhGWTfORokg9n3qm+PmrU8zJvJkEHKq2gU7JvuO0hKo0KWM28G0m5NuKS1H+N++GJ
	 qiO80FnG23D/h/uulDYSFF20xfI9x+vl9AxDImLUIwCi6ixUm+TmcPn/2frGIo9WFj
	 j/Ke/vL5blIDA==
Date: Tue, 26 Aug 2025 11:23:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Infinite loop in get_file_rcu() in face of a saturated ref count
Message-ID: <20250826-leinen-villa-02f66f98e13e@brauner>
References: <CAGudoHHBRhU+XidV9U4osc2Ta4w0Lgi2XiFkYukKQoH45zT6vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHBRhU+XidV9U4osc2Ta4w0Lgi2XiFkYukKQoH45zT6vw@mail.gmail.com>

On Mon, Aug 25, 2025 at 11:43:00PM +0200, Mateusz Guzik wrote:
> __get_file_rcu() bails early:
> 
>         if (unlikely(!file_ref_get(&file->f_ref)))
>                 return ERR_PTR(-EAGAIN);
> 
> But get_file_rcu():
>        for (;;) {
>                 struct file __rcu *file;
> 
>                 file = __get_file_rcu(f);
>                 if (!IS_ERR(file))
>                         return file;
>         }
> 
> So if this encounters a saturated refcount, the loop with never end.
> 
> I don't know what makes the most sense to do here and I'm no position
> to mess with any patches.
> 
> This is not a serious problem either, so I would put this on the back
> burner. Just reporting for interested.

That's like past 2^63 - 1 references. Apart from an odd bug is that
really something to worry about. I mean, we can add a VFS_WARN_ON_ONCE()
in there of course but specifically handling that in the code doesn't
seem sensible to me.

