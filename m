Return-Path: <linux-fsdevel+bounces-7044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213FB82097A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 02:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D65283C28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D3F1C01;
	Sun, 31 Dec 2023 01:29:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEB186E
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Dec 2023 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.80])
	by sina.com (172.16.235.25) with ESMTP
	id 6590C3D700005C47; Sun, 31 Dec 2023 09:28:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 34086234210350
X-SMAIL-UIID: 17A82AA05F31419BBB3E201479107F12-20231231-092858-1
From: Hillf Danton <hdanton@sina.com>
To: Genes Lists <lists@sapience.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Date: Sun, 31 Dec 2023 09:28:46 +0800
Message-Id: <20231231012846.2355-1-hdanton@sina.com>
In-Reply-To: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Dec 30, 2023 at 10:23:26AM -0500 Genes Lists <lists@sapience.com>
> Apologies in advance, but I cannot git bisect this since machine was
> running for 10 days on 6.6.8 before this happened.
>
> Dec 30 07:00:36 s6 kernel: ------------[ cut here ]------------
> Dec 30 07:00:36 s6 kernel: WARNING: CPU: 0 PID: 521524 at mm/page-writeback.c:2668 __folio_mark_dirty (??:?) 
> Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted 6.6.8-stable-1 #13 d238f5ab6a206cdb0cc5cd72f8688230f23d58df
> Dec 30 07:00:36 s6 kernel: block_dirty_folio (??:?) 
> Dec 30 07:00:36 s6 kernel: unmap_page_range (??:?) 
> Dec 30 07:00:36 s6 kernel: unmap_vmas (??:?) 
> Dec 30 07:00:36 s6 kernel: exit_mmap (??:?) 
> Dec 30 07:00:36 s6 kernel: __mmput (??:?) 
> Dec 30 07:00:36 s6 kernel: do_exit (??:?) 
> Dec 30 07:00:36 s6 kernel: do_group_exit (??:?) 
> Dec 30 07:00:36 s6 kernel: __x64_sys_exit_group (??:?) 
> Dec 30 07:00:36 s6 kernel: do_syscall_64 (??:?) 

See what comes out if race is handled.
Only for thoughts.

--- x/mm/page-writeback.c
+++ y/mm/page-writeback.c
@@ -2661,12 +2661,19 @@ void __folio_mark_dirty(struct folio *fo
 {
 	unsigned long flags;
 
+again:
 	xa_lock_irqsave(&mapping->i_pages, flags);
-	if (folio->mapping) {	/* Race with truncate? */
+	if (folio->mapping && mapping == folio->mapping) {
 		WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
 		folio_account_dirtied(folio, mapping);
 		__xa_set_mark(&mapping->i_pages, folio_index(folio),
 				PAGECACHE_TAG_DIRTY);
+	} else if (folio->mapping) { /* Race with truncate? */
+		struct address_space *tmp = folio->mapping;
+
+		xa_unlock_irqrestore(&mapping->i_pages, flags);
+		mapping = tmp;
+		goto again;
 	}
 	xa_unlock_irqrestore(&mapping->i_pages, flags);
 }
--

