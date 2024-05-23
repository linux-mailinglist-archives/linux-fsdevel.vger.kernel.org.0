Return-Path: <linux-fsdevel+bounces-20043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265998CD085
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7851F229FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F135142E67;
	Thu, 23 May 2024 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zfF6dsOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5730E149C5F
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460994; cv=none; b=LpQBnWvvTz4q8IFN+dG9YtPO2O/BzIynoS1QgfJH+APBXVb9VF9wB8R1AOenNFEoUEJ9nxJVxoRw5RK2mScZIVsq+jCuLoxsVJYDKZROuR9etdei3s0H2e5irXqL9WxlVruvEgQz9RjaHqEm177iUB+Sz0LhV3vqac9Du2s8JfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460994; c=relaxed/simple;
	bh=wZhUgojuughYgYYxrpvMtVev5QWws6XkQH1DYbz9qm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZQDuwaNj93C+9Q4iQQ593XvwC3MsbhR+NKHdphenWkt+DrSjI20LseciP6Ys9a2eZGvJ16bANFqmYD68BqdvKvjIMRADGsM/TCjU13uxhXVbkVn4gbJHHKZrd90u3axmJ/ya7WIJo7vFtIpLwiGXsBkWyCy0c2kdkVBDmviCGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zfF6dsOV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso17290855e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716460992; x=1717065792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=blpZAozQ3ITK7SHWW4E6qfsTgxzl67pxZ/Pvq/s7bP4=;
        b=zfF6dsOVK3PrVhi86KFkTSo0Pf2H8OIDsuZVHf/HRAajCyeQJhHVhddfYyu4Zais0a
         OceD/NZbQwdksjcBQMq7wxaPLq7i0Gs3wVnGtqLlhclridPCwpqjCxvb0Zg3xC7ijvQf
         BkyXtPPe1Lk/1Y3FbpzuXygKNWHnUXv/6dTJpqK7jFgrlx1r7v8wfvmcaF7JBAYkwxub
         SXgPyCOosOa2W6+ObBX5GpgAl0q+5CBB6xATrZF9K80Wx4y/FiuvQqChufeWd/Z/lIs8
         fsu9M70c3NBuSL9CavFttc9bsKY9yRn28bjAOkjq5krzEl9qKtuZW0LhGrII7RY+iMKm
         Zz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716460992; x=1717065792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blpZAozQ3ITK7SHWW4E6qfsTgxzl67pxZ/Pvq/s7bP4=;
        b=J0gYpHG0GG9rK/pahcaLrqXzvjEWvyhBZfaDwOYWuewF018fWcoiNJ6Fv3miNB/405
         0L47BcqBXjopODmamgpbTC44KAuoZz6K0ywBoetcYeLDwaXl9rv3GTs8iwwyQlD15Cff
         cpLHG0HntnwZU7XP6Og2VlStC/8Y9FFTjyp6F2Ja4BCr5p7IPhAi56Bp/oe9EOJvB4ki
         N2tC/TBvnvbseBirJ+5bqiGm3CYfWguLVjqNRUDR8YQO6FBQ6zeiw2vH63356hN9w0Zx
         WeiTciThQfAEtaH5cV6S6L1P35vOA1+G6+XzCPnJNLr8njrgi2GW8ef7b/KicagdNfP0
         F1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNw3qL0bnGB5KYOFDeDf7jva431rjlIHaZCX+elx2We2Ueg1E5LehgGeqUin4fCLQd2M22yUPoop4UpxND2I9be+AGfUd5CIM8yrH9vQ==
X-Gm-Message-State: AOJu0YzNMXe5E3WPDVsJlh5AO943hpAWM2L3WXyfgvREPlKe/x67fOoP
	BGq4LtrXMAZbcbadE8L8R36czQJaIYlZiNjCWYmYI5DRK8U7L/gUu9Z3K14CvLacKLne0IZ4SqV
	gikc=
X-Google-Smtp-Source: AGHT+IEqmfLIqt+uK/afgKxha+DGnAVwMJxlTN1e6e0x6vAfoT8OIivGDrhmD2js1LqTqRKN+1LR6A==
X-Received: by 2002:a05:600c:1f90:b0:419:f241:633c with SMTP id 5b1f17b1804b1-420fd2d79cbmr41007515e9.4.1716460991618;
        Thu, 23 May 2024 03:43:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad58dsm21528105e9.39.2024.05.23.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:43:11 -0700 (PDT)
Date: Thu, 23 May 2024 13:43:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: oe-kbuild@lists.linux.dev, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
Message-ID: <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
References: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
 <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>

On Fri, May 17, 2024 at 07:21:09PM +0800, Hongbo Li wrote:
> Thanks for your attention, I have solved the warnings in the following patch
> (the similar title: hostfs: convert hostfs to use the new mount API):
> 
> https://lore.kernel.org/all/20240515025536.3667017-1-lihongbo22@huawei.com/
> 
> or
> 
> https://patchwork.ozlabs.org/project/linux-um/patch/20240515025536.3667017-1-lihongbo22@huawei.com/
> 
> It was strange that the kernel test robot did not send the results on the
> new patch.

With uninitialized variable warnings, quite often Smatch is not the only
or first checker to report the bug so I normally search lore to see if
it has already been fixed.  In this case there were no bug reports from
Nathan Chancelor and the second version of the patch wasn't marked as a
v2 and there was no note explaining it like:

---
v2: fixed uninitialized variable warning

So it wasn't immediately clear that it had been fixed already.
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


