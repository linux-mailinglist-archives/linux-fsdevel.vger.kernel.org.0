Return-Path: <linux-fsdevel+bounces-54356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80107AFE9C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75D1892F39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54C2DC32D;
	Wed,  9 Jul 2025 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vohlLMQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB182D9EC9
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066860; cv=none; b=BAhNAEwquvBBKaZdFHIAnO/KdI/MXREuEUzgobFxbFy8FNbqN178E9KW2Nv2cBFouFUtNFS/6iZCDvfcTu/HY94l/HJWcffhp86cojpxgdcar7W3RNARv8F9QqlN3z4oSHgutvwTPb7NcwGaiRYGinON7LxevwT1/rDmnBo4/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066860; c=relaxed/simple;
	bh=kLTEMPVzIjjYrZek/EUkfAV+ZnP3QhydpkJuddX1nQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smNclUIB2/rrYocYPvVwAUKFuPMFP4xLX6jSUSrlso2BBzvdUKOZhqFYo7R2nvihtyU8HXZ/es+iWihWdxBx1icrvP4xkg1dIh5JlT31tDM4GGNCI+TiEyN3o5JVEIqyfmOot2cpjE39rCx/1rFbJYC9h80RPrSJ2PkjAYm4iDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vohlLMQl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/nGbFXBrKneWxzRsb2ANnPRIhYzM5VxQ0PGg8bYiabY=; b=vohlLMQly/S6fpIzTrNV5JLnV0
	88IyhrXQMUOCx9tsf3r1PQ4KlAGyGVQsALVDmgC8cS7BwaGGDAwMQp6IWEhHrSmmF9gWMhOgz/yuW
	nuQg7TDXcevC09IAqcxeoUQL9h4BpKib21V8TgElfQIaYoCsX8niFV7Iqj+zeGKbNZERlVX/rB9i1
	GosINxgVKvK9FmC3HlNR51dV+/Ek4oJ4Joh5i/N3UmeT3ji+cuR9TTlCilGv9eJVthrZfvABm0NpF
	/6Q+AaFAkVmeV/rnUuh1LhKv95NPXpp0ytRz81Sb2WkxFY1gAzJh8qPU//Yva9PWYqBgpHIkhGjk9
	m93/Es2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZUcq-000000046r8-1xQD;
	Wed, 09 Jul 2025 13:14:16 +0000
Date: Wed, 9 Jul 2025 14:14:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: Remove unnecessary list_for_each_entry_safe() from
 evict_inodes()
Message-ID: <aG5rKNILXdJM2Duo@casper.infradead.org>
References: <20250709090635.26319-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709090635.26319-2-jack@suse.cz>

On Wed, Jul 09, 2025 at 11:06:36AM +0200, Jan Kara wrote:
> evict_inodes() uses list_for_each_entry_safe() to iterate sb->s_inodes
> list. However, since we use i_lru list entry for our local temporary
> list of inodes to destroy, the inode is guaranteed to stay in
> sb->s_inodes list while we hold sb->s_inode_list_lock. So there is no
> real need for safe iteration variant and we can use
> list_for_each_entry() just fine.

Yes, agreed, this is safe.  I thought it wasn't, because (a) we call
inode_lru_list_del(), but that's a different list (i_lru, not i_sb_list)
and (b) we call dispose() which calls evict(), but if we do that, we
restart the list walk.

> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

