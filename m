Return-Path: <linux-fsdevel+bounces-71378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2506FCC09EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 084B5302355D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED22E8B8D;
	Tue, 16 Dec 2025 02:39:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FB25F797
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765852786; cv=none; b=W5VfCnGk1lLpewBiaaOLIei+mQ/r3555/DsEBPEovHozBVtgX3Huv5C2Wg96dwNdtn9xuQiAUAcL8UdgWnm7kwCDD4pc9RpLN0irTs9b1QDKy5XMAhXxTkitGvmjLYUxjk80k9j8/2rsmVGcVcbituwrYGNvij9ODuzpv2XgAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765852786; c=relaxed/simple;
	bh=6+A8S3M6/gdqTPzGnQYeGZAkRFFddMC0RWi8Sbb/p3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McmOSLX3VnrDbefDghOnNAfOaf2zaIAUxp8T/wWKcKtQN+lZqMYi7l/KQ3FeHvrUxagfCsGPxoICZUbnKJK1QT7bnZOkY+3ApgLV9HNSBcF28xzuPgs19qmylWvka8pbGZ7+lTvu+NjZcAcq8CU9xBAWENDtwtDAoSFBjCRHcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78e7cfd782aso17906177b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 18:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765852784; x=1766457584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+A8S3M6/gdqTPzGnQYeGZAkRFFddMC0RWi8Sbb/p3o=;
        b=IYWwW8LDIDlBIOSPxos4k0LB/XmKJPdIoXhWtv5WZZTQsKq7Y+AHFyI2zTXfv3N/qg
         BeyX77jJ4rLDqc5tseMNg8zd5cPXVJctOLlqnpHB9gcgTVv252Rgdfe/rnOnudqWwBJd
         z4p+H6OFuFNOYWlJ/10PD8EPzFCsOUyefXnP8JLmmGSEmzxCzPjbWq3HRL0CCFIvgaRj
         ldRrfOGmHsv4alL1kAT4cmfkkpD0eE8EkXG5QZWAXIbbgGfwpT0T516WDCwyhz26iQCm
         SHDME+GYNFgPJp7AkHJGh+qwS64SctSUhDcqYxg75jcBTQ0yFZlGZaCFvaTPQGGPmqJl
         QqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgh+dKwue5sjbl1JYQaX5jY4MslHsgtj2IQSGmA23Wa9mE+ljg0jbDwD6C/wR9AJgKJLTiUCFCzZB/Wfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xxVRU5Qn797WMfv3QDDgX3LH1f0qdmuN7T+2uVRhbvhnKrNA
	25hm6rlNt9E1tX4e8728qxKGLlNx7GVkBUSFsZPELfvHtzOB+PRgLnhEz07/zQLZE/4=
X-Gm-Gg: AY/fxX4bhN9APZt+EVJPv0bZjbFN4qdB3UPRDcqhB5R04SJSTRzxff8PCGYBZcIT2+r
	2zBHm7LJ2yTBvSK84kN1F/FKiQ8aN89w2svZ2O4E64YFHOx72tPeHckCfZQHQZZX89ItWkBG8th
	lISpZzK6h0Gkjag+ZRtMlfHGWPdE9ch0aMdt00qJfYL5fuXwnjkUUPVt0IvkTxbGcrado4fstdp
	rB2+K+usoME4Bfs7qk/nJFlAhkD8WJ4kp5bzNwniK/s/0j/8j2Ig5DhMvG9fAVPLcHwVYTYL0hm
	+OwYEpUGtoqjPkFpcgnqZecVkyarEiO8Wtnjh5nqrNjRv//8yrrxv4IRDGfP/F1LU7agFwyi67I
	BcV1csuI+16nHRmZhCVUGCr9S8w12lcW1WnALJrdXeTjX7fbtdZmW1Km3WsDBjQQWIiyeQDKFcg
	9Z+x5YaUCy68ptqVC5rmvaVblBqI6OZ9odDrPqScWaHX4=
X-Google-Smtp-Source: AGHT+IGela1PDm8zuml5+4BRnr1t1FzOWhE5DgXg4WuGli+Lc9qiZDuFv4FesmBRXoDyt9Ty1JiqFg==
X-Received: by 2002:a05:690c:3703:b0:786:59d3:49c3 with SMTP id 00721157ae682-78e6841dee3mr85186637b3.46.1765852784005;
        Mon, 15 Dec 2025 18:39:44 -0800 (PST)
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com. [74.125.224.51])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a1d79csm34385707b3.44.2025.12.15.18.39.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 18:39:43 -0800 (PST)
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6446c924f9eso4298510d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 18:39:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwC2Q4HcX/hy6/g7H021duIYPx9zxruexfoBbglxRjIA/Z1iFah968OzohLGaMJJi6fN9ZoqLkcvnmPt72@vger.kernel.org
X-Received: by 2002:a05:690e:4093:b0:644:39d9:8c39 with SMTP id
 956f58d0204a3-6455567e258mr9662377d50.84.1765852782739; Mon, 15 Dec 2025
 18:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
 <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd> <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
In-Reply-To: <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 16 Dec 2025 10:39:31 +0800
X-Gmail-Original-Message-ID: <CAC1kPDOLT5SXp6f=4ON1Z0kEvnHiCVq4-chyUvLfV-2LEW=Zmg@mail.gmail.com>
X-Gm-Features: AQt7F2oC7cQJhs_16xCMwLIiNvx09SHFk-EFa0dvlAzpcOl0wDlM_p9UfLrvgFU
Message-ID: <CAC1kPDOLT5SXp6f=4ON1Z0kEvnHiCVq4-chyUvLfV-2LEW=Zmg@mail.gmail.com>
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, me@black-desk.cn, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:55=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Uh, I'm not sure we should do this. If this only affects cgroup v1 then
> I say we should simply not care at all. It's a deprecated api and anyone
> using it uses something that is inherently broken and a big portion of
> userspace has already migrated. The current or upcoming systemd release
> has dropped all cgroup v1 support.

I am not quite sure if nfs will be affected by this or not.
It looks like vfs_get_tree -> nfs_get_tree -> nfs_try_get_tree ->
nfs_try_get_tree ->
nfs_request_mount -> nfs_mount -> rpc_call_sync -> rpc_run_task ->
rpc_execute ->
__rpc_execute -> rpc_wait_bit_killable might return -ERESTARTSYS.

