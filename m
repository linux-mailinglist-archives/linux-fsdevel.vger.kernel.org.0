Return-Path: <linux-fsdevel+bounces-7051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242FE8212CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 02:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94542829F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jan 2024 01:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1315C0;
	Mon,  1 Jan 2024 01:55:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEA7FD
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jan 2024 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.64])
	by sina.com (172.16.235.24) with ESMTP
	id 65921B8100004871; Mon, 1 Jan 2024 09:55:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 15200245089584
X-SMAIL-UIID: 0DEB7DF064144DCD825404CC9C1C793E-20240101-095516-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Genes Lists <lists@sapience.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Date: Mon,  1 Jan 2024 09:55:04 +0800
Message-Id: <20240101015504.2446-1-hdanton@sina.com>
In-Reply-To: <ZZFnd3tZZvg2eZun@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com> <20231231012846.2355-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 Dec 2023 13:07:03 +0000 Matthew Wilcox <willy@infradead.org>
> On Sun, Dec 31, 2023 at 09:28:46AM +0800, Hillf Danton wrote:
> > On Sat, Dec 30, 2023 at 10:23:26AM -0500 Genes Lists <lists@sapience.com>
> > > Apologies in advance, but I cannot git bisect this since machine was
> > > running for 10 days on 6.6.8 before this happened.
> > >
> > > Dec 30 07:00:36 s6 kernel: ------------[ cut here ]------------
> > > Dec 30 07:00:36 s6 kernel: WARNING: CPU: 0 PID: 521524 at mm/page-writeback.c:2668 __folio_mark_dirty (??:?) 
> > > Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted 6.6.8-stable-1 #13 d238f5ab6a206cdb0cc5cd72f8688230f23d58df
> > > Dec 30 07:00:36 s6 kernel: block_dirty_folio (??:?) 
> > > Dec 30 07:00:36 s6 kernel: unmap_page_range (??:?) 
> > > Dec 30 07:00:36 s6 kernel: unmap_vmas (??:?) 
> > > Dec 30 07:00:36 s6 kernel: exit_mmap (??:?) 
> > > Dec 30 07:00:36 s6 kernel: __mmput (??:?) 
> > > Dec 30 07:00:36 s6 kernel: do_exit (??:?) 
> > > Dec 30 07:00:36 s6 kernel: do_group_exit (??:?) 
> > > Dec 30 07:00:36 s6 kernel: __x64_sys_exit_group (??:?) 
> > > Dec 30 07:00:36 s6 kernel: do_syscall_64 (??:?) 
> > 
> > See what comes out if race is handled.
> > Only for thoughts.
> 
> I don't think this can happen.  Look at the call trace;
> block_dirty_folio() is called from unmap_page_range().  That means the
> page is in the page tables.  We unmap the pages in a folio from the
> page tables before we set folio->mapping to NULL.  Look at
> invalidate_inode_pages2_range() for example:
> 
>                                 unmap_mapping_pages(mapping, indices[i],
>                                                 (1 + end - indices[i]), false);
>                         folio_lock(folio);
>                         folio_wait_writeback(folio);
>                         if (folio_mapped(folio))
>                                 unmap_mapping_folio(folio);
>                         BUG_ON(folio_mapped(folio));
>                                 if (!invalidate_complete_folio2(mapping, folio))
> 
What is missed here is the same check [1] in invalidate_inode_pages2_range(),
so I built no wheel.

			folio_lock(folio);
			if (unlikely(folio->mapping != mapping)) {
				folio_unlock(folio);
				continue;
			}

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/truncate.c#n658

