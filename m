Return-Path: <linux-fsdevel+bounces-37917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6165D9F8EC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 10:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC55189703E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A101BD9FF;
	Fri, 20 Dec 2024 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWLbLRLx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22071BCA0E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734686121; cv=none; b=eLBRqdwdQQdY2rzsklfnr2q+02kmP5Qx/eFcFEVHmJiKHg0vwaJzH74OLtwBSsRMjI1+4nibcC8uUG/CWvd1REnPNdwH/b9gjwLsJBYYpz7QeWXPFO95phjUcR8G8nN8Di9ey5ks4lvPXDS2Q/les9nHAuZKc4jYlkoELKeaIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734686121; c=relaxed/simple;
	bh=NLetd7nVAxQOP/5NukKrvogts5apKvc1tTqPC3qKmrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k9k1vefNfpKkYc8eurCpDzNIwRTDpIuwXGBf+Rwcmgxc0SclCXM/niWWz/9P6GrVbFEhSbGgqDPcTsgtU2l8kjr/98XQvNvnuqDJ4oRy2uZXAMUAHHCozaDJtimztjbNh79bD7h1dJMc6N4ZAlH5GvQkT+uRfNPYees0cbQNazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWLbLRLx; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46677ef6910so16848961cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 01:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734686118; x=1735290918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLetd7nVAxQOP/5NukKrvogts5apKvc1tTqPC3qKmrg=;
        b=cWLbLRLxUNYVFQfRc3J4XvJM5ck/i2bgNwdtjjcBHJ0Df70CBrNq4SXLFx2WjdlLqo
         DJ5ihEWvzNdG46QwDKl0MsdAJ40/AQ0dj633a3oOQKa/4gCpO4N8TtoHRkdYdX4i5lZE
         e1ntkRWe4i9Qlhqw4LHehdIqsDksEYn6yj7NI9k8WylJbEZcBfJ9gGIM5mDBhT2ywjW0
         f3tdSf6NzQ5hWyX/J58FEdkETHjzRRer6BDvoMMReNytrkmimAjSyFatGw+7IvxU0gHc
         GikFFvWWanpqrZx168BeQAL0N0b0g48hSuDVAzQ47GYnpPhWczALuxhf4870bQWbFsYn
         CDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734686118; x=1735290918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLetd7nVAxQOP/5NukKrvogts5apKvc1tTqPC3qKmrg=;
        b=tT1tooiZbmqoa/7IbjL0FlqlEvyRaqew7Tx4MDdUWL2rfbubVm5CEXyjX7PpSFVVA3
         2sj2fE/pedPJw5Vm2HT4nSlRn9vlBvpvOc8l86tzLhT8SB5djMFwKDEHF17nNuZXY+zg
         pIhhg+7l0UoUX2fbUoA44U+hUQ7HhZdAsuhw5vc3n81rM+X8lIa22CHaknDRsNi1p++q
         1NnKBpG9p/AeFj9nuc1BTRLlTBEJX4q//dLFj1mR558auHf03DVYeQt3Cvx8ZkXzMkpa
         r1V9Zb6yR7uG6pz5XlZ+sR25bV46JGwhCFUGI7xkdiH35HsHTNOHTvNmHzc1ZXKNYTne
         8Alg==
X-Forwarded-Encrypted: i=1; AJvYcCW1zYmxN8456fBPx1cPdyLro2oAezXoq/2NsMtEwVVojmCRBqvETddeCkM3vksAKaW1UghnqMzHNfcB0I3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OgyeaPwH6u2/CxHXmNWgawBS0EtQHJzgpmmzVnJlynqyguF4
	/e2g5mPnbJvRxOPUlg5wHwnDRu74C6e7Dw+/6V9Cfxp7CqFPqiM+bHUSMgcOtST4+jTQ8HkxQ4v
	EFDLYdrpdXO2Hx0GypGtYyYpxhpdHQY09fyko
X-Gm-Gg: ASbGnctjNKZK8LAygV+LtMK6vdcNusLIl56lhzs6y9pQcNKI+N2pIF+FRTxnse9Oj45
	Tzuf2ktCGSQ9ziMZe0HoUjLldxKo9/vQooYspUu+GuaEizNlfQymVvBy5zW77af4IHAkd15c=
X-Google-Smtp-Source: AGHT+IHbqklK1pSTmIW831w6oAdLhJYtp1HjS6HeZzZ/1mmVAAXvEHRnXziEYR94uU6VDefdz0BCkAa8wLSLmYVFNUE=
X-Received: by 2002:a05:6214:4188:b0:6d8:9002:bdd4 with SMTP id
 6a1803df08f44-6dd23358724mr35457356d6.28.1734686118302; Fri, 20 Dec 2024
 01:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AFMAUQCEIuMrCuBcOuRJwqrY.1.1734682065298.Hmail.3014218099@tju.edu.cn>
In-Reply-To: <AFMAUQCEIuMrCuBcOuRJwqrY.1.1734682065298.Hmail.3014218099@tju.edu.cn>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 20 Dec 2024 10:14:41 +0100
Message-ID: <CAG_fn=ULq8ZY_PtZO96ADVHTAVEr1LyTp+XHYOtiBFmn6EewbA@mail.gmail.com>
Subject: Re: Kernel Bug: "KASAN: slab-out-of-bounds Read in jfs_readdir"
To: Haichi Wang <wanghaichi@tju.edu.cn>
Cc: paulmck@kernel.org, rientjes@google.com, josh@joshtriplett.org, 
	dvyukov@google.com, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, andreyknvl@gmail.com, peterz@infradead.org, 
	jfs-discussion@lists.sourceforge.net, bp@alien8.de, linux-mm@kvack.org, 
	cl@linux.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com, 
	jiangshanlai@gmail.com, viro@zeniv.linux.org.uk, kasan-dev@googlegroups.com, 
	mingo@redhat.com, tglx@linutronix.de, luto@kernel.org, 
	neeraj.upadhyay@kernel.org, urezki@gmail.com, roman.gushchin@linux.dev, 
	vbabka@suse.cz, linux-kernel@vger.kernel.org, jack@suse.cz, 
	rcu@vger.kernel.org, boqun.feng@gmail.com, x86@kernel.org, 
	frederic@kernel.org, vincenzo.frascino@arm.com, rostedt@goodmis.org, 
	42.hyeyoo@gmail.com, shaggy@kernel.org, penberg@kernel.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, brauner@kernel.org, 
	qiang.zhang1211@gmail.com, ryabinin.a.a@gmail.com, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 9:07=E2=80=AFAM Haichi Wang <wanghaichi@tju.edu.cn>=
 wrote:
>
> Dear Linux maintainers and reviewers:
>
> We are reporting a Linux kernel bug titled **KASAN: slab-out-of-bounds Re=
ad in jfs_readdir**, discovered using a modified version of Syzkaller.
>

Hello Haichi,

Unfortunately right now the bug is not actionable, because one needs
to download 180Mb of archives just to look at it and decide whether
they know anything about it or not.
Could you at least post the symbolized KASAN report?

