Return-Path: <linux-fsdevel+bounces-52634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D69AE4CB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7654416D614
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4C2D028A;
	Mon, 23 Jun 2025 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A88B/ENI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7953BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702919; cv=none; b=bpPA09Xbqzwfv5PD3k/Beja8NlhXURONEuotYflly/NOSNkceFmKcaHQKqf/PY20U5oRTwrRYlcrbHXTVIWkOt9PPeP+Wk973st0rSjMflPBNM5We/rmTZ6CJozoT4YZDrI6FdKbtJU9C8m4xMXX4An6QOfFZRtCm0EEVoXAuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702919; c=relaxed/simple;
	bh=KdoidYXby0xpk/s+6YujWdZAk6+GGiW8NtafDhpg3lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3iBW9gwj4hYsMjIr/YwlVY++I9suzeUH+p5/gEkb2tryABeJJdj/G5Xk9DKX2nsaN5/Mooa45X5RnLPrtkn76qbP5tFJxeuqyLJjflKTfFGWxs2zoKDsryOhCDU58AKSKuX8mKC+ioQYD5lT4yB8yo3mavSJi/U7sbZhlTqdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A88B/ENI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so7837586a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750702915; x=1751307715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GQs4olYcwyx9snEcwR/AxBPgclJCTw7iVJ4ACeNwh0U=;
        b=A88B/ENI/5asfgFE1EcvYV6amYN+VP2j1UpaV03SfUgH5RTu3SzqfeezWiOJrc3/8q
         CF9+L4VwjHaiAjjtS0tpJom2HHcNKO8dkg0JEM7TSkFrx8rPKGULVHGAYnYi8fcoARci
         575670wNMyyFxeNNAKbThtKwXSR4OxZp3iT/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702915; x=1751307715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQs4olYcwyx9snEcwR/AxBPgclJCTw7iVJ4ACeNwh0U=;
        b=AedMKP4tkemokxwxbmKUTiCOhQ6o27mf7S+ke4PrWxchixK6JnkPSXDCb8h8nkHheM
         tPrddoK8jVhs0EKFVGu77pRs97zaqP1sT/+B7iK4SAm5RkJmWM7c/5p/KW6E/jSnS8VR
         pdaejPQDxnt/XgkyKgRIQT1/lQdGVqxYgGVxDjJEfyOy+V6dJfX6mRkU4KAsk3h0dcHW
         y7fPnY3zu0COBQ11CSRKQfMYNvWNFiRSzvZfji/4bN7hgJCYvLjZsyQRSMFo2T0cZEPp
         y8txRdx2WFJgL61CbGFAhgF7kLe0e4T9hiIPiSy0Xa1uuwrQ+Czj1gpieifqKvD7VsmZ
         ySFQ==
X-Gm-Message-State: AOJu0YzlrFoUSBXDv7wqTvL8GL4ep62FC4X+UgEuwR3psazpss/y+30+
	JtPObMCnRZCYPJyyyVIa3O6akLvvq00I6MOAYd782YID3zkdZw3+/pNOa8HMNwaXhK8Cxjjlnio
	G18O/4Rs=
X-Gm-Gg: ASbGncubD+1MZGteX6RUtwECITRHz6hs4EoLkkZc9B1MCTTaVaOy+0Vgv8MG6ldjoHl
	4KUGStnTEAk7SN5d/cU4OADH9+CEYZyLIZ3NScs1n6Xn2wuwWdBRjAqNiXbPbsOZHmIjmtP0//s
	ZUroWTPcoHbP/UN/0IrJ5umAqYtRJkZTYFUr4lHJ5Cv4RyMMaWT5fjLdfW+0lFsmmg7zPbbBY+C
	9oQ0qi0c9vuRcVro+gm0Czjg4tJE1mACoxbdlQakGDfoqBYs3XN2C7cIBC34k+Xcu9uCzgBnXpv
	eU96D/uRP9EnZcqEs/BycDRhwgjZRd61Y/ZPxKh0ssTzr8+had4ToFQvMSD+t11g8Tr6RaFYT8W
	exELebc+pTRXL+ibl6zbEAwERMqrOC0+K6+K9
X-Google-Smtp-Source: AGHT+IER/7cWOBu895x5XEFdaHF1IN0R+P6nE45mbo8agWvtSNw/Npw+XXVSKuZcnn1PT66C4KQwVw==
X-Received: by 2002:a05:6402:5246:b0:606:df70:7a9f with SMTP id 4fb4d7f45d1cf-60a1d167770mr13614794a12.19.1750702915564;
        Mon, 23 Jun 2025 11:21:55 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a18c94730sm6364714a12.52.2025.06.23.11.21.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:21:54 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607434e1821so6678555a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:21:54 -0700 (PDT)
X-Received: by 2002:a17:907:3cd5:b0:ae0:8648:f8bf with SMTP id
 a640c23a62f3a-ae08648fc4cmr568478866b.10.1750702914023; Mon, 23 Jun 2025
 11:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623044912.GA1248894@ZenIV> <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk> <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV>
In-Reply-To: <20250623170314.GG1880847@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Jun 2025 11:21:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcEG4rawktd_DbEJMJnTzqFvGRdEr53En8RAcNfKrvbg@mail.gmail.com>
X-Gm-Features: AX0GCFsi-Z1jFQWD_lLCSbSbQmSD3eutPPA4tBySnO04u0sPuZvQl7udpGn0TWk
Message-ID: <CAHk-=wjcEG4rawktd_DbEJMJnTzqFvGRdEr53En8RAcNfKrvbg@mail.gmail.com>
Subject: Re: [PATCH v2 17/35] sanitize handling of long-term internal mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 10:03, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I don't know...  7 callers with explicit strlen():

Yeah. Most of them clearly just want the string length.

But there were clearly a couple that really didn't have a
NUL-termination thing. And one - that nfs namespace thing - that do
have a string, but get the string length differently.

> > Or maybe even go further and some helper to doi that
> > "fs_context_for_mount()" _with_ a list of param's to be added?
>
> Vararg, presumably?

Or just pass in a descriptor struct / array that can be NULL?

But this really is not a huge deal. I was just looking at your series,
and most things cleaned things up, and this one just grated on me a
bit.

           Linus

