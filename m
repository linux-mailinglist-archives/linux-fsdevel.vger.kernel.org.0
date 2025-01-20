Return-Path: <linux-fsdevel+bounces-39700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E95CCA170E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D953A1121
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90D1EBFE4;
	Mon, 20 Jan 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx2R+xit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A51EB9EF;
	Mon, 20 Jan 2025 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392371; cv=none; b=iLuvSHy3a0+3tI8Yqy6hhGigdOmqjoehU4aFzxyDR2wHgGDnESi7fDAYhjA+mlsJEKeEYQ2BHsPqlUflYwDzmz5yKtQ9FTZTbx2zkVKtzsNudDyriW67p3Ut9Xm41CLyFUf83M5r6DdEtMFswFDg3tx9MtOZsRwLJrSsFe6Bf0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392371; c=relaxed/simple;
	bh=LZkqVXI9MbwjNIaos6mTWd0B/kiusApTXtjScSIuz9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeTzeAEf87iDrhKwWcN2oLw5RTTskkTiv3tqH4OM54kKsVPrspNAUkoF/UtBoSpHBjdMClMXWzNoX2F4hNzvcGWRA1wfjrb7P1vD4XTDdw7bi2UxxgBRGoVhlce1wBBYV684JbThsZ2nN/Jq1Z+DBtGiA50qTMPZ9hmhzIeIuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx2R+xit; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso6226638a12.0;
        Mon, 20 Jan 2025 08:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737392368; x=1737997168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZkqVXI9MbwjNIaos6mTWd0B/kiusApTXtjScSIuz9o=;
        b=Nx2R+xitklB9JFnIG2xnfEVgbzlQkeJkC+H3WYxZCa71VMWBagK3fSG5inWY/+l09P
         yy0WUak3+l7DbqgNXXFDtzVJzF1XWJL30MK96cRYBX5Uet2Ca28j3T3Bzi55SZjMqbAJ
         x9vTxAVaFSEA6HGpreEnO/AbYTeLUtKDnfRt9JE20l9lSCP5tN9/M0Uhho4XvAaCN1Ts
         +I+o46WBWVftUcKH884xt+fkP3RJ3CRX96BFxWyJH0bpqCzKfqxuELwPz8VMJc+g4rgG
         oNSO30TsPH9ey6Wc2wHL7164Hheg4zy4ZwOhhlZWmYh6L1iByq5wv2vseVxBXAWH4ZlG
         HHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737392368; x=1737997168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZkqVXI9MbwjNIaos6mTWd0B/kiusApTXtjScSIuz9o=;
        b=ZBABV6X0BXMnZhv2X1WWLxDCm3/di0SSPA4i30k9xKwTba44D1z3jiLZPWzWc37AgM
         4O/D8MO6RWYf8aYjeim0Pxv7t3LkSvaqFQeSOr2t32FXuAj5NSmI4uIybHeF7hF7q5OR
         T8s67ub9t9DCjZF21CozVUHx884RvMpyb2sIGXiR24GqT9Ay6C2RbehWc0zTUR/oJDUq
         3pkSvKk549jI6dcFgWZL+Ca4s8xnJ9uMby4pcOB7eDV3qn0JmL/khVL6LR77FQz9jGZJ
         gunbutDFVRcZb1M3hu6EGXKumPBn0EAdzOkR/g3/jFOk51pzELqSDpcGvsPAZud2yhS3
         PWkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy4Woi1JIniFMR0DJPGJOvqdjIDTJtrTBDCSR5uAwsOwM/WyyKXvIMHTQFnfM29lkro3/XN0YUmFmAbLrm@vger.kernel.org, AJvYcCXe77ChnUoiP+fYPzvDtED7MoysY4iJJvkpXk/1HOiwQ2EPchKPcmH+oPeqUcrt8A8+ZA2vhwQ4dHKkA0cx@vger.kernel.org
X-Gm-Message-State: AOJu0Yys6CPNyjA0sJJf7jafUx70aYPWWE5VqRE595pBLTeMGpdCxfXF
	r7cUTpM0j/3s0RFCxZBy6p8kSd3qGjqWaM9KsWUyDo2wba5gI5gguQrdlBQ+EEKEJrVXxdjigUC
	4XCHOzN0WaeiADKtsEIeFda+ERzE=
X-Gm-Gg: ASbGncssLf75dE2Tp/gfndOHj75RPc+6MXLurP7a2bbMlXsdqkX5cFWAVoWRAqU4+3j
	AQkQZSMootIUKNBwRvfkDT+keX0TXf6Stac2W96qLztzUTvo/fgg=
X-Google-Smtp-Source: AGHT+IH6zCDnNnGoZfdW8RVHy8XiGQEPQ/0uz30GpY/GODEywo99XsjckmFy9IqpPlWEHstk9bx5pRgRx7iE91r4wuk=
X-Received: by 2002:a05:6402:2105:b0:5d8:8292:5674 with SMTP id
 4fb4d7f45d1cf-5db7dc69528mr12111885a12.7.1737392367451; Mon, 20 Jan 2025
 08:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119103205.2172432-1-mjguzik@gmail.com> <55qxyg2diynlelvdzorhvtk4omfcobarious3fkxh4n33oezod@sju7s6sebec3>
In-Reply-To: <55qxyg2diynlelvdzorhvtk4omfcobarious3fkxh4n33oezod@sju7s6sebec3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 20 Jan 2025 17:59:15 +0100
X-Gm-Features: AbW1kvZq74DcCKaOaaVNpiz27xXeCSDxs2uqT_K742SG4CHaeD43A9tIibZ7vdY
Message-ID: <CAGudoHGTKftmuE33BfNo89Ac_uTuYueNzqxi3nZ0WpUNy8WXzQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs: avoid mmap sem relocks when coredumping with
 many missing pages
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, tavianator@tavianator.com, linux-mm@kvack.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 5:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> BTW: I don't see how we could fundamentally move away from page-sized
> iteration because core dumping is "by definition" walking page tables and
> gathering pages there. But it could certainly be much more efficient if
> implemented properly (e.g. in the example above we'd see that most of PGD
> level tables are not even allocated so we could be skipping 1GB ranges of
> address space in one step).
>

I was thinking find first allocated page starting at X, then fill in
the gap from the last one as required by the format. Rinse & repeat
until the entire vma is covered.

Surely finding the next page which is known to be there is going to be
cheaper than specifically checking if a given page is there.

--=20
Mateusz Guzik <mjguzik gmail.com>

