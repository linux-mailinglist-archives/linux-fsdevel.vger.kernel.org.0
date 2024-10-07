Return-Path: <linux-fsdevel+bounces-31223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593B099345F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004E11F2414B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEB81DC1A3;
	Mon,  7 Oct 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QkuBpBO8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6571D9691;
	Mon,  7 Oct 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320687; cv=none; b=Bbid+ccTYs0ypiynPtOggpssGhnQFFDhSarBDMFH91/YyZbVezwURnhMkTQ9xzoxZKx6ODmgCzlaQ2bgU9Lv9sfVBTnslaQTG9My0jTYZlyTGyrDsf0r4+DpkHEAq6F1xkZYfHprEQIlIoY4/opdaV0aw7SxpgXI64icdAlItjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320687; c=relaxed/simple;
	bh=deqWRZ33yJSVHmhP1Gx+vE6owdHSQiabHbYQ6543LnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z88ybsPW0motXMgGt5j9PXQs4tu5isA3rG4AWG82Ps/vEeAGzLCXJcPjAImXV29rIIIDYKMOq3ETzkwcuBlqQatgmvSXJVptzzJ7remAc1arC+FvIX7amnR2IKtHGRBbWPtlyKFLeg0tTxWoG6tdHGo8IskmQVqhUEmXU8nQAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QkuBpBO8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JoKjQBELUVBjdiYyNwdGEKoAi3K9bxWk3X3B7+w8jFk=; b=QkuBpBO8zEC+T8gsddF9EHqcqt
	eLXdeOdCy9BOgwJkLm7BTiUMDd6myn3wwP7RyQX91xQFrbQ3RXITXQof3l/6SHEnnxsbqWgiJgezi
	VL/fApRb5lbPBQfSjCpNTl0f+BnR2Q4ObT2b5fnGq7/YS871lWoIVOe0kfSJ30pwC2zlaDVLWQGM/
	Ofz3Amhb68vXDpRiBxwk4XgsNVT1vNCL4sa1kmNxVWcAtnYxOaRFLPQ+l9J5ujnuJ7jDBScpu3cIV
	K1kCav/2nbc9/J3C9s+b88nO58Ai0ovblYMRjwAuVj6NmjUBxgtIEYYHFtaR8SiHqr3NFxYiVoLw3
	G3QT5Xng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxrA2-00000001eLL-447g;
	Mon, 07 Oct 2024 17:04:43 +0000
Date: Mon, 7 Oct 2024 18:04:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
Message-ID: <20241007170442.GO4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
 <20241007141925.327055-2-amir73il@gmail.com>
 <20241007143908.GK4017910@ZenIV>
 <CAOQ4uxjS9YMF6tiJTNBBSYSpWuHY+Ds3J_C6ySYDpe7-o5wRNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjS9YMF6tiJTNBBSYSpWuHY+Ds3J_C6ySYDpe7-o5wRNw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 05:56:51PM +0200, Amir Goldstein wrote:

> You are right (again) I open code it, it looks much better:
> 
>         /* Don't sync lower file for fear of receiving EROFS error */
> -       upperfile = ovl_upper_file(file, datasync);
> -       if (IS_ERR_OR_NULL(upperfile))
> +       type = ovl_path_type(dentry);
> +       if (!OVL_TYPE_UPPER(type) || (datasync && OVL_TYPE_MERGE(type)))
> +               return 0;
> +
> +       ovl_path_upper(dentry, &upperpath);

OK, this answers my other question (re why skipping ovl_verify_lowerdata()
in ovl_upper_file() is OK); you don't want to mess with the lowerdata
anyway, so...

