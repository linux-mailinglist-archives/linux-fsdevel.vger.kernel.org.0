Return-Path: <linux-fsdevel+bounces-51513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DC6AD793E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 19:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F471895A8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257A29C341;
	Thu, 12 Jun 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWEHW72x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B91D63EE;
	Thu, 12 Jun 2025 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750204; cv=none; b=T8fqbW1AS2WrLZBvojHhNK0lvxYBQ5M4MVATjVoIH4xGhDsRvBltAo+7KlPp2Ezap43oSYse+8WXOD2KHcm4Qf+EZ0xDTig+G9R7wM85PGD4Fowga7Uo2tE+7WvmHdCB33KB256ob0DbmdmwP22k9R1S/Z9KQRzcTrhwRMFqo0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750204; c=relaxed/simple;
	bh=dKayhC9xxtObiuBsZJuLUNkO6JtTY+M6lHYtE0x3/5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdNJPwFS5Ty7qrRitIGLP795l2uOLLv6meaWvdWosVAjZ0q2iJj27xW2nM1FlVpkKen2PomopvsFEkG/cVbiVNYgj31eUWa6ZOXpfIh2XDslfzWIk4leYMc8GAuFuqJ5ynicnAWEmvgG8vaNKZvQ99+vMTu3F97ICTe7XUqcQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWEHW72x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626FFC4CEEE;
	Thu, 12 Jun 2025 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749750204;
	bh=dKayhC9xxtObiuBsZJuLUNkO6JtTY+M6lHYtE0x3/5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MWEHW72xuKOpDwj5O1DgBMsdjcs3l4nO/WnTovXp7sNZ3LfB0XXHv4LnODwOymP8k
	 4iUK3ls03pi9sSxqPFtjzZfY7oej+31PwpZhn0bh1+DtamkWIIY8zdJn8swfpvQyDz
	 9YR7pmCVQzbju78KthNQoxFJm+66dq8FZq0K0XDaTbII9i27T0j6LkrpJgYETyhNAa
	 gEtdopcNZp68qxuKKjkm/EgiZeSbjivfGJcsL4azcMtbVO05go+ZIbkLBzCmNJTX3T
	 vkXrew+3zENncmbJrjyT3egSwPAy3jqcUxkQUaXKB/He8r5bBZoi3c7oqOS6eBwH7c
	 o8W2MM5Pr1IzA==
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81a7d90835so1165368276.1;
        Thu, 12 Jun 2025 10:43:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSG5CP9fSrVmMuNffRY46OF2uWHvKc8UdPnDSxuUOEs12g7pqi1HcwL0ynYpyhDI4xMIrG7Hve59jbvSvCXk4q@vger.kernel.org, AJvYcCXawaFI0IaEeKbdOzxp82GqY5yZSz17lm5/3bT84LDqd8e8YpZ+mXAICJMZgjffHFAwaXdh1pomY8PIE0rF@vger.kernel.org
X-Gm-Message-State: AOJu0YxwOtnpnAtDLLLS+tboOQm2by4QrvGD1b/CFqgRI+o73ANZvVCg
	uVILncAH9pwi5JKM3WbLwkt+H3OWudlkh/XcbMvskobvcrHiASb9yIlTp2IFoPNAN6oywNlNrGB
	dNbbahg9stAwl+vNkks6yewLEh/I8ehg=
X-Google-Smtp-Source: AGHT+IFPmxEr57X83PbmKSBX2oWa6mbGaRV2CCbB7ny7ubWrLdKUlSvkwyNAyOvsXjJv3YvyEcstyOwipzmua6+6h78=
X-Received: by 2002:a05:6902:240a:b0:e82:162d:1fec with SMTP id
 3f1490d57ef6-e821a73dfd9mr758543276.2.1749750203751; Thu, 12 Jun 2025
 10:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612030951.GC1647736@ZenIV> <20250612031154.2308915-1-viro@zeniv.linux.org.uk>
 <20250612031154.2308915-9-viro@zeniv.linux.org.uk>
In-Reply-To: <20250612031154.2308915-9-viro@zeniv.linux.org.uk>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 12 Jun 2025 10:43:12 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEcH2D5vA19n4LQwrgGE2wHTpT_vshCgk2oUiO2rB12cw@mail.gmail.com>
X-Gm-Features: AX0GCFt31UdFTJlXrL3E_iss_0Omq3CyAgwzM1yXC0QF3e_5WuYReU5RBrTZg8I
Message-ID: <CAKtyLkEcH2D5vA19n4LQwrgGE2wHTpT_vshCgk2oUiO2rB12cw@mail.gmail.com>
Subject: Re: [PATCH 09/10] ipe: don't bother with removal of files in
 directory we'll be removing
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 8:12=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> ... and use securityfs_remove() instead of securityfs_recursive_remove()
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/ipe/fs.c        | 32 ++++++++++++--------------------
>  security/ipe/policy_fs.c |  4 ++--
>  2 files changed, 14 insertions(+), 22 deletions(-)
>

Acked-by: Fan Wu <wufan@kernel.org>

These changes look good to me. I ran our ipe test suite and it works well.

However, I didn't try fault injection to trigger the dentry creation
failure. I will try it later.

-Fan

