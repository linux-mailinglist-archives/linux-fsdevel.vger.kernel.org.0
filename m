Return-Path: <linux-fsdevel+bounces-48075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F500AA940B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774A216869B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092E1F417E;
	Mon,  5 May 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq5iKNY/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE751F4607
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450528; cv=none; b=TUEEvI5ugZ09DF3HEURomyZ7xq3DTdyniq6cQSsl8aJYXztqFQUIpqCGRTfl2Ny/96sfLmQmqRhApg7eCOMFqX1I4ay7g4m3w2W7o3yYPri3cYn+M1zulp/3nq/NXcwGKRrL3Q30OVmJGIFBciEfGua7Ujo5B7IAOBW4nW4wh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450528; c=relaxed/simple;
	bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX+3pATF8B+/Oie2C9wBLwMmatoMJl6JBfYuYQoFRX9eEpDCUW6QsZxPUF527CaMJr/V2JA49t1KjmkupxmVPxszvhwDS351eEfL9rnJfQn+vh/L1aSUrpGgVELWL/8SlZpGtYWDcEVI9MxsjScDQ9T7BQYOUHfovA6KsTJbo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq5iKNY/; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f88f236167so12837a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746450524; x=1747055324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
        b=kq5iKNY/AnIUtVknlPT/tz98zm4MSOGfJnLvMZH5/eXGakKynlE9gEdHx8ZEJHpvbm
         nRNIruInVpmfJt2my0CZFwVH/9hrFAqp6vxR+vbgNQT6OAvKXDurcpbFdiiKUQBbHOlm
         6lgK9imDnlBKKa7RsE6DswQyetBWo6MVlxy7HcwAnk01VUsGIB263xLRt7tcAIJbYFMT
         A9uNi7TdPvRYxw87Epu9uRGBL7Zae4geyq10K8jiAl7x5nKvVYc3yDklB/jssV2IxZoN
         YO/llfhEmc1//+pu4h5h1iSRwW0DBsdkTJo/+p3/lUBVfdwY0rRM3CvCcHcF9hquimbZ
         YvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746450524; x=1747055324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTxzgBbzI90f+wN0JcENM4jZ4hoxOhLzv6DnmnMc4A=;
        b=fG58NaE3M99kfCaad2FjbcGZBe7aePJ3Pj3BPR37HABlUOmmL2SOLMnF1iRbQbz4or
         G0y4zTuzJBdrtd4YrgDQ5jUUoJwsE7FNEEsxaFrELWAT8wKJTw+2y4bwN0CjP6kxdOSQ
         eHdE5UPzvtgUUvTBFAmdlJ4++kDu1NHxYGEQYNvGsVJkKhE4MpT9Xfk12MNRdnZXTIYL
         9uprMrS+V+suhAycH1ZGQQQQuAx8ecuq8HHKpKtKTQ4q8SOw7gQWskfINpfyT+jrVMDO
         GQfr+kfn8Dk7kL3zxRJh91WaBWr7ClIVK554w7Xkdra49KpPit2JQkS893w0qDM1tk1u
         0hFw==
X-Forwarded-Encrypted: i=1; AJvYcCXGCcOSyMclxbbs0zesnkunPL2GQ86N5QqD3cUs/2Ta+mexbdXourfM8StU54f5LO0GlPWkVfX4bIHZdZaX@vger.kernel.org
X-Gm-Message-State: AOJu0YzFlr53XFQy8o2T5hLEx71MGX4NcYbX90AvTXJty1YICu2ErG0Q
	c5Ve7ylwEqjFOl6bHrmvC9JIwTga+/ARvlpmZSs/GlNYBkSa3HMV6Wep4ZdvRWPesutfesA36+o
	S0hng9V5V7szXv7BxkNCKPLYavhKlRH7SBZnP
X-Gm-Gg: ASbGncsjzWCRgL9gq71G3KSfWmE/uDIkeB8zIbW7ILXZvpaTnCdOxNSYWl082YgUGuh
	kpK+QGug0DbCRFVtnMRn0/AYZzNqEA3cK4SIRPdM7L+9RZNp1T49IX0idI/icSS31HZkXTI3102
	NeTLki10YXdjnWX1sk4JkQPlIYQ2AJ+AbHQk9EyOKNWNa0c/TP3A==
X-Google-Smtp-Source: AGHT+IFX1jZnIEUIqKHTcho7yIpvOOHBKxzhoHPTnmaDdVP2OafarV7bS2cZO9snYNbMzLKCcMCds3n+Ecp9RGACrAw=
X-Received: by 2002:a50:ab11:0:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5faaa1f2701mr123881a12.3.1746450523693; Mon, 05 May 2025
 06:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org> <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
In-Reply-To: <20250505-work-coredump-socket-v3-8-e1832f0e1eae@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 15:08:07 +0200
X-Gm-Features: ATxdqUHIxwIoIqV0etAlWQHM7DrrKMZU_RnaVc88wfMW5gzzGzHJfNE1OpkPS5Y
Message-ID: <CAG48ez3UKBf0bGJY_xh1MHwHgDh1bwhbzMdxS64=gHNZDnNuMQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/10] net, pidfs, coredump: only allow coredumping
 tasks to connect to coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 1:14=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Make sure that only tasks that actually coredumped may connect to the
> coredump socket. This restriction may be loosened later in case
> userspace processes would like to use it to generate their own
> coredumps. Though it'd be wiser if userspace just exposed a separate
> socket for that.

This implementation kinda feels a bit fragile to me... I wonder if we
could instead have a flag inside the af_unix client socket that says
"this is a special client socket for coredumping".

