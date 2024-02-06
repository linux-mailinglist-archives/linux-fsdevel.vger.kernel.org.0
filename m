Return-Path: <linux-fsdevel+bounces-10473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD42584B7BC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05AA1C24D12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2B1132485;
	Tue,  6 Feb 2024 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cdlsl7Tt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61E12FF97;
	Tue,  6 Feb 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229467; cv=none; b=mPs3EtYJArPR7A97pIH9fYZZxE42lUXV/mD895ETuiY3F3N4n91zd+ngRWQOJ2DiRDtxw+N8X1V9/svIP0B7WO6MpfOw+tGB4hawXiUxBI4dvsIgnx+YXB9Gy8NhxkEfQHNg8Efz0CXcCj82Km90ZcDUvniiF8Um3rRQFqtXjsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229467; c=relaxed/simple;
	bh=LZhmzg4KBKuQN8gmVwYVjL7Q/LDk/w1Db/umrMK4dIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7aXPzF9Kz9Ni+d+W1WtQf8xg6zlgtSmqm2hmPiY/T9oNoGmjWd9n2XXxzfEQIQCPefnSBlnGQzEfhjO99bkw6puC+ID7g1g9yEu9aKy/Se8gwkpYP8+IswztMrAU8pcvUstmg1+uV+QrWrVa5lxFCbmnSBvGsBWdTLmb2v21Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cdlsl7Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D6C433C7;
	Tue,  6 Feb 2024 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707229466;
	bh=LZhmzg4KBKuQN8gmVwYVjL7Q/LDk/w1Db/umrMK4dIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cdlsl7TttHTuGdn47fLyHckZ2861xI1Rzdfy4XDa7SmFTUY2ocuScrLRTY1rQFAbQ
	 R0fSqRU2OYlICwGW8CXFa0DzRIjYTOISNpnWlgD80l3CRaxwck/y+XsCRwfe+ejUqt
	 hILxVFp+p8SHOiCbPqdPTC1D+YxfKz6q6Z0RSyn0=
Date: Tue, 6 Feb 2024 14:24:23 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v4 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Message-ID: <2024020614-idealist-rentable-4df8@gregkh>
References: <20240206001333.1710070-1-yoann.congal@smile.fr>
 <20240206001333.1710070-3-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206001333.1710070-3-yoann.congal@smile.fr>

On Tue, Feb 06, 2024 at 01:13:32AM +0100, Yoann Congal wrote:
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.
> 
> So, change its type to bool and adapt all usages:
> CONFIG_BASE_SMALL == 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
> CONFIG_BASE_SMALL != 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> NB: This is preliminary work for the following patch removing
> CONFIG_BASE_FULL (now equivalent to !CONFIG_BASE_SMALL)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

