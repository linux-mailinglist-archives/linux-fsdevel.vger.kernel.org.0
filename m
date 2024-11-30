Return-Path: <linux-fsdevel+bounces-36190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81109DF34E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 22:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 443B0B21215
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 21:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B61AB6F7;
	Sat, 30 Nov 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZhUzwRpO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B21A2540
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 21:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002469; cv=none; b=aypZUQGcrzFQmmfJiowIiwOnSyrbCDzm9CkYAX988YM5hJVj5EkQXzRx+fTGy/EbGwwrn4PKjQbtQuExPEN5AUWAyv904mWTHmgwhOlwRH15tcD9NAqrh0wSSoD306roxXTcw9jaMg3kCfBblEKNSRHaZknsYF/Ckhv7Q2ekGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002469; c=relaxed/simple;
	bh=9dW6bWsFGFk529Smtr9Gpb2nVhhhhNJjaw2Mew5NbpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLtsIy0Bi6b6hf7RZKyZF5K5783tNJ2yUjMDq98axL04s5rESN1+9UYV7/lTJbbx11Gy7a418SQang1Hj9Eyt33rvAQ2996htSDztAxshQQJ1CW2rWgfJFV5oqP4z/EsehoOm8nlt4IyRQ7iEiDv235THWhUIz54zmCeLRlvkkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZhUzwRpO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa549d9dffdso450955466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002465; x=1733607265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=ZhUzwRpOSGdelDJvL6ta2G8xuA1qBd/9/0OkfN6hTTiK2lz7pO8GOc4e9y5QYoK6i0
         pJOe9y8m682QBLiJi4lRFMTzrC/8Vns0YfCqLTQsOYs3SusOBo3V9weP6sHgPbBFAO0y
         FSFKN59N460NzNNT8bRvSHiDoKehAlFyL3AtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002465; x=1733607265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNyysF0czXG+9VpzTWGbzEwJuxUcYyjjRR4QdXrg+wU=;
        b=h9W7OYUCWlfNaKiij/l90jZgtQ1ZDbp6pnxeQIzxShQRDayo4mRKeKuMoAXK4KjKAg
         h5C2iUnTrf9MMYZKhP31X3wV3Ey0TaZK6zTyW7jpJq38jZPRLQEtgLh7fIqFYcuO4cd5
         kk6XUkfAkULA+vmM1iTQ1Nlbh9T4U7ee9vVzSX7QZxakq0NdKx1rHE2Hx94oldj3LWnb
         5xRx6Nw1iFGEoifS9kq9m7CM/xSuQLpE9VoDaR4RfumcbDk640rt8Invdz90O2vbA4uK
         U4i3uuZZjb2hCSdbySP1tpLMvjGD+kW0usdWPhm0w0WB8YdEDD3KU41prupf6BLOgJRu
         cKhw==
X-Forwarded-Encrypted: i=1; AJvYcCWQaScqPjllm63alHnk3VgYy/y46AaTEZYeTMgB0ZWj4IpoU0OIjVWZRfFh9LIJGIja3ekzjUzapCOpQTi2@vger.kernel.org
X-Gm-Message-State: AOJu0YxlqAmlRCMBzYq6eSkWoamd5yTTFsCAANFoqoK1OiaH81ULo4K8
	Ro2lWNPy2ry2/n9/cR/jZLpWhWyCCW8CFQ2CkCd58LUPLk15ZGw5Nu0+06/oghppWg5huXosR2+
	X+swH1g==
X-Gm-Gg: ASbGnctouYmBGP+DE+DcZe6ApTlzrvfDS+lgTC1tdM76M8NFWFNXiGA0P79/zjf1gLo
	cgoP9uJgjIO4FBOEDLtUFm62TNXdXEDvcqFKl1HjJyoxv+I/uW4VHQt6f6Z3gaLfRhM2dDVr801
	LrTr1esJxDNi9a2aR1YLqBA2NTmnZ50Mh4Phy4Oqhj+Smc0X6IpjWQHoMUr1qFJRt3mFxBEAzb5
	xLpmBwe9+EIwfimqmTuDcTGSpR+WBXvoSxo55HD99E/t58vQntsQg+1PwaLi3x8Xs3BT1xUj3qM
	rq24yk2gwoGbk4b3M4UG+y5q
X-Google-Smtp-Source: AGHT+IHCT5CagBCc4Ep5aFfaCTyFp1qQIpn9e9qURuAl+6I9BPmK0cCOOF/bkRNpfsP2zBA9+qyCtA==
X-Received: by 2002:a17:906:18b1:b0:aa5:3f53:ad53 with SMTP id a640c23a62f3a-aa580f6aec8mr1340245366b.26.1733002465299;
        Sat, 30 Nov 2024 13:34:25 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd66e4sm3181220a12.43.2024.11.30.13.34.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:34:24 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa549d9dffdso450950666b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 13:34:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCgTkJdGEFqdM+JXnFsQWLuKKkpcwMykALyXuxKOXQ+8vEigvwP+SPjtW8L7ooe6q4V6TtYphVlwrJjlEY@vger.kernel.org
X-Received: by 2002:a17:907:ca20:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa58108aa80mr1263837466b.54.1733002462844; Sat, 30 Nov 2024
 13:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130045437.work.390-kees@kernel.org> <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
In-Reply-To: <ej5vp7iifyy4s2faxsh72dytcfjmpktembvgw6n65sucyf77ze@gmbn2bjvdoau>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:34:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Message-ID: <CAHk-=wgAVEbjFzhNpqvgTxKymCi6uE5UO7BzyB6ch7pDiUz+Yg@mail.gmail.com>
Subject: Re: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH)
 case
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 12:28, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> > +             /* The dentry name won't change while we hold the rcu read lock. */
> > +             __set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> > +                             true);
>
> This does not sound legit whatsoever as it would indicate all renames
> wait for rcu grace periods to end, which would be prettye weird.

Yes, the "won't change" should be "won't go away from under us".

          Linus

