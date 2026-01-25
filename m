Return-Path: <linux-fsdevel+bounces-75394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDNUMtiPdmksSAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:49:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C420828FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 22:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BEBF30086EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 21:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8379B30DEA0;
	Sun, 25 Jan 2026 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5UblH7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB34224240;
	Sun, 25 Jan 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377714; cv=none; b=LQ4yF7zz9w1PAaNI5wH0/Bo+9FOhzrYs+qWV7z4G877Qnqb0lS0aLiuLTAsBUuRofroAdDrAoOOgy/7mpcIX3KSAJWyDhPFIjw/FzXT8nlRu7ywY2XOaYRGIGoKZPSE/I6nfpdJq6SouU+DPwaLNedyXNmWecR5vGE3d6mfnTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377714; c=relaxed/simple;
	bh=dVblczFOT3KK64ywz5l+aXQv3RLrX2RoBjFt0kny0a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtYpqOlsJ+oIqczEAEfgipQ5P62mh66nTdor8cE+GpmjCb9gBH6cNBLZdwLrihTj5wnF5j9J6SL8Gml7163eMy2kGlYyaEKkaB/Py8xEdxWyvYj51mkvd0tvr2YuKPSJBlb8T0Bo7lOCO9vQt86J2zsgYWl76AX1H4Z8uSmIrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e5UblH7z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=quPIaL6J4vgskyL8jbt0HEBw7S9sSjdcy/gh2a5f1k4=; b=e5UblH7z5/IjdAKi22YkrU/R70
	RpKHo3fZ71OVhhLv/oYJcW70xMU/N3QMFRSrTRoQ9NeI+QbCHXH6TZFSTz7yN+zkprWYk2wCe/zb3
	WX/cZTCUAglWH3fuxkJxwIsSo1ygzzq8aILKQhkTwvQIZa0Gs44VH3lUCouxwoEMoc1LE24FR4KWG
	fJMxm+deBt8KWp6yJWvwdt80mv2jzq+ZxWiF2/cKu3t4q9ZP9O5fMu/JhZ+INTwx0ZWaHrytz8VhQ
	dRyMWcchY40sPMrTdfnDW2tPwobxN98aqvOeIbVBJ6KjknVfCVzvDeD2O4zCb58CWO3yMSzyMePbg
	j2CpBSzw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vk7y2-00000004zbi-1ua8;
	Sun, 25 Jan 2026 21:48:22 +0000
Date: Sun, 25 Jan 2026 21:48:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 11/11] fsverity: use a hashtable to find the fsverity_info
Message-ID: <aXaPph6Yi-hzf0J-@casper.infradead.org>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
 <20260125013104.GA2255@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125013104.GA2255@sol>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75394-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C420828FD
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 05:31:04PM -0800, Eric Biggers wrote:
> Maybe do:
> 
> 	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> 		/*
>                  * This pairs with the try_cmpxchg in set_mask_bits()
>                  * used to set the S_VERITY bit in i_flags.
> 		 */
> 		smp_mb();
> 		return true;
> 	}

Is there a reason not to do as DAX did:

+++ b/include/linux/fs.h
@@ -2119,7 +2119,11 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 #endif
 #define S_ENCRYPTED    (1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD     (1 << 15) /* Casefolded file */
+#ifdef CONFIG_FS_VERITY
 #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
+#else
+#define S_VERITY       0         /* Make all the verity checks disappear */
+#endif
 #define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 #define S_ANON_INODE   (1 << 19) /* Inode is an anonymous inode */


and then we can drop the CONFIG_FS_VERITY check here and in (at leaast)
three other places

