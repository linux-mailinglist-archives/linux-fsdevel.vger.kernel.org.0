Return-Path: <linux-fsdevel+bounces-14367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C691887B3EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D86282C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8055E6E;
	Wed, 13 Mar 2024 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OpFJ1Qo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075153E3D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366719; cv=none; b=SPhe7JDuGbHNm+3HSeaA3/CjQD4beK6ZDn5x7TrY2CMNiW7+cPVyItImUy3J/SiyXQIXvRp7A1FNmO0MUSD2hHcn6e6Uh1w2gZYkn6opYM9nW7atAfCy8gH2gvz9rymCryiEwb4gaXd06owYETOlHRQjU1P+dOVVg9+Y39wCuaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366719; c=relaxed/simple;
	bh=hBdvIs25UMavbKrjHvaxFsQ76fNHP6pFUKDpTkxaYns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHXETIcWsQIhrILTLNn56ES4bsQ42i7l8l/FVHXjGO9HWB7AUSMfqoIPvAe02HaLguDdIAXysk8fvf3DqPK603Hfa151R4G95x7lqhpur27ly/qypQz89ouN0abFhshvbEHocGBMUnLIfP3dj6RiIZBpl+EbnKrhGyaTU6szp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OpFJ1Qo0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2376164a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710366715; x=1710971515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QeGHZUugSwtILKFvBXuTtAPNxZwHhdb9r9cwhsNH7u8=;
        b=OpFJ1Qo0vR+rwbHrm+JShrKFXXCtuJmnPWkDBHefhtAozF72+dqTuIzF+jwkkaXlfj
         ytAu9YzZ6eofX03aru3Mg/8bKXas2a9tJfVJ1NjinxN5GVU3Khil+glxgwlEA4un4ZGo
         LNjL9LfL0V1xAs5SFSTL4/j/e1xWWLud+f914=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366715; x=1710971515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeGHZUugSwtILKFvBXuTtAPNxZwHhdb9r9cwhsNH7u8=;
        b=W7zvDareMZUGjHtNaHXw7agaFbzn2tvOL4VCV6YfqyvRP3FicTv9RTZpd2T4CjMvy1
         S+4090hqYq4sYBYgvhoUc80ah8OVsivZhngj5iwTBC+Uze0gFo5n7e5Hgzb0GWSRyH3N
         fG8cJhJI1JQV65eWYaLZPp0+JRAq/Nav2FBZOCDQyUfmZIuPNohoD3OdzgoOC2JX4hym
         NByFwhjKKoAgvSfphKGVdqdjpvW6VcVHq2Gbmdt/6DHs9pp428Psrnd+foa6PBjTwTfa
         K9ScFsoyt1+pUWwSHuxeo0JR4EmEZusF+mSv+giz7SCGuqWrUxrmpH9Q15fDBrVlm6Gn
         Lctg==
X-Forwarded-Encrypted: i=1; AJvYcCXKP/AawG5qmnjs/xjAsVRcAfF8vE1JI38DtVF7a5GxvRx2ba7g5qadG9/4XAAsNR3v+o6WYWDNJaQ6L3GaMAy+vJLc6XXMieWQRtz1rw==
X-Gm-Message-State: AOJu0Yye7QVZ5sxxmXwC0JEj2B1vR8ckilPWM0tfvBBmHNaKcvTt9gy2
	Vh1OJhG56X5uu46S2vg6D9g+mLLHj4DdsVLLt7BK1LXT46zaW3EB9vxzWnO/IKuzm/mC0MZQ1Uh
	3KLSvMg==
X-Google-Smtp-Source: AGHT+IHElCvuVK11O1/FtOoxF/lDdL+AHatPB3X/lv6OZC7DlBlNHrfMG45i0JMAsGl3bPfq1NaqOQ==
X-Received: by 2002:a17:906:1ed7:b0:a46:2e1c:2a6f with SMTP id m23-20020a1709061ed700b00a462e1c2a6fmr3371837ejj.2.1710366715633;
        Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a42f6d17123sm43404ejc.46.2024.03.13.14.51.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a446b5a08f0so64095566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 14:51:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTVDgtyjX4Vpurwj853XvrLeVQ6iE+TOa3vxxYBhu/S+tlm2Pz1rHxOoXuy6+xZyJpmMyCjwnB3G2VQYBm7tEa3ERe2MTc3vFDxOP4+Q==
X-Received: by 2002:a17:906:c0d4:b0:a44:52ec:b9e7 with SMTP id
 bn20-20020a170906c0d400b00a4452ecb9e7mr20310ejb.16.1710366714711; Wed, 13 Mar
 2024 14:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <lfypw4vqq3rkohlh2iwhub3igjopdy26lfforfcjws2dfizk7d@32yk5dnemi4u>
 <CAHk-=wg3djFJMeN3L_zx3P-6eN978Y1JTssxy81RhAbxB==L8Q@mail.gmail.com> <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
In-Reply-To: <bqlnihgtaxv4gq2k6nah33hq7f3vk73x2sd6mlbdvxln2nbfu6@ypoukdqdqbtb>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 14:51:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
Message-ID: <CAHk-=whbgtooUErM9bOP2iWimndpkPLaPy1YZmbmHACU07h3Mw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.9
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 14:34, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I liked your MAD suggestion, but the catch was that we need an
> exponentially weighted version,

The code for the weighted version literally doesn't change.

The variance value is different, but the difference between MAD and
standard deviation is basically just a constant factor (which will be
different for different distributions, but so what? Any _particular_
case will have a particular distribution).

So why would a constant factor make _any_ difference for any
exponential weighting?

Anyway, feel free to keep your code in bcachefs.

And maybe xfs even wants to copy that code. I don't care, it seems
stupid, but that's a filesystem choice.

But if we're making it a generic kernel library, it needs to be sane.
Not making people do 64-bit square roots and 128-bit divides just for
a random statistical element.

              Linus

