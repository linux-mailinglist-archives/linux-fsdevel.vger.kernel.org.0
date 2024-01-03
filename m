Return-Path: <linux-fsdevel+bounces-7169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BC822B9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AE31F23647
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549118C3A;
	Wed,  3 Jan 2024 10:49:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1E18C24
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.3])
	by sina.com (10.75.12.45) with ESMTP
	id 65953BAD00004F0F; Wed, 3 Jan 2024 18:49:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 77753331457868
X-SMAIL-UIID: CDA513BA0B8741509C75670EC74D7D86-20240103-184920-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Genes Lists <lists@sapience.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Date: Wed,  3 Jan 2024 18:49:07 +0800
Message-Id: <20240103104907.2657-1-hdanton@sina.com>
In-Reply-To: <ZZLH9u9KGUgqAmGC@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com> <20231231012846.2355-1-hdanton@sina.com> <20240101015504.2446-1-hdanton@sina.com> <20240101113316.2595-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Jan 2024 14:11:02 +0000 Matthew Wilcox
> 
> From an mm point of view, what is implicit is that truncate calls
> unmap_mapping_folio -> unmap_mapping_range_tree ->
> unmap_mapping_range_vma -> zap_page_range_single -> unmap_single_vma ->
> unmap_page_range -> zap_p4d_range -> zap_pud_range -> zap_pmd_range ->
> zap_pte_range -> pte_offset_map_lock()
> 
> So a truncate will take the page lock, then spin on the pte lock
> until the racing munmap() has finished (ok, this was an exit(), not
> a munmap(), but exit() does an implicit munmap()).
> 
But ptl fails to explain the warning reported, while the sequence in
__block_commit_write()

	mark_buffer_dirty();
	folio_mark_uptodate();

hints the warning is bogus.

