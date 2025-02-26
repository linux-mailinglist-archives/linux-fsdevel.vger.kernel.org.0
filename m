Return-Path: <linux-fsdevel+bounces-42623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C830CA451BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 01:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B641E17D69C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 00:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8DF1552E3;
	Wed, 26 Feb 2025 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4tpAjixY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA2155A52
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530969; cv=none; b=Ft5HxP0+rDKm0aReneUyD4MjCpceNAkgNsiWya6VoCC5r1AumgMbV/wFZr4qVhQMifKV90xNKyBnsPNn76XaQfJkEO2uyKtAEFp5kheXI5aCVVw8VPDAxuI2f6SS50ilQ6Y0QIBRX3g2CDlqtNWnAYBfcyB84N6rmQzI20DSVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530969; c=relaxed/simple;
	bh=RdF71WMJfSCIE7G3SXLRiy4c1Julw9Y+79vYTN6H6+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq8n6Mg+94Dlhgm2KXA0W/8BKJQm5e5VXJyIKRqe8n+m8TKL6KSCeVbudnbhX2MHCs7q8ao6x9fvMISBsGhyrMfhfOdse7MgLDg9IkkpystJi9WNQhCEo5fVxXCTobrQSAlI8KE+BXXLHCxFFuYWjX2yuZsXmgyJgwbDPCNHF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4tpAjixY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2212222d4cdso56545ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 16:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740530967; x=1741135767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLpzFy1eZlUB+Co+8Fz3W/0aCqMmDbq8AAvSFegM+xA=;
        b=4tpAjixYEnEFxtmsJIWElSutsF4UGhjoffSMmciYZiUjUpQI7jLWyqUN+nzhwg0Ify
         5Jdno4VFimI+62t6NiLTAV56YalbGrQr8a3ckMIO3YNxknfoMDISUUNN+ateWdfxkKQb
         MXfocXPAoqnaQ8ufIdS9Xt0Ky4wIULknmhBIE5PkJ4l/CcPRe5M6mmG5LG4kSqG7NPXD
         1QlZVIfpxJCZGtBtTmIodgVsO+zhN3LtuXjJhD3myNKwguMo+cNFj2p4JbHqg10luYAp
         o8jm4mmn7eNgK2mos7OMam0YxH8uV5RlsCDeIe+4nW6CtAubOxpnIv1/tg0K7xcgsDLf
         GNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530967; x=1741135767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLpzFy1eZlUB+Co+8Fz3W/0aCqMmDbq8AAvSFegM+xA=;
        b=GG7iMPO6o4VVndl6cZER03whOpCF9aYIcYIDf+fomoma9cFxPz6c+N6Qsj927cgnVz
         LmCm7AiCMJaGdaXlhnHTce8EmdGmEYP93o8tCwdpP1TN0F2twc7iSylTI8Ceum1fKJL7
         ANN/1HciSvOa4v2JxvAO6pyLKROMSmv0GG/D8fACDuQJmEqT/aMYh4d6m7ClUbfun4Cj
         fxz8J1xuZF2bTNAZ6pjlGsL2XjR6WYPmHsjIAtdJsL0KjU+v9mDyJoEUQ8HAc3bJY5TP
         lOMMOEcJs2g/j+2BlzSXz1awtvNAL+kgvedYX8wilxNTWZ8aevgjVHltVWbWGHhq8rSJ
         a/rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRiTR0k7JmB3QFmQpNCuTpe/Td2cwgbRfm1MrrZ6gKaW9ok6/xEDqHC2AZevb+dHOFEJs+kEHbw0HpXabo@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtHtPj5i9Z8/dn9ne7815BpOdudEid6FWGBxj2fnwnAn1sqot
	fa1ppi8BBRPLKMkkzfiGc87FgpgzhrOV1aVTGWOD46bE91xIEADq9NVhWmwZb7tJfudDYHnS9NY
	C42YHK179rbOMKCIBwAXxg/lAhp5ChvPTOk2j
X-Gm-Gg: ASbGncu0OXDO9/0AOF+Pi3T1G765axY/RZOBp86hcz31UMf2EDtLmNtAct9mEFuT9qO
	F7tMDZUCsw4zDJbxLL9BFOKBlGK6inSRcJSPtnBylShYf63X+8HmEq9kbCfVV6heZgPjDLBf1v3
	X7KPbx66sOSP72zwZ6BbSUvKHrxqMf7UmjkRQ=
X-Google-Smtp-Source: AGHT+IG90pILEcepVYruyOtG/cFNqGXmQtOt3vqmJXOayyRiGXLeQJNoLvWR67x+HpC2WBY5cIPmuqv6icg1EjoRJcE=
X-Received: by 2002:a17:903:41ce:b0:215:aca2:dc04 with SMTP id
 d9443c01a7336-22307aaca93mr5261065ad.26.1740530966777; Tue, 25 Feb 2025
 16:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local> <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
 <82fbe53b-98c4-4e55-9eeb-5a013596c4c6@lucifer.local> <CAC_TJvcnD731xyudgapjHx=dvVHY+cxoO1--2us7oo9TqA9-_g@mail.gmail.com>
 <jenbcj2kmujffuznxsmy4ozqch77ay5jzznx5ftvevgr663er6@wym7xxkbv2sc>
