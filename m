Return-Path: <linux-fsdevel+bounces-24617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C89415B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAB21C22E7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B81BA863;
	Tue, 30 Jul 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oN4XIH6X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC62145A18;
	Tue, 30 Jul 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354569; cv=none; b=S1suAoUaHQw1euKZirwV4zD8ull+HQGsCPRBXALtApv+HKLPxxJ7Lj5bqiVGO8YQi9w4kDkYIAFE5UZyVFjre1xdrM17NvV7yPPFZiQ8CNL5sZnkuD5R4mahnRszKUYRrxPE6rxPb/Qcyh95KriipyevDxT0mG/jMd/UvsLzTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354569; c=relaxed/simple;
	bh=mG/lZYRAbNolyavVYbg7FVFULpSSiiaq1xp5oVx/yRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEaQjtwQDAqP7ugCcxmq3r2XaM68pAHWSSQSAnw4o+wu2hLE8yLR5jLNCxOWlLdCY7myfIJpjQ3rIvurm+vs4PdZKUOJqBcne1a1T6cULxKxDAxLNnKjn5c5dDYH52z+2JX0yTDnw/l4PfMWCBbFNs07seaNWLKoY7rQTFFsSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oN4XIH6X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Kva6ZYHFM4BbWRczdOK/dFl8iQUaafaoo6zDDqkDfis=; b=oN4XIH6X4SztUEwRIot7ltuShb
	7MOeKwnZAFh/Nk0FT0Q7LhgecS/8zhFoYIOCVaQ/IVpR4pkeN+Agg2A0ruLfGT9nywm0TVNIH+3x0
	psQ/AlOLsttRzrzFML8DolakaWhQJCuVTtDHgheiuAU821+PlLPUDksFefK9xRMgNal2I5VfvWrdJ
	1N8Lza2XHWLMcQoM4MODbBU8IU2SI2JYnbiGONpnFXbt3cG+jMEAD8uPqmfNCjEDt8a1rqNoNRGpS
	1LHQx2Gk36x5+AE5XxHghVDNfLC497c43Qj3syHmcZRt2cMCCfxWgQOpUFfB63gndzlAO1M4Pd3+l
	FyfaRgOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sYp6L-00000000GTP-06jJ;
	Tue, 30 Jul 2024 15:49:25 +0000
Date: Tue, 30 Jul 2024 16:49:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Message-ID: <20240730154924.GF5334@ZenIV>
References: <20240730085856.32385-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730085856.32385-1-olaf@aepfle.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 30, 2024 at 10:58:13AM +0200, Olaf Hering wrote:
> If no page could be allocated, an error pointer was used as format
> string in pr_warn.
> 
> Rearrange the code to return early in case of OOM. Also add a check
> for the return value of d_path. The API of that function is not
> documented. It currently returns only ERR_PTR values, but may return
> also NULL in the future. Use PTR_ERR_OR_ZERO to cover both cases.

Don't use PTR_ERR_OR_ZERO.  And don't mix ERR_PTR() and NULL for
error returns without a really good reason for that.

d_path() is *NOT* going to return NULL.

NAK in that form.

