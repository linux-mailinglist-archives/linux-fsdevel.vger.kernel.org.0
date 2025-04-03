Return-Path: <linux-fsdevel+bounces-45590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF0A79A21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 04:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A8F7A59AC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2EF18A6AD;
	Thu,  3 Apr 2025 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CcUAl6+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC85149E13;
	Thu,  3 Apr 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648487; cv=none; b=u5um8yXN2HCNN1/VrINtnJ+c4RN6p9FiEr+XAMJrNd9EYJNb9PaHqVldDe+c+CDqePBjFs7Std8ipmQZv1Tq40RAu988vcjJtWrDu0/EqlOR2pODybDQ2yO4PGciWspMMOrwv68GnUpoZknWQwsOAZNFbuAjVzg1u8D2OgsgE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648487; c=relaxed/simple;
	bh=JiZ0yPlBWbC5qsQiWdQY4dY24O4HAbX6YfiLK1mqrMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT+R7PPy8Agwt2hMgThFUXj0iGCzwtXFvtUoiI9ec15fT0G8GPWRLeFKRX0NVjCKxx7CDR3BsT25/FLsw0sHirrBNjcWwPUuuHcHp+KCpZHtzqVtHkHDrgeOsE0liIGzE77I0/fhZKQ4DbIcONpjowm4cRB41hp0AFFS02GZzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CcUAl6+E; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=roPnxm69DeI/ZOuBMC0ueKqZy9g2rUju3cPHwkdIQ/Y=; b=CcUAl6+E/ERnHURJdS+ub+D08w
	ctBSZqWZHa5wa1ieAfXu4NhaVhBuKj76uDOf/xD9Q+p1KKrKL/x/OKV2ltHAYCjC/Hzx8thK3WFqx
	m08QxpFdtzIiu7ZIKgAeKIyVv3I7k8QUiPZgUPlW8I2h3aCwBKZJOE3Fp4BZ0hF2iFVpabmT3oOM2
	Rws6l6Ql0vMdjeDkpPUI95//bEwZePnlZV4Vb1srfZRqYiklg7enVZrk4oavcVAiujCl8+eeoa1Oz
	j4Y/I9lSlF7N3qIZnFM4VxMcF8vZgU6TfAbSq858hEe2+O9hKMFyk+X8rtUdUA1AFiQCZMvkllpvd
	qvOaCzpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0AcW-0000000A0S1-0Zkd;
	Thu, 03 Apr 2025 02:47:56 +0000
Date: Thu, 3 Apr 2025 03:47:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xiaole He <hexiaole1994@126.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] fs/super.c: Add NULL check for type in
 iterate_supers_type
Message-ID: <20250403024756.GL2023217@ZenIV>
References: <20250402034529.12642-1-hexiaole1994@126.com>
 <35a8d2093ba4c4b60ce07f1efc17ff2595f6964d.camel@HansenPartnership.com>
 <4ee2fdcb.1854a.195f9828c86.Coremail.hexiaole1994@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee2fdcb.1854a.195f9828c86.Coremail.hexiaole1994@126.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 03, 2025 at 10:37:17AM +0800, Xiaole He wrote:
> Thank you for your feedback.
> While I acknowledge your points, I would like to clarify the rationale
> behind submitting this patch.
> During my experimentation with an external module interacting with the
> superblock, I utilized iterate_supers_type (from fs/super.c) as it is
> an exported symbol. However, I observed a potential vulnerability in
> its implementation: the type argument can be passed as NULL, leading
> to a null pointer dereference. To verify this, I deliberately triggered
> a scenario where type was set to NULL, resulting in the following dmesg
> output:

> After this observasion, I worry about if this vulnerability can cause
> the whole kernel crash if the type argument is passed by a
> unintentional NULL in the kernel code rather than in the external
> module.
> Thus I submitted the patch to address the missing null-check.
> Thank you for your review.

You do realize that passing it NULL as the second (function pointer) argument
would also oops, right?  Passing (void (*)(struct super_block *))kfree
there would do even more unpleasant things, etc.

Sure, it's exported - so's strlen().  While we are at it, checking just for
NULL is not the limit - what if the caller gives it ERR_PTR(...) as argument?

