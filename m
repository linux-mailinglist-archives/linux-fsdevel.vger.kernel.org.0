Return-Path: <linux-fsdevel+bounces-50787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C75ACF92F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F8216AAEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48827EC73;
	Thu,  5 Jun 2025 21:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nlIddnrB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E65A1E7C03
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749158163; cv=none; b=i4lmFWXo5wvF3szunWyidqP8VZO0O56oc6BLBIVhR7bxusV8ieoXFj0Y7YBDVPs701IrC7/Zc6TVcO6k25O4sIW5kJ/WwpAYnwQMzJXo4VcisivzwuMWl2uKeZLYHQ0zLkn+OnnvsnrrcYzQ78B2vyFOKFK30L+JLFi8ljB8NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749158163; c=relaxed/simple;
	bh=deJ8ujgYVXOLDRzPlJGjcrFyGqlX+2qP5XJVIPJC13c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aac8sUZKp0FXfnGbg4XFULY2n1J/24t6m3NOnDrfbfFkHRT6B/CGSZaXV7D57MBEz+BBqZ8sYPDYx7LeqiuA3T2EWowINoeIgh73dp2xrBT6g7d/hClmRdBRrbbdHleX6ZEpzCgGV8fuwo5HE38e+8t8q+vGVMkFp6yriBM7GbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nlIddnrB; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555L4kNO027681
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Jun 2025 17:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=kYNh9HFT2uHBGBuTCKgX10WS8SJF8NGZEUcVRDSxRuQ=;
 b=nlIddnrBHoiqBQUxB3TXUWD9X49XJOdQ8+6EFQ5EkkzQBJ3Ia4xkx6p3xxL6htuwx2k2
 MilhN28kQAe1lMta4lgEf62GFMpuusvSIwB8OX959Du/kJ+7/9/udrZ+bsChklShmuvE
 R6UQOtySiL0jiZJxeEY+djwK81qUIFPntG2IP2HS3Y+jmPWute/Mc4Kr+ppfCYyQ0ctV
 fweOOaMHrYGDfqtcfq0Eh/KCeG4NoXFx7TLozSakYOPqBMRwehriUz0O/bdX9vPVsFig
 UnJ2V+4rnw+qKv6oYuaVKhdQY/eaEHZbO5kt0JyKfAxzbgH7oyDkFEFwxTRogKMnbpcm 8A== 
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 46yv219yr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 17:16:01 -0400
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e3acd6353so21783687b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 14:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749158160; x=1749762960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYNh9HFT2uHBGBuTCKgX10WS8SJF8NGZEUcVRDSxRuQ=;
        b=LWHbyGfMMIU3lBQo+tIDCbhq+X308w2tfk1+V5OpmvyGELr24FO6AE+ZTfRdqrHaTm
         leYq2j0egkh0z52RpDIGb6QbUsFoe877mUd/RxiZyJQ9Bc7c9MZKvZ4DIsT4LDlmu88/
         fq8NqN16WTVC52LMKjal/zOa7fT0zK8wfHYoCUTyCv4PT21OttgsxnL/CXhmb/vgOS/c
         HrlJ1l3DPq2uMPvabgUPd5KXhS9tlcV+uqfgQPx4mgyhDkbnzSBPq1fSNA47jrlCwL0I
         8s0Z6aSZAnz+UFbBOMIPCmj4zUtJKK70TduHZud82tOTsNUjaiPJgA3NtccAKOaalpds
         Q19w==
X-Forwarded-Encrypted: i=1; AJvYcCXQcmjbQQg7JeGhMj3wXgUL62mAqVYZxesGSIMTHQSApaB9/Ns3ON5Nc6ZvQvJ/CFCQdeUbGaIKBVnOGx4f@vger.kernel.org
X-Gm-Message-State: AOJu0YwiBlbG1UDJSK59QpnI509D5XtLp8KQLsNosBt4oVRnrsXBvNk0
	gFZx46H/JoN7ZMfyKejWvv+by8MdNzJtCCj3+VfKyCxuJbIzzPeRsgOiocLXk3yFJ6W/WG38Sxx
	+6bncuXvTNCpEcGStcYaUnP0eBh+gdEowGtV4Iq1JjKLFORHpiwiV6hWQKyxed1xyVtG8pPyX1R
	NqE84rWSgn+r7DLULDFrJvxWSASqgheXRu1PN18A==
X-Gm-Gg: ASbGnct/lInCjberbpZ5cNFguUwiXRX0bpP1xTjifrZWzEsJ4Yw8gVIFmoR9qpEm8A4
	E+rRFXcP4Ramoc4DwqZmuCGHxYt7zQxUJOURr4heAl3k1wT1ZRpW24BCEPt2UvTNyVQoPIg==
