Return-Path: <linux-fsdevel+bounces-25062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B09487D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 05:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32C8280DC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305455B69E;
	Tue,  6 Aug 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AqIjGFxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC73BBC9
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913812; cv=none; b=F7fl/eLeMlHzdg11kQ9uOTOUwx5b/UC4b8haWeLEB3+L8QqsPhCtyQUfTGO43ENzI6Qb3y0PkRO6LYAZba8wx6MqGy3qYq/jpngSuU8UunOn41Q51R7+xtAP7s9wElATe9YCBQ/A/DWHz2xjm8H/6qiwDQPXiiYoK7rNkE7OWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913812; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntk34cyQziTkxNfGsavO7ZT531L6AjYeljdIT9YOlu0g1D9vEShwMqkoFaQuF2TfUUCPIv5ZU2w+4rSQpNN/9yznFTsB8ZBDp8LJsuymrGNiRXzqBHyUuBTtm1y35MFgrRJeulLcHgAK0tlqY+DcmuOvB5CWZeOlFiH941DBxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AqIjGFxt; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so3171866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913809; x=1723518609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=AqIjGFxtM0nFjNXxOr7KDYCUIJeYxKS32lAgjemtmmhh9bvx3RgcyRhtpne9s7jhkw
         8JaHUpJqtcDLArsgJamUrkgkrJQk/mdyXVPUbfOYS9kY5bzsrpUHWNPaW1nz9o9qGaEK
         HB5VZVGmFKgZ0VFV6k1d4LmCh5BFz3eqoS5cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913809; x=1723518609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=j4oq9aoBS821L0/ZTsyXYrTbSENMPQUNdA45AB0jlWW0lXg398j7U8Z4DsB3gCuEnD
         Z5NPsghQ6bzD4kjMy7NCEhJAvKNsCkQxx4rrtjdf7t3QdHne5DZh9a6PbxsojjxKRcNR
         7hWLEBbGDwXBx3SflS3lhaPdAVy83bRweEM8elrsEKnMjCIyUNdFWxybvBLXoln/OQXM
         geRqeXohjUcFL5gdz+4DFUjcviwgd41GIyCZinwSJzoHjooJk6T3n26LD7f+AWatbgWu
         ACuzfo2i8GhpFBjTWvFOUXpEOuzuu2I9iHkg6Jom9XDxpNgOV6O8QGVWXXhgwPIYzt4d
         xoHw==
X-Forwarded-Encrypted: i=1; AJvYcCX767ozdrKK/Q88VLr2CdWv1aNgWPZcea0EQpWSPh7lsPru2pqC7pDSYRlAnvjW/R+C3FsYQBIl6qdPKoej8+IaGZhrTcPj11N8ZQZgfg==
X-Gm-Message-State: AOJu0YxOhc5wFG0a6Glb2bN6Ze55c2RSAnxyu0EmuhWHX4zn2CiDKHj2
	LMBdr7ap+U5PPBffCXulCEvAdSqkxwEJrQ7HTy2p7EENy5boXQbmJQmnWlKxrKGuN5HKn3fd9N9
	9BCQHsg==
X-Google-Smtp-Source: AGHT+IGuu3zGLLUNcqbiff2a+OoRc4ylzXfmrhQvgDL7H5IJliT3uo/v0eW5D3AB+GOlQPGgIlsWNw==
X-Received: by 2002:a17:907:3f8b:b0:a7a:9954:1fc1 with SMTP id a640c23a62f3a-a7dc4ea981cmr924654166b.24.1722913808689;
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dd074ec36sm477786666b.57.2024.08.05.20.10.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ac449a0e6so3171566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnmNoFYnhd1plM8MIlg71iMKI+davNrpoidhXYXzJ3OUB13OxnI5AHVvte60B7/OhgKR6wRytiWds84JIk1pS/qFarHMOYs2+p4bY0GA==
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus

