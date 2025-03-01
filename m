Return-Path: <linux-fsdevel+bounces-42876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70CA4A8A3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437633BBE6E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 04:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113231ADC93;
	Sat,  1 Mar 2025 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dajWCXIi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556C2F56
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740804380; cv=none; b=CwFMm6JG9PGkcoVqH6WhanKPyX+rfieAuvNVptSn2lz6bMthrURtzYq3ZvT/h7TGXDbr9JK5mdf96EagZhFmJyb96aGIDIcgYIZTUwBybpZVTYbpYQMlvEya3BRQW+gmDRFTpE5R/a/dyo+Pru6IfPlTwkNb4r4OAcpdFFUb6Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740804380; c=relaxed/simple;
	bh=9CcV72lZH6t8fpIV3dWxRu2ZtJjkP6wYZjTHWZzTsA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXFtdN+9mURws+r5UN3f/Ch7OLMTuLgM1cvgySps6D951PeDBF40j/bmeAG0h2C7AJnYdDSqY+J4TH0lrHBDxafaOaPsMPsi60Do3iinKhNYAUt2Q01ILRdf1LWcAcKvWNF/Q79ycXvpjZnfFzgJp0NoEdmDMzFPti+T9fEkADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dajWCXIi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439950a45daso17880805e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 20:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740804376; x=1741409176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aE0LCDUko6eQcYdA1egDiPI4BFrvTBjOmKpd93ehkP4=;
        b=dajWCXIiL6Nh5c+HyEnqLCwz7JE3+BLfNjYvjlJCf9CKPudzYbr1hlr3EIr35j2iKE
         P8KjdKMieTsWN3kAwzFcTglYDflZhv7A4M8JxtuVLblD/f/1/SfV2c2mmnlsrLsdOQrQ
         RME5S5EaNHkyMa0cXYw/OYjdurSu4DOmgaH+o4jI4/3ON2+lYbG8qC3JnrgV7drpdeoO
         Ai/r2fwQ3w4hofeIO/MAm0duJQQSIOLXsHvu8VGvAmx9PEXZOZ4lziWMEeCiUNFF6Bec
         LrJRA/sCpIbrXOxw2KVwC00wOwllEGtSzB0yGVvodxH42OXMw8kILneZrToIuEbjX30g
         2lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740804376; x=1741409176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aE0LCDUko6eQcYdA1egDiPI4BFrvTBjOmKpd93ehkP4=;
        b=HzRw44xuaOYTr12B8nUOACGJxvzUFwdJqzBhO0W6r40v6YNkm9CyXiu2u4r5E3kQTj
         P10l5X/TNiLh6Fc3CfuNzj0uXecAL6Xqywar252EApRp4C5IZtYy38oUjTeB3/Yz8rGT
         Q0E00AIRcOchEmIoidbodvMZgqwZTIUt8coOxAU/4JIsbO6eBiZqmc3mQg3JdR7XSjmo
         fYQsBCP7Kb18eDzG8hHP3gsVaPi0rPlrOaXpNfK1vP1bvtnTyQaWnK2Om+Lk3z88dGig
         zooMRQnxU96wkESY+9L/AltQBl4fkRZE+w/3LpnMCpUEuyq/a9iavjlozJxQS86HtXmx
         yNFA==
X-Forwarded-Encrypted: i=1; AJvYcCWw3UAmFghkggev1xdnbBdXZyTwxrvDlHZMDb7lYp2Yqw1sdyRp+sXN2b3sh62bWxqqOZ4GOgP9BHIW6zOy@vger.kernel.org
X-Gm-Message-State: AOJu0YxOahH87oWEkbQH6Mdwz2gyp5xIz+mT4GER7ckayRaaw8iAuZEv
	Y3y1ZWcqycrJU334SaB7gUOMmlwSv7su/haJCwaYlksoVlRHzfk=
X-Gm-Gg: ASbGncvX3ck/NAWR1rRgmSR2+u59+2BvN93OdnLPWa3crLDmM39Ich5Vbr13BdUqCES
	wmDz3XmWBnbHJsYCJccVg2g+iKjrZZMUMaBcvQUHI/uSURTEb912nNneTK07/OPlUefi66sjNBt
	thGien/f5Hdng3r1RCKX/bmBMGVB9LHAhJvnFm9nAvfaXaitP/G4jFxTXs0usqmNm24FU3CsGDs
	18E5A+B1EtDFpkD53O3lBj9Iw7XW/TIk8aKN7astYwWInEP215BK5QJqo5A4oI5OOLc6iEqAcym
	KBVseOPXJbAzAZSeQQXssx0ax4++OJJbwA==
X-Google-Smtp-Source: AGHT+IHFg6kkiJUmjxI6SCRgu9D7dV5gOPJvnjyVVJtLW1ma14lrPVkjO5do0H67EPq2pEHS2j4KLw==
X-Received: by 2002:a05:600c:5251:b0:43b:8198:f6e5 with SMTP id 5b1f17b1804b1-43ba66e1dbamr46784055e9.12.1740804375859;
        Fri, 28 Feb 2025 20:46:15 -0800 (PST)
Received: from p183 ([178.172.146.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f74e8sm82400145e9.7.2025.02.28.20.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 20:46:15 -0800 (PST)
Date: Sat, 1 Mar 2025 07:46:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: akpm@linux-foundation.org, rick.p.edgecombe@intel.com, ast@kernel.org,
	kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH] proc: fix use-after-free in proc_get_inode()
Message-ID: <2cdf3fb7-1b83-4484-b1e6-6508ddb8ed13@p183>
References: <20250301034024.277290-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250301034024.277290-1-yebin@huaweicloud.com>

On Sat, Mar 01, 2025 at 11:40:24AM +0800, Ye Bin wrote:
> There's a issue as follows:
> BUG: unable to handle page fault for address: fffffbfff80a702b

> Above issue may happen as follows:
>       rmmod                         lookup
> sys_delete_module
>                          proc_lookup_de
>                            read_lock(&proc_subdir_lock);
> 			   pde_get(de);
> 			   read_unlock(&proc_subdir_lock);
> 			   proc_get_inode(dir->i_sb, de);
>   mod->exit()
>     proc_remove
>       remove_proc_subtree
>        write_lock(&proc_subdir_lock);
>        write_unlock(&proc_subdir_lock);
>        proc_entry_rundown(de);
>   free_module(mod);
> 
>                                if (S_ISREG(inode->i_mode))
> 	                         if (de->proc_ops->proc_read_iter)
>                            --> As module is already freed, will trigger UAF

Hey look, vintage 17.5 year old /proc bug.
This just shows how long I didn't ran rmmod test. :-(

> To solve above issue there's need to get 'in_use' before use proc_dir_entry
> in proc_get_inode().
> 
> Fixes: fd5a13f4893c ("proc: add a read_iter method to proc proc_ops")

OK, this is copy of the original sin below.

> Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")

This one is.

Let me think a little.

> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -644,6 +644,11 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  		return inode;
>  	}
>  
> +	if (!pde_is_permanent(de) && !use_pde(de)) {
> +		pde_put(de);
> +		return NULL;
> +	}
> +
>  	if (de->mode) {
>  		inode->i_mode = de->mode;
>  		inode->i_uid = de->uid;
> @@ -677,5 +682,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  	} else {
>  		BUG();
>  	}
> +
> +	if (!pde_is_permanent(de))
> +		unuse_pde(de);
> +
>  	return inode;
>  }

