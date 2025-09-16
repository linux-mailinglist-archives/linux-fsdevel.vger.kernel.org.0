Return-Path: <linux-fsdevel+bounces-61667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3025B58B00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09D74857DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3C6202987;
	Tue, 16 Sep 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kggIUaa0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3B1A3172;
	Tue, 16 Sep 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985946; cv=none; b=WHkix8ebph4pm7ItsPhEdA2aZPcgvEfS2iSOVLt05ihSNZLwtZJrAWgtSHZLrlPwL87xGHdPbIfms86RkYeSh6aLxBTZNf5LYtCvg43TVWnzZGuJwkeHJ0GlaWI7CNXrIQpAczhHBa/BmymlMQUijUIN2i29fY9oNbSFATq1OLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985946; c=relaxed/simple;
	bh=PGeRW4ekw1e1g4x0lpkZJsoIgE94eDG9hnq6zEYbfKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Orts1/jQM6WdSonBJayWAw3hGl0vCU+UEsA87YDejHCTpXIDtM8GvqHQYfToJ71YoUbAYMkGvvcqkvtwN2S4vCGuTnIK/0HgQUSSLYvQjk3YS0asT8M098eMtlHES6EaHCK5HF7QEBQBKDIpn6I/XxvxSAAiPy7UXGALqxGOcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kggIUaa0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B614RUOvUSUKIJ0B+X+YtpwqX4Y/bq8nTphOp+NT/xU=; b=kggIUaa0rjDo4pyHgIRPymVR1U
	AVsRHORrGTt7YxtvsxEWenqsj95W+JWlvXOhJKVPNHG2GQz+x1vSt+HWLYqwrK6lTRyUhZ2bvsj8y
	fLG8Yn7e7qrVdp7Bm11+/qaP2Nz6HAX9tASD45MIdDFdrsa0mruZNc2T5bBiD7BPOCli8NzoOuuzX
	oEmBneQqi7+Z15RrYVqTfeXya+swphEEhvo0ujqueZD0EEWIG6N/kQPa/rUWhOqgyzspiFekK7IVY
	1wTzmf9GyKAzUZ+O8rgvrZ7Q7d7sZBoTddxXOKGGGP6r+GUFg5D9AYrhC1W0HFr6JveIeSH4EK/py
	V/+uXrPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyKRt-00000003t6x-24wA;
	Tue, 16 Sep 2025 01:25:37 +0000
Date: Tue, 16 Sep 2025 02:25:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] lock_mount(): Remove unused function
Message-ID: <20250916012537.GL39973@ZenIV>
References: <20250915160221.2916038-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915160221.2916038-1-andriy.shevchenko@linux.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 15, 2025 at 06:02:21PM +0200, Andy Shevchenko wrote:
> clang is not happy about unused function:
> 
> /fs/namespace.c:2856:20: error: unused function 'lock_mount' [-Werror,-Wunused-function]
>  2856 | static inline void lock_mount(const struct path *path,
>       |                    ^~~~~~~~~~
> 1 error generated.
> 
> Fix the compilation breakage (`make W=1` build) by removing unused function.
> 
> Fixes: d14b32629541 ("change calling conventions for lock_mount() et.al.")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Folded into commit in question to avoid bisect hazard

