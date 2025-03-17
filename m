Return-Path: <linux-fsdevel+bounces-44219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0503EA65E84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EED7A8984
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1751EB5C6;
	Mon, 17 Mar 2025 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q1mvhQT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F348F5E;
	Mon, 17 Mar 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241225; cv=none; b=knmpJm22dcYMLhU3J+5uXeprAs+bTYdz09y+Ccgsv72jxKSdlOJ50CXcBUqTArrJnleWpcBSREsaUvQIP9uQSLk6yRuCjBvwqwOPAns61ZHf/TlpnFT0ubLIdVEs7r45cScLAjFEP9lgh59Q6PDPL3PqJHmoVp96YVjXP7ssLDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241225; c=relaxed/simple;
	bh=lFLaG2NSSozJ87JPF2OwgFydEdTutnwNKBGiS+1aDtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMS70KR0Wcer5cY4zJow8lGqzVpRW5MnmwAg6MiGKF1DrXmHSU4rAaUdvadjiFkbfj3SLPPKTDEl6JWXv1NL/ad1hJQK0dGdU3RNFa8zAUyRNNj6HqqrGNouHGfdJNgJIPa5MkR9NEyCMImWOuOeykk50Wk6apMr228UFEUNdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q1mvhQT0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VqqbwZLM+OKvvtT9a4ynh4iaEeSQNo77XvM/25CxXik=; b=Q1mvhQT0Mt4aaQFPwbeBlmjpf8
	YFt0162I6qhWuCuMxoCUv7JSMEF65xYCD0JF5hUlIeO0gIUeyrQWipl5sYhwmfLP2PrBEp3b0Ej5p
	2tPggKK08l3iKhynT4WX30AS6F37ZNbzHb9D7viiWGWyNKNNqV/2zUR+P0LSHQLRl0mIgPF4r15Zr
	l9r6H9UHi8uGhU35VaEfv2mZq4VOjpR6gk5miJeyHlOXr2Jf8GA/2agTc6vX/JurmfyCAc6V92kqa
	BnsghedQxSVA5l9DmmYz95YKLkbR4SkI9GJFOELVmEHlJfOI0r3b0Bbi6tXCNMrtuvtP59t43FWcI
	XnfXZvDA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuGWm-00000009TMQ-2MSS;
	Mon, 17 Mar 2025 19:53:36 +0000
Date: Mon, 17 Mar 2025 19:53:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Ruiwu Chen <rwchen404@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] drop_caches: Allow re-enabling message after disabling
Message-ID: <Z9h9wKcAD2iiO7dS@casper.infradead.org>
References: <20250317-jag-drop_caches_msg-v2-1-e22d9a6a3038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-jag-drop_caches_msg-v2-1-e22d9a6a3038@kernel.org>

On Mon, Mar 17, 2025 at 08:40:04PM +0100, Joel Granados wrote:
> After writing "4" to /proc/sys/vm/drop_caches there was no way to
> re-enable the drop_caches kernel message. By replacing the "or"
> assignment for the stfu variable, it is now possible to toggle the
> message on and off by setting the 4th bit in /proc/sys/vm/drop_caches.

I don't like the toggle.  Nobody wants to toggle, which means that you
need to keep track of what it is in order to make it be "on" or "off".
And you can't keep track of it, because it's system-wide.  Which means
you might turn it off when you wanted it on, or vice versa.

Did I miss the discussion which promopted this change?  It seems like
terrible UI to me.

> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
> Changes in v2:
> - Check the 4 bit before we actualy toggle the message
> - Link to v1: https://lore.kernel.org/r/20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org
> ---
> 
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 2 +-
>  fs/drop_caches.c                        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index f48eaa98d22d2b575f6e913f437b0d548daac3e6..75a032f8cbfb4e05f04610cca219d154bd852789 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -266,7 +266,7 @@ used::
>  	cat (1234): drop_caches: 3
>  
>  These are informational only.  They do not mean that anything is wrong
> -with your system.  To disable them, echo 4 (bit 2) into drop_caches.
> +with your system.  To toggle them, echo 4 (bit 2) into drop_caches.
>  
>  enable_soft_offline
>  ===================
> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
> index d45ef541d848a73cbd19205e0111c2cab3b73617..15730593ae39955ae7ae93aec17546fc96f89dce 100644
> --- a/fs/drop_caches.c
> +++ b/fs/drop_caches.c
> @@ -68,12 +68,13 @@ int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>  			drop_slab();
>  			count_vm_event(DROP_SLAB);
>  		}
> +		if (sysctl_drop_caches & 4)
> +			stfu ^= 1;
>  		if (!stfu) {
>  			pr_info("%s (%d): drop_caches: %d\n",
>  				current->comm, task_pid_nr(current),
>  				sysctl_drop_caches);
>  		}
> -		stfu |= sysctl_drop_caches & 4;
>  	}
>  	return 0;
>  }
> 
> ---
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> change-id: 20250313-jag-drop_caches_msg-c4fbfedb51f3
> 
> Best regards,
> -- 
> Joel Granados <joel.granados@kernel.org>
> 
> 
> 

