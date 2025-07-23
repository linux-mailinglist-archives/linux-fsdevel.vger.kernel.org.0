Return-Path: <linux-fsdevel+bounces-55775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B62B0E8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 04:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94911C87D63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1B1DDC0B;
	Wed, 23 Jul 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lWvfWsS1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F692111BF;
	Wed, 23 Jul 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237959; cv=none; b=ayqz/lhRjfiLUfWBSg/KhGJSyY+Ad7UOxge3LFLRd2EvOIudRBg2vKKNaW0+YuHk2ur9QN3l27I1WgpMli8tlmCUJotfm8Z/0Hor0y+ry5Uelwy8zPPPcOeZ4m0VyndrNrO73oNJ1bcvjwZMg3aQXRBJBM8oPR1JZ1Qfr7EzhDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237959; c=relaxed/simple;
	bh=w4kZKJvPwi76U1MKCa3gr6+XmhuntU3PT+X7+AO7CQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9vG9Xwhbdd6koFPPzddP3Q0NG2iP7NGgRGVuGDomVpxAKySu7ExHlywBddNSJcwGFF8b008xvWP7xQaHecYxQDtvxiDqzFuMkY7uLw2Dh4brqzUeFdslVpjbeI5JAsdhKOHbnH3VxsHKRULOuAjzkmg6WK9BaDGpBeuK2t7P9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lWvfWsS1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DLPxMt6bqkIRsK3lPc2ugQPcGXoJwyKCqfZJo4el2hE=; b=lWvfWsS1j8xIHx/DJyKkkMxNMn
	R2bbOvx59Vr6irEpcjlM9CFmSqm8qH7pGaIVSDMHqkU9H9SA/+cMpCg0TlIDEpKggX3KQe+mPLyj8
	0TRVF/Wej7EB7QmA6asseRPm3f7Kjqb4WoPGLCMG0cAJ2TG6j9+9d+zFATLvF089TMHlpc4xGExKC
	kQIwoV3iv3JY4bojJZg1bBjeB0u5RYkJvR+6ULxJOKHCynYmKMcEQHA6lcQl22Fkvx/8hqZqzRWR3
	AtRVNPkrK8MFV6DZL57Vvdidg3zcabcU19exYREuBIlX0EQ32vvSwPZH8TToCccHWZBk1zloCj6OW
	dtog/CPw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uePHV-000000053uX-2BJU;
	Wed, 23 Jul 2025 02:32:33 +0000
Date: Wed, 23 Jul 2025 03:32:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yangtao Li <frank.li@vivo.com>
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] hfsplus: fix to update ctime after rename
Message-ID: <20250723023233.GL2580412@ZenIV>
References: <20250722071347.1076367-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722071347.1076367-1-frank.li@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 22, 2025 at 01:13:45AM -0600, Yangtao Li wrote:

> @@ -552,9 +553,13 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
>  	res = hfsplus_rename_cat((u32)(unsigned long)old_dentry->d_fsdata,
>  				 old_dir, &old_dentry->d_name,
>  				 new_dir, &new_dentry->d_name);
> -	if (!res)
> -		new_dentry->d_fsdata = old_dentry->d_fsdata;
> -	return res;
> +	if (res)
> +		return res;
> +
> +	new_dentry->d_fsdata = old_dentry->d_fsdata;

	Umm...  Is that assignment (either before or after that patch)
actually correct?

	Note that new_dentry essentially got unlinked here; old_dentry
is about to have its parent/name changed by the caller of ->rename(),
so...  that looks very odd.

	What is that line about?

