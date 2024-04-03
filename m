Return-Path: <linux-fsdevel+bounces-16029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2EC897192
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 15:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BE92821AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57112148FEB;
	Wed,  3 Apr 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chCBJ5cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7F148FE1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152229; cv=none; b=fFTLXrpLN7CNeU0nmO7UYKdxylBAYhJczzPkJbsF44JwUR32DOISanQZreBHu0guxG6aYHWBst0XAhVYG9PsHjfLCxSOEtT7NzHBJDVZnA4KS52mXLdWBN/CLObR/ZnZp4wio3K3BI/2iU/ECduoLMQNXt90OaLCzw5iOjIwhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152229; c=relaxed/simple;
	bh=SNs5mn9q2CYcjUZ4AvUrXAt5dsOuFa1tNz0XiT4priE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg2tGj+w/T98LOBxZ9OU4kRqtnMuPOcpuDjIGqzTsUh/JJ4IISKN7/sIUuf+iKuL+1RynCVbKqbK4yVdL4maYknQTL39a4kjdJsWifj8eHx9w182Xf5z2Tx/qVO3MHJo95vVfgvHlnIPiGEACoEr2WEbK1s32r/GJSfCXhzZlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=chCBJ5cg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j7/etqMGMPSyH+wRa4krhFIvV76igxRl28+rNLU7x/M=; b=chCBJ5cgiUK22CWM6VUCUezLPy
	8Ci+of9g8uj1J+mSwIY4pYgP7AM0ORMKqbETNBX8NijAjRIAhFaa4YWXCcYUXK93c/qeHGx5374Qj
	EyLJO8xyVA7T1IZWqTM2cbDUoRJVOwctCYQ/RO23NGyYYw8eTQsWoQje8PDnZlSoA8lC7u4jxKm/k
	FW25cMvxCYFdGsgTSMZBQmReGQJpikEOaGp7+wNvQ1s5TFKu8hw7b2FQYsVsGcDwQU7mZs+t6MwL1
	aZKpoi7HElHE9mk7UYpoNTg9CsHsZIaLrs2EjJvOftuFeU+j0vCdzvidEQDnKB7g7tRm3BZ5zw74E
	CUHWGU3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs10S-00000005hxO-4A5W;
	Wed, 03 Apr 2024 13:50:25 +0000
Date: Wed, 3 Apr 2024 14:50:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>,
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
	"dchinner@redhat.com" <dchinner@redhat.com>
Subject: Re: [PATCH v1] exfat: move extend valid_size into ->page_mkwrite()
Message-ID: <Zg1eoJToXZYEHqg4@casper.infradead.org>
References: <PUZPR04MB6316A7351B69621BA899844F813D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB6316A7351B69621BA899844F813D2@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Wed, Apr 03, 2024 at 07:34:08AM +0000, Yuezhang.Mo@sony.com wrote:
> +static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct address_space *mapping = file->f_mapping;
> +
> +	if (!mapping->a_ops->read_folio)
> +		return -ENOEXEC;

Why do you need this check?

> +	file_accessed(file);
> +	vma->vm_ops = &exfat_file_vm_ops;
> +	return 0;
>  }


