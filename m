Return-Path: <linux-fsdevel+bounces-44239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE211A66775
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E38C1756A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 03:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01018DB1D;
	Tue, 18 Mar 2025 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Nq0eiCx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD61638FA6;
	Tue, 18 Mar 2025 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269065; cv=none; b=Wt06rYzlRbujIMP7fmFXvqr68vCIpykf0Eutzk5QJDVAZn7QZ+H4TOIRYWqHIwEMF8N3AHiZxzJmcYpviIdw58S5Jo+KIY+QsGWYNFttqCi3LMUGQlx+CxGCnK6D+E41WaZJbgenSPsWyIRFmPH2fVhylPFCzuckdAv2aSH0f/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269065; c=relaxed/simple;
	bh=bKyIFPg3XZ+Bod/00TpreRsU5QJfPCsSdLDDvUS2/Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmHTORVirkQJKMaIMXxdVnWlnP70aj7IKKLbc/N71CTogSrLfXxgYkIjLf3299PE/XD9CsfqF156mpieLQdhnqBWHgNKWsfv9tXdZOBc73jW4ENw3a12LwAp5uUBPOdrIrrXKIkgKDR4J+HGTmXYrYd9zIPJg+VOG84UQS3aoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Nq0eiCx7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SiljaLdkd2hmHxgBxKsouw1FqJx45KhXJjStC2gpHY0=; b=Nq0eiCx7JLz/2AlosYt/4PmHMs
	WRL0HL181MMNSM6simbggdyqJc/6mHuDSaYMsrxvMkZ777reUkIBlGsDI5Cpz58mxk9kOWggFnNA6
	U9i4lsr1O+h5sse7L1OW27R8HNr4+MWd9sz6wbXFxgzn8RQ2WIob8YR6YGIbiqLWOP8nO+73GUr+5
	j/ImiVWlE9X/dAADgzUwJMU9gTnj+PWK2NfhlwrAhXfMH96OQJDoQLTMArdBXfqHi1RBdqeBBm7O/
	GJyLlH5WBioDaA4JcjBX8HEkPU8JgVPlwiDzLsz0MvgrPdZv+IGF5W34YcrQO8IiVvxm2kWe2Tq8f
	3Ndlyz4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tuNlq-0000000EbPo-2byP;
	Tue, 18 Mar 2025 03:37:38 +0000
Date: Tue, 18 Mar 2025 03:37:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ryan Lee <ryan.lee@canonical.com>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] efivarfs: fix NULL dereference on resume
Message-ID: <20250318033738.GV2023217@ZenIV>
References: <3e998bf87638a442cbc6864cdcd3d8d9e08ce3e3.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e998bf87638a442cbc6864cdcd3d8d9e08ce3e3.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 17, 2025 at 11:06:01PM -0400, James Bottomley wrote:

> +	/* ensure single superblock is alive and pin it */
> +	if (!atomic_inc_not_zero(&s->s_active))
> +		return NOTIFY_DONE;
> +
>  	pr_info("efivarfs: resyncing variable state\n");
>  
> -	/* O_NOATIME is required to prevent oops on NULL mnt */
> +	path.dentry = sfi->sb->s_root;
> +
> +	/*
> +	 * do not add SB_KERNMOUNT which a single superblock could
> +	 * expose to userspace and which also causes MNT_INTERNAL, see
> +	 * below
> +	 */
> +	path.mnt = vfs_kern_mount(&efivarfs_type, 0,
> +				  efivarfs_type.name, NULL);

Umm...  That's probably safe, but not as a long-term solution -
it's too intimately dependent upon fs/super.c internals.
The reasons why you can't run into ->s_umount deadlock here
are non-trivial...

