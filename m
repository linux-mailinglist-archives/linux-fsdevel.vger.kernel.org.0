Return-Path: <linux-fsdevel+bounces-27707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27079636C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023791C21141
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA4C8E9;
	Thu, 29 Aug 2024 00:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7q2uKup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897212B73;
	Thu, 29 Aug 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890676; cv=none; b=sd/h1hYIBobj7RWJvgqx+T94TgNNzBAL4rtOE8iGCc3bYQVPnIMU6JjePjbmyj4I3v8Vc5wufbut5eLOgDFYSXqEdW+BsvsRtezXenweAXp42r+xbP1C9tdhtvwUyKOS9E5UZTrVdw17P0Lq9iV+urZ6JBG/vaiFi1fcXlJVFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890676; c=relaxed/simple;
	bh=wqwfbglmiOW3zEjrozGHbRY21H9OrGw1J7tCUk4qVjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP/9xmiK9tj0vtuh8LUMZI5X/zTJpN7h/b2cKzLMUr0Jt5oFv97Xs3VKCGD3dmGe/5ravgj2isvyy7X4KaVKea1LQEZb3tGBnpySRo7UKki0d4tpywUEkTEljcNupr+weZ99YHUStMLGs2tuPt7t1RC4CC1O82PA2rTTFOd+r9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7q2uKup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5D1C4CEC0;
	Thu, 29 Aug 2024 00:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724890675;
	bh=wqwfbglmiOW3zEjrozGHbRY21H9OrGw1J7tCUk4qVjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7q2uKupXiWrXEb5VBisQRcVpWz1lLcSeE7zINvaSJm8aB8JKzaa1Qlj4qvHMl9T/
	 mB0q0BY6SVtNcYAr1aQd4hYDHFHib8zZ9wUNt5pkZkagn7QUYxvdthCYydJEcS6isS
	 EIaBZgHBZegmK+8STHem6es+CstqnY94jKsuJoGG9Eu4OXFZpHJMWmXP/XUZReh9Ty
	 SwdIv0b0X/rYgMw8zApCJK8AIPIiB13V8lLrSIAOdunytxsuwfeR+sQxj1xQwuY7Db
	 UT7C88ojT+76hQqBGXasE9vK2f5kOA2shjJvfoKnyQ6Bq2qrQ6C6FSIanWfsDiAHqV
	 G4c5NZzYW7RGA==
Date: Wed, 28 Aug 2024 17:17:55 -0700
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, justinstitt@google.com,
	ebiederm@xmission.com, alexei.starovoitov@gmail.com,
	rostedt@goodmis.org, catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matus Jokay <matus.jokay@stuba.sk>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
Message-ID: <202408281712.F78440FF@keescook>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
 <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
 <CALOAHbBAYHjDnKBVw63B8JBFc6U-2RNUX9L=ryA2Gbz7nnJfsQ@mail.gmail.com>
 <7839453E-CA06-430A-A198-92EB906F94D9@kernel.org>
 <ynrircglkinhherehtjz7woq55te55y4ol4rtxhfh75pvle3d5@uxp5esxt4slq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ynrircglkinhherehtjz7woq55te55y4ol4rtxhfh75pvle3d5@uxp5esxt4slq>

On Wed, Aug 28, 2024 at 05:09:08PM +0200, Alejandro Colomar wrote:
> Hi Kees,
> 
> On Wed, Aug 28, 2024 at 06:48:39AM GMT, Kees Cook wrote:
> 
> [...]
> 
> > >Thank you for your suggestion. How does the following commit log look
> > >to you? Does it meet your expectations?
> > >
> > >    string: Use ARRAY_SIZE() in strscpy()
> > >
> > >    We can use ARRAY_SIZE() instead to clarify that they are regular characters.
> > >
> > >    Co-developed-by: Alejandro Colomar <alx@kernel.org>
> > >    Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > >    Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > >
> > >diff --git a/arch/um/include/shared/user.h b/arch/um/include/shared/user.h
> > >index bbab79c0c074..07216996e3a9 100644
> > >--- a/arch/um/include/shared/user.h
> > >+++ b/arch/um/include/shared/user.h
> > >@@ -14,7 +14,7 @@
> > >  * copying too much infrastructure for my taste, so userspace files
> > >  * get less checking than kernel files.
> > >  */
> > >-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > >+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + __must_be_array(x))
> > >
> > > /* This is to get size_t and NULL */
> > > #ifndef __UM_HOST__
> > >@@ -60,7 +60,7 @@ static inline void print_hex_dump(const char *level,
> > >const char *prefix_str,
> > > extern int in_aton(char *str);
> > > extern size_t strlcat(char *, const char *, size_t);
> > > extern size_t sized_strscpy(char *, const char *, size_t);
> > >-#define strscpy(dst, src)      sized_strscpy(dst, src, sizeof(dst))
> > >+#define strscpy(dst, src)      sized_strscpy(dst, src, ARRAY_SIZE(dst))
> > 
> > Uh, but why? strscpy() copies bytes, not array elements. Using sizeof() is already correct and using ARRAY_SIZE() could lead to unexpectedly small counts (in admittedly odd situations).
> > 
> > What is the problem you're trying to solve here?
> 
> I suggested that here:
> <https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq/>
> 
> There, you'll find the rationale (and also for avoiding the _pad calls
> where not necessary --I ignore if it's necessary here--).

Right, so we only use byte strings for strscpy(), so sizeof() is
sufficient. There's no technical need to switch to ARRAY_SIZE(), and I'd
like to minimize any changes to such core APIs without a good reason.

And for the _pad change, we are also doing strncpy() replacement via
case-by-case analysis, but with a common function like get_task_comm(),
I don't want to change the behavior without a complete audit of the
padding needs of every caller. Since that's rather a lot for this series,
I'd rather we just leave the existing behavior as-is, and if padding
removal is wanted after that, we can do it on a case-by-case basis then.

-Kees

-- 
Kees Cook

