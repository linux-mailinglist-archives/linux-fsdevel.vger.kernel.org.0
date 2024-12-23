Return-Path: <linux-fsdevel+bounces-38071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31189FB51E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 21:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F5A164DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AC1C5496;
	Mon, 23 Dec 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hyN1XBqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0691538F82;
	Mon, 23 Dec 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734985233; cv=none; b=PhRvbq6iBOUL55Hkvhn1B+GcLywo9lhhHv37V+wWtOqSTXAYBV/sOqR85KxFcL4fmSpVkXzH3Gu+h8d7JJsXi4WZNW+rUfpopNPBGj+XhcXLHy5v8lS/bCubeV2Zom73aLb9NWU4qMeVAxtBnxrPH5OaB2RXjUzg54Dqy8gboSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734985233; c=relaxed/simple;
	bh=QDE7sTj6D2f16oggKs3fTpt5E4GFNVsv48oy7HnRD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAedXHhjf/FXNhEtGPn8tfUn/aIQ0bsOrKcPv80snDUwS+dWDlLlPQzW71I6xv1fKw6JaGEDpimmlT4u6rIOmbBMPfEIxiofyCO98gM7uAJjQcV+wECBM4gPa/kyLZkMHCRCnRQ/vLqTAJ9wyZd8aTvhZ5Qexkd3SjZPBtS2xZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hyN1XBqj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I3/kAdSnGEKGkUM1UWCTRtS1hHL/EqWNK+lWJxh8Blg=; b=hyN1XBqjDRuiic+Jpd9T7+to7b
	AQ2Dx4nauSoQ9pn9z9Z3Z7v8tbRmGnx9lZ1wdTyXN0naHmIElGtgY/Kab8rdbvz2btAkMfP0nQWgX
	O1paw5GAXxNEAvuN6c6+qjuIarmnIM2+bvLpSA66C6nQWiwV0B6pueZFdziRXWXMPQLeTaFeMRJlS
	vE3NeL94mT4d2CSGtd/O2xBgaeHjnU1zmHey63gZXbRkV1T5qcfrZuIa3tB9L3PA9A9PPRCoSQ4Bp
	0GapncDIlVu/4InTrh/ZdW0dMI9J2+pPT+HO7lnr8b58E1JHHk3EHtjWwDZjvMuZQyblLBYBQq8P3
	10WuWRQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tPouj-0000000BQ6f-1m5x;
	Mon, 23 Dec 2024 20:20:29 +0000
Date: Mon, 23 Dec 2024 20:20:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 3/6] efivarfs: make variable_is_present use dcache lookup
Message-ID: <20241223202029.GP1977892@ZenIV>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 10, 2024 at 12:02:21PM -0500, James Bottomley wrote:
> Instead of searching the variable entry list for a variable, use the
> dcache lookup functions to find it instead.  Also add an efivarfs_
> prefix to the function now it is no longer static.

> +bool efivarfs_variable_is_present(efi_char16_t *variable_name,
> +				  efi_guid_t *vendor, void *data)
> +{
> +	char *name = efivar_get_utf8name(variable_name, vendor);
> +	struct super_block *sb = data;
> +	struct dentry *dentry;
> +	struct qstr qstr;
> +
> +	if (!name)
> +		return true;
> +
> +	qstr.name = name;
> +	qstr.len = strlen(name);
> +	dentry = d_hash_and_lookup(sb->s_root, &qstr);
> +	kfree(name);
> +	if (dentry)
> +		dput(dentry);

If that ever gets called with efivarfs_valid_name(name, strlen(name))
being false, that's going to oops...

