Return-Path: <linux-fsdevel+bounces-77310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOFoHrZFk2l83AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 17:28:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7881462CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6258C3032DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0966332EC7;
	Mon, 16 Feb 2026 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az1dURk9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569423328E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259270; cv=none; b=tJ/b4ESKxDl5GoRACq3nNjtHSH4R6TWnwaNpzaXj+7htTpURMQbSLDBZfJqiZYV3qbLcjIYtT3LD/Sl/ByWiklWulSRq7hdKycQQ8+o85fMYr2ua2Q3t1+kY6uxXPrdStWSctlZNhG2HNzt2KFzzM5SjJFmYYwVwT17pr9RGDCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259270; c=relaxed/simple;
	bh=uK0yhrheAWp+1HFKdzB6+HC7KQxXpCfeyD8TYNIEf8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA+eA2rYuTpCkAt6Y9aWeetzQBCsWoboQT6ZbBddde4kB9hdtoMH7meW+ux9uap+PibKE2947sL0+vjXLfSnqFHtB1PJRur5cKD+VGePYer7ShBAM5P12fqqO5zzuQVqZFW6fJoYbXMCD/EXxpLWl+r+JMNW7kMJ3e83MnI30CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az1dURk9; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48372efa020so23590175e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 08:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771259267; x=1771864067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=psgHVJWvQ0vhmy9UM6Py2oOFm9j9yzqcdlkiRgF10nA=;
        b=az1dURk9nNMb7qsEIG9PFsFwoF40lLEMZz/oFpjHBz2RUWCvpYbBTyA/V6CT9iQwCT
         dEzRMwv/RMbyqJjGx3Z3vubPjMlgCAI30Zphkm7XbVci+XHrXsIDP9MnvYRslvNr7Fs4
         sdlFd+F2axAcAnAc+BWE6JO9fsGNGgG9HDD58EhtD4LLfMnJdLz0fQzm+OZ5i1Zvo3pF
         UsExNfdQohCyh2CmCC1SV9XmTanmt58Dnye7gvEMhyNp4nUzoBxGma0YG/fB+jOPHSyf
         z5I2qRsJ4r1C98y5T8oola3HlbM/XfL6o7NlTDt+PBjU8dN8LwuCrZ820CcmgO5JWQ39
         0Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771259267; x=1771864067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psgHVJWvQ0vhmy9UM6Py2oOFm9j9yzqcdlkiRgF10nA=;
        b=e3rCKjnlBy8SC6PT35IToPNiJUGtN4jO5Mxrt4nWlei/iIEsQOxurQqVwfc1XMbzlJ
         alRxl9Hz5CwbDl1QVRPHkc108yaoUFRrBz1vCQkHFiT6kmPLasAJGIzbw3Tpcki+aZ3Z
         dBW6HgIZukBL835OH/bSOvGPoYY5FZEBJHJVmstf0wgbGkLHvt7ePJ5YeAZypxSvRzzc
         030h+htwU8MLk4p7bHlL7NQlBHcuQbqZJR45/2+UgAsipia2mxdhYlF1sEa3ng7ziQbj
         GIBGB9EMuLRhySgDV0Nqky34iHpOXiqdqdNaS/G/uvPAsVJ4AzJr4hrc67IFREOO2q7e
         4OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9ph3eOSZKcemI6aRM0P8W0YJ3lRRwV7saiqgtJ4LaX/jPKwCjZ8jcWmCsTEcxUjPJ3wh8eZoOjE99q//G@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhpsvkWcG+IAu2N9c0/NrMcXnp5zk+eqaFdxsx3GpQfyUNCsL
	fDY+jlCw+5riO64k/RMmd0ZDf6EDRD2JgkcoJibiRLsJSVEm1120dInn
