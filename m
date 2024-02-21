Return-Path: <linux-fsdevel+bounces-12254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F585D612
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 11:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131D81F23F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0DD3DB8C;
	Wed, 21 Feb 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fe8Kupdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340C36AF1;
	Wed, 21 Feb 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512724; cv=none; b=M64wn6LhvdSx6EkKi0Vhdcqop2J4GAFzyFhaVg3tUdolNNIFJ/gyi4OaLh/ESyu4GEBhmNJ/CPIdLJ0Kb/ngsCiYJCv28IGAAP5D8923CxkQg/PS9QPtGplsF8HGK6M/rfDsyIqTgS1HR8P+xmX0u7DHWBSzjSm+3Jd6C2k1mgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512724; c=relaxed/simple;
	bh=1x3NEsyd2n0SU0RKb9wgtvD/E48d3dJd2NJAvwfvS80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAfArV+wYv9w1Kbcfl3HYHCGZX9hW2tT2Nh8WteRI4n51NLLeAZx+W/iAWmp/qOA2+OoRpazKe6HisYH1Yau3yY97UrEWPaAh716MRNrplBjKVcJNJzMccBtHqIrcx1yFlTAMNj8p80FwCihIFFkhkjwGtaBsZZnSaoObiYcILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fe8Kupdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A2CC433C7;
	Wed, 21 Feb 2024 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708512723;
	bh=1x3NEsyd2n0SU0RKb9wgtvD/E48d3dJd2NJAvwfvS80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fe8KupdolBUg9nyNVdHIk0a7gCoiYbBCTePyxHrqQumJgOtRNakRepk+/omfB+Sdj
	 ifJtDe7j0vZKkJPJrwJsMs7vcChMcooXVWWt2OgI215t47Pg2ud8wrKExlaWqsjgKE
	 jA5C7iPP1l56a6uazEHlwTPQvZngcE6gysz8Ackw=
Date: Wed, 21 Feb 2024 11:52:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alfred Piccioni <alpic@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH 5.4,4.19] lsm: new security_file_ioctl_compat() hook
Message-ID: <2024022148-gallows-ravine-92bd@gregkh>
References: <20240206012953.114308-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206012953.114308-1-ebiggers@kernel.org>

On Mon, Feb 05, 2024 at 05:29:53PM -0800, Eric Biggers wrote:
> From: Alfred Piccioni <alpic@google.com>
> 
> commit f1bb47a31dff6d4b34fb14e99850860ee74bb003 upstream.
> [Please apply to 5.4-stable and 4.19-stable.  The upstream commit failed
> to apply to these kernels.  This patch resolves the conflicts.]
> 
> Some ioctl commands do not require ioctl permission, but are routed to
> other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
> done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).
> 
> However, if a 32-bit process is running on a 64-bit kernel, it emits
> 32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
> being checked erroneously, which leads to these ioctl operations being
> routed to the ioctl permission, rather than the correct file
> permissions.
> 
> This was also noted in a RED-PEN finding from a while back -
> "/* RED-PEN how should LSM module know it's handling 32bit? */".
> 
> This patch introduces a new hook, security_file_ioctl_compat(), that is
> called from the compat ioctl syscall. All current LSMs have been changed
> to support this hook.
> 
> Reviewing the three places where we are currently using
> security_file_ioctl(), it appears that only SELinux needs a dedicated
> compat change; TOMOYO and SMACK appear to be functional without any
> change.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
> Signed-off-by: Alfred Piccioni <alpic@google.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: subject tweak, line length fixes, and alignment corrections]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Now queued up, thanks.

greg k-h

