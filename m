Return-Path: <linux-fsdevel+bounces-39431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1737A141CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17853169D35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AB22F15D;
	Thu, 16 Jan 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="C7vRTy+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAF14D6ED;
	Thu, 16 Jan 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053120; cv=none; b=ZZFXKPuJN5k8zEMOD4fXizamWHqdnv2MgJHYS9kb8VYJ2wH3kfSOK06rMMsjMySCUhyN/MqIbYHbkBI2Mc2OhkMpa+YamTVdsL+cwL3+wQC/GXOrtPwhlVkV6K9Q3Dh73JxyOd+ICq8CFX50DTAOiFmR5RxCSJ4OUN1xNrE9wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053120; c=relaxed/simple;
	bh=rsjWx8snrVSihpGO5O/rsgrHlkXisv74B79AM8nijKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBnQaGmtMIBvLARLMbHlM1DQtw4gFNGqMRdMi6QM/lVnIlj466BImpwaEajA28Fqv8fUjehPRNY2KGWkrjciaagFETh5DjnVq0I+DRSy4tftj54M5QgD2jVtWSPc9hntWiD+N3/OYbw21MpysCwm0gZ7ldAKpmtT/TJLWs7L8oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=C7vRTy+2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZLSocMY2P0mkdKTPNTXYIKtWnPaaWSzi7Sey7jOpivg=; b=C7vRTy+2V5Qi4XWNioSQMzFJvv
	E3H12ja5Z76uHO9iUlLV/m6zRTnMzVacBgTL4ssZ+vfU8DnDK7ZSOAC7snP1vT/2Nc3U5svfICByE
	Q57l6if1e2gDMrszrmpsHCaNYxIYRHAnwSdHwN0WFcsoFRLGlqJLVe7a0iKz32uGhFe7fQUvaSZMw
	DMexyxfXayWMjUhAlCYbI1wsBLzpZwIAHNNXaoV32OcKpstb5F2GeGNcBJYnU1cqoR3f7SQfyqo6V
	4fzEkJjEDQcNiimvq3lqhu/W29814KK3CC8GVSWogtsaPpTdLuGQdTpk50l9JfhbOuqA7+o5qjM1V
	X8aoiWsg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYUrl-00000002YAW-2h0H;
	Thu, 16 Jan 2025 18:45:17 +0000
Date: Thu, 16 Jan 2025 18:45:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 6/6] efivarfs: fix error on write to new variable
 leaving remnants
Message-ID: <20250116184517.GK1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 06, 2025 at 06:35:25PM -0800, James Bottomley wrote:

> +	inode_lock(inode);
> +	if (d_unhashed(file->f_path.dentry)) {
> +		/*
> +		 * file got removed; don't allow a set.  Caused by an
> +		 * unsuccessful create or successful delete write
> +		 * racing with us.
> +		 */
> +		bytes = -EIO;
> +		goto out;
> +	}

Wouldn't the check for zero ->i_size work here?  Would be easier to
follow...

