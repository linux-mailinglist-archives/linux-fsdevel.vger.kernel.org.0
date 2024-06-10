Return-Path: <linux-fsdevel+bounces-21365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4143A902C29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC09E1F232AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223EC1514F6;
	Mon, 10 Jun 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPHqPPzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9717545;
	Mon, 10 Jun 2024 23:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060508; cv=none; b=ckhifRV77swfR9hBzi3Ec7WzqH8bUtuaJYthL1nV2kcwCJH85FYuAd1pNPvplv4QA9pUrpebWyjB1kfMql0DsESsLXlL0GY6Q/FUIFtp/onCtsWAWVJBKgPlkce7JxbnJspX0vZLmH1+uSVwbDZa1EfkVDo3qwCfqG4CAPMnO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060508; c=relaxed/simple;
	bh=ls7HTQ+/jbzpvqw5yh4Yy1Cb/Btht+DdhN/vrACOwIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgQwm4NwyjrcgkCAfTzKYYHBpxY0zSLjn9OF08xTzEYaKrMff4tF6RALinZj7qt35Hf1Sgot/jDSD2OnhpAmEtvGz60lw9NBiCK5gt5c0tqVGP2IgG45WkkM2WrJZ9fG6CLoKvy0Cc39BFKQQfgI/lHg7CGoHt8UMAS1fpKiQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPHqPPzM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-354be94c874so348980f8f.3;
        Mon, 10 Jun 2024 16:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718060505; x=1718665305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls7HTQ+/jbzpvqw5yh4Yy1Cb/Btht+DdhN/vrACOwIg=;
        b=EPHqPPzMRMtgNgc1IFkone2e2fgn5zwJresoDmHoi7KgEpiytQXHoNCYxCZ8kAyPZh
         SCQfoBiGOUueYsgcYJ+a6ALOKbOCpFvRNJlO1J1XsfclePBznS94f41SmR9M99W4Fpxt
         lVzSLppQKP0ZLggixrdEnCxPFtO2Nf7r+eHmLudL2JqjDl+PlEbfO7dftsxjZ3lktn2T
         L5oKqcb1rvY/EVn6pRMDGbAusdqSXigaYGaIDoii2MxjObru5NZLUKewakdTiJkC7k2v
         i2ac+rBejacP8iYPaejxlDzOPfDWINSXT/gt6hr/6q+XgZ5vxN//TfCmtp7STXLNm8dg
         H5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060505; x=1718665305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls7HTQ+/jbzpvqw5yh4Yy1Cb/Btht+DdhN/vrACOwIg=;
        b=jifApUcNwiCgBMNF3jjKVqKU40InEWofM9TUyC1QylAyCJ9/80ZLCYStddC1PgH1ZS
         q3RE49J28ytCIyqfdLZq/oyVN+58gSxDVOOQuYmeKT9K2g2bENkRMXJDSZFj7gpi8bJO
         8f/l8Ed3UR6ThSxKMvkgzV4ke4rpGdz4ggOGKQ/WpHcf4k4P1s1gpYAgO67PU7VeG9h4
         RFzy1+/MYm87GiWADCRj7MkhL2LIuX+6w57dGkmodA4vu4SlWB9+1jQu40q7YVY+qpOL
         jzt0XkFsoICUOJNVKPb0YtTuuBf0Gns58XEhpJxQfo5tEEI368nc5Kb8OJ5LvB9eCq1y
         z4tA==
X-Forwarded-Encrypted: i=1; AJvYcCXAwj1ns+F9X6iWGxHUd7nQA6xfsOqAn74d0LNn332J8tj0LHhNwmPgWC8AzkqXfQk/GBMdXWCkKOwaESVwbYU3dUlJQYODXyPZu/f28kDvBAOzpKyDY305E6BPEy6PjpPdvhRJ07R+56kMY4H7yeXUE69MYQwNfNANyQtRPDrKn/ufjNsV7ke8VY+zB0YbRHHvRLqfo0RWmjOHfVN7NfTPFPmGh23ZkfZYRcKo0LUlmKwHSCtB+mCJewtISdZ6Id0rYgkN4K9RjC0WwHXmEzNxxh4JyTjqKINrvZxDSA==
X-Gm-Message-State: AOJu0YxaSus8oZ5TqaFF59lXGkCOIzeYGN8sXMBDLcRvKswnmoL+wGuU
	ZQme110pQKvePi6FMXXXsWlLXgcE45/QZIYhMjUcNi9fTy24VNJeiL1Ct6cm3xpxmrjhr7LsBwy
	nDri5FVOIynAnqCaw925IvyjHheI=
X-Google-Smtp-Source: AGHT+IG9rTv9XLL+c9x3TKAtlg11qCt3Ry3LNyhJckbX7PwJtMcxvlnWL84CmLkok90u60BS/pZg9lk0L5MvUxg112g=
X-Received: by 2002:adf:fc0f:0:b0:35f:90e:a1d2 with SMTP id
 ffacd0b85a97d-35f090ea26fmr7973708f8f.9.1718060505013; Mon, 10 Jun 2024
 16:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-2-laoar.shao@gmail.com>
 <87ikysdmsi.fsf@email.froward.int.ebiederm.org> <CALOAHbAASdjLjfDv5ZH7uj=oChKE6iYnwjKFMu6oabzqfs2QUw@mail.gmail.com>
 <CAADnVQJ_RPg_xTjuO=+3G=4auZkS-t-F2WTs18rU2PbVdJVbdQ@mail.gmail.com>
 <874jabdygo.fsf@email.froward.int.ebiederm.org> <CAADnVQ+9T4n=ZhNMd57qfu2w=VqHM8Dzx-7UAAinU5MoORg63w@mail.gmail.com>
 <87ikyhrn7q.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ikyhrn7q.fsf@email.froward.int.ebiederm.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 10 Jun 2024 16:01:33 -0700
Message-ID: <CAADnVQKaHdy-KvHCejYgr8N8VNBQBjbmFDiE5mtm76GZGkOsaw@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs/exec: Drop task_lock() inside __get_task_comm()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm <linux-mm@kvack.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, audit@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>, selinux@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:34=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Sun, Jun 2, 2024 at 10:53=E2=80=AFAM Eric W. Biederman <ebiederm@xmi=
ssion.com> wrote:
> >>
> >> If you are performing lockless reads and depending upon a '\0'
> >> terminator without limiting yourself to the size of the buffer
> >> there needs to be a big fat comment as to how in the world
> >> you are guaranteed that a '\0' inside the buffer will always
> >> be found.
> >
> > I think Yafang can certainly add such a comment next to
> > __[gs]et_task_comm.
> >
> > I prefer to avoid open coding memcpy + mmemset when strscpy_pad works.
>
> Looking through the code in set_task_comm
> strscpy_pad only works when both the source and designation are aligned.
> Otherwise it performs a byte a time copy, and is most definitely
> susceptible to the race I observed.

Byte copy doesn't have an issue either.
Due to padding there is always a zero there.
Worst case in the last byte. So dst buffer will be zero terminated.

