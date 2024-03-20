Return-Path: <linux-fsdevel+bounces-14905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4863788143A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038EC281BFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A434EB58;
	Wed, 20 Mar 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPVEY70f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AC4D5AB;
	Wed, 20 Mar 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947540; cv=none; b=Jiu7w5qw/BHwZSxZPZKxcEQqhAqn86FUqtcijvdHkfChVtKMf9L12GQ4BUC7+VUh7MZqaU0/ABW7me2AMTl960P53eM+7k9rr1HTsMnJyfSnEV2wzqUB4ISpxRZQ8qWiVsADXzANFSKEPJp94u6Ycc4sN6Ogo3XOq8YTYmjYRjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947540; c=relaxed/simple;
	bh=JBm3tKEy8c3qv/abgEtj16lwVaxaRDzvpv3wWbXgvoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW5Cr8iwASU5PGsPx7/42xEWdw8DlmDv5umsHuexmyNhiKmMYaOWxSYOnboqk5yRJ+qD978sUCnVIbqAcNFCuGGptlInWj152HTzQ3ibGpybBVMk7sLVtPG5KYeDIDVbYgXm6jamntAcyGk9VcEwuiwNDLVK3v+Tvho2BrLXRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPVEY70f; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f4155b76so71639477b3.1;
        Wed, 20 Mar 2024 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710947538; x=1711552338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0Q7XVy7i9nvarztc7Je9Voa0UwdstlOrHeH8QzsOW8=;
        b=kPVEY70feQ6INpM/cO6P8s3LILQsIXgUApfys4WCsPfM6y8+VSG+RifLdvY5RplAIJ
         TTUznBtzvml0Lk9nS55swvn4GwARAbr6VKOHu7NYrgOSXmXCF0FjeKVBnr+ZLZjj3cYs
         RijUKHNa0NLmfQHsvU3pFUyQLrlJT7GWXhKP0SwUBtYWBkiSgHGpZ6EIdO8c7iuWHPzf
         ZC2kDPxu0y577Z04HfD3gKOg+AEmIf1UAHItXVI08bLgYF5zF6iWdCuMF8ngeGfgEMmL
         +JmIGfLpmncmZK/c3KlsE1DKQBzqymPo0iwQcpCozeAnfgBp5WBOid6yBhHxqpwLZoTG
         jDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710947538; x=1711552338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0Q7XVy7i9nvarztc7Je9Voa0UwdstlOrHeH8QzsOW8=;
        b=kcjWcbNWJCAccO6/ZgzCpy3Rnjppbl8kwxzHgFnpFX8MKRuX+g9yXaCVAMqRUC1WPI
         +hvWzrwBS5SjFhfQGwB7uZetYQJc8NqbMy3/31EKrHwfPvln9y5S8HZUOWG+zm71Gv0A
         ONc20CnGyM2maiP0AABJ3705V8FjJiJ46cZfaVVvrz3MC8dTEv0BBM2HZ7Yq8ou2qTkI
         P+qmokik89zPl7Pr9mCwOwKwwknuaG2JvaJJQZniMUQlmBeCk0NPVw33WnsYNGNOnm8a
         UzxJHwPpPAN1Gvd1rDUxIgGfDbJrgPLfdyHJskw5V9E2uRoP1VSvWdyXiFeEMo+v+f43
         NMGA==
X-Forwarded-Encrypted: i=1; AJvYcCWeO8AVHxv/CGZg6Ub+on0B1i+x8n80prDxlfhYfTGlJQKC8YjdSRoPjdatv5jp3aXTj4YnWYnw4quKM+9x62Wb+RDwVLAzMCG4dA2GT51ImvTG258wKYEsQD5ncscVytph2ibeUN7XLIDtQg==
X-Gm-Message-State: AOJu0YyOKous608PojxaJGkRphtBnFRo+fLmsCAbq6fKIfscH/YKsRSL
	VleBWbps6VwhhJdJXPRdDeK0xqBkifaPFH2LvOefXmVYtinGxr5s
X-Google-Smtp-Source: AGHT+IFTR4fm1uStL8cRl6ajaCTynzvyqW24aoW37kXmZJk/KJEYBtwHoXZooYT4+Fw2P9ONeFWmVg==
X-Received: by 2002:a81:430d:0:b0:610:e289:aaba with SMTP id q13-20020a81430d000000b00610e289aabamr4805790ywa.51.1710947537705;
        Wed, 20 Mar 2024 08:12:17 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id z5-20020a81e245000000b0060a10495664sm834091ywl.94.2024.03.20.08.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:12:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 08:12:16 -0700
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 4/6] writeback: add wb_monitor.py script to monitor
 writeback info on bdi
Message-ID: <Zfr80KXrxyf_nJAz@mtj.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-5-shikemeng@huaweicloud.com>

On Wed, Mar 20, 2024 at 07:02:20PM +0800, Kemeng Shi wrote:
> Add wb_monitor.py script to monitor writeback information on backing dev
> which makes it easier and more convenient to observe writeback behaviors
> of running system.
> 
> This script is based on copy of wq_monitor.py.

I don't think I did that when wq_monitor.py was added but would you mind
adding an example output so that people can have a better idea on what to
expect?

Thanks.

-- 
tejun