X-Gm-Gg: AZuq6aLPCiZ+SXCGUK9Ff32fgewwYwS1T/Ncq8zL+Oy0DVieF1AoIyEwSHTQFGmeQWl
	/OTmZgk/cTM+Pb0xS3DWcGyg/wtMY4sUS22B06Qzxj/4gAfFBkRvgWM0XFfrChroTtJpZk2BOrO
	kw+Ayw37+MXGSFe8J9gsMQA4I84HAVWgDHD8qNs0XUrMKYy3KR+F1s40flzl+L03RiHdVvaI9rQ
	S0PIGaWTAK0WJx6Yo8DVuhvz/DfozWeH46hAQ3Ei/DmuZJiTNttyyhdQP0fRaBecfEkqtjTan1i
	1wWLUDMAXOIm1pvgEzjGfuLGem4Jtu18AtON2bMqTm4js2t0BJfK9v91n8GnsJT6tiD4doRpSh/
	Z3g1rJt9sJRAmu70UfyXCPQp3bNCuFaWIFh5bT4ZNrx8sempHIp3qvLgSV+ivS9etKVUvubFXMT
	MrxNy8gWoD7VAeVpBeGB17szKhix5weZJcuKouNJHeflWoFjJdwt368p8W
X-Received: by 2002:a05:600c:1f92:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-48379bfd727mr142402445e9.17.1771259266651;
        Mon, 16 Feb 2026 08:27:46 -0800 (PST)
Received: from localhost (bzq-166-168-31-253.red.bezeqint.net. [31.168.166.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e327sm441915175e9.14.2026.02.16.08.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 08:27:46 -0800 (PST)
Date: Mon, 16 Feb 2026 18:27:45 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 1/3] kernfs: allow passing fsnotify event types
Message-ID: <aZNFTR_gc6j116rw@amir-ThinkPad-T480>
References: <20260212215814.629709-1-tjmercier@google.com>
 <20260212215814.629709-2-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212215814.629709-2-tjmercier@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77310-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B7881462CE
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:58:12PM -0800, T.J. Mercier wrote:
> The kernfs_notify function is hardcoded to only issue FS_MODIFY events
> since that is the only current use case. Allow for supporting other
> events by adding a notify_event field to kernfs_elem_attr. The
> limitation of only one queued event per kernfs_node continues to exist
> as a consequence of the design of the kernfs_notify_list. The new
> notify_event field is protected by the same kernfs_notify_lock as the
> existing notify_next field.
> 
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Looks fine
Feel free to add
Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/kernfs/file.c       | 8 ++++++--
>  include/linux/kernfs.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 9adf36e6364b..e978284ff983 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -914,6 +914,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	struct kernfs_node *kn;
>  	struct kernfs_super_info *info;
>  	struct kernfs_root *root;
> +	u32 notify_event;
>  repeat:
>  	/* pop one off the notify_list */
>  	spin_lock_irq(&kernfs_notify_lock);
> @@ -924,6 +925,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	}
>  	kernfs_notify_list = kn->attr.notify_next;
>  	kn->attr.notify_next = NULL;
> +	notify_event = kn->attr.notify_event;
> +	kn->attr.notify_event = 0;
>  	spin_unlock_irq(&kernfs_notify_lock);
>  
>  	root = kernfs_root(kn);
> @@ -954,7 +957,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  		if (parent) {
>  			p_inode = ilookup(info->sb, kernfs_ino(parent));
>  			if (p_inode) {
> -				fsnotify(FS_MODIFY | FS_EVENT_ON_CHILD,
> +				fsnotify(notify_event | FS_EVENT_ON_CHILD,
>  					 inode, FSNOTIFY_EVENT_INODE,
>  					 p_inode, &name, inode, 0);
>  				iput(p_inode);
> @@ -964,7 +967,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  		}
>  
>  		if (!p_inode)
> -			fsnotify_inode(inode, FS_MODIFY);
> +			fsnotify_inode(inode, notify_event);
>  
>  		iput(inode);
>  	}
> @@ -1005,6 +1008,7 @@ void kernfs_notify(struct kernfs_node *kn)
>  	if (!kn->attr.notify_next) {
>  		kernfs_get(kn);
>  		kn->attr.notify_next = kernfs_notify_list;
> +		kn->attr.notify_event = FS_MODIFY;
>  		kernfs_notify_list = kn;
>  		schedule_work(&kernfs_notify_work);
>  	}
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index b5a5f32fdfd1..1762b32c1a8e 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -181,6 +181,7 @@ struct kernfs_elem_attr {
>  	struct kernfs_open_node __rcu	*open;
>  	loff_t			size;
>  	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
> +	u32			notify_event;   /* for kernfs_notify() */
>  };
>  
>  /*
> -- 
> 2.53.0.273.g2a3d683680-goog
> 

