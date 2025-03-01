Return-Path: <linux-fsdevel+bounces-42881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E42A4AAD7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D7A3B9084
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09E1DE4DA;
	Sat,  1 Mar 2025 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ7GW3rG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA423F383
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829919; cv=none; b=uHzqACf+DOg6/GPBrYJxrjRLpwCQj9PDf4qI85Spon3IF1tpXYHTgUo/GqCN/2xLoBKbwRw5kfZ3Ej0FtKAxpA5pJuK2CQ/cifxvmjRahMSDODDptUUno+I/yy/hSvkctRyzb8zk3A+gHVZPRbn9sE8pIubLZT/n/S8McH5HRn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829919; c=relaxed/simple;
	bh=jTxCf3HjD0u3GuYFbiEO6icy7sUbcibTl7xtnF2TTzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTGh2qvSD3jZj3v4a0GIUqsDuEZ1u2ukDqVsDPo2UvNe9gmHYd9LVsWGjrgq6w2vcdr2l2WggepFm8V6VzDHM+D7/0f5PcCZYLgeVydTBNDQSB2YP1KnpzXzsOqWci2GbZRA8NeQ10uCXc0Rbl328ZKYwbmHu6I1M7rCzY0g8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ7GW3rG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so28244735e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Mar 2025 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740829916; x=1741434716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWknNrmhgKXLnSev9yJeWxJd5ndh9CuLKoS4J0Ev7O8=;
        b=YZ7GW3rGPWhb2uXBAGG4vO78FSLJV5VPVyu4uRK88LXSF59ncDOq+tdte7UqkSd7sk
         H7jLXQDMFkyTE0eoEPWdT1HXf+phkB6TcZL78vupOJH17ddYf1nNOjT/atRuOGc1VE05
         OJm4NspWsu4WHxPcmcppd1lM30QkFlVHcaoOZ+ecytDDW0m7ncBm9PPK/NAyaUT54ZNq
         JMWWRjbCfvQk98dTOXSE8CYdYjgL3ySAhfTEELpmvt1FjzgfNIifuQivcmkxZtMk1IWr
         Q1ky4CCHmOPrXAnQuFT9eOJHwNL/wKwHn7XI9OF6wIOol0ZlBKfgzmQ26awe4di9w453
         +DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829916; x=1741434716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWknNrmhgKXLnSev9yJeWxJd5ndh9CuLKoS4J0Ev7O8=;
        b=qlHpkn86Map5+Y5j8yTMa4YLXLjhDcF7YVw756g68Ga0WztqDBAjj1T2Y70tjwgwRb
         sJnsAvYNFtOoat6q/UgIpf6mYWdScreV3rZekpTJd5zYL0yfdjmIOI8Y9OUlag7jG/T3
         zoXB7h2lYVrBa3vneyqFdqmFF/7ypf85tK7XgQWQ1CIpogxOigUqJwnXuAkpqC3xQ9Xa
         W75+8ZSLtcnqQtOZ+L28YU+Hj+lFxms58T0buLsBQrSwSstdTMJazdDimDDy4VeTTTTU
         Zfjy19Mo+BCo24srykjB2Utbk7vEXRk4DkSATOLn7IjG7J7E9GTL5NaqlrGiI60Qvj5j
         ne3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP3YYn7MbXdNSGLFH1U+t5QOmNfNuUozKfUZsVMB78/eOzo64X2P5e5deM8l5C5uN0uqxFWLJuHw64B0Wi@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh29R6G0bJCddthF7Y34LtbZaxeDc0UG/xHRx6/EkoyVjXDdxl
	AYrkWK6iYUcfFM6/uq8SPNcL1kR52e1PTG9sWRlZEX0oZkOxBRBwK4zQ