In-Reply-To: <jenbcj2kmujffuznxsmy4ozqch77ay5jzznx5ftvevgr663er6@wym7xxkbv2sc>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 25 Feb 2025 16:49:14 -0800
X-Gm-Features: AWEUYZkjjuouYBkdANv8_JSZ7I4hioxdu3ksdNpLharkVu2AtsYMHuGfmDf5kuQ
Message-ID: <CAC_TJvdAH2wEt0E2cE-Pa9f1FAi+pftLVJ_BrHe_XLQ6NJTGtA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead Behavior
To: Jan Kara <jack@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, lsf-pc@lists.linux-foundation.org, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Juan Yescas <jyescas@google.com>, 
	android-mm <android-mm@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	"Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 24-02-25 13:36:50, Kalesh Singh wrote:
> > On Mon, Feb 24, 2025 at 8:52=E2=80=AFAM Lorenzo Stoakes
> > > > > > OK, I agree the behavior you describe exists. But do you have s=
ome
> > > > > > real-world numbers showing its extent? I'm not looking for some=
 artificial
> > > > > > numbers - sure bad cases can be constructed - but how big pract=
ical problem
> > > > > > is this? If you can show that average Android phone has 10% of =
these
> > > > > > useless pages in memory than that's one thing and we should be =
looking for
> > > > > > some general solution. If it is more like 0.1%, then why bother=
?
> > > > > >
> >
> > Once I revert a workaround that we currently have to avoid
> > fault-around for these regions (we don't have an out of tree solution
> > to prevent the page cache population); our CI which checks memory
> > usage after performing some common app user-journeys; reports
> > regressions as shown in the snippet below. Note, that the increases
> > here are only for the populated PTEs (bounded by VMA) so the actual
> > pollution is theoretically larger.
> >
> > Metric: perfetto_media.extractor#file-rss-avg
> > Increased by 7.495 MB (32.7%)
> >
> > Metric: perfetto_/system/bin/audioserver#file-rss-avg
> > Increased by 6.262 MB (29.8%)
> >
> > Metric: perfetto_/system/bin/mediaserver#file-rss-max
> > Increased by 8.325 MB (28.0%)
> >
> > Metric: perfetto_/system/bin/mediaserver#file-rss-avg
> > Increased by 8.198 MB (28.4%)
> >
> > Metric: perfetto_media.extractor#file-rss-max
> > Increased by 7.95 MB (33.6%)
> >
> > Metric: perfetto_/system/bin/incidentd#file-rss-avg
> > Increased by 0.896 MB (20.4%)
> >
> > Metric: perfetto_/system/bin/audioserver#file-rss-max
> > Increased by 6.883 MB (31.9%)
> >
> > Metric: perfetto_media.swcodec#file-rss-max
> > Increased by 7.236 MB (34.9%)
> >
> > Metric: perfetto_/system/bin/incidentd#file-rss-max
> > Increased by 1.003 MB (22.7%)
> >
> > Metric: perfetto_/system/bin/cameraserver#file-rss-avg
> > Increased by 6.946 MB (34.2%)
> >
> > Metric: perfetto_/system/bin/cameraserver#file-rss-max
> > Increased by 7.205 MB (33.8%)
> >
> > Metric: perfetto_com.android.nfc#file-rss-max
> > Increased by 8.525 MB (9.8%)
> >
> > Metric: perfetto_/system/bin/surfaceflinger#file-rss-avg
> > Increased by 3.715 MB (3.6%)
> >
> > Metric: perfetto_media.swcodec#file-rss-avg
> > Increased by 5.096 MB (27.1%)
> >
> > [...]
> >
> > The issue is widespread across processes because in order to support
> > larger page sizes Android has a requirement that the ELF segments are
> > at-least 16KB aligned, which lead to the padding regions (never
> > accessed).
>
> Thanks for the numbers! It's much more than I'd expect. So you apparently
> have a lot of relatively small segments?

Hi Jan,

Yeah you are right the segments can be relatively small.

I took one app on my device as an example:

adb shell 'cat /proc/$(pidof com.google.android.youtube)/maps' | grep
'.so$' | tee youtube_so_segments.txt

cat youtube_so_segments.txt | ./total_mapped_size.sh
Total mapping length: 147980288 bytes

cat youtube_so_segments.txt | wc -l
1148

147980288/1148/1024 =3D 125.88 KB

Let's say very roughly on average it's 128KB per segment; the padding
region can be anywhere from 0 to 60KB of that.

--Kalesh

>
> > Another possible way we can look at this: in the regressions shared
> > above by the ELF padding regions, we are able to make these regions
> > sparse (for *almost* all cases) -- solving the shared-zero page
> > problem for file mappings, would also eliminate much of this overhead.
> > So perhaps we should tackle this angle? If that's a more tangible
> > solution ?
> >
> > From the previous discussions that Matthew shared [7], it seems like
> > Dave proposed an alternative to moving the extents to the VFS layer to
> > invert the IO read path operations [8]. Maybe this is a move
> > approachable solution since there is precedence for the same in the
> > write path?
>
> Yeah, so I certainly wouldn't be opposed to this. What Dave suggests make=
s
> a lot of sense. In principle we did something similar for DAX. But it won=
't be
> a trivial change so details matter...
>
>                                                                         H=
onza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

