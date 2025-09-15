Return-Path: <linux-fsdevel+bounces-61465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B7DB5880E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B734581C9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EA2853F9;
	Mon, 15 Sep 2025 23:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PhCobLao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9792C11CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977869; cv=none; b=d+EqlDAQ50ZWQNBL9KIf3pfdkKKTo0wpczOrWN0Xuj/ssc6RzpDYe53a9to2lggaO14uTJJMT3FeEMKkXVicXJjze4dGH5IPnGB2BRRhxhyqI8jaktXZfrAnXTiAuI4PF/IqLxM7DF94B3IgRGJLTq85YF9k8icYakkNGpyiCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977869; c=relaxed/simple;
	bh=yCf7pdssRjrTw8YwfJN/Luc4l85IOtsGpURxNehXsC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDqJ6u2WLky914I5PThS5OoY2W73aZvUaYUFMwT9ellOtGi9FId1HKzO6b/1HX0kKWfLsFekJwxTIL/Llh66Zq63mbKDBpw3BVhxHMCMJzlpdPhTHuWL4NlNwNpK8DuBv/uqJH0ywDAc29ONLIV6Jw+a2y3vAhwzVtnJqmtuCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PhCobLao; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-265f460ae7bso77445ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977867; x=1758582667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsKsrMGZGN6//cTNQ+8/HyCAfqvHtLWhWR4uwDDiSCM=;
        b=PhCobLaoxda2DRQRlts3OtzFxxEFjUMzFfsh9gDOplybwM7WGJ8sjvwbG9pk69WMRq
         P7gDpreGwLJi+ReyyF7mNDKo1dltxo7oHrNSw5hKQ9X06ZE/e1E++FllF4jPJ5vQ8sfg
         3ZePUM3vXifrZim6K8u6PhJ0YH31YOUnnzH23VsN8m9aPsrDpdqN0ipCZLcoWbkQFLss
         TfqBmtRHZBZwizIyEvfPWfB6LSZC24nAlhuhVx6phFg9py7I/VGeW6cIFgaTdBYyjjCa
         tfxoj1icZCV80HA/mw/xprWBVRYy0eWcvAfrBNkT/1dtgPvQo5FqIL3Gyr3zO3xTNqSi
         U1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977867; x=1758582667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsKsrMGZGN6//cTNQ+8/HyCAfqvHtLWhWR4uwDDiSCM=;
        b=ZB4bK1xoBhmmDo/51eOQRvmiieLAyrOC4B805hpeoZRVR3lnZxyAD41LqLoWzC447i
         eSe1cyXhdJTWt2dNDKwW20YkWp3oaz9oOxw4D7gOf+Covj6NwnoPUgN5zpahgV+avHWZ
         2aIaghHb1rpsPvIXI08rPyoA69SroXw/B3vwXXWlThQriIoUY9WhfC2cTNTtadmE5kpH
         EFhVHMi6657DrnmBvllXxGmssUB2JmxdMbfG07nAXNOFQ7HIh3GZCD9KKQGquT39/iSi
         nMaXFAfsb3E4aXrv01jWgKHMzQu8txikmuuYLCdvh4fCMfWub6HrJ/l12KDuuDzy+vFJ
         +evg==
X-Forwarded-Encrypted: i=1; AJvYcCUL8hMYqdNK+Qua2urPAPWUIJXIHKf3cFD7D22JYXUFwfJgbOCdY/3ixKi2Gxs0ZFhDcnDqx+ub8/yju2eb@vger.kernel.org
X-Gm-Message-State: AOJu0YxZz5n8yyf2RhiCz4Khu7xSKNZ9tKCeYkX+zOPDJEm51+jG3Smc
	LjA7Dew4AQC5t/uhm5F3fLr6PukyCFbo3iudBXwQ5vichMct0x7YjCJLFjA2qGSXKW/mT/Wbtn3
	9bfKl9wZh7W7udaAZwgaRewXk2bfnuxNJlEnKJJWB
X-Gm-Gg: ASbGncvHdl0HrYTIgAukicAePUJAJpaodj4ALr24M+f6NwpJNwnD3bXhPuCNTVSqi/E
	EaPtRjTdmJnrTEkFJ3to88v9Y4f3Ef9+nkw4P3fL6s2ZOyd1bK0TMXMYeLjDfCbmUWf99IQy1o3
	2YuFSicIiMNTC2C56WCWXnQLIf8DzGRFN1InrD876/H2PIXFkPf+NL4e/VnnvMG0t5Ft8rueLrI
	VdHBkZ5/i5YiCFvXodMolXi5s1vaIw41Fax7mV1cTdKknSayClfRvI=
X-Google-Smtp-Source: AGHT+IEkitpGEz8BMKWmLGPZ3W85vqrSP9MG29lIbMnJb9upndiATYfQPV08S+weYTCqY9YvT87o5wWIohG6pp/8rq4=
X-Received: by 2002:a17:903:181:b0:246:a8ac:1a36 with SMTP id
 d9443c01a7336-267c1903062mr2169965ad.2.1757977867063; Mon, 15 Sep 2025
 16:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com> <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
In-Reply-To: <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 15 Sep 2025 16:10:55 -0700
X-Gm-Features: Ac12FXwVYGcBZT9d6NPCct-EK04uGWSzFyRbMpRKe55ZXQp9Zltcw49n-TJl9YM
Message-ID: <CAC_TJvd=zwhRZcXTvDPfuzdjYV7j_jvZKZ--eKDRTsE+LBmASA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Andrew Morton <akpm@linux-foundation.org>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 09:36:31 -0700 Kalesh Singh <kaleshsingh@google.com> =
wrote:
>
> > Hi all,
> >
> > This is v2 to the VMA count patch I previously posted at:
> >
> > https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.c=
om/
> >
> >
> > I've split it into multiple patches to address the feedback.
> >
> > The main changes in v2 are:
> >
> > - Use a capacity-based check for VMA count limit, per Lorenzo.
> > - Rename map_count to vma_count, per David.
> > - Add assertions for exceeding the limit, per Pedro.
> > - Add tests for max_vma_count, per Liam.
> > - Emit a trace event for failure due to insufficient capacity for
> >   observability
> >
> > Tested on x86_64 and arm64:
> >
> > - Build test:
> >     - allyesconfig for rename
> >
> > - Selftests:
> >       cd tools/testing/selftests/mm && \
> >           make && \
> >           ./run_vmtests.sh -t max_vma_count
> >
> >        (With trace_max_vma_count_exceeded enabled)
> >
> > - vma tests:
> >       cd tools/testing/vma && \
> >           make && \
> >         ./vma
>
> fwiw, there's nothing in the above which is usable in a [0/N] overview.
>
> While useful, the "what changed since the previous version" info isn't
> a suitable thing to carry in the permanent kernel record - it's
> short-term treansient stuff, not helpful to someone who is looking at
> the patchset in 2029.
>
> Similarly, the "how it was tested" material is also useful, but it
> becomes irrelevant as soon as the code hits linux-next and mainline.

Hi Andrew,

Thanks for the feedback. Do you mean the cover letter was not needed
in this case or that it lacked enough context?

>
>
> Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> feeling a need to slow things down for additional stabilization and so
> people hopefully get additional bandwidth to digest the material we've
> added this far.  So I think I'll just cherrypick [1/7] for now.  A
> great flood of positive review activity would probably make me revisit
> that ;)
>

I understand, yes 1/7 is all we need for now, since it prevents an
unrecoverable situation where we get over the limit and cannot recover
as munmap() will then always fail.

Thanks,
Kalesh

