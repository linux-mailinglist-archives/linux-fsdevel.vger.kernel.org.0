Return-Path: <linux-fsdevel+bounces-68172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCCC55653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 03:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002B43AA2F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63B29BD95;
	Thu, 13 Nov 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTy+beqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9F1F181F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999756; cv=none; b=YdJMipOflGhtdF3qAFNBE/kp/Ek9Oq7fxwyhaZNtOdifDY9DH0SRKIgPpFvSkIf3Gh2HJIf+FYFFPpfimJ05lK/mzX9P3lScocBZuSaV69r0gVaHwTqpgUj1seOwmMgi+Xkp1kFDMjiPy/7k2W/ZfCevxUrHx2mNPAeSO7NkIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999756; c=relaxed/simple;
	bh=6UwvIGsRbrpFaKVD6/b6P6NuYJ3KfTLF6Du4cbGN6Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZee8HrS4xgMvR+rn57UABckXGTbUvJ5FnVcK9z+kPtD3VDjclyqIfDIAr7Z3cBnY8Ptl/pp/cQduKXslltpXHH8y4g8telFPWoayo2TufR93tbDfRTXxsdhWYwvcNZ7RYE0mnenrdrU8jiYSX32vDi12zB8DYR53wa2dya8eGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTy+beqK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b403bb7843eso50751566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762999753; x=1763604553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YilcDuhj1dhziVhER+kb8IKURkf5X7d7kISKxPO1dD4=;
        b=PTy+beqK+BHaTpw4dgbyvx4F5AGsL/x/Wz+DmfUuBpHIZ4tjV8mB/gR/MH7aS/FkPV
         5cJuKOHvyu7nKM85x3q9svHZMOgqLCKVBqsJS51Xpy0cVxc1t7ehDoc17SgRDBoHZlAq
         Ozfdljg0K7NL8PbqUYhvA7vOyykUTNcStb3V2UXnu70kdsxynCoZvCb6uEHmgqtF+5d6
         iNVPXvHO1mssIzmjhHAUizkx4DQ007jh/4U39pFcWdD4Ja7JWPbl7hgXsnlmjpJn3aBj
         bYmV2mkZVTr4uWfFbJxTo8sb4OqYrRhXQaeDYxcivcPx6a9R/u7gouYbWBofmi7RtxIq
         yO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999753; x=1763604553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YilcDuhj1dhziVhER+kb8IKURkf5X7d7kISKxPO1dD4=;
        b=wMoa2AK0nn7Aq2dPJ6/KTI5wwbVN34UpcTksWUStEfjQqIuqhjOz7e+RuykSLh54Y+
         1N7i4i1rB6pPbWe2SYnjMdDJ2Ci5dAI8p+7ORylXLlxRqvnuvrY92Sj/rqwyxjjdRO1S
         N+q9EZY7OzBNql1BAuQLsbEqJWQyMI5BUCeOHJ/tr1hbxFhmjErrHjWX7bQzYnH9Rsrh
         pym1GtQSgjtf+byK3q25tdwIOyBpDH5GxoROmdwjJcfYE2LFY58giBi13ZDhpr9Ajmr8
         dZduCF6W/2tNTy5ctuDsasI68HaWOpcht3baGD2YnHVY/vkZvJLrIDiyV0uumayWkc5b
         yvbg==
X-Forwarded-Encrypted: i=1; AJvYcCXc1cwzQvkgpd9XO0D2yVfISSTFJnpcbV+hou2zUubxblkXHVGiizzhKQSAAW1ScbtLo0tNlBI+zrYHtGOE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4h2CA3HITaLx59FcO6uSbE0rUghRh6u/mxZey9yu13mPYWxrF
	AINwgbxJy+m6JC/FQo2z4SOHvwVMpQfKBJtR7yZ8pbPVQYma91+LbT/L
