Return-Path: <linux-fsdevel+bounces-23339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286492AC97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 01:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4955C1F21BFA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B3152E0E;
	Mon,  8 Jul 2024 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNSkltlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB33A27B;
	Mon,  8 Jul 2024 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720482195; cv=none; b=K6EM8Jh3HEw1HKQExNwSA9/sQXN+CJyem2RFzN6OEumgHFJWk6E4WsRfmIdwwowSKdbohpEBPfBvXKmodtGXQ0inMl42jHc7YaNNOqYdAviDTJXIhxZ3ZovmRSv038yoqG15KgqIymr+onFo7RWvxW08iQgL7F/UWkkqUpcUIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720482195; c=relaxed/simple;
	bh=yDcT9L7Zk0KFiBp0ZQUaBASvcdoU9u1j2Ta/LTRDoH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPIFGyLXPK8Pz0rmnpvhlw4kASupVoQZj05A5Ay5pX0qCEZ/aIZl1yg/csOQg9pIzKzQoQL9RYcbaTG5Da2qShFQIMg67EcOxGRUU9I/iS9kYijStdbmuqenMT68tdf06S6gpM+/7Lp8lCT7hvrs1Xif6YkwJRupY8C3+BuAn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNSkltlh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b0e7f6f6fso2826750b3a.2;
        Mon, 08 Jul 2024 16:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720482193; x=1721086993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDcT9L7Zk0KFiBp0ZQUaBASvcdoU9u1j2Ta/LTRDoH0=;
        b=HNSkltlhDQwgkNNyYD21asdOHLhuet1uhki37jIOi9K8Gv4xp+SED0RfPBBXnw394S
         8/aqnivOBhns+fyrD5lD691nmr/dchaMApkVMrWCxTKm1Q+bGJonp36f/2XhqvzWjdiw
         TOk8li/5q8/no3WejIRqVxGBHQsrwFtF6bRXgwl4C6awYxMUCGs9089XKTOkMIFE0HYo
         1VP8Viqu/C5B1IY7Xnhr7ozjssk72tThEVqzWkYvSJnYZXuwb109WKy9avEMuE4RCC3P
         kfztG21uiHNz2WjoUegzlnJdII+ALrCNxAe7WzCrwdOx4BYCDAK1rs9pXd9chVeIqkU1
         +d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720482193; x=1721086993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDcT9L7Zk0KFiBp0ZQUaBASvcdoU9u1j2Ta/LTRDoH0=;
        b=npZNxUvtqeoabjTG0m0TdsVujKp0oE6Opy7MVjnQQlI7yf0hy7wH/dds5Q7VNrvWDM
         Gg0nHfyOz2GqioWY90nvA+pe6HckRy22vkXNxdoTz3Ql0gAw3W3idty1KsP7oar+yfxG
         Zm4C2xHbGYPj8yYOH9LLqYg3EVffXNVt8CWTcfbFfuKORdOsABtBmriFnQ5IPIcA7kh8
         ujPh1yvoZEN1vJXrJ4CpcBeosZ6d7AH5HXlmRhZxguUA49yG2w0tNN26k/cA2cBxN4RH
         8bFSB5oEdlVQOIsv+90JPkQ3TZHiXNmsNOLxUqb5y7Jx56xFLQwpO7sa/OJlySl4NFef
         d+3A==
X-Forwarded-Encrypted: i=1; AJvYcCUd4V2MLkoCLukDyex0HvoBkmywHWeZYaz+o+6t7WBXH8tilYpMjkdXciz21GIyuYgat0X7A3pM2UWFiILueVA5ImmrjhfuHVsIMm3Uzczdv8DJNJF25OO2+BISHZ6j1s2uJGehmUNlLI/IskZ2H1XnY+FdKH2ZxR8LPPfqYxzKqA==
X-Gm-Message-State: AOJu0YyYauRFZXRIK+AFnIPKx4BK6qFrmkfrI0j5qPwLjADvyet+386f
	bSbox7HRYGRnlSFeYJ8oIk1D5nmjezE/ORJvCW5mg2TZQqZMQDnoEXwvKuZOh6HZfoOYQeYHQwS
	pNwOa27uKJQBa8GfrqyuhKAj+bpU=
X-Google-Smtp-Source: AGHT+IH1imuiEMLyu25NOak7kJ+zWW5+fNO/01KMRl9fOcvLwbOGzy+gF+7wDMeIVkDREa+KeJTZolbZG7rgeibCAEc=
X-Received: by 2002:a05:6a21:3382:b0:1af:66aa:7fc7 with SMTP id
 adf61e73a8af0-1c2981ff88emr1168425637.3.1720482193011; Mon, 08 Jul 2024
 16:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627170900.1672542-1-andrii@kernel.org> <20240627170900.1672542-4-andrii@kernel.org>
 <878qyqyorq.fsf@linux.intel.com> <CAEf4BzZHOhruFGinsRoPLtOsCzbEJyf2hSW=-F67hEHhvAsNZQ@mail.gmail.com>
 <Zn86IUVaFh7rqS2I@tassilo> <CAEf4Bzb3CnCKZi-kZ21F=qM0BHvJnexgajP0mHanRfEOzzES6A@mail.gmail.com>
 <ZoQTlSLDwaX3u37r@tassilo>
In-Reply-To: <ZoQTlSLDwaX3u37r@tassilo>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 16:43:00 -0700
Message-ID: <CAEf4BzYikHHoPGGX=hZ5283F1DEoinEt0kfRX3kpq2YFhzqyDw@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] fs/procfs: add build ID fetching to PROCMAP_QUERY API
To: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org, adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:50=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wrot=
e:
>
> > 1) non-executable file-backed VMA still has build ID associated with
> > it. Note, build ID is extracted from the backing file's content, not
> > from VMA itself. The part of ELF file that contains build ID isn't
> > necessarily mmap()'ed at all
>
> That's true, but there should be at least one executable mapping
> for any useful ELF file.
>
> Basically such a check guarantee that you cannot tell anything
> about a non x mapping not related to ELF.

Hey Andi,

So when we were discussing this I was imagining that
inode/address_space does have something like VMA's VM_MAYEXEC flag and
it would be easy and fast to check that. But it doesn't seem so.

So what exactly did you have in mind when you were proposing that
check? Did you mean to do a pass over all VMAs within the process to
check if there is at least one executable VMA belonging to
address_space? If yes, then that would certainly be way too expensive
to be usable.

If I missed something obvious, please point me in the right direction.

As it stands, I don't see any reasonable way to check what you asked
performantly. And given this is a bit of over-cautious check, I'm
inclined to just not add it. Worst case someone with PTRACE_MODE_READ
access would be able to tell if the first 4 bytes of a file are ELF
signature or not. Given PTRACE_MODE_READ, I'd imagine that's not
really a problem.

>
> >
> > 2) What sort of exploitation are we talking about here? it's not
> > enough for backing file to have correct 4 starting bytes (0x7f"ELF"),
> > we still have to find correct PT_NOTE segment, and .note.gnu.build-id
> > section within it, that has correct type (3) and key name "GNU".
>
> There's a timing side channel, you can tell where the checks
> stop. I don't think it's a big problem, but it's still better to avoid
> such leaks in the first place as much as possible.
>
> >
> > I'm trying to understand what we are protecting against here.
> > Especially that opening /proc/<pid>/maps already requires
> > PTRACE_MODE_READ permissions anyways (or pid should be self).
>
> While that's true for the standard security permission model there might
> be non standard ones where the relationship is more complicated.
>
> -Andi

