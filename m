Return-Path: <linux-fsdevel+bounces-20885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755D8FA8D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07F3289FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 03:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BA7640E;
	Tue,  4 Jun 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LFdvTtHV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3D389
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717472457; cv=none; b=RDhefP9OrS3yUDDKQkomXfTp1gghSThVos2pIVSN281bEXwzIUSbRtCj6ehPkQbyGBR/3X53DWvcJ4pYG8SVnGgT8bNmK++ilqxpFBMAe3G0Jg2v2dAysrHaxMFsdwf47KvB9LLog1a9qnlbE9QNcTzd6fHDbxtdmdkFAUDxNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717472457; c=relaxed/simple;
	bh=wC1+qbAZqtg5gg0SYXiEFyEKRgftPZa1d8robpM572k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hP4rGJoyfBTparswgcOEaCot+m3jxC8mkG7+HVMJz8P0l5rZNHXLVXMuybdJKiCmR1LZHYSDMt+macg86jP7Wusxut6ksbletBGNTAxcdGufdVKod5n94Av2V9eeBecaF/onYWx1T1qk61WvC5d4O6+WZOm85sGmYDyH/KuKwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LFdvTtHV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QLqVdjAHxsgQd9YC1NzEow8QAo7ORDItsrHw2sQUDiA=; b=LFdvTtHVaQT2aiyoqZsXEYblCs
	UsoIcLg6kUOmxBxzfHwrC5mLCCCVP4Vu0CJtBfgPxFKNeb3gD9EwCIMcDQ2lX+Q1u20o2ryYex7BN
	kvlj67bBus4lOUL7FmA6koyVL6FZQ9C07FkpWj9KQpsqx4NHp/1CffUo68I4jXtR7sj98/LPBiSK2
	qrUoBMG5C5OjvG5TUYlTW2QiYMZ5wcMHTPRZjhX2ZXm3t+6ajxLlg/58vwpdI/sqrmVTjB2mgBIvr
	EanXYiBboS58dSWCR6DnQ7vVF52t15UoRl2hQlAmffQA/cLz45UmOZk7EDFQ7wsyO3dEcmCV4e+c7
	B+SN+4VQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sEL2Z-00CqDS-09;
	Tue, 04 Jun 2024 03:40:51 +0000
Date: Tue, 4 Jun 2024 04:40:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: why does proc_fd_getattr() bother with S_ISDIR(inode->i_mode)?
Message-ID: <20240604034051.GP1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	... when the only way to get to it is via ->getattr() in
proc_fd_inode_operations?  Note that proc_fd_inode_operations
has ->lookup() in it; it _can't_ be ->i_op of a non-directory.

	Am I missing something here?

