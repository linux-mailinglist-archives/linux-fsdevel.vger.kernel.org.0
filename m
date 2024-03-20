Return-Path: <linux-fsdevel+bounces-14921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111768817D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65281C21E59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78685642;
	Wed, 20 Mar 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l6z8UkWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72ED6AFAE;
	Wed, 20 Mar 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962991; cv=none; b=ska3Q/ZtNdAutaQB/ZMy+fIjXLvAXPTAtQCyHXV2UQUdl3RPZ+CzlZmK3gcrXombhWT/xqjVmkW/Z2DsBlT8Q0ZsJTmbUMI3KMMrUkJP+ZxD12DBtL9jm6PPFw+Kyx7/RRCcqBcBwo9Qns8sCVG9mS6zjXogfOZL00L+MBFiYPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962991; c=relaxed/simple;
	bh=zSZ9KkY083/xyX1OWaFfmiEEW4XlP6evc9N/ZITr/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9R1jNsesPjJ3qh4Ugo0b2wVhjKMAw6gI6UMR5htDIuvzh4FxsFLd0Eu6rA8N1gv+N4BsvnauzhnBOSuFBJf6A14LH2Npjr4WVP88+Or0ovyEjkEchudQAJJfXAuQdn5xst1LmdR38HdDpWEWSH1wRDuK/403AP8wepF23iroao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l6z8UkWz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yvq+o8b7UjuJnPOttI4lLotYQ0Q3sPL2mIWTZN8jvW0=; b=l6z8UkWzI0ESS7o9ZWcOPP5lby
	9zxxbsnFzQthW6djG85BtYcfSPsQF2oOY1v/H/GtyB6eLQiOMHEdm8i+3uwmmBtZWaA0zBuhcKzME
	TDAcb/GEg7WgmDOHWSq5ABZel17C8g7W0aEu4Qkey+7Q68CtMZLmFMmppnaHL8bIk6DoJZzdz+ZU+
	MApl7pBBBV69Lo1vj1t/67Mjo0OvdOFMw+btrI7qA+gZR5qnZ6OTqhAAB2QIHt4RMHkn7g/jgOLbs
	Kt7xRzUDH5w+mM8+JH2gex+3Hxce9HYaRLVufdF/50egFUWr2wvNETPIidYey2WCeyeyWKfgury6j
	h/fwfNVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn1dB-00000004xuW-1mOR;
	Wed, 20 Mar 2024 19:29:45 +0000
Date: Wed, 20 Mar 2024 19:29:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>, stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Message-ID: <Zfs5KTgGnetmg1we@casper.infradead.org>
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320182607.1472887-1-jcmvbkbc@gmail.com>

On Wed, Mar 20, 2024 at 11:26:07AM -0700, Max Filippov wrote:
> In NUMMU kernel the value of linux_binprm::p is the offset inside the
> temporary program arguments array maintained in separate pages in the
> linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> thus must be adjusted when that array is copied to the user stack.
> Without that adjustment the value passed by the NOMMU kernel to the ELF
> program in the AT_EXECFN entry of the aux array doesn't make any sense
> and it may break programs that try to access memory pointed to by that
> entry.
> 
> Adjust linux_binprm::exec before the successful return from the
> transfer_args_to_stack().

Do you know which commit broke this, ie how far back should this be
backported?  Or has it always been broken?

> Cc: stable@vger.kernel.org
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  fs/exec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index af4fbb61cd53..5ee2545c3e18 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -895,6 +895,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
>  			goto out;
>  	}
>  
> +	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
>  	*sp_location = sp;
>  
>  out:
> -- 
> 2.39.2
> 
> 

