Return-Path: <linux-fsdevel+bounces-70203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6EC937A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 04:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2682F34A41A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C322256F;
	Sat, 29 Nov 2025 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gif53AQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFB1DE2BF;
	Sat, 29 Nov 2025 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764388507; cv=none; b=BxeTzm1TcG24pD/+bCdKZzCFvmjHCkTmK2bk1xFM1k7SgHsHpfWnxxx0pqUaBXlVmmkcHwgcSXgAE9jSNh+Il8beXpYEPqOA60HTRiUMos4tkQpNflXJiNPvwCGzKSH0FSKvUJv6UMDt9K8Qfg1TVH97jcON3lPBwrx7DczmZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764388507; c=relaxed/simple;
	bh=1dCa0Yi2abB18gZnNstjxBDy+4BryzpI37joEvmB9nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj8Ynyzn1SGNqkPJO0rd0cVPVS7nmnpUyZmfrgTBrVOuXvpEs7Vvwr/UHYQKG7hchas+eDZBjSBzAczCQuLRe1SzfPcZ6MYchf3+rgOObjwHZkkxZOBmvS8IdHQpPuzX55Sb43/n08fP+ZgG/ggSK0+Gb8/h5v7HRPFzYQQIZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gif53AQX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1dCa0Yi2abB18gZnNstjxBDy+4BryzpI37joEvmB9nM=; b=gif53AQXc1RzHnygPbDtIU0X9L
	pXTFfokzhGNWnuy66xDaEH/e5OK0oyUdCm4pbTUKtbbksPMcXlqSNS0VCZDb2SJIB9J/PGAbtpqbG
	CO8OW3uSLvzVc3N7Das2tMfFe7RiY/yna+fzkylq+2CW5cGxecl6dTfKxhJgvWdBBeoPwcIyDFC2s
	8sQLhqsD1hjniYUK2XVRqXshs+TJ0gYBdaxjzN6imMaYMF+GPISY28ftXIfPzc78DeU0qhSE93uU7
	+1dLgV4XxZb7onQ+ybhE2DK6uXuf5i3CZdI074nrQAY1XXegzlcxto0oJi2wynNGH9zvSxytr5yAR
	kywVSLoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vPC3C-00000000XUf-1HpY;
	Sat, 29 Nov 2025 03:55:10 +0000
Date: Sat, 29 Nov 2025 03:55:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, jack@suse.com,
	brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
	linux@armlinux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com,
	wangkefeng.wang@huawei.com, pangliyuan1@huawei.com,
	xieyuanbin1@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <20251129035510.GI3538@ZenIV>
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <aShLKpTBr9akSuUG@willie-the-truck>
 <9ff0d134-2c64-4204-bbac-9fdf0867ac46@huaweicloud.com>
 <39d99c56-3c2f-46bd-933f-2aef69d169f3@huaweicloud.com>
 <61757d05-ffce-476d-9b07-88332e5db1b9@huaweicloud.com>
 <aSmUnZZATTn3JD7m@willie-the-truck>
 <b6e23094-f53f-4242-acb5-881bd304d707@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e23094-f53f-4242-acb5-881bd304d707@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 29, 2025 at 09:02:27AM +0800, Zizhi Wo wrote:

> Thank you very much for the answer. For the vmalloc area, I checked the
> call points on the vfs side, such as dentry_string_cmp() or hash_name().
> Their "names addr" are all assigned by kmalloc(), so there should be no
> corresponding issues. But I'm not familiar with the other calling
> points...

Pathname might be a symlink body, sitting in page cache or whatever
->get_link() has returned...

