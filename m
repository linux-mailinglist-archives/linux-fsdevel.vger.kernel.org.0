Return-Path: <linux-fsdevel+bounces-29899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9D97F139
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D731E1C20CB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBCB1A01BF;
	Mon, 23 Sep 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q+OfNknT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985D1CA84
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120196; cv=none; b=DOWXhKCnv12UlyAIJ1exnvsuwPb4A2AhccIhS47h5rbHFSZ43F4Hwi62eeBC4QXP3Wxlw7KTedCMF/BWuZq2xt2HJETkkEY6F4LGFMRix7lYJ8LNlbTe29meNwTn1ZN+sIKqGzoZVbJiOa3c6OSvl3B7RFD/AsdOXPDG+sSr9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120196; c=relaxed/simple;
	bh=kv4Ft879Fi+umHg4uh2vnPEnmHVuK5xmThu/6lqTC7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuyANBBIHmwTbcKZ16MOqsC4v0M/32oOhr/jkvprYbbRLq2lUUB4suaR1d4zdqKK9kLQUp/DAch6fa+hoQd2KBweUWwC5Y0yPY9/lHgljs3KjtNide42r3XYJnGKu+9Xjr8r8v5biW3U4r9oX7bFz3M5VleF5439FEmFVDWZBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q+OfNknT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d24f98215so637642366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727120193; x=1727724993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EisBpG748oQOOKzccw2NRkqTUbCtVi6yqtP1A4psMzU=;
        b=Q+OfNknTSzZTpkW0uw0YDOYkz++BAnsPG0R0m9r/bc/3QQkpA/HcZ09JmThaTu10LA
         0kkt6sX5xNcwvn2PmBzOixU5nGPUEdTV7dyp+0bXLpN3LHiPHkrRtYbEj9sSIKMuKRg6
         kLaxWrLbUCKHDVv8LOoJdAm+L1EQ01eZcrYaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727120193; x=1727724993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EisBpG748oQOOKzccw2NRkqTUbCtVi6yqtP1A4psMzU=;
        b=FrcboY4JfK0oJLHiY6I9dtz2ndPsW+uwnaTdujqSvD/4Y5OZ0jAVssnB2DF1wZnZsO
         ET2TQa7+AeLUKCjwtHyPuWIZjgftn8c0ZdYH/hPyJaP6lyAh6qvC4d/1IkRnHe9RKMDo
         cx357N+3OGyvdKXXZ5qW+4CAKvoVV66eUYaTPxV2mcg5P1j3bW6BWlGsy8xdgaqBOS5f
         sdSamjHHEvkYihtax9FdmGYduBOgymcYI1bbCP494w5sgSsJDNa8V0QxU4aUZ2Evgcnq
         VACsBTtt8f2c0rwsLQCuU+QIXDmX9+DN9+JvUTJlH+9U9rEW86W9GEHVb09YQfrZ9YQT
         SqZA==
X-Forwarded-Encrypted: i=1; AJvYcCVQyBl8P+wJTL32Y0My+A11ryu7/K17kdVjBwVHWJ1azhZSrOs4kWu2WiKEzEq5APy8WY5V4v6oz3dJ9QBc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9JPqfvo5EaIfB110SOLgbCHDAFFPxWnDpJlS9qagR9mSO+ip2
	OwtPbJkypH/QBGEjaMYiU1LQpUg0jf6n5Gx3HTHM7kP3iSlbJCqdG1TnkbOgcryx6QS4v3VBO2+
	7UknM7Q==
X-Google-Smtp-Source: AGHT+IEF0cWHVu2e32BYLM296lqbaHWN+mf7gZW6sejxnH5NRdQwon7jqTQBerhLEipRO/D8KNCOGQ==
X-Received: by 2002:a17:907:3f19:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a90d4fbc6a1mr1486784366b.13.1727120192760;
        Mon, 23 Sep 2024 12:36:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096784sm1268727266b.1.2024.09.23.12.36.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 12:36:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d446adf6eso739368166b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 12:36:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjJno5DilZrRH25jala2GQLjtFpmybueXWDeiB5AZBpWASACxYn8rl2e0FkkUFNpB3m+UbtUSeEj1/KmrP@vger.kernel.org
X-Received: by 2002:a17:907:e65b:b0:a8d:c3b:b16 with SMTP id
 a640c23a62f3a-a90d4ffaf60mr1082820266b.28.1727120190738; Mon, 23 Sep 2024
 12:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923110348.tbwihs42dxxltabc@quack3> <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3>
In-Reply-To: <20240923191322.3jbkvwqzxvopt3kb@quack3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 12:36:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
Message-ID: <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 12:13, Jan Kara <jack@suse.cz> wrote:
>
> Sure, the details are in some of the commit messages but you're right I
> should have summarized them in the pull request as well:

So I really only looked at the parts I know - the VM side, and
honestly, I threw up in my mouth a bit there.

Do we really want to call that horrific fsnotify path for the case
where we already have the page cached? This is a fairly critical
fastpath, and not giving out page cache pages means that now you are
literally violating mmap coherency.

If the aim is to fill in caches on first access, then if we already
have a page cache page, it's by definition not first access any more!

So I *really* don't like the VM side of this. That's what then made me
go look for permission code, and since I don't know the fsnotify code
very well, I didn't find it.

               Linus

