Return-Path: <linux-fsdevel+bounces-21467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0090443C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64FDB24D8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEB7E107;
	Tue, 11 Jun 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU96ngDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8A79949;
	Tue, 11 Jun 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132848; cv=none; b=F4cNw/LG4uKbmPHsu9CZ39jXaUPjSZMUxb1nwbHjY+M4Eb0SIT42TtO//il0SFLIt3J+cWJrf0lGJw5DvPC0pYQwbIYrkUPC6wXIXeZzkBqlW8Yqvwrd91pHL2g/OCmyuo4OdzCTYNN+GITqbzkUuvzI2hJ7Rm93RHRYpCmt2f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132848; c=relaxed/simple;
	bh=BAGG3VCL2e20GdafQcA5iNGAhlFA6kUCqwP0LAl0kbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlrQB3KLmcef00Cp9s6+izD9gjruyO1szxPE1uZ+4yV+Wfvq84knFMzNKxFwaifd9ub3QQyJ/9bXbt7/o7KgARWpYvkrn3e0TbytiXk0A/7I/6HCWwfAhDCYVOX5suRil7dH8y3+0YQGdzxpbQNNS2eY7RbTNrhesd8+Pvijkxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU96ngDd; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso8828633a12.3;
        Tue, 11 Jun 2024 12:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718132845; x=1718737645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAGG3VCL2e20GdafQcA5iNGAhlFA6kUCqwP0LAl0kbw=;
        b=OU96ngDdM4IKogfRmn8zwJBhltdfjVMytAIu1dwVmaf48TfZ4ZLFq4P/PfBV+wuDKO
         Q4T43j55RAi5/4QNRBj13lecH5Pa5xMlNHCnMINmwc+rYkpC8SmHJSW8CVyK2k6u23+g
         CRcKNk1o7pjeJKJp6ubR0lVpnaqR+xCycZSYMztHRVOE0ZIEZtHjmorPtWy7dkChxLMW
         7H/NV9Bfo+VR0erGo1ZFVycJ9fNcVDzgjvPRJFzsSSz7yjLDIZP8jLM6wXYDPFhWHTae
         p3eNv/vuczPy7NZLzxk4Gtuk0xzeHhum70bJ4EjbCjqJAkxvYRb2QcqUtsPSVu5F1QI6
         paCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718132845; x=1718737645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAGG3VCL2e20GdafQcA5iNGAhlFA6kUCqwP0LAl0kbw=;
        b=aQI66mfjhw/pdvs4b4lkxpMTY59O6u02N/KlfWYAc3LaPiVg1xAZl4a419jjbavjbZ
         p79qxFuaV6E5QJGMmzN0DoXYIh+PWpgHbSt1GMHmMMTo+iHDkX9FnHgC5k95Doesn3Ug
         XiYkwKJ5hjrYYNqyiX0Pgq8KoMyOtW8p2e8zw4w+TXWuha+R832LJY7ydtJ8s3WlGVI+
         KcR5wSi7jzQNdgbaVjTnAk3SGOwPRX+txe0J5Ad3YvHCM8yWI8Ty92wxClyGRlmDm14M
         etR1SfC5WlnViPgc4eg6lSD3qoEEO64sZ/oUMXepm5nOcRvjVvGE21gcI6nENRXeQLYw
         nLug==
X-Forwarded-Encrypted: i=1; AJvYcCWpyTJwYJFjfrobmZwUTXk3+T+MH9F60n9J60sp2H4jC5NHLJdbxBch/x49hB26fFRckWXZJ6KCWxWxieAGk4p92sivV4fr8tv7AoXDu8bSyAhs2n2X4eRKjqczwAJXNHNPn/HRAO3Fe/oNlQ==
X-Gm-Message-State: AOJu0Yyd8GA+KGhenTkxsYPdVIM+rVgw5omzgLHmMcce7jYmPYXgBxni
	ChY/xpCjAcAiVWcxBqOO/UBDe1SBMicM+8LPkQ+3X1trp9sQW5elS1u8OTiDuRJtuZPvh/S1wsd
	ZwloMjgy/AzXnsnPwqSnZXZyVK5U=
X-Google-Smtp-Source: AGHT+IG5CPRrnHucL8oWwiZ6MhGtXUPOFRXbCBj7P25quScF3LydnZxIjbq+2Z48TvRhccxXJO2Ru/nhBvw2aA0hcWI=
X-Received: by 2002:a50:9518:0:b0:57c:7471:a0dd with SMTP id
 4fb4d7f45d1cf-57c7471a13bmr5306450a12.12.1718132845076; Tue, 11 Jun 2024
 12:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jykEwNO-fsyWFayF7f+ZNd86ZN2fm6DD+tQox7+4oSXSw@mail.gmail.com>
In-Reply-To: <CAJg=8jykEwNO-fsyWFayF7f+ZNd86ZN2fm6DD+tQox7+4oSXSw@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 11 Jun 2024 12:07:14 -0700
Message-ID: <CAJg=8jz6BSMAGfoVYSEPVD8XMf86niJ-tr=v-P98SOebwHwpQg@mail.gmail.com>
Subject: Re: WARNING in __brelse
To: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: harrisonmichaelgreen@gmail.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Please excuse us for forgetting to attach the following information to
the previous email.

This bug seems to be related to a bug previously found by syzbot
(https://syzkaller.appspot.com/bug?extid=7902cd7684bc35306224)
and fixed (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c791730f2554a9ebb8f18df9368dc27d4ebc38c2).
The fixing commit is present in the kernel version that we analyzed,
yet the reproducer is still able to trigger the bug.

I hope this information helps in further debugging this issue!

Best,
Marius

