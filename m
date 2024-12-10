Return-Path: <linux-fsdevel+bounces-36978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF4C9EB9A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 19:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CCD1647B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AB214201;
	Tue, 10 Dec 2024 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYlrywhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB223ED41;
	Tue, 10 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856692; cv=none; b=kLZmi2cO8GtZyrZRf7KOIJLCSfKVWBj4WyfFDak6DFYKYLljjhmVkcI9oz10nIXI7Qj8A4rjqp55OnEirP+2LLThTI/VdgXl3rOsspsMAIlsEBrrezGbeg928ivh1usoauCrBtdNHDnmBFCcC+3lzZJZaO4a2THIhymKhnZX4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856692; c=relaxed/simple;
	bh=lAZTB+5AUs87Gv5Bp400EFKF06lTy9auqfzLDlXibt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJu4pRSVGNr0Zu16VBQUl6C6PxKtkRoRLxi8q0RSz3tL0X5hlcKWvMqkWwJk9tHqVDL7FT9dacMzLTiPLgJInOvOOWHsIBq42Pfi86gvims/ND31W+rEJuxHduZJmOCnXik993aHuC7Q/0nQiOllfrd7vSN4ZfWs5atqbcaetMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYlrywhH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so3314010f8f.2;
        Tue, 10 Dec 2024 10:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856689; x=1734461489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbWcTejsLTu/yfEmnZUJI7lrVRDEyeRIYi0sBNJufoA=;
        b=gYlrywhH9uGWkWgkYvdFwD4QndXqKseDOfAXgabNgA7wbW17nvK2xgqtpjVfGEq+oE
         z74YVld32l9aNhdT7wcvQ0bnsJj/84IP6A37wsF0m8HpzJTW9gDTJmQOrCZ5R5uabR0r
         tLSoZ1Kb4nlQrhu4NthRQFwYeik1VQnB6ErcJDNPjcx4IagARABKT3m7htZyQL+SeLtg
         hn+EVXoMpN6CXTBrK7nRqqWKTmaenxvMY76ZHsJQq+1y16dqV8CYEoQiyzp0DJFevRCi
         n7ON8YqFuofi2WYYz8nci9Luj/VXRdn17Bw1kQnTRNoNAxXjPf3dLCzLhC60eHDl1V5+
         tCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856689; x=1734461489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbWcTejsLTu/yfEmnZUJI7lrVRDEyeRIYi0sBNJufoA=;
        b=TqX5uiZBPk3D7goagN63sqUwQpPixYMgq38MPrHXUb+/+65ANn1IT4PUAX9gJHb7ET
         oF2pLA85jct6etL3kORaoLtKn0lGUPqoGZRQdac0k2JgqgcZ8V6ZYFvZ/YWaXJ1fD5W3
         1NvYsMXhjUvaQAr4atizFSZJmKFnexoEaHhQ9yLHXY0mQLLjLyXRgAL/5/5QkfkqvVFS
         kCreCk34JhKrpVBmAtjp6oQPF6TnsD/+KMTikoNlmoUIM9ly9ofOzC9rKap0d+YIGRJi
         fi9ziq1sHDz75JKTRzrJBS7mIbeYidFDYJjEqCzYDkdEcyhJ5pb1T4mUDXdabzi36pOU
         0r9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2RTZsK6H4DmCgJwlxMiby8MOplZSEUGSr2N0rcPmKG+fDien30SjETIFBuPpmnx+F92M=@vger.kernel.org, AJvYcCUeTIBRyjHOU33/jqlXRW2HHiAaIvHezMSnfCp7A84vFxoGctuCfTXYYZa5cgVQbbmVCIWbHQD1YTLvIs0x5w==@vger.kernel.org, AJvYcCXIEgARs8NZYEgB1Bi1ZIQoulw8qY3508ukrOxeXyg0K17pbHMuwmYHR7E6AtlnBE+z0UbgVTOg/ZyyDLkX@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYPsWlYepUyTwt0GOXn2WDa6SQrkzkw2axsm2a0naTeT9wpeM
	DP+FKxqhfU7Ww7OiYrL2MbFaWbW5t+YJBVyZf4nJctiFNcKv7i6umluvB55uAdXeJEzzB5uORtf
	tTb+uYSg+zwK/AuKa8j297j4zric=
X-Gm-Gg: ASbGnctg/xa3n5OYGNmyrgVT2oGFXmnsPR9Ofii1JHc0DBUJ9NFT2wYNG9oW3DURIy3
	qKobOPPTwlrker+KGqtnZ+B4wCH5xwMcAykxL4gQjoVa+M8iiDUw=
X-Google-Smtp-Source: AGHT+IEL/YKXKf4bDl5tUFIznsup7O7nfZD38kP19L0CXIrXpOLmVvLwja0xemsUWoCwI3noI6ez88l42gRf8OLITTQ=
X-Received: by 2002:a05:6000:1a86:b0:385:e8f9:e839 with SMTP id
 ffacd0b85a97d-3864ced38a4mr149857f8f.56.1733856688725; Tue, 10 Dec 2024
 10:51:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080756ABBCCCBF664B374EB993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-zustehen-skilift-44ba2f53ceca@brauner> <AM6PR03MB50808A2F7DEBB5825473B38F993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB50808A2F7DEBB5825473B38F993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 10:51:17 -0800
Message-ID: <CAADnVQKK3vmfPmRxLuh6ad94FeioN2JV=v+L-93ZvwdYqR_Kcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] selftests/bpf: Add tests for open-coded
 style process file iterator
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 8:23=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> >> +SEC("fentry/" SYS_PREFIX "sys_nanosleep")
> >> +int test_bpf_iter_task_file(void *ctx)
> >> +{
> >> +    struct bpf_iter_task_file task_file_it;
> >> +    struct bpf_iter_task_file_item *item;
> >> +    struct task_struct *task;
> >> +
> >> +    task =3D bpf_get_current_task_btf();
> >> +    if (task->parent->pid !=3D parent_pid)
> >> +            return 0;
> >> +
> >> +    count++;
> >> +
> >> +    bpf_rcu_read_lock();
> >
> > What does the RCU read lock do here exactly?
> >
>
> Thanks for your reply.
>
> This is used to solve the problem previously discussed in v3 [0].
>
> Task ref may be released during iteration.
>
> [0]:
> https://lore.kernel.org/bpf/CAADnVQ+0LUXxmfm1YgyGDz=3Dcciy3+dGGM-Zysq84fp=
AdaB74Qw@mail.gmail.com/

I think you misunderstood my comment.

"If this object _was_ RCU protected ..."

Adding rcu_read_lock doesn't make 'task' pointer RCU protected.
That's not how RCU works.

So patch 1 doing:

item->task =3D task;

is not correct.

See bpf_iter_task_vma_new(). It's doing:
kit->data->task =3D get_task_struct(task);
to make sure task stays valid while iterating.

pw-bot: cr

