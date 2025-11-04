Return-Path: <linux-fsdevel+bounces-66871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30516C2EDE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E9C18837A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 01:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BC22DF9E;
	Tue,  4 Nov 2025 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY6b2MM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459162264B1;
	Tue,  4 Nov 2025 01:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220625; cv=none; b=oNvQMNUM3JvAAZu57ruHrWiQcuy5E5YSgHiuTzt7PGpO6uvAnQBhv/0njyN/Tg3tfMcDk0CmyeXV3npuuIfVkoLW5GQVfUKmVm/ZQFgDwaU6M6Uyl4rmfCbnNJnXrrpk6OJFShGcjGhHFkQOiUNEUF6CzBOzE8rAwMx4NMOFrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220625; c=relaxed/simple;
	bh=BX0tUVsyY8ldvnds1/e/y6kgPKJqlyj2E8lWQ44dxfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwdL9Jp9t0vvYYiGRhOGpm12qex8sQ1gsraYDPHJad2Ys7IUuycMbvYFcUUKPBkydT3UhN9jTcsBvONe/hhRMQAYO2u+T9Ae55/eWiVVpGzkzykTh+2qhkTAkRpSDo3AbMZcuGFtNXff7FfDZtH7XCMvt8WNdDyBTsKlND2q/bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY6b2MM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0699BC4CEFD;
	Tue,  4 Nov 2025 01:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220625;
	bh=BX0tUVsyY8ldvnds1/e/y6kgPKJqlyj2E8lWQ44dxfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dY6b2MM6lvQesY8UEelJfXc71chFYKuoyIOZKssRUSMQJxDm9jXPKotxE9/ABbFPu
	 XdSerDYLKzYzDqDQ6JtxN3d5froEQfTFFz5xPdBJiYV5fi7EtRoBao1e6KRqYwr3AY
	 4WLnVKWA2sLfmr9+9HcGjMrprpXu64yk6i9qhfJk1xH3AdHuzSaP7REg2SZctZwFBT
	 ziPcYiFBzusRmwzHTOosUeYKOg4gg5R34YL/8ezSb/+A5pYwNrmsMmzydnbJ1FjVaF
	 jXaQc0pHgng9HvscIjQuljf8jrhjAvtPL5qfzHDAlZO3QJ8dh49y79v1EdVD6oFICv
	 aPXmbZutFbm5Q==
Date: Mon, 3 Nov 2025 17:43:44 -0800
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 18/50] convert pstore
Message-ID: <202511031743.3F127F8@keescook>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-19-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028004614.393374-19-viro@zeniv.linux.org.uk>

On Tue, Oct 28, 2025 at 12:45:37AM +0000, Al Viro wrote:
> object creation by d_alloc_name()+d_add() in pstore_mkfile(), removal -
> via normal VFS codepaths (with ->unlink() using simple_unlink()) or
> in pstore_put_backend_records() via locked_recursive_removal()
> 
> Replace d_add() with d_make_persistent()+dput() - that's what really
> happens there.  The reference that goes into record->dentry is valid
> only until the unlink (and explicitly cleared by pstore_unlink()).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks for the refactoring!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