X-Received: by 2002:a05:6902:228d:b0:e81:9ebf:f5ed with SMTP id 3f1490d57ef6-e81a226a62dmr1945949276.1.1749158160144;
        Thu, 05 Jun 2025 14:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb2rG2d+9fop1XPRUg94ju87oBPhimyPjoI4Ye2fKsZq+dhB515YFqLZyXsjORvVHzCfDPRC8LU2/J90no5JA=
X-Received: by 2002:a05:6902:228d:b0:e81:9ebf:f5ed with SMTP id
 3f1490d57ef6-e81a226a62dmr1945917276.1.1749158159774; Thu, 05 Jun 2025
 14:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
 <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu> <84cf5418-42e9-4ec5-bd87-17ba91995c47@redhat.com>
 <aEBhqz1UgpP8d9hG@x1.local> <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com>
In-Reply-To: <0a1dab1c-80d2-436f-857f-734d95939aec@redhat.com>
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 5 Jun 2025 17:15:49 -0400
X-Gm-Features: AX0GCFsgrid_kqSVQH8gQAr68i4R2zJRlWIOJnyZmu8rrEwiMxn2I5F4znJwQ4U
Message-ID: <CAKha_sovhM3ju9jV-d_2PgbWLhuCek5MgdVRVt24y7TQcmZvQg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE5MSBTYWx0ZWRfX8HedyuhQegIv MjFWCW8D5HIBXS6D1TKD8vQevcSmD8zQA5d23L7y5PllJ+97G/4RF+oikydWXMDGHss1dw64gLO QB4XBuaxkdUKXIOxkprOFuu7fp9p2P6RlOaoTsdm0aAgAkKlbkQ+944xPsVpsyJydX/UYa4y/DT
 gNW8FCrJHtd/DIjJRmCliXorPPPMaDezF3Kfwlm8QUhP294iZdnYn9g5DXj2AxgH+4oET4k6hY6 xQnxEl3OlOeZ2kc2QqbC445gXpNL6rPKd4Whj/GqiOgRQbfiKHQeCfLjgyMQIwCI+ljwFyZnXJk pQNMfzHXrZgs+SGz7ffYqef/qvf+VPXt3ID5zDbhL1cldFz0opGYcYOKL6fmpAlXbfRtqVkRt1L TdqRvzEO
X-Proofpoint-GUID: ub-aJ2NlJSEjCIpXSlCNq3ZDhVQ9-cx2
X-Proofpoint-ORIG-GUID: ub-aJ2NlJSEjCIpXSlCNq3ZDhVQ9-cx2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=844
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10 spamscore=0
 bulkscore=10 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050191

On Thu, Jun 5, 2025 at 5:06=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.06.25 17:09, Peter Xu wrote:
> > On Wed, Jun 04, 2025 at 03:23:38PM +0200, David Hildenbrand wrote:
> >> On 04.06.25 00:14, Tal Zussman wrote:
> >>> Currently, a VMA registered with a uffd can be unregistered through a
> >>> different uffd asssociated with the same mm_struct.
> >>>
> >>> Change this behavior to be stricter by requiring VMAs to be unregiste=
red
> >>> through the same uffd they were registered with.
> >>>
> >>> While at it, correct the comment for the no userfaultfd case. This se=
ems
> >>> to be a copy-paste artifact from the analagous userfaultfd_register()
> >>> check.
> >>
> >> I consider it a BUG that should be fixed. Hoping Peter can share his
> >> opinion.
> >
> > Agree it smells like unintentional, it's just that the man page indeed
> > didn't mention what would happen if the userfaultfd isn't the one got
> > registered but only requesting them to be "compatible".
> >
> > DESCRIPTION
> >         Unregister a memory address range from userfaultfd.  The pages =
in
> >         the range must be =E2=80=9Ccompatible=E2=80=9D (see UFFDIO_REGI=
STER(2const)).
> >
> > So it sounds still possible if we have existing userapp creating multip=
le
> > userfaultfds (for example, for scalability reasons on using multiple
> > queues) to manage its own mm address space, one uffd in charge of a por=
tion
> > of VMAs, then it can randomly take one userfaultfd to do unregistration=
s.
> > Such might break.
>
> Not sure if relevant, but consider the following:
>
> an app being controlled by another process using userfaultfd.
>
> The app itself can "escape" uffd control of the other process by simply
> creating a userfaultfd and unregistering VMAs.

Yes, this is exactly what I was thinking. Or (less likely) a child process
that inherits a uffd from its parent can then mess with memory the parent
registers with a different uffd after the fork.

> --
> Cheers,
>
> David / dhildenb
>

