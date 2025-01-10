Return-Path: <linux-fsdevel+bounces-38800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1FDA085C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 04:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFA43A908C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F501FECA5;
	Fri, 10 Jan 2025 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iIaR3zQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D991A4F1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736478729; cv=none; b=ZA5JGPVPRhNfjENz/MY3FvBZ6mYhuGumoHiTXcAySgKHg2JEr2GjKKnb966Wlhtki03AoszBVyPwgRZpFvYhwTccBhIA/m18O+15ndbi977tZKMj5xsfhE4OosTHAjgFyXRYzwjHEMvFPbkdYX8Hs2WIjZehQyQI6PR21DFMfXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736478729; c=relaxed/simple;
	bh=D18utRlVGGzPCuWewtrj5krIU9bJrmplcMeXiRT1+TY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZKOSJRX+MF0ccKOCZjNK79tQdN0ZngJ/EHBR0bN3Xw5UTh6yRpmJovaGkULOcum7YPqm0s2cvRo8ncVWX5I2Y0zCYHxUmxf9X7PzHVcrkSrznVVVb5gisxD5Boi0hZpmwgIMnwijroM+DWeRnmPEULBI5tRF7O32uLwLksepUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iIaR3zQr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d88c355e0dso2651832a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 19:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736478726; x=1737083526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1QMtuuDrMek+cqp6TB29HWYKAOWii4BW9zvMrbHJAk=;
        b=iIaR3zQr9AEjbZm4QgIkpIovhvlGfB/Pvp7eIl4rhPekf8k+6cNzGuD1i91pyFqPHt
         rosrpVTUU4L4xFDsln+TO5MwcnFgobiUJGZLLgFtIcKt/xir8KOfpZ9CCwY2hRSIcW02
         zY2cgbU/6w1qu+h0RNS6PpYETzIxO0+Lw8nGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736478726; x=1737083526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1QMtuuDrMek+cqp6TB29HWYKAOWii4BW9zvMrbHJAk=;
        b=bAbrGp4kl73OhHrEUqVlRuH6g8/JjIjyoJO1eH4c3/VPPFVU8hG30c5vjvA7QCI7e7
         zwm3lU3QmNioktl08VCKAbUEuWAEj3B3eMVvQqTGTuinAAJl6SrYB1NJkUqN8Hik6p/6
         LPkNrLD5SoSOtNgNg2WCjSGKIhxt2Ccp2A35DAHqjYDNNBf2ioz7rIquMyVjekeAALmI
         flS7KGx+FbJk6N38ys+pHYs2LxpLDZ5AWMBVvMQALQcvRCQ3nc1sJbGdekorhiEtn1Ax
         h2hHBi4GlgeoxEVPpUSbQAx0luMQ/NbOuZjs60Rr84AN1LJbohi3rOOrjtdrCMEMjVgQ
         L8Qg==
X-Gm-Message-State: AOJu0Yw3+q1ojT4zexeJy3bozVxMqeOjc0bk9EGzAD67EilDaw/Lx3+t
	IJcsJP2vm6lK6MG86/2nbbGnqg/x1zfwognjE6qldlARAIw0A+0f9IPxzTQj+HO5UPSjT49A9S7
	rBHUiyg==
X-Gm-Gg: ASbGncvUk7aMM/i2vJzY2BFmnczaeFAaomZfP96v8ZivQGFu+ZuJLzkVO6rxvMPBxRM
	2yrEUzwUCLqHutq2TpcG0iF0Uzqf9p2o7huU4QaHbK8yOgP+KlFWg+3m5XyF0/Erh4B+ysGsj6U
	9vZjgXycLPAF4Kl9zPuMcwpcSRA2i1lUADwt7Rhj3MvCmoglNrAqwxyuaxUrSbH46hP4y2wPssI
	/92zwMT+YNblI35loLHD5UjQkntNmcn+EfBQBst8nZqlAvHrVF0ohcxbBUmhSX5jiustw81KqX7
	L/iyqg/EFEcZwM2C3kAIhA9VP2Qxn2Y=
X-Google-Smtp-Source: AGHT+IGzRrqYbSvplOqoDDLDrSL0B15AENBIh81ujcIRxkllGlZqRgWtbhrc2WtGjrGRyqFo4JHnYQ==
X-Received: by 2002:a05:6402:34c8:b0:5d9:701c:85ac with SMTP id 4fb4d7f45d1cf-5d972e0e24fmr7748704a12.10.1736478726117;
        Thu, 09 Jan 2025 19:12:06 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c3328sm1186782a12.50.2025.01.09.19.12.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 19:12:04 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa689a37dd4so293090666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 19:12:04 -0800 (PST)
X-Received: by 2002:a17:907:7f24:b0:aa6:5eae:7ece with SMTP id
 a640c23a62f3a-ab2abc93e22mr778679366b.43.1736478723770; Thu, 09 Jan 2025
 19:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110023854.GS1977892@ZenIV> <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
 <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
In-Reply-To: <20250110024303.4157645-20-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Jan 2025 19:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
X-Gm-Features: AbW1kvZaQx4RZA3DoPNnn7ySYeCUxXnMhPsF3e4Ed8oCi4wmKUNd_tb4o7KrlrQ
Message-ID: <CAHk-=wh2i3j3GUYpiTBteS7Ln02endudZCqc9DRz==3p8T__yQ@mail.gmail.com>
Subject: Re: [PATCH 20/20] 9p: fix ->rename_sem exclusion
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com, 
	brauner@kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	hubcap@omnibond.com, jack@suse.cz, krisman@kernel.org, 
	linux-nfs@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jan 2025 at 18:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> However, to reduce dentry_operations bloat, let's add one method instead -
> ->d_want_unalias(alias, true) instead of ->d_unalias_trylock(alias) and
> ->d_want_unalias(alias, false) instead of ->d_unalias_unlock(alias).

Ugh.

So of all the patches, this is the one that I hate.

I absolutely detest interfaces with random true/false arguments, and
when it is about locking, the "detest" becomes something even darker
and more visceral.

I think it would be a lot better as separate ops, considering that

 (a) we'll probably have only one or two actual users, so it's not
like it complicates things on that side

 (b) we don't have *that* many "struct dentry_operations" structures:
I think they are all statically generated constant structures
(typically one or two per filesystem), so it's not like we're saving
memory by merging those pointers into one.

Please?

           Linus