X-Gm-Gg: ASbGncth+EZyq172O2CgbmLsQfwrifi4sc6l7zfItNy7KzC45cvNzYoLqaB3aK2ws9N
	kjqvlzFZo77EonknbVKaBFQQadKoAGyjKnkIG0Cqx8aVX6v24m7Afj4cZOqCk7P/fRGXby8vtx5
	sBAgyvHkPyQWZxJ4RFj1ggYqBD0CCMG+X612pLy9SIxPjXB2bTyIlm5wTILCKCjEG5PkPOS4tdb
	g7IyhXEBnxPXNqV1ybMfrTuce+j2IDN2X5DbkgIT7G+lBd1sadFX4Lmic/CmdxL2sGnUEsS9d5U
	EHRyFKZngkoGM++Vx/V/qVGxCPX0Bj6JwkfOYnXIc1yqIbcdij9Wzz/QRqK4GDjD7KOV7mZwo8W
	aU6Hf3IF1iGjMO5SFtCkt1KMuJGd4VRj48eRuPfjDGGQi9HtXFhU9gCMYvZizUr2fVqazKhxLBQ
	whIIVnkIyywFPWcKpQOpiZFrXRxb8wCScRHkMu1l1LcxgOyQ==
X-Google-Smtp-Source: AGHT+IFxoYa5KI4RfrUVTTMhZzXg4lGOX/gv1esso0Q+isWJ+ieIFGJgHziAmQfL7z67Pf8gUo2nwQ==
X-Received: by 2002:a17:907:e895:b0:b5f:c2f6:a172 with SMTP id a640c23a62f3a-b7331a70378mr520934766b.30.1762999753041;
        Wed, 12 Nov 2025 18:09:13 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fad41e5sm54885666b.19.2025.11.12.18.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:09:12 -0800 (PST)
Date: Thu, 13 Nov 2025 03:08:47 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: jayxu1990@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, rdlee.upstream@gmail.com, 
	avnerkhan@utexas.edu
Subject: Re: [PATCH] fs: optimize chown_common by skipping unnecessary
 ownership changes
Message-ID: <uh2mcjliqvhew2myuvi4hyvpwv5a7bnnzqlptfpwq5gguiskad@ciafu7tfwr4h>
References: <20251113013449.3874650-1-jayxu1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251113013449.3874650-1-jayxu1990@gmail.com>

On Thu, Nov 13, 2025 at 09:34:49AM +0800, jayxu1990@gmail.com wrote:
> From: Jay Xu <jayxu1990@gmail.com>
> 
> Add early return optimization to chown_common() when the requested
> uid/gid already matches the current inode ownership. This avoids
> calling notify_change() and associated filesystem operations when
> no actual change is needed.
> 

If this is useful in practice, then so is probably chmod.

> The check is performed after acquiring the inode lock to ensure
> atomicity and uses the kernel's uid_eq()/gid_eq() functions for
> proper comparison.
> 
> This optimization provides several benefits:
> - Reduces unnecessary filesystem metadata updates and journal writes
> - Prevents redundant storage I/O when files are on persistent storage
> - Improves performance for recursive chown operations that encounter
>   files with already-correct ownership
> - Avoids invoking security hooks and filesystem-specific setattr
>   operations when no change is required

The last bit is a breaking change in behavior though. For example right
now invoking chown 0:0 /bin as an unprivileged user fails. It will succeed
with your patch.

iow you can't avoid any of the security checks.

However, if there are real workloads which chown/chmod to the current
value already, perhaps it would make sense for the routine to track if
anything changed and if not to avoid dirtying the inode, which still
might save on I/O.

> 
> Signed-off-by: Jay Xu <jayxu1990@gmail.com>
> ---
>  fs/open.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc67..82bde70c6c08 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -761,6 +761,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	struct iattr newattrs;
>  	kuid_t uid;
>  	kgid_t gid;
> +	bool needs_update = false;
>  
>  	uid = make_kuid(current_user_ns(), user);
>  	gid = make_kgid(current_user_ns(), group);
> @@ -779,6 +780,17 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  	error = inode_lock_killable(inode);
>  	if (error)
>  		return error;
> +
> +	/* Check if ownership actually needs to change */
> +	if ((newattrs.ia_valid & ATTR_UID) && !uid_eq(inode->i_uid, uid))
> +		needs_update = true;
> +	if ((newattrs.ia_valid & ATTR_GID) && !gid_eq(inode->i_gid, gid))
> +		needs_update = true;
> +
> +	if (!needs_update) {
> +		inode_unlock(inode);
> +		return 0;
> +	}
>  	if (!S_ISDIR(inode->i_mode))
>  		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>  				     setattr_should_drop_sgid(idmap, inode);
> -- 
> 2.34.1
> 

