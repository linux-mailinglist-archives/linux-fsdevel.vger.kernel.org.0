Return-Path: <linux-fsdevel+bounces-45835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDAA7D358
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 07:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0D07A4193
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 05:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DFD221F29;
	Mon,  7 Apr 2025 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kodOXdzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914238FA3;
	Mon,  7 Apr 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002679; cv=none; b=ff79FXtaBWa3W14HLyfIP1eQSr1D8GVx19eARYxfdX+MKv6KpHTGF3AhjgkOq4CzBPdXVYQwzIRpOSGA0zoP0m5GYzOngnguYmySsgiBao+Hhx3mZ0DneKbJP/WVStchIoXfLZPRvbbpSSj+ZFMGoG+ix6K92+uiM71ghJspt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002679; c=relaxed/simple;
	bh=D+D3fj7YrbDTWnWjZYBw+TnH9upDoJdnPsJmJILuUOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skMYB4glFOT17o5aTgCWQM4ARQMn8R7gH1MJd2ps/wG8QrNjLtB9vP9XHuf30pWIUrDzsgPdBBET+kofU1J6SvCax8f7hXDAYXk+DOnzQZjqsk1EiZ7gDi777v9FcyaswBq+UMg4H5jc8BZ8Wt4DEzsC9M64LAuwtxFi5cvqKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kodOXdzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2044C4CEDD;
	Mon,  7 Apr 2025 05:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744002679;
	bh=D+D3fj7YrbDTWnWjZYBw+TnH9upDoJdnPsJmJILuUOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kodOXdzcuYyh+5SWoFKeyLii5UvxLyavtSPQe4x5MOTATOoyEOi2N/IKZEtBUr2Px
	 U7siTzdmM2gKemiVe+dU8EW1dyL8ebhvKEdFxkYJk/b3EpMyvuSdOGh0rVG4JhgxeO
	 SvPbKD8x4p4PhGlJK5sG35+7mvsTI+Hf7Nc34csA=
Date: Mon, 7 Apr 2025 06:09:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev, willy@infradead.org,
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Kernel Bug] BUG: unable to handle kernel paging request in
 const_folio_flags
Message-ID: <2025040727-portly-aggregate-02c7@gregkh>
References: <CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com>
 <CALf2hKtNemTQPCGkbCfRZj3Lkd_2-L2QX+Y2rUxGgxMgdpJ8Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALf2hKtNemTQPCGkbCfRZj3Lkd_2-L2QX+Y2rUxGgxMgdpJ8Jw@mail.gmail.com>

On Mon, Apr 07, 2025 at 11:13:22AM +0800, Zhiyu Zhang wrote:
> Hi,
> 
> Is there any update on this issue? Shall I sumit a patch for it?

always submit a patch, that's the best way to get anything fixed.

thanks,

greg k-h

