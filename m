Return-Path: <linux-fsdevel+bounces-61449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D460AB58478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 20:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1570A7AD059
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FF2C2354;
	Mon, 15 Sep 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VyAopmCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61F2BEFE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 18:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960472; cv=none; b=Lc6ITF9s90R2AfXi6v+FQiZ/JauA7k+ujZcXS6eWkK0AcNJcsYO0BFdcrR9hNvEFr7773E98+g3Q6/b7UOIGyZnhVb17Upe9r5/K3vlKsJxrWDGYE5FNKRByrY+sljCs0+4spiQXna+SSbBYE/sUDT8EtJoQB9EQ1WJ0s6YDWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960472; c=relaxed/simple;
	bh=0aDdECbcFnvzK6gvTk++iDWF1gYYmeS5TIpHZBB7Yb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggglS+K0GpzEvACM3ZIk8v8Vf54gycqFQyVvFkEYPFnWOWzqLWwDbA7J+Tak8Zts5e8NpXNjlhiuIGttWj9CjMv4jWT/0jipRlP/DZvAivOGgE4n9nC9Y6MVvWmG0xBkhTboAvdcRawnpONYCCfNEsBFyW3qaHEcmrOTOWjryeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VyAopmCP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603b674aso31186777b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757960469; x=1758565269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=VyAopmCPFu7azUOHo0iM0H7C1iay8VW3m34YkV5/b7mkIrzNgdYj5gIB3MfbOgXNdw
         An1WLWvxpwHETRBOl6tExv14asHr/pcrwj+azTUyrRbWDdskINTs5rsmOapntNqNXL95
         t81vuvAhPUOVXnTPbrGYMDEg5e3GgK/d72EbDKkpXRHbEahmQtKj5f/MPk/JGqiHY7Pq
         En+4QRjrwFfGtSEBIVtYCHLnbd1yI+elNGt3Lf9l0fJMxlbjMhQIfYtIIsyzRsBAdvNH
         TG6/v5FypG6rdlO1ex/QEMEoZhYXH47Yn/9WI67xG2S1GDFt4p3nCwKGtO8N1hyud4OA
         XhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757960469; x=1758565269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+GliT1Pd8d53HWEdMQBU1YHyq1rnSI3P+2j/fil2q0=;
        b=rneBY1jnWjmvXZKwZvTzLpamXAehT0mUwW6AvcSwOAvzO8VoyzvEg9VUTZXJR5EYo1
         G75VvMqL8wVoIZQHY8GFgf24KsN1NJ1WJ86LQy2HAEUsuJjDAG0LF7fWzozhgvAg3B1v
         S4xImmBhg893zb7bh0OW6D1/6H7nmwIMaWIwICkpvvCz5MknceWkQfNzmOCgXnytt3yQ
         bFlRs4W5oEdoScM2aQJQCrFnrOnK6aZ+10giBgGDwbFmAzTZnN5BCdYsbZu428VoKBU8
         /G9m9eYVVVBTMf94YsieKlo47eg5p3SVAItFsNAhcw8+1evGAaFVc3nkbfkdOtu7l8gI
         Qn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVuVXWgl29wPKI2JqnOQ2ob2VZrQTCZQw9cuin/inusQAHo1NkOWFC8+YyFHyHfz3Ozk3UghZqQ9oHBCV+m@vger.kernel.org
X-Gm-Message-State: AOJu0YxZyBYTuGri4cmEJdGNDyOUIudj0p6lR+vhlXsjq2ZKv40sDC+C
	5vOosC/p8l4ExBKH9irQFLUcCfv411s7Bsxno7dSHhohd4iHzIuH0mTxC4xHm6FvKpMSskbs9Yf
	Svnsrm1qibGA4N0WDlfsG3jU8S07/usLpyyLn5R0f5w==
X-Gm-Gg: ASbGncvqFc/loftejTl5QCQSTDwC/L8TmO/AvuUXM56Ma01QcZZuZ+PHDuSM9NuesaV
	93TF1qbwyKSQPQ5Wt3/Pt3By5mO0R+Kby/o0uwt2sZqrd81w1v3j7eFc4TExaavW5lAtqFHyzDq
	w8WM9D3P9+97IOsu7iQYWFKDEc1n5uDMqB1du9a90j9pQ3dFBR8uOU8JqWyzOEkonbq6/YSqTkD
	3ZyLdtfvHk+S/4=
X-Google-Smtp-Source: AGHT+IEDp5ZYxkbjon4yCrRZanz3ywO+1Dqvmg43vzDGc4l+oL6FL33NrpAa1korZr0/WJwLYzGBFv1kfMtD4v4LVjo=
X-Received: by 2002:a05:690c:9c0c:b0:71c:1a46:48d5 with SMTP id
 00721157ae682-73063480b69mr133022797b3.21.1757960468639; Mon, 15 Sep 2025
 11:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com>
 <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com> <CAHSKhteHC26yXVFtjgdanfM7+vsOVZ+HHWnBYD01A4eiRHibVQ@mail.gmail.com>
 <240A7968-D530-4135-856A-CE90D269D5E6@linux.ibm.com> <20250915142612.1412769A80-agordeev@linux.ibm.com>
In-Reply-To: <20250915142612.1412769A80-agordeev@linux.ibm.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Tue, 16 Sep 2025 02:20:55 +0800
X-Gm-Features: Ac12FXz4gtGN6Jqt9p3sI4NDKpM8RKfj3WgCz5dLwYdzbiuc_wRBtKzbSNJCafg
Message-ID: <CAHSKhtc-514tQoyCSukK1sLbDbc+Ne_TnwEks-h+gQWv8ZKHOA@mail.gmail.com>
Subject: Re: [External] Re: [linux-next20250911]Kernel OOPs while running
 generic/256 on Pmem device
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Venkat <venkat88@linux.ibm.com>, tj@kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org, songmuchun@bytedance.com, shakeelb@google.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mhocko@suse.com, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com, 
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:26=E2=80=AFPM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Mon, Sep 15, 2025 at 07:49:26PM +0530, Venkat wrote:
> > Hello,
> >
> > Thanks for the fix. This is fixing the reported issue.
> >
> > While sending out the patch please add below tag as well.
> >
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
> And Reported-by as well, if I may add ;)
>

I'd like to but I will resend the whole patch which is used to address
another issue.  Thanks a lot for reporting anyway =E2=80=94 it=E2=80=99s ve=
ry helpful!
> > Regards,
> > Venkat.
>
> Thanks!


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

