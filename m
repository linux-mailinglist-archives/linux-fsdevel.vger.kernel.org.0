Return-Path: <linux-fsdevel+bounces-71259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7118CBB5CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 02:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AFAC3007222
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9671A254E;
	Sun, 14 Dec 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pohQfsG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF3139D;
	Sun, 14 Dec 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765675941; cv=none; b=qCzc61hWnEdAL5atw6i1Z1onNEHi2IbyAyyhi6niJz4MzmYYhdiqCJQHYD+8bxSWb0oyjY4V6G5Dz8pRg7wCoztWiH5hVdM2Q8dXoVijDlqQK3F2ZnjucHLSGpWgnIAPazuoh25+razzB8HnNuWy2UhHx+eD9+N/zBg9kSpyQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765675941; c=relaxed/simple;
	bh=rbah+cJZwepc2KqNhV8z4XTLjI/nUhuFQM2qIGoZ9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRK1pySX2ObWhaZjx+rlNpXORGU9UsWL5PU9MXd6cM5zERrtNsOl8NcZE/aWqQv2xghWlz3PlISntpq6XmNmsabfsq+mZgBKYEZ2Oi+mZkdpiNXXdzElMDfWspviUsBlB73fcxOEM40R5QC+R3Nhx/8c/s0gpwzDtwgX3QJgVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pohQfsG+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5ibn7uyDlvDUWsg61nRhxPbcOhhLppEfE8ro/aVnr3Y=; b=pohQfsG+dAC/fuFOt0nd45RStt
	YZ6gikl9WJpdwiQPsdBdLgiOTdvCzRnDcP29dgvZj5XwcCDvyFLPtF5xUqzin5ymyUiqJyP9Lz8vE
	rNbLYEX3G74c9AmoR2tHTeJWb8yKS49OQS6ewx2oXvv1L6zODDiKqECs0SUR0YLiXVdGQw2c/INoT
	rRDTf9jrdjyHDHeH4a5a2zDxqoIZvaGMfCr+lmeYJ8wiaF5xCG9bPOsOOYTo4TbQAaFqiDDsmRyNY
	7gwToZb3YftBdFqZ1PEtDSv7zUJ56aT86thU2JtB/hwzrDHvHgLSrWJ4nruog/nP/yQZICS04aYSP
	96vGZ3Og==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUayf-00000000dLh-1tWv;
	Sun, 14 Dec 2025 01:32:49 +0000
Date: Sun, 14 Dec 2025 01:32:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: Re: [PATCH] adfs: fix memory leak in sb->s_fs_info
Message-ID: <20251214013249.GI1712166@ZenIV>
References: <20251213233621.151496-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213233621.151496-2-eraykrdg1@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Dec 14, 2025 at 02:36:22AM +0300, Ahmet Eray Karadag wrote:
> Syzbot reported a memory leak in adfs during the mount process. The issue
> arises because the ownership of the allocated (struct adfs_sb_info) is
> transferred from the filesystem context to the superblock via sget_fc().
> This function sets fc->s_fs_info to NULL after the transfer.
> 
> The ADFS filesystem previously used the default kill_block_super for
> superblock destruction. This helper performs generic cleanup but does not
> free the private sb->s_fs_info data. Since fc->s_fs_info is set to
> NULL during the transfer, the standard context cleanup (adfs_free_fc)
> also skips freeing this memory. As a result, if the superblock is
> destroyed, the allocated struct adfs_sb_info is leaked.
> 
> Fix this by implementing a custom .kill_sb callback (adfs_kill_sb)
> that explicitly frees sb->s_fs_info before invoking the generic
> kill_block_super.

I hate dealing with humans in the way one would deal with a chatbot, but...


Question: if that thing is leaking all the time, why hadn't that been caught
earlier?

Question: does it really leak all the time?  How would one check that?

Question: if it does not leak in each and every case, presumably the damn thing
does get freed at some point; where would that be?

Question: would we, by any chance, run into a double-free with that "fix"?


Please, do yourself a favour and find answers to the questions above.
They are fairly trivial and it is the kind of exercise one has to do every
time when dealing with something of that sort.

