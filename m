Return-Path: <linux-fsdevel+bounces-70802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E573ECA6C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C1E1302FD5B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314030F529;
	Fri,  5 Dec 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG+3QOFK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n2gQ5eBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F62FF66A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924627; cv=none; b=L8KsHc9GuG1PGTV0wR+vsN/h9wGEsq9Y5x6WtA1FHLziQqhRjRLmYVClf5Cvl2GuW5Q4Q4Zh8rUoMXp+HixewX9v7Nqv58dnMsgZGljOKFfErXmxfSxk1BQKp+bf1+QZAYFLNEIwLzNfh8yPn7KbdKsweunbuUW8u1axqpocL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924627; c=relaxed/simple;
	bh=umtlRGx5EL/Darbl/2rxiYcpP31JcGWYNq7tr1JvXJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAmE/jUwbvYfuNclaX9vIuVUAAGwWIgks9IZC4mOCOiIydUSPFxnxDcXtRsvDqY6e9jVwEM3EZJ8lDuaAytsmI355XmZe8ZNgoE2Dy92+RoI/1DMOjK7GJHXNKsFFkfF42+Po43BXmtLWZCS2PF43bOXl4jMP31fyHOvC3Ya7kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG+3QOFK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n2gQ5eBN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764924618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
	b=OG+3QOFKGdFjG5A3cwQBEMvOBAAcUHRKVwt2NgKElJFrR1V3In5aJpzl2+57M3UJi8FvDP
	fkwb0+kHLFjEKxOfesMLXnAUTwesI754rl7biSoAl0WP0YlbENPe2/T1HFZgudNo9H31cg
	GE8rDV0anYW3sBxypi2IURi4gPRuNNM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-c-prcPWaPdCk77ZKcpXKtA-1; Fri, 05 Dec 2025 03:50:16 -0500
X-MC-Unique: c-prcPWaPdCk77ZKcpXKtA-1
X-Mimecast-MFC-AGG-ID: c-prcPWaPdCk77ZKcpXKtA_1764924615
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-342701608e2so2016422a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Dec 2025 00:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764924615; x=1765529415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
        b=n2gQ5eBNROTJphP3Uc9b/wJikltdttBENQvvHaf0iaYKWq57ft8/oQdE0Aih9lbKT7
         BSNAi2+uOxXZ1kWGdlIbwM3u7KC+XWvyh74pUUjPW+pseQPpLucuh4UbF8xOGoQ+KFFy
         4NrGfVrK0FQSuEAOSSkOJXYN7qO9++cA48b6Wg/VMHqU+9ndni29sKvSX5ihuKCsrCIo
         X7NvVdJ+I+s4bRHS/njGQPBTUdW+/uxKOxshyP5MltVjo9aaUlCELhi3R/CIPh7Q7fH5
         TJ0F7kU+5QjnCRxkOlHAqIwrRJ277WJX3BaXnmNZXQFFDz8LtTU6vDhfqd1PSgb3vrG5
         bEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764924615; x=1765529415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mu4vhDBoG/9WX9EFo4RIO76XRCI3bL/HXhvs+9OJge4=;
        b=F6cs91W7mOiQ/Fkf7DltIy3DJjloxrxnYFXZ54OOEBPccdofZNp2qn1k/PhuAFGeKG
         ZQyP13DvO5mL2xOr7rqropH02d9zN9NgkQYw7e9UbQmNXiKB7kC3BDItsBuMoYQXONpj
         17eN9GZ/izmGS+x2PmzLFxzzyyypECW/j99ZexgfTMERHsIMMkLC8omxT3n4yWgQhu4i
         Taob4GgZ/8YKs/KJ6LZspP27qmxStnoPnflPRJZd4dEf14MgGYmaF6wcyJjq0efXkGkf
         Boy+jB48sMWOgi9RzXyAnbhYRCaWYhTVTiS26C+DfLOMOiGcpmj3k0PCH/4p7/5FReI+
         q+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6oHYnVq9qqmUEkdV2X1gI+SjEpQamY+bANM0BwogT9LQrPcBaPYMfDloZSocjEyuqI4D5GDfRyNZtapLg@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZ4mrruEShIxdQZAnMZTFZ0fHvaUzdMfmN+spfGYHe+ILZoZj
	FI1b1sU0R0IF/rnIxBYKNSL21RRyLP4XzdOEAXxRXY7PD1TF6kwgszgM7eioZ4b8BZHnqx3aNbA
	rqllSiEA9UQNlCPtmld6B7iI9zoa9lw8V1XBlKuyL0ga9+8Su9HHKh4ZRafW6nBIR7iWTJI4UCp
	I7JQkKChxHcQLsy/3Z3P4O1BNij37Kcp/vkbFWltAs3A==
