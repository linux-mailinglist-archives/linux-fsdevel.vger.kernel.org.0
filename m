Return-Path: <linux-fsdevel+bounces-52565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33BAE4279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2804516A262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B624BBE4;
	Mon, 23 Jun 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KIlEPPjH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5454424E019
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684629; cv=none; b=cBlTHgEoQU3Dj1IbbpfSYxeiAE2BOXmbWxdMoIxtjBnWVpJ4XSniBOHIf1xNFMl6eWAz2RSSrsXrYTecYIn6LDde7T0jX6KQ9IgWsmnN8VB9XbxGcIf2rH9D9rdUJQM5vv8EQ92NgIH/8anFIlJpHsRhwj+weqPs+8hNkXF9OYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684629; c=relaxed/simple;
	bh=FzfPRoIJprPonWn/8gkChXjed1Rl1pDWPUEKdIH9waU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf/jqHlJ53f0VnlQXbp2+Kgn1VtXni2sFPaTYTknbe65OUiP1Y4lg8bQhStzoORI8mASTS+L4Ty7GLRr8HHI/eTnt32hOiaOrJW6RrqdkNvePv1dHunL7Cj52ufUEVLOhHJA7kOFP1LeHt9tYPkFW05hPzCry4YhQXh/jfcdihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KIlEPPjH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a4323fe8caso24700251cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1750684625; x=1751289425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNrHQFMj/WblgGjRZ+Rwm5AzRS7ewU/kytkJbvIF3do=;
        b=KIlEPPjHD+tVnHFJrMjWugoThYOBzSGfn+MHNp1bp+45FPAD136BMVk7BORnLaJuNx
         ILTZaVqV8q74QGLjRWBWNkiyrxPznoXF+T8qcFDWnj6PDR//C7tSlFDZZvucGknVFRmo
         XZqCzXI4enIZjJPrOQQBc2CT9yW7PX8tI66HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750684625; x=1751289425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNrHQFMj/WblgGjRZ+Rwm5AzRS7ewU/kytkJbvIF3do=;
        b=Qw1Bk9JBOaRQBL2WJ7fDUeaXs+oUeXH56SAxOWwg6b9SShUCiyQXlYxunrgyx43ADg
         4IaQiSHonrP+/zERCOq5mkSslF0420hOUddeg76tiqh1DkNUW8ogiDNeLAZD4MOhnlFM
         NzTwz+A5j3lJzwH4GCyY0xDCPGqwDI06T8L14y12i2ZXXe4c78x6Q2VImmaJ3ADRHQhd
         GGZNOVLTQfpdep3OkuXpMY3JFaOvhWabOlpmEoV2cLpyw53YPKQP5ddrPijn+t58n3NP
         wbx52dqXMDU0F+dNL3XKe5I9yuSw7MoNQ1u+dRUjjZJtVV0s+Qc+4Hl50QYa7p5p0VK8
         nYDA==
X-Forwarded-Encrypted: i=1; AJvYcCWr8Kx1C0q9c3FO+PxXN/j5wAuC2qzDKwNIRXHtYMvDnrCzvBfKaJKY9gC7F3EbU4Lm9dx0//LQUsfCbBmq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/j0dexrzGWSVKdJowcXK9HXC+CJu4CxwHmyDi5K/IrN+n8gV
	EVP5MQZZ5kfYWvNaFPf3hRaF0V8kvLdrsDYJy6KhrTZfQ7L+aKLaUwKS8vQ5QUZjzVVD1Xrvl4j
	63Kfa+g51Rnu5WvC18UkGBR7iMr+av0WqGvwCHN+ksg==
X-Gm-Gg: ASbGnctwK1B02eAAEgDp2sigSEj47Kf0RxlXBoEOSSQmgImMyG3apML5wdrziFJ9P3b
	4N1z4fjuShsuioLVR3GUK4HrKx2E1dGeqoqTMESqU/SLutcdUDjrGSvWH8F3JCfQuWfKIJJnpRb
	UjcIK+zxNUtVRpfAYf6IesLzwz5fFQgJecop14Ge2mO+4CwAOHukdHhw==
X-Google-Smtp-Source: AGHT+IE4jWGaqz2lc0klPR5nD58waFDtLTocTV0febrAytRiNbweHyPyJLGUjtcLA/PyvQLquDAn03DOACqGp3J8b3U=
X-Received: by 2002:a05:622a:64b:b0:4a4:3913:c1a5 with SMTP id
 d75a77b69052e-4a77a207d55mr217248551cf.16.1750684624825; Mon, 23 Jun 2025
 06:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250613173710.GL6138@frogsfrogsfrogs>
In-Reply-To: <20250613173710.GL6138@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 Jun 2025 15:16:53 +0200
X-Gm-Features: AX0GCFuqRKww0FB4NtOXuEyq6cUWzb_e_wCOLGCtSuPqfMKkekhloiCMyjbILjE
Message-ID: <CAJfpegui8-_J3o1QKOxGqMKOSt5O6Xw979YnnmwTF3P0yh_j+Q@mail.gmail.com>
Subject: Re: [RFC[RAP] V2] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, 
	bernd@bsbernd.com, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 19:37, Darrick J. Wong <djwong@kernel.org> wrote:

> Top of that list is timestamps and file attributes, because fuse no
> longer calls the fuse server for file writes.  As a result, the kernel
> inode always has the most uptodate versions of the some file attributes
> (i_size, timestamps, mode) and just want to send FUSE_SETATTR whenever
> the dirty inode gets flushed.

This is already the case for cached writes, no new code should be needed.

Thanks,
Miklos

