Return-Path: <linux-fsdevel+bounces-69132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75251C70A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A46B229BEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951A1327C1F;
	Wed, 19 Nov 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+MKxpAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951230B52F
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577298; cv=none; b=J5fiv/L1Pzk+jYEEoqSkK7GhQZVpTZYHRobpoVr6T9dmoBPljlnqb0twxRgYgRe13wdwa+ImCs8nAf0dwdSQzJeA9wExyAl/yl7/gXKTu1Zp01ef+Cm7WOJj4eXvHZXSptYFYUhhWgOPQ5XqRBPwcTKv9SiPJm0WbFa0TWUz/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577298; c=relaxed/simple;
	bh=iX/ybG6HPqAkpshrGv+ORbH78nPHyHdGlGGvt5nfSZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt9WMmlo3fY91IBDGeBhHjnd0V+CKHc09VVqmRYoFi2GEAEHTo8IQ3MmTNIQNKjOqjx0kZtvgNWYmkB1hYQlJh04sPg+B7IrMosefCoqfT6KsUyAebEc2OU0t3BNAOEQrLAmcNxSRdiTV7TXLySd6nuYRft4GBr4F8JVcfjO+U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+MKxpAO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so829606f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763577290; x=1764182090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+POvJ8Ws+92l8UUWtvuhisP25BWZ9HM6mjmX0/Aerk=;
        b=M+MKxpAOQ2iAgiFIyMffJMePSIJ9l8ZLPS/fIg0ZCVdg0SLKmD66n4MDOIij11O84K
         COyoEWTgPdrXXicK29ffbTYr5g/3R9foCL5h6yBu8V3xpTT9eNPXpwbIqKtv28er0rJM
         l6XtdjGVx7pO0lfxYEcX3+YJ25uOY3xf4GyYZVtTkoPvTM8DUSwTGuevIG0WmAmHfCVS
         KxCI00KMEZYLgoBV15MU08goagRFl+hQH+Qfds+hxGJVpwh98WPcm/XvyGDSICO198YR
         i5L0NtJSvgTuELvTGynEI+bWu2RfrgfmHqdHWHsnIrIY7TlLIpHLOvJYzcU2iInTSltd
         2LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763577290; x=1764182090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+POvJ8Ws+92l8UUWtvuhisP25BWZ9HM6mjmX0/Aerk=;
        b=UZ852oLUvE2gUaHptAENHGiLwBsdAmW6hEziP+/TTX45/QPfXqnmW9h61XRB+InZip
         qqpTZrikW1lmqwUJXhLkFcTgZgRFpXvUun3/NBbD9k3UzMCrFYnNBurgAp+JwcQ7dpd4
         ODgJ2g87p//0w6A947hAaOxExQ66vJWxu2ek0+Ue5L9V490fCPLYgD+PjttT+vsXQQnu
         lDfm7SLXbY7ArLcA53bpf6kw3aVV5FHIQUgtCM3vmZTV8Gg6YnvVdYXEWglRDMemdUSm
         AbiyMF5ydAEnnIZpyw/lqtE2MxJ6RvknFW0M4Ve5V41Ln9FOI0cCBfraW3BMQ66DlUqD
         84VA==
X-Gm-Message-State: AOJu0YzJg1FGsK/Fa3s2PsxOLJ34jd2fB9XFN+CAVy13GbG4GneACxIi
	mw70At+Wh0gQLJq/2WAvFSICaT5E8++wfRf3UgbIHPxK0rFOLLDWMC4X
X-Gm-Gg: ASbGncsj6kcUKg+qxjGEEt5hiUmBvbUMHwl5H4CW0FhdBiFALWFbreUssyWEVYKsf6a
	MdHlF7VITk7CpWA6BSqa3AhDrFhS4vHyulMwqBx0d4JwcBwekW3ORiiFQ7z5hjLPzvBCZR8rvT5
	Z1DMZAnQBsiuMckkLsnmP5mPkX9n8VI6pfdtz01vtEFlBzYzuR+NlzEl7M3B62uDD71tndul2Vs
	TrRmfKWeSkfhYB8+UBeuxSh0gusOMmflQekZ+dyg24GG4EfmqwSoUK4OyVx5lrGvHymbxLdRf1n
	oibDgYbzGd+pz9lopXWlytY6lg8ascy45Mp9O6zIi227o87Sd8NKuBL+vQjkuzH/8OdeTZL554E
	IxyxN7mcfZ1+hztmOXrps01bmq9Wi1yJPM0d/DjqOwvSP9VGHZabXqEPW8HqovfwzuY/REOm2UT
	31ERS6PVUZA8ZMDzz4doqdiEF+D2qStwJ6Y2KXu3MjN1YM7CWP9GBxcX25Rm+t9fU=
X-Google-Smtp-Source: AGHT+IHnNneLZz+FDHY9DEP2k8i38PWhPNJ2zyasJSA57R/KNoqMioNiRl0N0/4PhXsFU4l3jnTlvQ==
X-Received: by 2002:a05:6000:2584:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42cb86c280amr239486f8f.0.1763577289765;
        Wed, 19 Nov 2025 10:34:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363c0sm606097f8f.18.2025.11.19.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:34:49 -0800 (PST)
Date: Wed, 19 Nov 2025 18:34:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: linux-fsdevel@vger.kernel.org, Demi Marie Obenour
 <demiobenour@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Jann Horn
 <jannh@google.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
 jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
 David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Tycho Andersen <tycho@tycho.pizza>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: Safety of resolving untrusted paths with detached mount dirfd
Message-ID: <20251119183447.7185b739@pumpkin>
In-Reply-To: <87cy5eqgn8.fsf@alyssa.is>
References: <87cy5eqgn8.fsf@alyssa.is>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 14:46:35 +0100
Alyssa Ross <hi@alyssa.is> wrote:

> Hello,
> 
> As we know, it's not safe to use chroot() for resolving untrusted paths
> within some root, as a subdirectory could be moved outside of the
> process root while walking the path[1].  On the other hand,
> LOOKUP_BENEATH is supposed to be robust against this, and going by [2],
> it sounds like resolving with the mount namespace root as dirfd should
> also be.
> 
> My question is: would resolving an untrusted path against a detached
> mount root dirfd opened with OPEN_TREE_CLONE (not necessarily a
> filesystem root) also be expected to be robust against traversal issues?
> i.e. can I rely on an untrusted path never resolving to a path that
> isn't under the mount root?
> 
> [1]: https://lore.kernel.org/lkml/CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com/
> [2]: https://lore.kernel.org/lkml/C89D720F-3CC4-4FA9-9CBB-E41A67360A6B@amacapital.net/

May not be directly relevant, but I found 'pwd' giving the wrong answer
when done inside a chroot (that isn't a filesytem mount point) after
'faffing' [1] with network namespaces.

The basic problem was that two kernel 'inode' structures end up referencing
the base of the chroot - so the pointer equality test fails.

So you could find the path of the chroot without any help from outside. 

[1] Brain thinks it might have been an 'unshare' to leave a network namespace
that cause the problem.

	David

