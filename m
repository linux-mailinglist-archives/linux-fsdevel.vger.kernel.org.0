Return-Path: <linux-fsdevel+bounces-70471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D45C9C522
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 18:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 049D54E022A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971B2BE655;
	Tue,  2 Dec 2025 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WtTVwM5G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9D023EA90
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694880; cv=none; b=d8Y8f+QhyZBanE0nB8xKgLykzehd5tOIKiW3fIKYB4v7pcTv3zst4HGrve2ZUdwVvrPcYxKxthIGAkFj/AikVUmmIT23SaTYtz0OTd5ZV9K8MBxyb/nu74Vfs9xdvNvgO5ZUyvyZeZVV8BTD7V9oQYNSywlYoMDMufTvqzn79pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694880; c=relaxed/simple;
	bh=qRcGZFXKJMaKX/yvJKRpEH3ICexfqw2LvBvIVsUdxyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okrjkvjwf/XHXT9y3KVKVRatswKbNFwC0MWzikIv2BsOIP4HVDEODNYlhhzB3xoR11K2EiWEbIUWlhK6yQ8izeyCEuqHmB5OpgJhI31RZznvsMuX4KBfcDYP3J9D+ywg/6y+6TzNZMjMzzcfFezydgZVck7PiaIFW3PmDBUFXiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WtTVwM5G; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324204so855401566b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764694876; x=1765299676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aKw8GaNp5Rdkt/37eGWeHQsaSq+KKpAjLZM3zt8c76s=;
        b=WtTVwM5GdJbs07nXlXBA5ImZKYtCQ4GizN8f+QBW4BojDdmwqXxR53r+CE9ZBt5kGn
         jaFmHw8ZZq9uOuNBqwkOiwnN+5qYI9h9IqHbwgDjNqyPKC9TMFtP7RDVh9jQg61RHt47
         jP/UD3SYyY2VX49d890N+WAj2A6JnfxRtYJIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694876; x=1765299676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKw8GaNp5Rdkt/37eGWeHQsaSq+KKpAjLZM3zt8c76s=;
        b=IwIoCxJRamMQiPQavDOFe2m53Si+VzNhSwEXT8vbhuWql2HA5esXxboDjC1OYlbE2x
         6oQIUxsKP0LUTVdfQuuBv1oPAEDKk5JkvMmkpQhvHWNJ8QdrlEE4BT2QyDTW98m4xJFo
         939TXwc7/KIi+5llp0kXyfnZKjoOxe4ACJTPETVFeZxIOJISNW6dzO4OySw1fA6sEdr/
         2s/xLZTQsGmMR/Do8EpSeINNjtTcrbHlNpDsVhNVB0l8MhtKjVBcCSAhSA7LWtptPdKQ
         7naKCr5ywRWpBphhpRO5YahKd4x6Nwr9oCKXqWF8p10gSzRVOJRNw8my2LOSv47Jr5Lu
         mrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcjxl3y4r5OkVr55H2VbPaSzKTK7ASP+/VLF9l1X69ATn/etuDpZg++MqK9NxTU6PlDTcMDwm+aBFSzjCV@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUkX3cwdPgyfhDT59/n5hJozFtLzrtzHT03nNSNUwaC0QiIec
	KeVbPNIzP7vqOvB4gjo1mh1D7OIbbCvN7Jfpe8gZCVomMicixWaBGyfhUWymOpG7NHpXCpCQP1d
	8pQNYZeE=
