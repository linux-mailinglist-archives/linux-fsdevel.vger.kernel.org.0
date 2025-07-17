Return-Path: <linux-fsdevel+bounces-55200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD7B0827F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 03:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D47117D43C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3F1E0083;
	Thu, 17 Jul 2025 01:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxxRZTSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA519AD5C
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716297; cv=none; b=FaSa6xOiiE3I64xBb0dxGA/y19u/TUUtMzwdD/CI0HHsVgYElwFLb3aveRx7qKOB4EN/2YQBpdSLEYfSmqBnR7DYrewcoTnLX32RZ2TqEmrpvogd3wNXX+h05dUb7gWaFEnVYEyGBGdHHLbzgRlY5JMpHp50B+Gu96IMAPsO7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716297; c=relaxed/simple;
	bh=XEl9xWdkm001s4BWnfLogzuaUUgUnWcQGefbm9+v6Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwlaZ8XmumP3xojlDeONinb8cgIG+icdx1ou7jGmhO8+eRqRt5lGioqIOICNQVC8yPp2xcK5/sSaHCHW0hqN/rzpPysA2urw7EcxnfhdhD/Yhl4IwM/7AOINlwVO3YT2cb7XuqZVlZg1NYpnb9txX/G5sz6DjgGbRwnaT19T1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxxRZTSX; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4aaf43cbbdcso51381cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 18:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752716295; x=1753321095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=OxxRZTSXtTD9FlCZefwGZvtN6zgTd/mAAiQ9U9Mo/GrseOIKTaNUvUz8B0epqcT0iB
         QzmkABZYq33cQD3Psg9WEmpue9OKSgCv6zkuSsv3+1HFIxJ228ZUvuuqWCe5gCsHGI3n
         hrKYRiD8GDocH6Ivg/ge/qeKQnVkETWEcKqqSVWyoyGeiNzeDrRpu4/AmLBfvAE0RUTT
         S4yNB2zd6Fafe0q7I9Bu/jqW81nOZzXqQLaLoA9OrkhKJ1GPgIBaLlXyiWR/300MhtxX
         wOBWdEzAX9m4DcqUwniHM0LkSwm1XXsUpFQt/oqIUSaVMf+12uyghXdG2Fd6opuF9vlw
         Xvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716295; x=1753321095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHi1gfOxjmldjSqGVDMu9tqxYC0kWW1LbdeHYepUyWU=;
        b=FahTegZEA943XMal6n8WVSn6vFxMjy5hjCXaF138Abe1qH6eTPEMj79mddniUzlPq2
         LlhZt+FgOxoequGfXipGIOj4UX7Ivcb7IxPtCXY5IdhfqDUut5o6K2ngl3EMlN//y96D
         9wqPBHGr2qQ8637B9SkK/WwkgETLo1XYpRQwCe+9jm/84axIpKzN5ecM0B7ctNz7OLco
         7pEfq8NHEocqE5lRr6bCWjW2BwAIhxzK3xK9kN10k4N5lc9mTw/helpLOAwLB/NnaJQ/
         e8ysNh573k0t+L9MZZmEqFlk9ZxqQWtYWW7IIxEQtgPb6cy62Pi14wqNfjXajm6AFT2Z
         zgbA==
X-Forwarded-Encrypted: i=1; AJvYcCWozx6ripypEp1Q27WbWsz0fqvRHVdcxb2G5GOhkc3lHu/NE0dsxCoIzM7vIYOr95BsMY0HQQBAUc+OTKdd@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwy1XFGiENYTd7G/Oa7HfN2ivGZADg/8/wVs4d3zClDQl47sM
	nh9Qi15dqwzuxMtzlczGw8pQSBWkRZSAE+gXbSad5nTlcoXAoaWLSDaURYt9c6y3SfSUU77ve2B
	znBsVM6hsRG+asqWYPjb0Db50a71NQb+75YN87QQF
X-Gm-Gg: ASbGncsxR6d+ti803xQsFiVQ4+d16crmkNha20n0oiB7oR7KveAdteC2yLsMx7Vjnc7
	De9uZ73xNeWijSnYhbkVRPIAXBAimJ25yV2Sv2pEA3n09irzZo09wK4U5OoF1Nsk5WPort+4Yuj
	IrEINzKHTlmq09maW2WW1Ph1kJnZUJCiHYQ/iBlb0xaJCatUlTTGrLGDyZb4mxPGYExGrzRj7RI
	s/w6kM++jPPIueC
X-Google-Smtp-Source: AGHT+IFhiaeqzK2nQ8VSVgEqrMotFK2LCspw+YJrQhNSUfoYY0N+Vy0kgJUtxif7ZxBwweEETtv622z4tIyINzqhXvw=
X-Received: by 2002:a05:622a:a492:b0:497:75b6:e542 with SMTP id
 d75a77b69052e-4aba2bcfa11mr1814001cf.10.1752716294281; Wed, 16 Jul 2025
 18:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
In-Reply-To: <20250716155545.ad2efdd41c85d6812bf328bb@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 18:38:03 -0700
X-Gm-Features: Ac12FXxcylNiHfdNrzrYc5xn0C76o-sRxtUR8Ak1vbrrsG08KbBBjpmWceaRzxY
Message-ID: <CAJuCfpE7TAZmk+y-BC9WAYMTH31Ao1PNd9H8h=0GCLEyXygUdg@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] use per-vma locks for /proc/pid/maps reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:55=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 15 Jul 2025 20:05:49 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > This patchset switches from holding mmap_lock while reading /proc/pid/m=
aps
> > to taking per-vma locks as we walk the vma tree.
>
> Thanks, I added this v7 series to mm-new.  Which I usually push out
> mid-evening California time.

Thanks! There are some comments on the last version as well, so
unfortunately I'll have to respin and bother you again once that's
addressed but this update should at least remove the syzbot noise.

