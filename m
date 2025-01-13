Return-Path: <linux-fsdevel+bounces-39032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC35A0B539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B561683BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 11:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CB22F17D;
	Mon, 13 Jan 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IfG8DUFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091514B086
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766921; cv=none; b=q5jmYu2vat8plhcBfewBsCNanqFaKqWDWJTvDCIXuQ+XBVrqMSIPGbeKCDbiIdcrlvbOR/NniqfiJaLjhT3OGkbVFefclHri0Y+iSHApXfUOZrzfoVWvte1a7V2MSNaq/C299dy2H3Z0kMGaI+BWgUC5u2L7/qpF1GvPhme29G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766921; c=relaxed/simple;
	bh=YNXe34HTTnEKDNceJHkBJiUrqHSYQYxezeTlxeXH5qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC9Ysg1Sk7KGfLK52MdeCDDqP7AdmvNlGxOlbRAl1l86ubJ7SSmByH9n4g+HDuJJ11RE51ujw7g2eOkUcn8CPP4mZUtT1CkS6cTR+t/FOYarq6KPsT9T8XNUGFJ/f2B+JsYV3/8eVlf9MsCqYGaES3fvMD7tsMYQsyzdz6OgpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IfG8DUFW; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YWqRc009KzpZw;
	Mon, 13 Jan 2025 12:15:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736766907;
	bh=9VmIUGRg7ecSn3eVBNeu60OvvSp9tOOqFJ6XYLEmc5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfG8DUFWiV/4y2RnuEBjgFYtv57L0iFaOJ/JFODZPQ7DUjwYndnpjecN3/e8E1Q2u
	 5aHf+sfgZiyPyngvC+ODsHEjNrwqexjjSsYFVV452R3B0cLdvqbcFNBSc1FQHxKSW+
	 5iagbcPv3I1jr4nDHizFgNAjvUI8ZAJk51TUNTgQ=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YWqRY6kbVzp6M;
	Mon, 13 Jan 2025 12:15:05 +0100 (CET)
Date: Mon, 13 Jan 2025 12:15:05 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Charles Zaffery <czaffery@roblox.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, 
	Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, 
	Tyler Hicks <code@tyhicks.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 27/30] fs: Add iput() cleanup helper
Message-ID: <20250113.juseengu1Po2@digikod.net>
References: <20250108154338.1129069-1-mic@digikod.net>
 <20250108154338.1129069-28-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108154338.1129069-28-mic@digikod.net>
X-Infomaniak-Routing: alpha

Al, Christian, this standalone patch could be useful to others.  Feel
free to pick it in your tree.

On Wed, Jan 08, 2025 at 04:43:35PM +0100, Mickaël Salaün wrote:
> Add a simple scope-based helper to put an inode reference, similar to
> the fput() helper.
> 
> This is used in a following commit.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20250108154338.1129069-28-mic@digikod.net
> ---
> 
> Changes since v3:
> - New patch.
> ---
>  include/linux/fs.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..bd5a28b0871f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -47,6 +47,8 @@
>  #include <linux/rw_hint.h>
>  #include <linux/file_ref.h>
>  #include <linux/unicode.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
>  
>  #include <asm/byteorder.h>
>  #include <uapi/linux/fs.h>
> @@ -2698,6 +2700,8 @@ extern void iput(struct inode *);
>  int inode_update_timestamps(struct inode *inode, int flags);
>  int generic_update_time(struct inode *, int);
>  
> +DEFINE_FREE(iput, struct inode *, if (!IS_ERR_OR_NULL(_T)) iput(_T))
> +
>  /* /sys/fs */
>  extern struct kobject *fs_kobj;
>  
> @@ -3108,8 +3112,6 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
>  		(len == 1 || (len == 2 && name[1] == '.'));
>  }
>  
> -#include <linux/err.h>
> -
>  /* needed for stackable file system support */
>  extern loff_t default_llseek(struct file *file, loff_t offset, int whence);
>  
> -- 
> 2.47.1
> 
> 

