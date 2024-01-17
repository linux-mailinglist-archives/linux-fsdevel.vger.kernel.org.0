Return-Path: <linux-fsdevel+bounces-8208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47DF830F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 23:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D931F23C70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 22:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232081E881;
	Wed, 17 Jan 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rgWxj8wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1451E872
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531146; cv=none; b=uEb8STzgNxnaGY1YVJMJBak+27BeV2Z2Mx/5fs83dAD/D4pfmv60nA/V8h9JSH4/c4Ir3qgMrpVm246wqNh9VPVYAgER7k2QxRmtcm9l2d7C+jIeMck6FJA23wMmgTok1DHl2Sstglj6THGEJRJSMFc9fvQmzhd0J5sY6LNa0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531146; c=relaxed/simple;
	bh=LmQBDAfD2Iq7nOlyaEKKCImh7BSZ/V2ck2QX3Ib7Eqs=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender; b=WVZ+XEhZdFLZB9yAPPaCZZ2F2Y7tMfQ+KxyaZBrZgXoof7dWr/lr55p6RRB4xHx5Uler7Jhii/n7AR2/kwq8l3DeFbhdnBXe5iTSQ6/+Rfg85tUGguglZH0EpvHYTrEGQg+ix0/FehUr1VU3JTLyYM3LFI/22yjJMezHADhuTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rgWxj8wb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gmBjJj8ANbFfnYTyL72ts4H4lelBfp5M/aBIUkurCuQ=; b=rgWxj8wbiFy+X+rgEn3U5PymRY
	dYGhkzBAyRCHjEYYZRug2PTBn3Fyv5Vrin73/6RuPTi+N1kNNWFoN/EvG0p4UEDMjdpyJw9Dto7iM
	CCLNYTFxDvhmlJviSRyqmyyHyVhF9YpHrTt3lSUSLR07lg07fLUm7WSXGCBxSSdzmbyOLrWuoepWs
	S/krv+XdPpbU4gLIzoh6sra+jNF+QaZvHcjQKhLt1c0y7rDNu/UvXXFogNb29XxtoII19k5WPAiwx
	+d84oucl2QGqCFIM8dUHs34f6YFApQPgVEgh6EogBF2xfPWz2FsLb2cr3cOK2zu0rmgVvhjEXRBGV
	/wUFeaTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rQEYj-006hTy-1n;
	Wed, 17 Jan 2024 22:38:57 +0000
Date: Wed, 17 Jan 2024 22:38:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, tytso@mit.edu, linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] libfs: Attempt exact-match comparison first during
 casefold lookup
Message-ID: <20240117223857.GN1674809@ZenIV>
References: <20240117222836.11086-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117222836.11086-1-krisman@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 17, 2024 at 07:28:36PM -0300, Gabriel Krisman Bertazi wrote:

> Note that, for strict mode, generic_ci_d_compare used to reject an
> invalid UTF-8 string, which would now be considered valid if it
> exact-matches the disk-name.  But, if that is the case, the filesystem
> is corrupt.  More than that, it really doesn't matter in practice,
> because the name-under-lookup will have already been rejected by
> generic_ci_d_hash and we won't even get here.

> -	if (ret >= 0)
> -		return ret;
> -
> -	if (sb_has_strict_encoding(sb))
> +	qstr.len = len;
> +	qstr.name = str;
> +	ret = utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
> +	if (ret < 0)
>  		return -EINVAL;

Umm...  So why bother with -EINVAL?  The rest looks sane, but
considering the fact that your string *has* passed ->d_hash(),
do we need anything beyond
	return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
here?

