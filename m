Return-Path: <linux-fsdevel+bounces-67896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31FC4D08C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F21C4F7091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BCA34B183;
	Tue, 11 Nov 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cxh7bLzT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5E534A789
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856575; cv=none; b=i4jeGtXm4XisyIFR7ABYAqRmQswjJgi4jPwPApejC0jOtHamM+ZbpmP+duNuHvcMZioBmHaiPDPwrcHs8dK0Xqxy6EldHmeYniObobO5VaXNiaymrY+3YzHHpjNroHjJZ4rxshw62LS1U/ULc34FP/DgFBRB1HyVZgACEzHK/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856575; c=relaxed/simple;
	bh=JrxCJS6doR540ni5O4K+fTfT2J1vhfEKtnYrNkU/J6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYpFhwQ1pBoZb6eZgA1cxrOY3Ldi21V//UcoLn4BKEgB/5iBWbrePl5Si3wZulzFv4Ewf11qa5u5paLog8ftcmL0vaIqR+XevVjhpoKberQ8ZLM9gTzJYXdYNApMYFxKW/YIOdRNVZq03e18Qd8qCeWnnd7R5WrOTuyp2T3cn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cxh7bLzT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ed9d230e6dso44118011cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856571; x=1763461371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=Cxh7bLzTrr9BQePvVGjJ40vDC0NZ2fTThVB7BYFO3Iak6qyEFFlUvplymWg0joF7Q3
         HVvSugfkZBwk1iaxvYjWFo+NLRPZYh1e5zW3LFB3CpoBIX+SjOYunRJ+TM2+q8sIqGZU
         epcQ5oRizTN8F+VsWK6pLYxh6lReG0wjdPWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856571; x=1763461371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=Ra5y2LuW3dW9c/Ne1gNLo87zHnMkvCEJHtZInI3A9gxYgXNaa52xSWzuxgzQ1q3RYD
         Yz+bz3Nz0GKJE2d9Lktgu7uo73E9mWw79uObRuyztmkgVDE7WR58wy9TrTaWd0UYoq8A
         Gu2F8jbdOvIYTAN3/KjDM5rRkDz4B0fabiidzRXxEHtirobB1myzcthg/LhRmyShNB/P
         fnvc3mDh218Wh1eope8B9RclPUmM2yU9r3vkQYaCngU21KwOz4aIBngvfLoqKu3pWbQY
         iod7JOXuAB1x3ehcUMJPF0MEszVEUOP6mNLWuzofaMiXJXLsN831Igd+Sx00+ergPe1c
         6YNg==
X-Gm-Message-State: AOJu0Yyv1+17IrAVCyncifEbghS8mJXz1o9aLDiYKttP2hX8C+TWDQZc
	2JSKrizbxQQ0eFTcd64RTcodEM9ojru2Y7HURM2mcd89UzHRyTuQxcDeFrmFXPiY8qjAUsLqi8D
	xL5S+TgO6MmwQSmp7XxVyBtJkCgVg9ZA5hGrSSvOJig==
X-Gm-Gg: ASbGnctnVzM3sz92B2iCAy/ZyqWPLbVC8wInpV94YQ3fQrGB4Ezz0caCKqJnFyDeU9X
	eLH0YnDqghmEqM78KEwsYd0k6DJ/tAqgXLt4r9DnsU5ndYHZ96afmJ1PWS4TmgJkKc07gfAHEPV
	k3Eqmvy0k4uuGjNHpanlxUvI68SLrELFxNiZ7ys3G2gHFfB3RxRJGaaGomYxtTxispYxFKkYSJ3
	7jhWEKGSyddYl2CHupmiM/hku7B6Fh44r8+0+O5CxsmUlwFhmxFrSxDzE8=
X-Google-Smtp-Source: AGHT+IElRIVhqCvDTFpSgFEYkQvi9Gos4SnKPGf8Juir9zGtxxq03gYdBJSCGUUe4Ii0djCwuMFVWPO3CN8YKO0f0p8=
X-Received: by 2002:ac8:57d3:0:b0:4ec:f073:4239 with SMTP id
 d75a77b69052e-4eda4e7cbb2mr148255861cf.6.1762856570888; Tue, 11 Nov 2025
 02:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:22:38 +0100
X-Gm-Features: AWmQ_bn6E4e4WTTnqqQ9ptsMdEgyTHjWIJOU4-smQyjZiT3MKecFKgj620d_-Vc
Message-ID: <CAJfpeguqvHUDVzR7N=To8keErrF8Bn9kuojoFtM_58sLY_XXDw@mail.gmail.com>
Subject: Re: [PATCH v3 01/50] fuse_ctl_add_conn(): fix nlink breakage in case
 of early failure
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fuse_ctl_remove_conn() used to decrement the link count of root
> manually; that got subsumed by simple_recursive_removal(), but
> in case when subdirectory creation has failed the latter won't
> get called.
>
> Just move the modification of parent's link count into
> fuse_ctl_add_dentry() to keep the things simple.  Allows to
> get rid of the nlink argument as well...
>
> Fixes: fcaac5b42768 "fuse_ctl: use simple_recursive_removal()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

