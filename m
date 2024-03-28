Return-Path: <linux-fsdevel+bounces-15521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516688FECF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 13:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BAE28B890
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 12:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BC7E772;
	Thu, 28 Mar 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LJzPCpjn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DA57887
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628299; cv=none; b=O/9tUoSctzRkJS8LrQKZ8rEy/opaEhRiIIkdQCmjy+iaKuE0WQ9zk5YwOf73cNshl/UcKxYWnSb3pkTxpsYyMGY+ihhw0BElIxFcDa+4YIprACRfCtyzebvFE4J+rX9AQWO7wbtnJ/C/jdoecEL1d9wm2dBWO8TcHAlsn1gwll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628299; c=relaxed/simple;
	bh=Lwg1fmCknR8Ry1SW3M22oRRlcnp37S8ciED/40rgmkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqnU6Apy8IJwLBJJbaOe73nm0EgGSch2oUxmBWRS3cmmAAiDeSrPTkxlHTFSlqMLRC+8VEp4dIyEbyvDM391UfJT/xfZbny2Z1ZCep3sGsxKicajlPbunKAohxZON8brETXmvpDcA7tJAirjiXr2/Z3oDQhrKp5Tl4WekzdZmcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LJzPCpjn; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4V52Sb0bMRzTcl;
	Thu, 28 Mar 2024 13:11:11 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4V52SZ09ymzMpnPg;
	Thu, 28 Mar 2024 13:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1711627870;
	bh=Lwg1fmCknR8Ry1SW3M22oRRlcnp37S8ciED/40rgmkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJzPCpjnVdtNhC6IGj0hF26ckJqDOwQ78sc27EX27XxPQfii8VKyDbHy7Jj+dWy9+
	 dOl1TJyUXHgDbYb/vQehEMpoyYVHGQ3BPtzWIXG3Lb2rq1luUnHAvdVw7nXDa+LW/0
	 8fdHMmMIxnPEoFSq3CjIAMuZ6Xxe0xGzPSDS9RIE=
Date: Thu, 28 Mar 2024 13:11:09 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 10/10] fs/ioctl: Add a comment to keep the logic in
 sync with the Landlock LSM
Message-ID: <20240328.ahgh8EiLahpa@digikod.net>
References: <20240327131040.158777-1-gnoack@google.com>
 <20240327131040.158777-11-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327131040.158777-11-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Wed, Mar 27, 2024 at 01:10:40PM +0000, Günther Noack wrote:
> Landlock's IOCTL support needs to partially replicate the list of
> IOCTLs from do_vfs_ioctl().  The list of commands implemented in
> do_vfs_ioctl() should be kept in sync with Landlock's IOCTL policies.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1d5abfdf0f22..661b46125669 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -796,6 +796,9 @@ static int ioctl_get_fs_sysfs_path(struct file *file, void __user *argp)
>   *
>   * When you add any new common ioctls to the switches above and below,
>   * please ensure they have compatible arguments in compat mode.
> + *
> + * The commands which are implemented here should be kept in sync with the IOCTL
> + * security policies in the Landlock LSM.

Suggestion:
"with the Landlock IOCTL security policy defined in security/landlock/fs.c"

>   */
>  static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  			unsigned int cmd, unsigned long arg)
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 
> 

