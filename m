Return-Path: <linux-fsdevel+bounces-67264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4570CC399F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 09:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E94A4E5DA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4433002C5;
	Thu,  6 Nov 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="X30Bk2PF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316FA26E718
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418752; cv=none; b=KXaw1leyHKXfW1C+rBlRhfA0qS1aBMrA1P1Ek/u6GfraBolYEPQeGz+AtBW5DcONUJLvs61WNxlU7s5CAXFR0RevsblXECPw2DJ38G15onDZHAE8s8+aSrV8zEOHLMkE8gM3rgCJQe54xqnLke6DSlVwa5w4WSyM3oSYoUhDABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418752; c=relaxed/simple;
	bh=JeeGduUL6bWDAecqsw7jXtrhy0rUfGVWJXThQknPHYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9xsUxm/0SR1zouwbWXVG333siooIOqwtrv15rcgOCmMauUD/B6cpFswheCWadc+smC6Bi5lNDccQNzdaFlFaM48yJ8sCp4TjqOsHNrXlLvh/BO6tUVv3n8OlZ8VkvmCJ8xMVMrLtDUWNZPKDvvUMfkEUT4Tt8cUnFYAv9Szg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=X30Bk2PF; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d2G465h95zj7h;
	Thu,  6 Nov 2025 09:45:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1762418742;
	bh=JfNO0M5lh5psROFvDuYOwWJ0xb+D1+8vDp/FH+1rqVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X30Bk2PFMYipzWJ7/aD0f3Ym/BAnhmLFkPYEUVdne23t2s1Ir9+joBlwp6Di9JEbZ
	 sBEf7MkKQLVN1DVNZxQcI/ZzArZrdlEHEYKIPMH+ppOjVk1//SHGRXQr3kAK60lyjL
	 9KbnjgYprlQj+JEmTkgx0EXqV6fDKy1YiQ+QNKrc=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4d2G455C1YzlQr;
	Thu,  6 Nov 2025 09:45:41 +0100 (CET)
Date: Thu, 6 Nov 2025 09:45:40 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, eadavis@qq.com, gnoack@google.com, jack@suse.cz, 
	jannh@google.com, max.kellermann@ionos.com, m@maowtm.org, 
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 2/2] landlock: fix splats from iput() after it started
 calling might_sleep()
Message-ID: <20251106.ahm0loS4ceic@digikod.net>
References: <20251105212025.807549-1-mjguzik@gmail.com>
 <20251105212025.807549-2-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105212025.807549-2-mjguzik@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Nov 05, 2025 at 10:20:25PM +0100, Mateusz Guzik wrote:
> At this point it is guaranteed this is not the last reference.
> 
> However, a recent addition of might_sleep() at top of iput() started
> generating false-positives as it was executing for all values.
> 
> Remedy the problem by using the newly introduced iput_not_last().
> 
> Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68d32659.a70a0220.4f78.0012.GAE@google.com/
> Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

Thanks!

> ---
>  security/landlock/fs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 0bade2c5aa1d..d9c12b993fa7 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1335,11 +1335,10 @@ static void hook_sb_delete(struct super_block *const sb)
>  			 * At this point, we own the ihold() reference that was
>  			 * originally set up by get_inode_object() and the
>  			 * __iget() reference that we just set in this loop
> -			 * walk.  Therefore the following call to iput() will
> -			 * not sleep nor drop the inode because there is now at
> -			 * least two references to it.
> +			 * walk.  Therefore there are at least two references
> +			 * on the inode.
>  			 */
> -			iput(inode);
> +			iput_not_last(inode);
>  		} else {
>  			spin_unlock(&object->lock);
>  			rcu_read_unlock();
> -- 
> 2.48.1
> 
> 

