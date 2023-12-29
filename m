Return-Path: <linux-fsdevel+bounces-7021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479C81FFF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097B41F2224D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDCD11C9B;
	Fri, 29 Dec 2023 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEA3hGyp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989211720;
	Fri, 29 Dec 2023 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uia/OcVw+8oMM3SlBscvdoKEOngf/xeuNs9EweFJQFM=; b=YEA3hGyp+SRej8VlBz9cGVs5YW
	SUeiuyUAo3+t+++F/b0sMxuyZUmDKTElyd08c3NEhOjSDRB25MUOXSKBccqYWtSepYKlLO5Ky9ont
	/jpzc0QFoLrR8j+NPcLqUX+vAQvPrkY23U5yA7KyfBbLkFcf9n/+P3MSHeR3fBS6rcYPY8ENZLViD
	ECb/ILnN6bFBsexb0k8jI8i1sw8OihCB2TEpnRVtRwRaw7drw60f1UBDheSFlXBgmboGTffc5ol6H
	FgLcl9+dLahzrCWPsnzu4ChsT5CZ6t67njCrYglE88v69tamcFmLhG65t4OGdrMdAa88XYoWkAKwH
	PzTuEp6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJDkB-006GOp-Cc; Fri, 29 Dec 2023 14:21:47 +0000
Date: Fri, 29 Dec 2023 14:21:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] virtiofs: Improve error handling in
 virtio_fs_get_tree()
Message-ID: <ZY7V+ywWV/iKs4Hn@casper.infradead.org>
References: <c5c14b02-660a-46e1-9eb3-1a16d7c84922@web.de>
 <5745d81c-3c06-4871-9785-12a469870934@web.de>
 <ZY6Iir/idOZBiREy@casper.infradead.org>
 <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b353b6-949d-45a1-896d-bb5acb2ed4ed@web.de>

On Fri, Dec 29, 2023 at 10:10:08AM +0100, Markus Elfring wrote:
> >> The kfree() function was called in two cases by
> >> the virtio_fs_get_tree() function during error handling
> >> even if the passed variable contained a null pointer.
> >
> > So what?  kfree(NULL) is perfectly acceptable.
> 
> I suggest to reconsider the usefulness of such a special function call.

Can you be more explicit in your suggestion?

