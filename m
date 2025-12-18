Return-Path: <linux-fsdevel+bounces-71621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC7DCCA68B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 07:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38DA63015EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C029DB64;
	Thu, 18 Dec 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ashD29ZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258523EAA0;
	Thu, 18 Dec 2025 06:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038222; cv=none; b=kiRr+/rohjVOyRXTe07d7uuP8xE8ri+fv0n8ngqfX4oe4oPUq5OUgn/N6m7Mjahh+Gyu0ZWuH4Dh5aMm2pRdeuodO3Yrm/9rHFdSv8qV6qXwm+8ggTGTxJ5QsRLQE7Cl2co6lg0owrVtjkjDEpybt1GGb6p1QcqcZJ2S8yqjgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038222; c=relaxed/simple;
	bh=Vf+laP85/k6XStCJlnUJfA/IC+noD0CVjW6l67NPsw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl0racf+D+cTqU0VEjWBswzX1m2EsVrZKGgaSVfUoOxRphMIDYRSuuzq6HRZPVH1HC5LrPDAbW+TxlBSV/3RDO2v3soUkSaNIeZtTvzY33vp83hOSva5C9UfF6MPiITG8RH1I76AvOCMg0FNR6m/iP+PNGdC90p/y386Hidu6WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ashD29ZO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OY2hjPk8GkS3w6mS11PDJNurk7jBod5fBRVEmP0O3dk=; b=ashD29ZOwoEHPfmWPlGo9XySGH
	Kz6OBvVu4+vLJJ+/EW9G8fTPDpqiKN7mLhBW6ZJezv+feXZ09sx6UKaLsAsD2XVz2FVpYxV9a4Mbn
	Exmc2M1ZencyrIQYqWDMx/7G+oWLeRdjSRMFGTS0VyJBGwbT8nQEaEZNtZALJ0AahAPOx0kUWclSC
	QJcbbPUrJDNZySfENcjeG2jdE4fxP38I6Bn0wdNH2MhEiVPuhJm/pLi+YONORN/YWzpKQw1lyxgai
	9XPWwnmZwYUGVxaLt0CI4dyRxFAvsA/eZH711N4mU+r5ey8clFiC+n4sP1eXOrsWFBkqi7w8cOz0I
	Bt30SvnA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vW7E0-0000000BD4F-3U5O;
	Thu, 18 Dec 2025 06:10:56 +0000
Date: Thu, 18 Dec 2025 06:10:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: bagasdotme@gmail.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] VFS: fix dentry_create() kernel-doc comment
Message-ID: <20251218061056.GX1712166@ZenIV>
References: <20251218-dentry-inline-v1-1-0107f4cd8246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-dentry-inline-v1-1-0107f4cd8246@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Dec 18, 2025 at 12:05:00PM +0700, Bagas Sanjaya via B4 Relay wrote:

> @@ -4939,7 +4939,7 @@ EXPORT_SYMBOL(start_creating_user_path);
>  /**
>   * dentry_create - Create and open a file
>   * @path: path to create
> - * @flags: O_ flags
> + * @flags: O\_ flags
>   * @mode: mode bits for new file
>   * @cred: credentials to use
>   *
> @@ -4950,7 +4950,7 @@ EXPORT_SYMBOL(start_creating_user_path);
>   * the new file is to be created. The parent directory and the
>   * negative dentry must reside on the same filesystem instance.
>   *
> - * On success, returns a "struct file *". Otherwise a ERR_PTR
> + * On success, returns a "struct file \*". Otherwise a ERR_PTR
>   * is returned.
>   */

The first one might be borderline sane (I'd probably go for O_... instead
of O_, but whatever); the second is not.

Forget kernel-doc; what is that phrase supposed to mean in the
first place?  "struct file *" (in quotes, for whatever reason)
would presumably imply a value of mentioned type; a function
declared as
struct file *dentry_create(const struct path *path, int flags, umode_t mode,
                           const struct cred *cred)
*always* returns a value of that type, TYVM.

I'm not a native speaker, but I'd suggest something along the lines
of "a pointer to opened file" as replacement for that (without
quote marks, obviously).

