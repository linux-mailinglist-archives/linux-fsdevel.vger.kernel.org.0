Return-Path: <linux-fsdevel+bounces-40274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC1AA2170F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 05:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87681653DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 04:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF718C907;
	Wed, 29 Jan 2025 04:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MlUf2rJ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36A111713
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738125438; cv=none; b=LqxjaNoAEOTnwfWbwD6MIoxPVOYisEYSD/Vlre70hZ48CNPSAWgHTgZMo8hF1PjOm5YkuRnaZ7QGvDCDNAs0TvKM7DjwtLfh0cUjf+858B5siyQq/GJprS37Bn+IsNBv1FkZxXTFasZ23IvAnExNl1AdbaqdpigycONF/h6lEfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738125438; c=relaxed/simple;
	bh=W4ob3anL8zRM6rkF52Be+FUlxFmIA/SMHeUCC7+ZOsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYqk8YaEC84PCXoJFxKYe2dMS2+g4TF9khtvFXeq2q2jeZn3ofvsmLiDS4iLM4JDQsISkjbJmYTUupGR1v22NcpGewCOTxEnVUQREsX32AWwwAMpcxQrSSohD0vO8Vj8EKoNI7DIBRaBz1L+aDFKW+98lQbiwZPUO0gjbiaKPy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MlUf2rJ3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JeX1tJAMrqtvR3jMf2b/sXaEH55G0StnWi48rc5YjKQ=; b=MlUf2rJ3uR4N5+mmtmJhhLS3DQ
	RG+fqLhuTpSM0fsEz2aO/Ta9PawFZxxAsxThE+6kLou0Ug3Ha2fLYHZnua8PcLrlYhbxo6TVmtSOI
	bzwXsJKwCUZybuP/cqZ2rGBsh+MPTdI5cz+n1qIhuvi31K0s/fJjDyfcYojq/XHEwaXXsNI52U+Cz
	cwPFlvMwCxMj/dar3EreUPVWeDm7jlVusk0PFj5BZEdEKi9/lrlEFj/jYNQBYt8GWGujfNrzfVBsx
	0vCuQaP//LyvHJNcLBp60DOSubMBo3m7eyOpiqiD/MeOx9g6lQYM5PiVigRhhCpbv9uioucLaVcDL
	B7d75YGA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tczpA-0000000EzFI-0DpE;
	Wed, 29 Jan 2025 04:37:12 +0000
Date: Wed, 29 Jan 2025 04:37:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <20250129043712.GQ1977892@ZenIV>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <20250123181853.GC1977892@ZenIV>
 <Z5Zazwd0nto-v-RS@tuxmaker.boeblingen.de.ibm.com>
 <20250127050416.GE1977892@ZenIV>
 <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6129954089EA5288ED6D963EB9EF2@SJ1PR11MB6129.namprd11.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 28, 2025 at 04:00:58PM +0000, Borah, Chaitanya Kumar wrote:

> Unfortunately this change does not help us. I think it is the methods member that causes the problem. So the following change solves the problem for us.
> 
> 
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -102,6 +102,8 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
>                 if (!fsd)
>                         return -ENOMEM;
> 
> +               fsd->methods = 0;
> +
>                 if (mode == DBGFS_GET_SHORT) {
>                         const struct debugfs_short_fops *ops;
>                         ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;

D'OH.

Both are needed, actually.  Slightly longer term I would rather
split full_proxy_{read,write,lseek}() into short and full variant,
getting rid of the "check which pointer is non-NULL" and killed
the two remaining users of debugfs_real_fops() outside of
fs/debugfs/file.c; then we could union these ->..._fops pointers,
but until then they need to be initialized.

And yes, ->methods obviously needs to be initialized.

Al, bloody embarrassed ;-/

