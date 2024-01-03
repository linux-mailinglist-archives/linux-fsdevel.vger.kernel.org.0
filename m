Return-Path: <linux-fsdevel+bounces-7258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A1A8235FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 20:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD92285881
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 19:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2D1D522;
	Wed,  3 Jan 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0IaaALk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD51CF91
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so17200245e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704311854; x=1704916654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=X0IaaALkRKkC/tpqtW39My6T9I0c3gT+Zv9uo74p3GICEdErJnJFli/hkmgkd0VNgN
         EN6XG3e7GZ280LwWkSB84PyLu4jqzERQwnwXGl70rCWyHRQn4PTPZ7k1J6Utwv/EDeIz
         x5Yy3KlmsbBJOv/EXe5VZiZ0JmFzRvAC+ipX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704311854; x=1704916654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHOZq6HPvj4dG+d7G6FK1Ss+OGlgrauAKkpyntxQ1Jk=;
        b=vy+uy+zb0BRZxpObwJogrRNkXzezUW2oTyjZTI/6DOLTQoPqyDcd+mudcTzGDce5fY
         USF822qJv8GktuZwlfxU/NfmUNtGZYRe1E77s6UxCnJEGRYOX0KrAnIjW0YoP6hJjMXY
         Y12tHtUVidU98OokvGK0d1zsT8ckpC+ijV3DV9fqGvlMZazT6XbDjCRZ5Ew+NPV99mH0
         nb1+v4eE++n63oTg/PqylJUk9XILkcvdDrarOAqST2hp2eiJKC8/X5GnvRg0ckp6Q7CL
         mQgUrvvxazCGMxrVFHy5n8hbwUXyL5DHkx4Vq+ygBhnfONX1oIrrGQ4rYrLzGjOGsxru
         6mrw==
X-Gm-Message-State: AOJu0Yzg6c4wPFEnIbscqK2oV6BGODGvzmqc81wJVe91xFcBPix69ZzX
	Av6L0WhAaCVxmJrGLjIemjeVjX4FPTpoQZ6hsZK3KRrhpVz0R7XP
X-Google-Smtp-Source: AGHT+IFEXq+QtE1xCpyVbu1aWsWIeX7gLqj6A5KhHT0i9koWSM6DA8ov105oLrHVyaeAPmTpjuqQaQ==
X-Received: by 2002:a05:600c:1e0c:b0:40d:8c40:6c75 with SMTP id ay12-20020a05600c1e0c00b0040d8c406c75mr1628080wmb.52.1704311853843;
        Wed, 03 Jan 2024 11:57:33 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id x7-20020a50ba87000000b005527cfaa2dfsm18330240ede.49.2024.01.03.11.57.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 11:57:33 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28bd9ca247so35188766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 11:57:31 -0800 (PST)
X-Received: by 2002:a17:906:df13:b0:a28:34e5:b60a with SMTP id
 ie19-20020a170906df1300b00a2834e5b60amr1188633ejc.14.1704311851332; Wed, 03
 Jan 2024 11:57:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com> <20240103145306.51f8a4cd@gandalf.local.home>
In-Reply-To: <20240103145306.51f8a4cd@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 11:57:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Message-ID: <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 11:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This doesn't work because for tracefs (not eventfs) the dentries are
> created at boot up and before the file system is mounted. This means you
> can't even set a gid in /etc/fstab. This will cause a regression.

Which is why I suggested

   "I think the whole thing was triggered by commit 49d67e445742, and
    maybe the fix is to just revert that commit"

there was never any coherent reason for that commit, since the
permissions are dealt with at the mount point.

So this all was triggered by that original change that makes little
sense. The fact that you then apparently changed other things
afterwards too might need fixing.

Or, you know, you could do what I've told you to do at least TEN TIMES
already, which is to not mess with any of this, and just implement the
'->permission()' callback (and getattr() to just make 'ls' look sane
too, rather than silently saying "we'll act as if gid is set right,
but not show it").

Why do you keep bringing up things that I've told you solutions for many times?

                 Linus