X-Gm-Gg: ASbGncuWbJzv+pDHgqKT0WKJMghSvJQTo860ckxbhrGSSRdLf8qGnMhsdLhaGpYZ+5S
	cKaVWnoEkh8BKrwbNhti63VMs24V79QxhbR2gnewyd6BKtUt5jjCaqUAAYfH7bnJi7eepKxNH0i
	Bib8jECUXwMSzp9SFKDYpcAIhc2nM2oQ9EUqtyrw/EcuSpVopyes6wnfNlfgisVm5XvGsrp2Jp7
	kD3eyDRNcwsVs2trvztKUePZYc=
X-Received: by 2002:a17:90b:5101:b0:349:7f0a:381b with SMTP id 98e67ed59e1d1-3497f0a38cfmr722890a91.8.1764924615511;
        Fri, 05 Dec 2025 00:50:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxpl8nhnsm5A0Jf0tNdztoBLeKfKGGFhMtxDcEJNxWg5wU0TFBdOzIF/jbehPxHYjViqqf2YHleDsPoD3CxZ0=
X-Received: by 2002:a17:90b:5101:b0:349:7f0a:381b with SMTP id
 98e67ed59e1d1-3497f0a38cfmr722869a91.8.1764924615172; Fri, 05 Dec 2025
 00:50:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
In-Reply-To: <CAHC9VhSaM6Hkbe+VHpRXir9OJd1=S=e1BB3zLkSTD+CXwXaqHg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 5 Dec 2025 09:50:04 +0100
X-Gm-Features: AWmQ_bkqx9hXWJfAa0OD0GP1AsTD2CoA7wXj3vHVaodmsfNKvjiCR2RIZwD1OvY
Message-ID: <CAFqZXNvL1ciLXMhHrnoyBmQu1PAApH41LkSWEhrcvzAAbFij8Q@mail.gmail.com>
Subject: Re: overlayfs test failures on kernels post v6.18
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 12:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Those of you running tests on kernels during the merge window may have
> noticed overlayfs test failures in the selinux-testsuite.  I just took
> a quick look and the failure is occurring in test function sub_42() in
> tests/overlay/test.  That particular test is expecting a file type of
> "test_overlay_transition_files_t" but the actual file type is
> "test_overlay_files_rwx_t".
>
> I only had a few minutes to look at it just now, but there were a
> *lot* of overlayfs patches sent up to Linus for this merge window,
> most of them relating to overlayfs credentials (moving to scoped
> guards), so it is possible there are other SELinux/overlayfs failures
> as well.  Has anyone else noticed any odd SELinux/overlayfs bugs in
> recent kernels?

Didn't notice any other recent bug except the newly failing testsuite
test, but I managed to bisect that to:

commit e566bff963220ba0f740da42d46dd55c34ef745e
Author: Christian Brauner <brauner@kernel.org>
Date:   Mon Nov 17 10:34:42 2025 +0100

   ovl: port ovl_create_or_link() to new ovl_override_creator_creds
cleanup guard

I can't see anything obviously wrong with that commit, though. Perhaps
the author/maintainers will be able to spot the bug.

SELinux testsuite can be found here:
https://github.com/SELinuxProject/selinux-testsuite/

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


