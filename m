Return-Path: <linux-fsdevel+bounces-15019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E6885F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CBF1F26572
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E39013776D;
	Thu, 21 Mar 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fNCuajIk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195BF137755
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040705; cv=none; b=IIHly+J9CwZkosDXoXuivxMDOVhYu1irZBRdQenh0ogVF6/XR3UOpDSG75aJlQloZlRQ6KYcljJUuJet+XH8IJyiDMqnM7AfN7K0N2dQ60Ma/PCz+BNw5NRnjA7gAob/pLbFwGkcmBkbunYctXLziyJ7ixTmNQ0M1JKBjzrW4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040705; c=relaxed/simple;
	bh=F7BZPRrnGiUnAuBv0KvmsW8b1nfHOpvDFLxdGkrbpm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l89eZPMq3woKR6l7yiWNj864+GVW5j5OJS8ZxvJna4Ieh3oqJJIVhwVrhJUYlvrh/K2oA+xVRFB6OT1gMltKTlKegQAC41eHwxeFsxbBLTq07VVrv9/YGmMyv/iGneVg7BTtv4gaCiJJS+CO1OmHUDYo6h5z+SxUH7Q2EuxHy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fNCuajIk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e8f76f18d3so999336b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711040703; x=1711645503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=abV1KSQfMj1DzU4Wxs3gXedK8VwaffSMAGzyZA+mQ48=;
        b=fNCuajIkfUB0fTpb8UiK4C/yfMmbOvutmU/1Ppb6FePYcwb4lU2BnxCqo0vlNNniwg
         180bQbGurOpKxEeR1LilXtOfvwIilSztCthOJb9wXUIYJ6Ycqr5v8zEL02FY1tmwT+YK
         Ujk2x1j6oHhqotvox6FVelVonE5C7hZYMDV/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040703; x=1711645503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abV1KSQfMj1DzU4Wxs3gXedK8VwaffSMAGzyZA+mQ48=;
        b=O6cPMAFcqW28lRSt57Agwmc2SGBvRFolHWZo4IseUmeNr+Ye6JeemRdaFqTM2K66LK
         /QBRB9K8lNfmqC7zwtawxdaqF1Xxb0kr4XiTQCtmiFVvmjaThfStiQUnynjQnq+owJbf
         l8lL2ZdvqdArIqsm7zviODAvtSMSWrowVu+fVukZ9VDTF0Np/2pR+mfO6Vk5g9Kn/GZv
         qTuC82cZbxN2gam9zZIf/+iowxsyz4y/zeDBYuRoNisuleChzkySXEYOeap3u5YMoTJd
         fPB8o8OEAHG4TsXQjA2V8Jd90bHm3bxw9Woy178jJaMVIl3rvwqWRIb38ir+JaSqgSID
         EOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/FCtNFXXs4Yl1sSNTB28F/cGssPD5XlxLPUQBqw7iV1yUm5/qKOxW0SLch2R0rjCkHprCLHnGGGKr54XpE8mEila0MFaBTnRB0dUKpg==
X-Gm-Message-State: AOJu0YxHRYX+NG2shgDARXdE3bZ4iTh4VswEjrp1C+BCSEbSTPS5F23J
	FsZKpdR4hFAP8LfqprON+fDtV+JG51wgZ41GUGuR9Qo7roWrdjt4AImQDB3w5A==
X-Google-Smtp-Source: AGHT+IHjXoA11dA50WtbnjUSI44eAM2tLeRUNZtkfUInXbO/jmancQD+KVgSdBcSUYmuk5/U/6YV+A==
X-Received: by 2002:a05:6a00:3a05:b0:6e6:5291:1779 with SMTP id fj5-20020a056a003a0500b006e652911779mr4275257pfb.6.1711040703382;
        Thu, 21 Mar 2024 10:05:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a62d150000000b006e731b44241sm73573pfl.42.2024.03.21.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 10:05:02 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:05:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>, stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Message-ID: <202403211004.19F5EE27F@keescook>
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

What's the best way to test this? (Is there a qemu setup I can use to
see the before/after of AT_EXECFN?)

How did you encounter the problem?

> 
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

-- 
Kees Cook

