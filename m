Return-Path: <linux-fsdevel+bounces-44664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E09A6B2D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 03:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5445D1893521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C46A1E22FA;
	Fri, 21 Mar 2025 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ga3vdZFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15196184F;
	Fri, 21 Mar 2025 02:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742522913; cv=none; b=uW1nZPl30u9xk5R6wFFSjI9pxSAzldJ09LS6F1Vc168Xathd8Zk8roDvfkbfMQrA0QXMdNNIYRwwCipljg+/M9QVxsYVQfLLQamKYThLgR5WPim47BvZeT37hy8i5XGsulpoByccDzQF79lPw8oWLsx9uMizRLHcc+IS45hBZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742522913; c=relaxed/simple;
	bh=cinANPtNs9fVr4wBCGXN/SbujqVib64PjtGIptC+28Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUgK181mP8hOGcnZGA18sLsG4dRrGOtthNjJrF234F3AbM/UTgNqjYraw8Ih//o7CEgUr7PdVO2KNEIorDcYFvVuGkp2ICbtVQjYfF15EQJvmRX/d+t335F0rZ+WR7vsEYYfHocMXsVLpy8Lrb3FmhUrY7H0CXWkdoOFY27cmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ga3vdZFn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ahZVPAO/1t0i47rJqQsFMcVSyeqfjk4Xm8JVNgUxIK4=; b=Ga3vdZFnO7UP1csuSkCpoi3TnZ
	Z2/C0Z1jf0Ac++Nozq01uciJFZ9WmH8SFrfTUhRLHjKiebTP/7yJZpWNupLAvb3XUTESSm7tA09nj
	/44TZvtqIVeXIxwi+GWi+KjdHPLrFED7x5d/K8T2c8GwFH+FfFn/h1+okZm376u80B3YuscJRzXXA
	5LnyPzHhAYaGRwWoCaYwM24r+/JO0Wl22xeBLMkU8NuPSzCiDc5ZIpEF5MpNuAPm6nXU8VHMDemJm
	EUrYFEQyiBgOjgZOCSbrFXeI+TYynHXp2Ljxd+7m7a4ryHZLlVlPnLHpGoMXb/7HoK3HnvftbcK5K
	H+Jw4ouw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tvRoA-00000007AuC-1BtV;
	Fri, 21 Mar 2025 02:08:26 +0000
Date: Fri, 21 Mar 2025 02:08:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: julian.stecklina@cyberus-technology.de
Cc: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initrd: support erofs as initrd
Message-ID: <20250321020826.GB2023217@ZenIV>
References: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320-initrd-erofs-v1-1-35bbb293468a@cyberus-technology.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Mar 20, 2025 at 08:28:23PM +0100, Julian Stecklina via B4 Relay wrote:
> From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> 
> Add erofs detection to the initrd mount code. This allows systems to
> boot from an erofs-based initrd in the same way as they can boot from
> a squashfs initrd.
> 
> Just as squashfs initrds, erofs images as initrds are a good option
> for systems that are memory-constrained.
> 
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>

>  #include "do_mounts.h"
>  #include "../fs/squashfs/squashfs_fs.h"
> +#include "../fs/erofs/erofs_fs.h"

This is getting really unpleasant...

Folks, could we do something similar to initcalls - add a section
(.init.text.rd_detect?) with array of pointers to __init functions
that would be called by that thing in turn?  With filesystems that
want to add that kind of stuff being about to do something like

static int __init detect_minix(struct file *file, void *buf, loff_t *pos, int start_block)
{
	struct minix_super_block *minixsb = buf;
	initrd_fill_buffer(file, buf, pos, (start_block + 1) * BLOCK_SIZE);
	if (minixsb->s_magic == MINIX_SUPER_MAGIC ||
	    minixsb->s_magic == MINIX_SUPER_MAGIC2) {
		printk(KERN_NOTICE
			"RAMDISK: Minix filesystem found at block %d\n",
			start_block);
		return minixsb->s_nzones << minixsb->s_log_zone_size;
	}
	return -1;
}

initrd_detect(detect_minix);

with the latter emitting a pointer to detect_minix into that new
section?

initrd_fill_buffer() would be something along the lines of

	if (*pos != wanted) {
		*pos = wanted;
		kernel_read(file, buf, 512, pos);
	}

I mean, we can keep adding those pieces there, but...

