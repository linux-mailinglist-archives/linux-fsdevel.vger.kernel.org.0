Return-Path: <linux-fsdevel+bounces-7758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4550582A53E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDE01F240F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F8E7EE;
	Thu, 11 Jan 2024 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJsf+udm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75F392
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso5431782a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704933196; x=1705537996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=NJsf+udmMv6VWRQdlcAXxWsoP078V+yWouc3IQeOpsuDb8rBqf8Jwfw07hLxjov059
         J8vy97crNMGtVjaNPq4msOkVwEl5x3bkCSb2IceT3LFOCPMF2tAqZLLjqg2WOnBuDHRr
         sCfordjb1dO+oCi1c5/jySKpXZ/i/+teGjbss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933196; x=1705537996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=I4Pt8waw65a0WnvDcW57rGI8z8x73aMJnzOQCnA8sl3eYX5/s6DnfMl6HCchjk5Fhn
         qZX6NgQOfKTOppTi/3kEQzoCv9i6EYsyGYq/hI7Na2gin3IadByX8eK0+jHUaT75lMfm
         PU4qxOyke6z+cxKbmh/4LP0XDzdf9srl0mu6A+NuY5UzK4+B5xVLroXKVdP08T0dIccH
         OjFBX5nGPPNFHwk9+hLm7ypQB/tW5iNLYoIo+mASu077/hkUdB+1vlR/WcW7CP0Lg6ur
         XfjkiQKEam/4b0r0dXeUGpIsBPK1Bc3f6x9cLwzyD7tn1n6p/Wlr0tPQCjyGWI1w3QMY
         BDHA==
X-Gm-Message-State: AOJu0YySRZZWgKWpbeBHPUiidCMLpMwlh7aGhCzuEESaFufEsz2yb/ab
	0UmFLY85QjuIkZEZ5npLwkIrFy9ZNZl1boenLuffFMDximYcHWto
X-Google-Smtp-Source: AGHT+IFIevcB3AUA+dRvSozqRbwkVyU18FY3gp6P2QlSnLRo+ZuiLAxhztkSJtmex7E1AjzOA+jkUQ==
X-Received: by 2002:a05:6402:8c8:b0:558:9980:39ac with SMTP id d8-20020a05640208c800b00558998039acmr15601edz.73.1704933195883;
        Wed, 10 Jan 2024 16:33:15 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id x8-20020aa7cd88000000b0055751515a84sm2485876edv.51.2024.01.10.16.33.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 16:33:14 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26f73732c5so558712166b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 16:33:14 -0800 (PST)
X-Received: by 2002:a17:907:1c9b:b0:a28:d5dd:574f with SMTP id
 nb27-20020a1709071c9b00b00a28d5dd574fmr218565ejc.31.1704933194074; Wed, 10
 Jan 2024 16:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
In-Reply-To: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 16:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> with this patch in the tree, all sh4 builds fail with ICE.
>
> during RTL pass: final
> In file included from fs/namespace.c:11:
> fs/namespace.c: In function '__se_sys_listmount':
> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275

We do have those very ugly SYSCALL_DEFINEx() macros, but I'm not
seeing _anything_ that would be odd about the listmount case.

And the "__se_sys" thing in particular is just a fairly trivial wrapper.

It does use that asmlinkage_protect() thing, and it is unquestionably
horrendously ugly (staring too long at <linux/syscalls.h> has been
known to cause madness and despair), but we do that for *every* single
system call and I don't see why the new listmount entry would be
different.

           Linus

