Return-Path: <linux-fsdevel+bounces-2708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4CA7E7A0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 09:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FC01C20D00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82BD26F;
	Fri, 10 Nov 2023 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i6xQFLmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F679FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 08:21:38 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A8F93EB;
	Fri, 10 Nov 2023 00:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NsQ+DnYE/bAPSN7aXjsuBhHi7IqXlM77UwwV+IIISvM=; b=i6xQFLmMcUGCPg8SNtHRC0gzqH
	s1/PsMwZhcpNe8pE1MCjubNEddOBibPeqpfvWjNbM1FUJBr6EyEdPq8XLqr6jCt8raIgI1BnSyimH
	+NtoteV73RP4XxiT7WvTtP2YiUJlmnQFVD4HKK6pddoSKhmHe3Du/ttaGgtPal+mQ9QF2yDW29eCT
	FB35nXzBsK6zVhuclSqkfvfKCkpx5cm2EnBJkb/rhmOKGwx7qxOb/6fGq2kywgPnWw6ojirzH0QP0
	LZBfR9nKC/GdESNpsAYd3u953BXHdpT83iVWtuKJDqnNOrc1ESOCje8cJnalXD/hEXkaxBC8Elk9X
	DNt0MLoA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1MlL-00DoWD-1u;
	Fri, 10 Nov 2023 08:21:11 +0000
Date: Fri, 10 Nov 2023 08:21:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zizhi Wo <wozizhi@huawei.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
	jlayton@kernel.org, dchinner@redhat.com, adobriyan@gmail.com,
	yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH next V3] proc: support file->f_pos checking in mem_lseek
Message-ID: <20231110082111.GN1957730@ZenIV>
References: <20231110151928.2667204-1-wozizhi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110151928.2667204-1-wozizhi@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 10, 2023 at 11:19:28PM +0800, Zizhi Wo wrote:
> From: WoZ1zh1 <wozizhi@huawei.com>
> 
> In mem_lseek, file->f_pos may overflow. And it's not a problem that
> mem_open set file mode with FMODE_UNSIGNED_OFFSET(memory_lseek). However,
> another file use mem_lseek do lseek can have not FMODE_UNSIGNED_OFFSET
> (kpageflags_proc_ops/proc_pagemap_operations...), so in order to prevent
> file->f_pos updated to an abnormal number, fix it by checking overflow and
> FMODE_UNSIGNED_OFFSET.

1) How is that different from the previous version?
2) Would FMODE_UNSIGNED_OFFSET be wrong for those files?  If not, why not?

