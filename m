Return-Path: <linux-fsdevel+bounces-65973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083ADC177C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61441C80D93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CCC1E9B31;
	Wed, 29 Oct 2025 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="evHEHdUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB1B1BCA1C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761696644; cv=none; b=lrtuhr1iPV7gMOUEolJJ5NSZhuj7O98D2nQBVd7U/mUWxIi+7jUjHibLN/au1jHgrUgjRxo7NodxehprSHlVkvHdaCoGIANl4OfLEO0ZyqWwaD2Z80+tJ3ARbXlJ44/qpuEyWyjNsch/6rCCSKDt55IG/E3ZrJs9yQyOcAL8F3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761696644; c=relaxed/simple;
	bh=QloRiWksfwupmAUdBgNLV/svbMoFmzJRlSMrdXPaxnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyT/7SHJV04G2G87wbYgDbF3XaMTR+sPIP6koTuT4WLz6IrU5Dhcg5R5eKs+xHb/4zREL+ncvDGic/WDvzGF+6u49Ng2azr6LX6PE88qaY7PuHyRoQxs1rL2PBzaVKLZ+l2NUrOM12KsRpGpHMsbJPNoJFDh9GX3cDL9x8uVDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=evHEHdUk; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34029cd0cbdso1857675a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 17:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761696642; x=1762301442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=evHEHdUkGc41clD3/HvS6TCsRDFkA9q6MEZ+Ee8ikmU90EW0nwK1uXakOJknKdIEYw
         UPOMfeEvBNhKrHjLjHr7xIYCpdId2KHIvvTrAsza0xQeogPNi8UwwvqaI96FT8ITZ8vQ
         uzFC0R7kneeJXGfF8/cqcxLa3ozJQN2E70B69L9NShTl9bB++pcLxc0q3bhCZ6JHhbk2
         c7LXeRcZcT65SzKjp7o+Ph+jEW+BDN8aORwZ2Q6/pPfvCmUIvEEXu+nEyBOVi1hFu8Rr
         SUBY5Gz0grZxmej8kpSYf3nSsLE60De2XMA1fzyVirRng1clt1tCPFYnLsbjXnIXjkwS
         8jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761696642; x=1762301442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAeYT3sIf5J+urxpWRZdGCYWbbcmjWbjfXki2vhXqBo=;
        b=lZVC8lC8UjQyaTGr6uWln9H7WcySL2OjEkvFqE8cbjUydHP2chDPOYs19h576/DoVn
         3ubUfp3y7IKVgDdCvCJYp7rtCr+/fGMSPzVZMujKqFGDxibxLcg0TeKqXZwYNBJCLlQF
         GVZaJadbod9wQF9vC3jH5iQPFJcYuax5BQbmt0XsO3ObO3hfxLMpUVuT4z1tqNsJZ+xN
         dhQU0rOama2ahNcoGbiN8xhyxGHJBo+DEEYJKINIYwud/lBfIATLSHeAqvZsjF656d9t
         k3vYJRx+h5pQSxlqnEAea+zboYvmQJWjD27SAobW7hha29SpfSUeeG5i04LWZ9bZCdS4
         BUnw==
X-Gm-Message-State: AOJu0YzLAtcVpXJumeb9QgXUcXOxGzVySzlukYobmKg7km6JINeBhI+M
	dAsEJ81Ek0SFGzZO+ka+w5yJrSldoNk5GHfkFdiAHc4zeRL7UJy6hRa3dOax2h/2uhwfALSUwUY
	jUboQC13r0kXMioprvB3fGfxHCaB9I93ZYYN3euRp
X-Gm-Gg: ASbGncuPtzCZ03lbVWqXeyWznkOC5cWaC0pWC67lG6Q+qxLk5X8b3XwyBLLyQZFFbfJ
	njkdzUXQCnzKr6lRW7rM3f4SRGYYwHydvxhxEJaIAMhm36Z2GYzvJcUBbnoM5enh3Tipd8Yvz/y
	sQCVSjq/hXzKSIS8KKsPjWm4XgqfnghvphIju0kHg0wYHxL6exnJOEIKXjioVlwsUKd4ZaW83QD
	IqF9MW/D/Y4fQkiT2wZCmGW1apznNBQNphtAS1wv2SmIyrZxKYNowV0Bd4v
X-Google-Smtp-Source: AGHT+IGhjs8q4GiygXwr6DCqhQXMqWhNs5oaPfnq5KAn4id0agHe+xmdqRLWlZPNOFZ/N+dUgAnaM8QQHq+RXzkh3rE=
X-Received: by 2002:a17:90b:4c8c:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-3403a2a1014mr987268a91.18.1761696641654; Tue, 28 Oct 2025
 17:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk> <20251028004614.393374-49-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-49-viro@zeniv.linux.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 20:10:29 -0400
X-Gm-Features: AWmQ_bnyVa46lrJnSEC4p7b8a6-fhgKBPo6xvMl8XVNnPJL6uMjYjs2dxSO45Ps
Message-ID: <CAHC9VhRX6kqFbbKuOoKOLLve6c+7TN3=fXHrtXyj=osfNYd+2A@mail.gmail.com>
Subject: Re: [PATCH v2 48/50] convert securityfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:46=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> securityfs uses simple_recursive_removal(), but does not bother to mark
> dentries persistent.  This is the only place where it still happens; get
> rid of that irregularity.
>
> * use simple_{start,done}_creating() and d_make_persitent(); kill_litter_=
super()
> use was already gone, since we empty the filesystem instance before it ge=
ts
> shut down.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/inode.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)

Much cleaner now.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

