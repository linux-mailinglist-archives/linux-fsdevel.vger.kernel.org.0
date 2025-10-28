Return-Path: <linux-fsdevel+bounces-65877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B85F7C12F73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 06:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6689F500A9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 05:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE629DB96;
	Tue, 28 Oct 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HZyGKzzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BC1A0BD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 05:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629571; cv=none; b=CKS3h+cu5WbTqwLiYk1Qx85kGkfYMo9g5r2OgRfOaJYPBKCxfJlTXg8oS5vWQli+PCp1tDKgVhdQqVOhDsvdyHnD+e21cjQfCs691aRBRr+dX4VZ5Cy6iWt/KXEtjckMQWTV9YhiaspdFfBDgD9gAyojLj1oLSkzix/EFLmEMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629571; c=relaxed/simple;
	bh=MBBUGXoG1YUz44tfK9dC7obCvP9yR1LjZ/0B16rOeOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+gRj1MIK0EETv6knf4f36zjqS70IvXHLem4NCHJIHOG3v9RHVI2FQnRacFI8W5cDJHtb/aTaTi2dtgGldCYtS6BAeaM4nDxfPqxsoslj8hZowMwx4PAZxISoF5XrSdJqQX3sGFEfauCE9FrvwwXh/EJaBSxMRI4OPJ9+OTMqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HZyGKzzi; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso9547299a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629567; x=1762234367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=HZyGKzziPvNx8aZ8CpY7fv+4YkWU5YxvYP6GK17TuItuXLkObIxnxf3XyNUF083Pnj
         X17vVTbJsJBRUyenpqQUjcHbWsRoRpztfGNgSSz3ekYPAq7CrrEbODRv0GmVhmYCgXa5
         ppLIDl4RTbFzI3DuunBaFhd6tiCcEnVkR8DHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629567; x=1762234367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=iN8idANab4rdCt+jGkBeH4Zt/ST+bhwvH5HrgtDR1NkU1CEOPIb+dx7APzntM0AyhB
         kXrwqUHghx225u/rqF0tQfnSVvgO33Ciyttmh4OY1yYQ9dmk58OZi2mSqyUimtmy/xeE
         ykW6ru8I4NmnJSFTT7uh8C2fb5zwE6Dh+24m82vI0io82RUH3sq5tEOM6kdBDxx7Ru+r
         lYmHf2tzhC65zPC4Hh7rBnm6nEc58ykYFlD2vX3ALigA0dh1xBIvHzpB8lQ9x+rVGSKx
         cDSz8TFF6j9vMUPrZY6Q+tEkBuA5qXaL3nB97qIOpz8KJq5smsimy5dV4/J1mXSi0tJJ
         c7QQ==
X-Gm-Message-State: AOJu0Yy4qxrePuAZC57ZclaOQFzmpAA+owmgQs2fcZyf5zxy/+HY/ght
	HD/oEmYBSgY2oVu8J4jGQNKX759dv5brizQgevgPkI63JAWcBgN82Ntp4umRclgO4RdJUKsPEp8
	b06NrUhSpWA==
X-Gm-Gg: ASbGncvg13j29ylmua8aoPGiiwElyG8enpzNPa+7PBNgdS+nbeTEBPyq2IdxkF5+Wgn
	gCbHNpBzeMV9nZMLmskJ+l3agLc/ouPlogL5DpsYDaZPaPd+BP3nyFFGIwj1iCe6HFpH9L+hgAK
	0Ijqsfz/zYXYkA2KaDNgKDybBTdgnFu59pcJ2VoI/RYn0/zFvD94K8O+oCsPe3DneF+ZXLvz7iM
	UCO1VMncQANh0vrBd59BVFtQ4Er9aAZ9csvs3Eh9Owl4GtbbQYmNnJ0MHIwUYXhV5SCiZcDESca
	yAyznyPF2MmnqPUcnBGjAWD38dYGOQGdF1KwhfDpkjbee5+qXxDrM0x8XwoiDU5pKpEUL6zZoUh
	z/hIUj7KsBhglKWTpnGjWqopNkgXU8W8S5+8yWn4buGhsjYYtjKFADpxQf+3a9VjARn4/gOxeYi
	QFlkTdl2lvfDBrpL8FJ5u0/Q+ctfQL2XLHuQGWZonoh9VSSHp9/VZxLoJSrqtx
X-Google-Smtp-Source: AGHT+IEeaEurn5xN2bfWxj7u4tcPIJOq9u/j645VbGQUp9yeMDBMF3xBcxIB7xTSh10MVbaZe+r7fQ==
X-Received: by 2002:a05:6402:13cd:b0:637:dfb1:3395 with SMTP id 4fb4d7f45d1cf-63ed848c090mr2086990a12.8.1761629566660;
        Mon, 27 Oct 2025 22:32:46 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6c129sm8127494a12.3.2025.10.27.22.32.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso9824755a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:32:45 -0700 (PDT)
X-Received: by 2002:a05:6402:5346:20b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-63ed84d11b8mr1725392a12.22.1761629565035; Mon, 27 Oct 2025
 22:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-32-viro@zeniv.linux.org.uk> <20251028015553.GM2441659@ZenIV>
In-Reply-To: <20251028015553.GM2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:32:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkREqIMu_f1B9dwguEOjRWmmtrQM-BuU5ACiXPx-fVfEkz6aAECfx6yPOQ
Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
Subject: Re: [PATCH v2 31/50] convert autofs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 18:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason why autofs_dir_unlink() does not update
> ctime of the parent directory?

An autofs 'rmdir' is really just an expire, isn't it? It doesn't
really change anything in the parent, and a lookup will just reinstate
the directory.

So I'd go the other way, and say that the strange thing is that it
changes mtime...

That said, exactly *because* it changes mtime, I think the real answer
is that none of this matters, and it's probably just an oversight, and
it could easily go either way.

               Linus

