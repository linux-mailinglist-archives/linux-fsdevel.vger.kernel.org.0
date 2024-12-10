Return-Path: <linux-fsdevel+bounces-36979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1159EB9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 19:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B002834D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8031F214207;
	Tue, 10 Dec 2024 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwn7KQLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0886321;
	Tue, 10 Dec 2024 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857146; cv=none; b=u5L9dACzGj71+qlLxriiFWRCO+ROeCVqkjNEQDQSkjWDgqNxDcJSmwGIx+UWlp4GeAxRevU6Ty6unD72JArYmHSq+F5beHktqJGOyeLupm7Hx6JgH0CQ48cUz+hMuN9jWUjKnQ9FwwfCF/WCZHK5plygTPc/JBaAbcMi8zX1r0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857146; c=relaxed/simple;
	bh=6GDkXPNSXjUHcYvqBEdRjcYpKp1W111gqk3lUxV6vCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzAV/mB28o2f/aJ+AbLducP+N2rei72XP0cLvZe7bz7b7CwBJmuTHBpYiYsz2VWIvRnvYfMSy/Avaav4lXjZeXEiy8iOZ0F6AV8RKqj6BZJLQojOmYrUm3mDzn7dAZ76QnAt/oHy1tirxnpjna5N6JOHGp4kBqc9dpSPn/aVMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwn7KQLM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-386329da1d9so2017868f8f.1;
        Tue, 10 Dec 2024 10:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857143; x=1734461943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GDkXPNSXjUHcYvqBEdRjcYpKp1W111gqk3lUxV6vCc=;
        b=Nwn7KQLMJ3fAWDbKMOtOHagEXhpcAC7wosnwOmu6CuvTFKl4vDtdoSW4RWqYjaXM09
         zrVgEmMf8VHyP2gsuINqbLOE+bubcgYgduHzPLFsrfoIbG+XLsEjsNZy6zUlXqcyhyz/
         iRzGelajQDuRGrt8n2/IONeINr+GF3cfJFipfIqtbHMAdPUnDuNrAHFIDL+oQWLpdxVv
         8fjK7R8z0H4HkPCMuynILoVF3yhK8W3l9MrHPSuo07efPKLCf/WbBTTj6ms3yEEl4hCo
         8nuTQjOVoPiZvGhwODoPNiVXzhxnFvq7BGnpA4d+cHxZn9NPTr6nJFNplf1jDBF8/jwI
         8ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857143; x=1734461943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GDkXPNSXjUHcYvqBEdRjcYpKp1W111gqk3lUxV6vCc=;
        b=vN7oB9LL0GEHbaKuiNjI4m5lTGewwl8OTcrr/1WSLmdFesuwtUe7pLvo1dIClPPq2F
         yhISuB+mA7/ZPlLT4lMcXT3D6zlBDRvz3DoZuSINGpdDxHxwyCMIxM/Wg09UdC3oP3oj
         I2PxIYlHeWFBWH9ZX7Kg0ZwBwDj8R5DWhPhYHcSzJXyMFPGJ+XG+hkDfJr8WrQflb15t
         EHw/1f/0IMEVI687yqcQ2suqS7ulS7fVSPbC3ySRIJiuj8EKI6qd8MeI13HW/ePPpXnK
         Ymx0L8lAM+lW0SX2hdHlWno1IJirFAkTgyISlyjO6Lw75SGubm2t04P6lLNXF+dGitu9
         WYcA==
X-Forwarded-Encrypted: i=1; AJvYcCUDcIBwwfdEOMp8bWDFMycqH0Y3PtFgBZDpq64OvAnAJoZudk4Q92FDt6B94K3CLeWc6yIIIyDJOML5A+YF@vger.kernel.org, AJvYcCUe1HoJ1kiich+P2I8qLWosvWFSouOiKXI/PCGlrCqBfzuigx62ThNbYovPB8VScd74Bdw=@vger.kernel.org, AJvYcCVJrqt8DhI7+5jrcYKbS9pkUw5enegw8ucNero8mHyFzSj9Exanb2T4tGHpDKXMPwjv2VRPlLMRIlQUurJQsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqRyxUC7hvzEMAifkr9EjR3hfUZ4jtOdMuupOjao4h8rFX2ou
	zdkLPSFxOWICIEi272g29CUTMVLwg5sAHU57d20B14sMbFn1AeQnZILHmR3eayVqAcSRCWyy98z
	BqCe/x6mIz/JJVaWl3NPfBK38kL8=
X-Gm-Gg: ASbGncuuyrxkZLwcItPjKZsUyZxg0VlvcibdA8RuauUtuetFXWBZgs+2kNWphgisGm7
	3+6/czdi5JKbxqDpDv5JvCxoQpDD755AiF3ZqjzYdkHlFZzT3hBg=
X-Google-Smtp-Source: AGHT+IFnNHuIpD8rR77vf+oW8W5FNiYiAGRWby5lFgTpK2HxN2hD4FuiT9cxsYlQAbJq6RjI08PCypuGH4LCQzHLAC4=
X-Received: by 2002:a05:6000:2d06:b0:386:36e7:f44f with SMTP id
 ffacd0b85a97d-3864ce54e99mr110651f8f.18.1733857143335; Tue, 10 Dec 2024
 10:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
In-Reply-To: <20241210-eckig-april-9ffc098f193b@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 10:58:52 -0800
Message-ID: <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for SYSCALL
 and TRACING program types
To: Christian Brauner <brauner@kernel.org>
Cc: Juntong Deng <juntong.deng@outlook.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:43=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
> > Currently fs kfuncs are only available for LSM program type, but fs
> > kfuncs are generic and useful for scenarios other than LSM.
> >
> > This patch makes fs kfuncs available for SYSCALL and TRACING
> > program types.
>
> I would like a detailed explanation from the maintainers what it means
> to make this available to SYSCALL program types, please.

Sigh.
This is obviously not safe from tracing progs.

From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
since those progs are not attached to anything.
Such progs can only be executed via sys_bpf syscall prog_run command.
They're sleepable, preemptable, faultable, in task ctx.

But I'm not sure what's the value of enabling these kfuncs for
BPF_PROG_TYPE_SYSCALL.