X-Gm-Gg: ASbGncuBecXxRcdld4uJHIeJw/ScOSTP3cP0hOWgmz3n3nI9plQ2H3XggR4KZtUQL46
	ruk9xh5OZX5fCQMGI/z8mI5MUK53PkzStjB+h4f0MMtHNBWZxi9RcsVFGHq5Rd/3Czu6nitNWPB
	ezu02Hsg4Mb8gV9F4F9Jt77usedS3C/qND33K75DO++xx0KJOp6PsmHsgML4GBO+JamPoaPd6Ds
	cUPExXOuhu/f5X3BW0TtvXzCXPe2b56+4CQEODN01wbrbkWrGLywmlr1x59x2SgE1zUnEPnUQ6v
	lZip0yfEmxRGQcNu7N35ObPjkwq/chpbbQeo1mK3oxg8xADzyiS4I08B1Vs6pek39Aj5DOEAC1Q
	JiC9mIkCzFRG3rSCuLxy4txvtkP8GmExrp4dUX/7O1+AWI8o1CpBIhLoTziabrepMasJGUDcnV0
	Rb1fLQ9iN33dNO86G8kzEBXHxEBi7dqSzXbiGDUqReshBE3nWSKbk2xQ5jaxlw6kCUfabmjOc=
X-Google-Smtp-Source: AGHT+IGIF0YfPZJW/+m/iimMivKRmbLB2PvOqrxJlGia2e2ErAKqBnKPVHHX0h+7nSzAEf81aMJrYg==
X-Received: by 2002:a17:907:9625:b0:b73:6b24:14ba with SMTP id a640c23a62f3a-b76c5352f1cmr2990851266b.8.1764694876303;
        Tue, 02 Dec 2025 09:01:16 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5163903sm1599322466b.7.2025.12.02.09.01.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 09:01:15 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so9050145a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 09:01:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOzbOGYETkN67FToRPCua4SVWEN1rbMTbiNFsRev94hNmKwnxELGJc0qUiXvxmpWUnOJaIH2btplPrjU0E@vger.kernel.org
X-Received: by 2002:a05:6402:5203:b0:643:c8b:8d61 with SMTP id
 4fb4d7f45d1cf-645eafad307mr30539305a12.0.1764694874663; Tue, 02 Dec 2025
 09:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-kernel-namespaces-v619-28629f3fc911@brauner>
 <87ecperpid.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ecperpid.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Dec 2025 09:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPpVs67fAYWo4=SeD20cxjYoAE3d5RXgeHpXZ81uM7Lg@mail.gmail.com>
X-Gm-Features: AWmQ_bn2o0AS6BcgpiW3CE955dcwsPRXAVZIKXQGT7yckz2eOdb4b3Geamh17dM
Message-ID: <CAHk-=whPpVs67fAYWo4=SeD20cxjYoAE3d5RXgeHpXZ81uM7Lg@mail.gmail.com>
Subject: Re: [GIT PULL 05/17 for v6.19] namespaces
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linux Containers <containers@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 11:06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The reason such as system call has not been introduced in the past
> is because it introduces the namespace of namespace problem.
>
> How have you solved the namespace of namespaces problem?

So I think Christian would be better at answering this, but to a first
approximation I think the explanation from commit 76b6f5dfb3fd
("nstree: add listns()") gives some high-level rules:

    listns() respects namespace isolation and capabilities:

    (1) Global listing (user_ns_id = 0):
        - Requires CAP_SYS_ADMIN in the namespace's owning user namespace
        - OR the namespace must be in the caller's namespace context (e.g.,
          a namespace the caller is currently using)
        - User namespaces additionally allow listing if the caller has
          CAP_SYS_ADMIN in that user namespace itself
    (2) Owner-filtered listing (user_ns_id != 0):
        - Requires CAP_SYS_ADMIN in the specified owner user namespace
        - OR the namespace must be in the caller's namespace context
        - This allows unprivileged processes to enumerate namespaces they own
    (3) Visibility:
        - Only "active" namespaces are listed
        - A namespace is active if it has a non-zero __ns_ref_active count
        - This includes namespaces used by running processes, held by open
          file descriptors, or kept active by bind mounts
        - Inactive namespaces (kept alive only by internal kernel
          references) are not visible via listns()

but it would be very nice if you were to take a closer look at the
whole thing and make sure you're satisfied with it all.. Even just a
"overview scan" would be lovely.

            Linus