X-Gm-Gg: ASbGncs/W75/B871o9XAPb1RGOX+j18ciI76hN6WY9EaklG4+Dvdm0XVaYQzPBNiZ46
	4sO7XE2JHY9Mr21t0XnwxQ7Mo0V9jHvkvu2hwvuYNoKiAkeBHnIt7AxFxz616Eq6Rqxh7v70CA6
	GJWwTjsDkpPlggxYvLMOAY51OtGBx+JZi+UGGJWvm9f98fTQDMqSfJqR9x4byN9k52znNgzjZkr
	mXiL3RRXC2lBdLAK4MlKekvkXjKPCCMNbnEgNVsDpBC+CYwOKNozTfSJtpSvUF4KWAlS7rXYXbA
	zp86BISjyF4hdAb0wEEp3w7kquU/HcjpmKXo+o4TTg4dNc71UGvF75aiU+IyjWwRyJj1utBo9ia
	H0nIl5YHBqfa5Sg==
X-Google-Smtp-Source: AGHT+IHJL8qYe9qfGtf0J/3zCd+aZjTc10RSEXZyh6G6GQfFpop+y6sZcXyJktpyrjvG9FwSVQploQ==
X-Received: by 2002:a5d:6da3:0:b0:38d:d0ca:fbad with SMTP id ffacd0b85a97d-390ec7cb8bamr6431615f8f.14.1740829915527;
        Sat, 01 Mar 2025 03:51:55 -0800 (PST)
Received: from p183 (dynamic-vpdn-brest-46-53-133-113.brest.telecom.by. [46.53.133.113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm8036709f8f.71.2025.03.01.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:51:55 -0800 (PST)
Date: Sat, 1 Mar 2025 14:51:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ye Bin <yebin@huaweicloud.com>
Cc: akpm@linux-foundation.org, rick.p.edgecombe@intel.com, ast@kernel.org,
	kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org,
	yebin10@huawei.com
Subject: Re: [PATCH] proc: fix use-after-free in proc_get_inode()
Message-ID: <9760f1ae-7aec-4e17-b277-ea6aca13b382@p183>
References: <20250301034024.277290-1-yebin@huaweicloud.com>
 <2cdf3fb7-1b83-4484-b1e6-6508ddb8ed13@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cdf3fb7-1b83-4484-b1e6-6508ddb8ed13@p183>

On Sat, Mar 01, 2025 at 07:46:13AM +0300, Alexey Dobriyan wrote:
> On Sat, Mar 01, 2025 at 11:40:24AM +0800, Ye Bin wrote:
> > There's a issue as follows:
> > BUG: unable to handle page fault for address: fffffbfff80a702b
> 
> > Above issue may happen as follows:
> >       rmmod                         lookup
> > sys_delete_module
> >                          proc_lookup_de
> >                            read_lock(&proc_subdir_lock);
> > 			   pde_get(de);
> > 			   read_unlock(&proc_subdir_lock);
> > 			   proc_get_inode(dir->i_sb, de);
> >   mod->exit()
> >     proc_remove
> >       remove_proc_subtree
> >        write_lock(&proc_subdir_lock);
> >        write_unlock(&proc_subdir_lock);
> >        proc_entry_rundown(de);
> >   free_module(mod);
> > 
> >                                if (S_ISREG(inode->i_mode))
> > 	                         if (de->proc_ops->proc_read_iter)
> >                            --> As module is already freed, will trigger UAF
> 
> Hey look, vintage 17.5 year old /proc bug.
> This just shows how long I didn't ran rmmod test. :-(
> 
> > To solve above issue there's need to get 'in_use' before use proc_dir_entry
> > in proc_get_inode().
> > 
> > Fixes: fd5a13f4893c ("proc: add a read_iter method to proc proc_ops")
> 
> OK, this is copy of the original sin below.
> 
> > Fixes: 778f3dd5a13c ("Fix procfs compat_ioctl regression")
> 
> This one is.
> 
> Let me think a little.
> 
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -644,6 +644,11 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
> >  		return inode;
> >  	}
> >  
> > +	if (!pde_is_permanent(de) && !use_pde(de)) {
> > +		pde_put(de);
> > +		return NULL;
> > +	}
> > +
> >  	if (de->mode) {
> >  		inode->i_mode = de->mode;
> >  		inode->i_uid = de->uid;
> > @@ -677,5 +682,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
> >  	} else {
> >  		BUG();
> >  	}
> > +
> > +	if (!pde_is_permanent(de))
> > +		unuse_pde(de);
> > +

I can't reproduce. Can you test new patch -- it avoid 2 atomic ops on
common path.

If the bug is looking into pde->proc_ops, then don't do it.

