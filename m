Return-Path: <linux-fsdevel+bounces-61808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D320B59FB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBBA4E757A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E02276022;
	Tue, 16 Sep 2025 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yn4UqOCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95424EAB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044864; cv=none; b=f6HVNJ29DKu1liKOM7hyAZR9lxJ6xeEoWMWfXF8Ty9HItN8eEBJlAqtQCoJg8zWY6HS5sZEvSDe9p4+OwIo2nCnDxllZH88jdUrkQOp5cG1AmBEt0pGUgG2IXVv8EucAZi7j3/dzpgYeeYNJ3mPYBUwSLmtlkZSn3Pn/qXXcCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044864; c=relaxed/simple;
	bh=ytYn1xpYuNF6QYhgFt/snGrQld+uXtsG0hvu+3ooxIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlE0JmXUTrLCpbhL4vXOXcMv+8bOT0R6QJVFq5t3tS7bEGebgcVY7XFGKN9X8vfyhzqsA7jxth4ooXEqSIw2yDDLhxDiRUaq/XJ8IfFMR/O87/nZYMTm2bWOhUVsXjAQhpBFfXxdzBaipZ2v5otiOHrfMmCsQCqm4gBVFs9kFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yn4UqOCD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-265f460ae7bso17735ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758044862; x=1758649662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV8PZeNRScOuv4YluUBiR/tynYHUDyQLkirKhaJTO4E=;
        b=yn4UqOCDODnVitMhzAl57ZXsqmfdq8kJeuYTM4TJSvaRPMTvIvO6vSdvogM+lYPZFc
         gzFt03tFDWVO3K9mvVicpVqc+MweUd1VRzVMK5FH03r8tU3On2XkiaO+7ac6H3bmfFHb
         oGWOzg04z4Asw4fzBd1XmaOSZROVpHrN4mHK7dRROQ6J044RzJbGphbUgb5GWxr/Kuko
         aYAZUOKyPbABm2ysH+obm2PriBneK3iEoc3akRmM7RvmTQNQk43O4B8sH1cX7y9OutGi
         YMr2etzRTga0d/m0BDs6QkNlvP+riVwnZbE6QXISwmUHsQtvJeEOXIOuL749Kgi/Mt8g
         xhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044862; x=1758649662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8PZeNRScOuv4YluUBiR/tynYHUDyQLkirKhaJTO4E=;
        b=M7tpiBbCuzCFVmeP3LSoXQGoOCD84sFg9t77vF4q2tXAv5hJjxAWimji7iXp7c2zzx
         RKQVCazIsNb++jOWt5ndh7KStSg7o03YaEbwI+0y3+0dtFGDapexQRPQAFAwUGkjNkxo
         alnvsARiTtVHg6oehSw/lt+1xqADyn+LlbFFlboR9QsB5yAY/aL1f7uvyrqYENl18xwd
         n/3c2fOFyIRuRYbl3mjH3Iq3qolirVd8YvfKoGHhwMHrLGSnDDZJu+WbEsnx9TjBAQja
         amKPTJ2ICpRCsqSOKXoB9/1/Dk3FeqqpF++hRixRVv0ZcF17JCgoWhN+SlZdCkN3n7yV
         +tCg==
X-Forwarded-Encrypted: i=1; AJvYcCU6/p7MnwfE8VGUqSjE4m8hV4Fnf/yW40BjxpqIiUIuftqST5xD0HImQNKmowmYL+u15NYA0hHz4V5fqdS5@vger.kernel.org
X-Gm-Message-State: AOJu0YwckJSmK3lhPrSulEJ/u6k9WJrToeuZbBELm7qEpARA3O2ypGMi
	s7tNBUgf+9BqrpMnZobE/Wt5pjK9W5y7+UQtbiOadCsDqdn68hw2/Bk2P72Br9T7OqjE9tVf8X5
	+exUPceg89H9XE3OMdu59JjsRuEUOPUmk+EnV0+55
X-Gm-Gg: ASbGnctBqjl+ckuaGQOOsssdFw7ipDN6ZDqUwUIqM6QCOccyTJPmMyV0x2l3VSJ9GX0
	jgoQJNR1Bl2sPSKpT/ZtjH/5NZchzhhRDuNTxYSQCYNv5aKKc+IVaQUABzSQyrhw0kYaMyd+yoC
	JjrZUBCsbV1O0BdAvH6BjGtha96srEyam7dQKhH9Q1ld5DPcCq1JcZaMI6Yd/cDUK5PxKNDXW5x
	9nbRT0ogHn57rZVvirZK/Hgg8KePOvvD449VoSBsQjDfRoUVbY9thU=
X-Google-Smtp-Source: AGHT+IH481Ptt6TGK3gOl1kWB0jZ6sD/yNX/MW49IQWxuVmUns01xHRPJ06rIkyHQhotda3n4zze0byfKtMf1L55b6o=
X-Received: by 2002:a17:902:ea06:b0:267:912b:2b4d with SMTP id
 d9443c01a7336-26801263c77mr123545ad.7.1758044861731; Tue, 16 Sep 2025
 10:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org> <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
In-Reply-To: <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:47:30 -0700
X-Gm-Features: AS18NWAFaSQqFXRnUy8iH8cngSLpkM9xdFvTXyHLo_pUfxdfSq_22GyY9mLtXWo
Message-ID: <CAC_TJvdwt_66v_A3RnuUBS_XJ7xMwWhEwHEEeLpu2_M5aVQ=Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org, david@redhat.com, 
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

On Tue, Sep 16, 2025 at 3:12=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 03:34:01PM -0700, Andrew Morton wrote:
> > Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> > feeling a need to slow things down for additional stabilization and so
> > people hopefully get additional bandwidth to digest the material we've
> > added this far.  So I think I'll just cherrypick [1/7] for now.  A
> > great flood of positive review activity would probably make me revisit
> > that ;)
> >
>
> Kalesh - I do intend to look at this series when I have a chance. My revi=
ew
> workload has been insane so it's hard to keep up at the moment.
>
> Andrew - This cycle has been crazy, speaking from point of view of somebo=
dy
> doing a lot of review, it's been very very exhausting from this side too,
> and this kind of work can feel a little... thankless... sometimes :)
>
> I feel like we maybe need a way to ask people to slow down, sometimes at
> least.
>
> Perhaps being less accepting of patches during merge window is one aspect=
,
> as the merge window leading up to this cycle was almost the same review
> load as when the cycle started.
>
> Anyway, TL;DR: I think we need to be mindful of reviewer sanity as a fact=
or
> in all this too :)
>
> (I am spekaing at Kernel Recipes then going on a very-badly-needed 2.5 we=
ek
> vacataion afterwards over the merge window so I hope to stave off burnout
> that way. Be good if I could keep mails upon return to 3 digits, but I ha=
ve
> my doubts :P)

Hi Lorenzo,

Absolutely, take care of yourself. We all appreciate the  amount of
work you put into reviewing :)

Have a good talk and enjoy your vacation. Don't worry about the backlog.

-- Kalesh

>
> Cheers, Lorenzo

