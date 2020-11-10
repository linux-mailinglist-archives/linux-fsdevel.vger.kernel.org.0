Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B752ADF2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 20:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgKJTSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 14:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJTSn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:18:43 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D512054F;
        Tue, 10 Nov 2020 19:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605035923;
        bh=QyaQj8nTAcAePgBxv8GT7EUTzLqnjFIqlPDgD7W/gko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXutxCxmOb4O7uW0nfSaG1esxskxJHgmpeYeSOOdlK9bujKeiUkijwgWvglSsfH0h
         0UwJokCJsFTeHzDyS9tjtVxZEGXnYqzVLL2tQiOYsSse7EbDhsIVYigP4j4vK0GN2u
         7zR074kr/3rwJbZkU/7M7V3lLz8Fw8aV1K2BKEj4=
Date:   Tue, 10 Nov 2020 11:18:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
Subject: Re: [RESEND PATCH] libfs: fix error cast of negative value in
 simple_attr_write()
Message-Id: <20201110111842.1bc76e9def94279d4453ff67@linux-foundation.org>
In-Reply-To: <1605000324-7428-1-git-send-email-yangyicong@hisilicon.com>
References: <1605000324-7428-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 10 Nov 2020 17:25:24 +0800 Yicong Yang <yangyicong@hisilicon.com> wrote:

> The attr->set() receive a value of u64, but simple_strtoll() is used
> for doing the conversion. It will lead to the error cast if user inputs
> a negative value.
> 
> Use kstrtoull() instead of simple_strtoll() to convert a string got
> from the user to an unsigned value. The former will return '-EINVAL' if
> it gets a negetive value, but the latter can't handle the situation
> correctly.
> 
> ...
>
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
>  		goto out;
>  
>  	attr->set_buf[size] = '\0';
> -	val = simple_strtoll(attr->set_buf, NULL, 0);
> +	ret = kstrtoull(attr->set_buf, 0, &val);
> +	if (ret)
> +		goto out;
>  	ret = attr->set(attr->data, val);
>  	if (ret == 0)
>  		ret = len; /* on success, claim we got the whole input */

kstrtoull() takes an `unsigned long long *', but `val' is a u64.

I think this probably works OK on all architectures (ie, no 64-bit
architectures are using `unsigned long' for u64).  But perhaps `val'
should have type `unsigned long long'?

