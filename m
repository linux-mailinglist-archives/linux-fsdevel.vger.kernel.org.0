Return-Path: <linux-fsdevel+bounces-16008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F2896A25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B1C1F23334
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96045763F2;
	Wed,  3 Apr 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neCZ9zKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DA745C3;
	Wed,  3 Apr 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135489; cv=none; b=ElVEqhtsZNqHLGNZcJVnsGVMnOUpKRphW8meYrusN98X+A52MA/y1pJyiqH+Zbe3uSt8L4/HsRSJUxhPCKWN6JxKlm9fjNuupCTz69g41Cff5CprhJDfMt+uI0EdzO0PMBMCZwugbrTqlHBrhIqg7vX70xQLUVlUrKOy4x1A4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135489; c=relaxed/simple;
	bh=a4SU9LeyHasQcuTuvnaPAm2576TUr887qz82fyaiNNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isnBhRbQSNupHqMbm5BeIGXrNa5ajrv2nbleEOV1njF8Yv0U2LdcKZr8BRMnMHCD8V9YIQ2j/q5cc3cqrFKd53bkdMwTqeLnoghswfj7k0jSB+katC4oDCMTEiAXlpIMYSSav8RYHW47xWmOZU5PlYFfINnMd887zAK3bEEdywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neCZ9zKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E06C433F1;
	Wed,  3 Apr 2024 09:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712135488;
	bh=a4SU9LeyHasQcuTuvnaPAm2576TUr887qz82fyaiNNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neCZ9zKndHI2vjnoV80pGunkUnrmdHulqFhGcSD1hX1jINc24Vr+EzvQxtlEhS8n1
	 8QU8VuWEwBlHzPWbfLIf1tpIOPLk2s8qgoOebsjWa2Xn7zYCcNB83r2QWk10tGRGUa
	 yYOqogWUM7jHLmSg4V/lbbVrSid6qCz/6DlefXcOhUh/GFKX6ze6WoDm3xJPkwJcDA
	 cuzJisg6VdNTd0ujPxjAKAfbTln5l48n1qhTZ3TJdx/UKTa2w4gQl7buVXEqMYoaJ4
	 0C3S4Vt9VIYBk2Mi2+eunbA73z1AQlcTFM55qCBkxjfMfLdWY/iWS0ONyjqj+7Mj3o
	 x5B4lBGqW+eBw==
Date: Wed, 3 Apr 2024 11:11:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-cifs@vger.kernel.org, pc@manguebit.com, christian@brauner.io, 
	torvalds@linux-foundation.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v3] security: Place security_path_post_mknod() where the
 original IMA call was
Message-ID: <20240403-darmentleerung-wehen-b3a655cc50b8@brauner>
References: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403075729.2888084-1-roberto.sassu@huaweicloud.com>

On Wed, Apr 03, 2024 at 09:57:29AM +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Commit 08abce60d63f ("security: Introduce path_post_mknod hook")
> introduced security_path_post_mknod(), to replace the IMA-specific call to
> ima_post_path_mknod().
> 
> For symmetry with security_path_mknod(), security_path_post_mknod() was
> called after a successful mknod operation, for any file type, rather than
> only for regular files at the time there was the IMA call.
> 
> However, as reported by VFS maintainers, successful mknod operation does
> not mean that the dentry always has an inode attached to it (for example,
> not for FIFOs on a SAMBA mount).
> 
> If that condition happens, the kernel crashes when
> security_path_post_mknod() attempts to verify if the inode associated to
> the dentry is private.
> 
> Move security_path_post_mknod() where the ima_post_path_mknod() call was,
> which is obviously correct from IMA/EVM perspective. IMA/EVM are the only
> in-kernel users, and only need to inspect regular files.
> 
> Reported-by: Steve French <smfrench@gmail.com>
> Closes: https://lore.kernel.org/linux-kernel/CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com/
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Fixes: 08abce60d63f ("security: Introduce path_post_mknod hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

