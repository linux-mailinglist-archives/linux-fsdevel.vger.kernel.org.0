Return-Path: <linux-fsdevel+bounces-25883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F408951407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F18286C5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6A155E58;
	Wed, 14 Aug 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mTeyKRjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69B5FBBA;
	Wed, 14 Aug 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723614356; cv=none; b=n4U1qLND86tIUWtrR0UhG0JZTx+wwJEbNXOYQWEpgVXEb3FTB2MVnF5+S8GhtdLt2rOk7orGsZcZPANeqOM1ktLCdS0GR+wv3IEad6dUMkuP7VODtU1DKktlLkZJmkrdSRhwcNXRy3GgKETjrjbgEYLJ7j9IUC/ioLaruADlmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723614356; c=relaxed/simple;
	bh=D8lzcUYqNTKYKtGldYWQoLJmX4hcCeDHUf8sntU2pGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWCaSpfyst+GKjeH7nvAKw9JTiqQQf3NX6maQf9YFTGrM2uUXQwUkXf1zangMWcfsXw+yOtt5TO4dUwsowKhcQyA+0eXz+g/3I2JxUCLznhRqGNEJIi3WfScmSN7GfE8Ih2vUTdAhkMCI5I7aX+e4KE5gilaaOCygsZ8n8R5jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mTeyKRjJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jDDzySZKdFIhl4ah20o6yNkAIJY2fx5ERdxmmv07dS4=; b=mTeyKRjJWzjYq52/+2v4abSZX6
	+IP8JS6q06hV+5Awsu3E6uKFUabkRj0SJEmL3JMrAvmjQwM75KM1T16m/47AZEu+hIqpiywGFBQfc
	5Of709sXSKb+faO1EjGh1vLYCH3TOJX487XIJGK4RcdlzzWSFIZm7U07n0x28Fc2g8PaYfE2TApRa
	bJxH6B5I80fRTrJga+jCRfek8miAguBWZ3wF0V1SQJQgSGU9iXC9gZKhZrdlmfDBloGZA4OgQf2YM
	owzF6crlH9XbXcQErBpYoDgwcVv+xZP2JGnPfKxoDF2kd4ci7x6MJk3gTZXGpJkB8N+1/8QALEB3O
	avnzbxqw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se6pU-00000001Wm3-0lvO;
	Wed, 14 Aug 2024 05:45:52 +0000
Date: Wed, 14 Aug 2024 06:45:52 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs: add per dentry expire timeout
Message-ID: <20240814054552.GR13701@ZenIV>
References: <20240814035037.44267-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814035037.44267-1-raven@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 11:50:37AM +0800, Ian Kent wrote:

> +		inode_lock_shared(inode);
> +		dentry = try_lookup_one_len(param->path, base, path_len);
> +		inode_unlock_shared(inode);
> +		if (!dentry)
> +			return -ENOENT;
> +		ino = autofs_dentry_ino(dentry);

Why can't we get ERR_PTR(...) from try_lookup_one_len() here?

