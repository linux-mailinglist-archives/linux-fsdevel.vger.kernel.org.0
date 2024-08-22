Return-Path: <linux-fsdevel+bounces-26709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E195B33A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E18284012
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76301183CA0;
	Thu, 22 Aug 2024 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cbIm6M0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1765D17E918
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323974; cv=none; b=i7gahzDworpWYBcZBSV9bx807WCPnpt2h5Tsj6N2j4C5FJYBTkBn0XT42RrRFB2yNv+OcCy9NJg4sYcFKtsuqIjd8EFK07bP+qEK5OAgTvlFqJS3SKqiNkgN4Jb/cH5Fz3fRkCLTKMKEAkZ+dcaSA9aHt2uzZSYHgw9keTjutU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323974; c=relaxed/simple;
	bh=y605vAXATkbSnPLc32TQO2yOHICqbI07MCILSXKyu2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxGfkYGaPoPo9mvKXTPC5P36u44iTFsWn9H7Eyw4l0F72dspHzLLuwh1sT2pg+5AaRIxh3mMf4Xrw555skl2FmTcMQMjCMjuC7pRRf6EuD6y7HY34OSV4rxX8GWG0IBmHCG4wpHCtneBz/4HAXDeI21p3qwrVS1A0/6OMU3g+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cbIm6M0X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a83597ce5beso102556866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724323971; x=1724928771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/5OwHe6fl0710PXrnPDc64BRDoGhRYKmT1gfkjMADc=;
        b=cbIm6M0XrYGDfevggTsbi5e9WqYctamn26U08akYLcyw4y3cequ6v4jK+iLEPNjGEx
         vVJJdQVr8ygnCjI3BOKUsjraPdN99rlp2i/SFk9bT4JmTByhgYuBhaXNAEiC6r9fr1p9
         YwvQAgmRSZdqm7AVDfpFLW6SDJ5FH55AzhkL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724323971; x=1724928771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/5OwHe6fl0710PXrnPDc64BRDoGhRYKmT1gfkjMADc=;
        b=vymbU+UvTUE7fyG3aRR+pyKIcA7C0gCoNpHHtMJkjiaEqWjyAoskrCvTV/6fd1di63
         A5HPszWMhrRlnF+6V6UjR72bth6pCkkS1MxHdRdZXtVm6GNHXUSOj8ifI+/I7NEtY883
         nUGt4W8Uge584IS3BmfT3nDncIbu5am5/VoGDPGNuBzO1pEJ2M9BH4RIkEXYrsVj6AOO
         ZRA07lJCL8Yc5pDCrCj7I8gif9Vb9AKPNEJgr2Y+fcRM2BNiwHc8URtKqCVDCvyN1aJa
         S6wIIIPQgbSzut5Ofd54DkYRdmajZdZO3b8LdBBeMCUbpdlu0yq3v853dSEe21SvCqin
         p96g==
X-Forwarded-Encrypted: i=1; AJvYcCV/FlrVUtNiw9oqjzTAfXmgu2vQHYiEcxNsM2reFToMPail5dAzFk0eHV1H3MFhnOVCfkv05Vj1C3UDxjuf@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiznPE7X+JqAJ+3RwPVzk5//mcAuke7cTmBET9sYXo3Jz23jD
	6nmgw5nMqmgJHP2HI0ZFUhz3QiBOFDLoiP1wep0susJrEnKaOHkAFuTZrowImRjRBTT+4/ck6jD
	+mwO/siFyIirop4lHYtzIRa2ji7Fmv/JYTt8L9g==
X-Google-Smtp-Source: AGHT+IFB+FK7vHiB2mMwezh2Tjpw8TOxde0/EX3xwIeaS18J2MN/FaMhj9gKgYGaGppL2P/eZGpOuxaLsSsznNVS6g4=
X-Received: by 2002:a17:907:7fa0:b0:a7a:b18a:6c with SMTP id
 a640c23a62f3a-a868a6779dbmr294987866b.16.1724323971438; Thu, 22 Aug 2024
 03:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
 <20240821181130.GG1998418@perftesting> <CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com>
 <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com>
In-Reply-To: <CAJnrk1b7DUTMqprx1GNtV59umQh2G5cY8Qv7ExEXRP5fCA41PQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 12:52:39 +0200
Message-ID: <CAJfpegsPvb6KLcpp8wuP96gFhV3cH4a4DfRp1ZztpeGwugz=UQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 23:22, Joanne Koong <joannelkoong@gmail.com> wrote:

> Without a kernel enforced timeout, the only way out of this is to
> abort the connection. A userspace timeout wouldn't help in this case
> with getting the server unstuck. With the kernel timeout, this forces
> the kernel handling of the write request to proceed, whihc will drop
> the folio lock and resume the server back to a functioning state.
>
> I don't think situations like this are uncommon. For example, it's not
> obvious or clear to developers that fuse_lowlevel_notify_inval_inode()
> shouldn't be called inside of a write handler in their server code.

Documentation is definitely lacking.  In fact a simple rule is: never
call a notification function from within a request handling function.
Notifications are async events that should happen independently of
handling regular operations.  Anything else is an abuse of the
interface.

>
> For your concern about potential unintended side effects of timed out
> requests without the server's knowledge, could you elaborate more on
> the VFS locking example? In my mind, a request that times out is the
> same thing as a request that behaves normally and completes with an
> error code, but perhaps not?

- user calls mknod(2) on fuse directory
- VFS takes inode lock on parent directory
- calls into fuse to create the file
- fuse sends request to server
- file creation is slow and times out in the kernel
- fuse returns -ETIMEDOUT
- VFS releases inode lock
- meanwhile the server is still working on creating the file and has
no idea that something went wrong
- user calls the same mknod(2) again
- same things happen as last time
- server starts to create the file *again* knowing that the VFS takes
care of concurrency
- server crashes due to corruption


> I think also, having some way for system admins to enforce request
> timeouts across the board might be useful as well - for example, if a
> malignant fuse server doesn't reply to any requests, the requests hog
> memory until the server is killed.

As I said, I'm not against enforcing a response time for fuse servers,
as long as a timeout results in a complete abort and not just an error
on the timed out request.

Thanks,
Miklos

