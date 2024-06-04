Return-Path: <linux-fsdevel+bounces-20881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBF8FA853
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BF41C22CAF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BDA13D53F;
	Tue,  4 Jun 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKC46LM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0938B;
	Tue,  4 Jun 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717468550; cv=none; b=Nn6C5ERnJ98nIMZlYBavvCRDvERm0lGgkx0y7SlOGuSS/baOaSgaKGmZbyqVSivhlFqkxfi1uboaB1znvjz8YqqQFYKtBqfzs4LUk6C1J5AwH1C1tHXSUWL5vxRmU/j12OP9WU26Vp62fuRB8tUvg2nTQUzTW301cCgUoDIOGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717468550; c=relaxed/simple;
	bh=J0+6VuAcmJuFZUzfJKhRgy9ju+3AX5VnSvOv6JpeqlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHP9wOIKzyIOA7nN/70JipxsUXrIwkCPgAZbj53cCPyZPdAQgBfJPwQAee5tV7iSchO87iNoPMdkcQ9Q2hKpf/JoM7N3tm8Px50zHPD1Ixmn9EYj1+46tEMYJoaZNOU8ziZq/1qFf70AHyHVUTdhVHHxzk90Cx3BiAb+5xSo3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKC46LM3; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a2424ecb8so7122877b3.1;
        Mon, 03 Jun 2024 19:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717468548; x=1718073348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0+6VuAcmJuFZUzfJKhRgy9ju+3AX5VnSvOv6JpeqlU=;
        b=eKC46LM38fqF2wqA/Chjlx3Q5kAbRY22wubyPegY2K8RUzxLPElT1FNnteL9exQROj
         9soRa2W0y3GbJke5W52rOoSp9z4lq2O91Xcx8KE9lPVVplByi2QFU+mcnl/Q5v92cF3x
         oTfCbaG6sNN+LhnvZmU//zBYK9ZEszUOoSZQPjg7G+7UY1BLWCvsO5EY2Up7ixIhyhz7
         4gEE4uduQ+nQU8qg0aSc5Wc978M//nH6aoKt+BTHJQzhBZWlEJkRHK52j2wglGSz9FNH
         OReY7+UWeiu5+jtkvOKI4qe/n60881+C3jE1la28CK4GQZozkUauikdAaoZpxqWQywCw
         DazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717468548; x=1718073348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0+6VuAcmJuFZUzfJKhRgy9ju+3AX5VnSvOv6JpeqlU=;
        b=XosiLIFTKO+A/r4A1fCS4MR2I9ttosHmwJztnoEe4R0Pp4luPBKESmCu/5d6wNsgts
         4HNnv6mzEttyRXnQfE7z46AIioqYz2UXFTZpQvm+414zQXA54/PY16G/RzwQgQIj/r4l
         8wSroE9yDrL9/ulxCvTVnR10Yskhv0C27YdxLSDpxFLgXHFQLpPTSpRfvlCEwGxH4NT4
         hrMmBSKCBT1XdTlZHVrxlj3JC4FZTXBqazBvHU65C5TM31EpgGQHjbGSc4HXa4lhxRHG
         Vjm8WTI7fLIxd5gCUWcaDbkRUVMsvxUIEpqXzSnw2JMCb7r5fs9ljPani70/FxZqKBm1
         m4WA==
X-Forwarded-Encrypted: i=1; AJvYcCUzTDNzs/xiJA0/sPhvcnFc3+3kQhpYa9gHNlfxW8GNHeArr1rsmLg5D9hqnm2rT6nFwAbvF3UCmYEoptBXSdIRSka2c0iXndnSVSgYFk4hT8LhD9DSZra5yStfWDOFGY4tOBk8V6c/t115jOpqPsl77IoXqrJiR1/itEMmbXIOq7wbMdXqZBT1bV+BSmpB+Cq0A93f96cdkta9YhuwP3lN4+p8o/YXvJiSO7pwT539MqIj1UAtOT64n+8yZ6K9nNNMqhvwkxtUZE7tRRRVve+OuzZXZkSma4WeL+Dt7A==
X-Gm-Message-State: AOJu0Yx4lXiB8vpsMabjHDVl1uA7oC+q0GM2TKDlhIqw4jd0rcdkEMaU
	VAnYR0LzoR00a78cYtfNwPjNEOGtENQ55vqCHAgH6o6AwAhYceyNAxflLo0mL7JSOQK01x9OTtb
	Io27LaRrhO0u3gGvT/3GWklllCmM=
X-Google-Smtp-Source: AGHT+IFsJKKP6E7ehkS12dXoTKwwv7oEaZTZAGuMrX+8lYbnDgjPUWmWSK4wVLj6fy3L5FaNVQwEPCqorB1AY9Yfm7U=
X-Received: by 2002:a0d:eb91:0:b0:615:19db:8ed1 with SMTP id
 00721157ae682-62c79843f8fmr105571827b3.48.1717468548009; Mon, 03 Jun 2024
 19:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home> <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
 <20240603183742.17b34bc3@gandalf.local.home> <20240603184016.3374559f@gandalf.local.home>
In-Reply-To: <20240603184016.3374559f@gandalf.local.home>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 4 Jun 2024 10:35:09 +0800
Message-ID: <CALOAHbA_i_pUkX17rBdUKyM-Vr5LtQvbKe7bN9m9LfG=qndnAQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:39=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 3 Jun 2024 18:37:42 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Note, I've been wanting to get rid of the hard coded TASK_COMM_LEN from=
 the
> > events for a while. As I mentioned before, the only reason the memcpy e=
xists
> > is because it was added before the __string() logic was. Then it became
> > somewhat of a habit to do that for everything that referenced task->com=
m. :-/
>
> My point is that if we are going to be changing the way we record
> task->comm in the events, might as well do the change I've been wanting t=
o
> do for years. I'd hold off on the sched_switch event, as that's the one
> event (and perhaps sched_waking events) that user space may be have
> hardcoded how to read it.
>
> I would be interested in changing it, just to see what breaks, so I would
> know where to go fix things. But keep it a separate patch so that it coul=
d
> be easily reverted.
>

I will drop the tracing part that includes this patch and the patch #6
 in the next version, and leave it to you.

--=20
Regards
Yafang

