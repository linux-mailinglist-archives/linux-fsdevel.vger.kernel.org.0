Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646C12B12D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 00:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKLXeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 18:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKLXeF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:34:05 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1760216C4;
        Thu, 12 Nov 2020 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605224044;
        bh=nIRSdK3tKYO0dB96JMwbQCTv9g20dpAdzhZB7YmaRK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4o/eT8S3rHpaYU2ovTaREn4x63NGmbuebMoRLeUHo9nku9A4UDKJKGKX8cZU62ga
         DObxWaQbPaDHtEg2VzM01UKzs94oXvo7yItjoUm1HAP0U+Uh0TWzkNs4pxdcHFcSIE
         ok0JdHWG9sKSUz0hBZjtCuCMpsvv0dZZ9suFRQ4o=
Date:   Thu, 12 Nov 2020 15:34:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <akinobu.mita@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
Subject: Re: [RESEND PATCH] libfs: fix error cast of negative value in
 simple_attr_write()
Message-Id: <20201112153403.ea479704feb70d99dc114a10@linux-foundation.org>
In-Reply-To: <0b3954a4-1ac9-c454-a0ea-1fa1be5975b8@hisilicon.com>
References: <1605000324-7428-1-git-send-email-yangyicong@hisilicon.com>
        <20201110111842.1bc76e9def94279d4453ff67@linux-foundation.org>
        <0b3954a4-1ac9-c454-a0ea-1fa1be5975b8@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Nov 2020 18:18:31 +0800 Yicong Yang <yangyicong@hisilicon.com> wrote:

> Hi,
> 
> Thanks for reviewing this.
> 
> 
> On 2020/11/11 3:18, Andrew Morton wrote:
> > On Tue, 10 Nov 2020 17:25:24 +0800 Yicong Yang <yangyicong@hisilicon.com> wrote:
> >
> >> The attr->set() receive a value of u64, but simple_strtoll() is used
> >> for doing the conversion. It will lead to the error cast if user inputs
> >> a negative value.
> >>
> >> Use kstrtoull() instead of simple_strtoll() to convert a string got
> >> from the user to an unsigned value. The former will return '-EINVAL' if
> >> it gets a negetive value, but the latter can't handle the situation
> >> correctly.
> >>
> >> ...
> >>
> >> --- a/fs/libfs.c
> >> +++ b/fs/libfs.c
> >> @@ -977,7 +977,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
> >>  		goto out;
> >>  
> >>  	attr->set_buf[size] = '\0';
> >> -	val = simple_strtoll(attr->set_buf, NULL, 0);
> >> +	ret = kstrtoull(attr->set_buf, 0, &val);
> >> +	if (ret)
> >> +		goto out;
> >>  	ret = attr->set(attr->data, val);
> >>  	if (ret == 0)
> >>  		ret = len; /* on success, claim we got the whole input */
> > kstrtoull() takes an `unsigned long long *', but `val' is a u64.
> >
> > I think this probably works OK on all architectures (ie, no 64-bit
> > architectures are using `unsigned long' for u64).  But perhaps `val'
> > should have type `unsigned long long'?
> 
> the attr->set() takes 'val' as u64, so maybe we can stay it unchanged here
> if it works well.

Sure.  But the compiler will convert an unsigned long long into a u64
quite happily, regardless of how u64 was actually implemented.

However the compiler will not convert a `u64 *' into an `unsigned long
long *' if the underlying type of u64 happens to be `unsigned long'. 
It will warn.

