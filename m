Return-Path: <linux-fsdevel+bounces-33320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7099B7447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 07:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567F6285BF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EC313D518;
	Thu, 31 Oct 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZM5liCZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EDC8C07
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354713; cv=none; b=cWlnXg+UD9AbAGEZVoW8uOZXIY3nZ2BAUzGkuYItNVb4OICPc9OWpC9WyQoA/QxRw6KSg8DKttJ0ijk9WlLpv405b6GLlHQBTcC4X1jgAB9wmECge7ADYhUm74Wr7dWVKRI3+a8wPMpEytadtB/ctDs+b3miBrQQgPH5QrwU9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354713; c=relaxed/simple;
	bh=/tTg43zdv7GmWnnDrfDURfVxMn9xeulbbDWAWo7JFc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsxlRlBrrzBIKmDGF3cHYyMMEZczvKJBKbWkIj7jSfirRO/fRJ7rcNGxQv0aXHqOZXbqvrBo7GHr4QhFywEYfTDDvV5AG67+n48KT/ETuqGqKhHoWRFCTHfx7wxRjVgzuW9p5K2bSqA1jySYCQ7Yr9Yzp0ApyGyPYbH4A7bp1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZM5liCZo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zALay53fED9p1F4M82EjtoyIdvfTkXll6cuz/W/w2JY=; b=ZM5liCZoo+gkgb5j3t9r46VPA5
	IecLYS4PwI8QbDlggDIq2nwySFK7e3EofO4t5WbriwjEnHeBXCvJwkzeDAAPKCjuitgmWnDywPlmI
	EQHKbQvgNJDRhCye1o441uv3PwiL7mvDVt25NBqDh12y2bYob6xZANsO9fx4AUMihRtLW0unl7ZHV
	jDkbXtHu51+eRu8QWwWjxlwDzg4sMNGkjp+DFTjjYZnmqzNFlkF/kjDq8zNK7yfuZz8XBaTsbDNfd
	fsTEj5XGKwr1DsX/lIOiJIPDPPUz7Aj032TCMfec0jfG+amaB1sy/n7ZfnD2pSVrbwkzuT0ZwG9oR
	APpoXi7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6OIt-00000009g38-2oSm;
	Thu, 31 Oct 2024 06:05:07 +0000
Date: Thu, 31 Oct 2024 06:05:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20241031060507.GJ1350452@ZenIV>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 30, 2024 at 06:16:22PM -1000, Linus Torvalds wrote:

> +static inline bool no_acl_inode(struct inode *inode)
> +{
> +#ifdef CONFIG_FS_POSIX_ACL
> +	return likely(!READ_ONCE(inode->i_acl));
> +#else
> +	return true;
> +#endif
> +}

Hmm... Shouldn't there be || !IS_POSIXACL(inode) in there?

