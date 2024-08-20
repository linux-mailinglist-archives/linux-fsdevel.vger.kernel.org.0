Return-Path: <linux-fsdevel+bounces-26383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39538958CD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2711C2199F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3A1B8E9B;
	Tue, 20 Aug 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sk+f2XX8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D08B1BDC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 17:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173874; cv=none; b=iPjlPOp90Mr2hPuCT49mq5pPs2LWfZIBGrPP3pAzRofZZeKOO75DfRrz09JlEibHzbSF047PCYiOLLm+VKHDDTp4krtw1s95eVnPhcu3TTX1OZGXLm3FM0+rPil0T+bmJnJrORi/mAS4i/h62SyLjlSu3iSHRl08vh7nZn9JsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173874; c=relaxed/simple;
	bh=tiYc7NMd6ShDpuQr2lsaMKA/SXnnL/yjQ/y+BXGtSCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vuqf+NrY/NL2AmWvcTFSPcGxB8stW4Z5a4A/xVusblbg4csAIl3y7VHNppKQiKp4Z1C4zwN//Whe0cG9T5LivU6Hb+cW8/txgr7MEswy0fUF43cFZj9s9DtYvGA9/viQgmC5mv1ZzYFKlSaCgXhBhlqtRlHHIAfHGTGcKzaOAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sk+f2XX8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so4869210a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724173870; x=1724778670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hH810C5Dvms5hE8tnsbYw9PLZwu3/ngn3PN03tyo3yA=;
        b=Sk+f2XX8Sj7KM+X4YqFqgPcAF9k14zHCcdPg5h3HlVYhtaLxqldYJ/Es8LechoieP1
         5B8B26tmby4jqTUEwyEC2RJpxVplwM1YS1jV1UWn+7qhT+GEm3UjdwXkFa3HnjAUu2Fk
         YJnPmy3oo5VL4tiMmRaJAUvr7e/FKV2iu7O+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724173870; x=1724778670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hH810C5Dvms5hE8tnsbYw9PLZwu3/ngn3PN03tyo3yA=;
        b=WSGyZraWGB3Jh1jiOKP1TtG11U6qR6Z7Arv08mD0epP/ErotyY8rNCgrgksgbs1cPt
         1R6KmSRbnN1EvuO0ZdUFNAHvt3PVpIn6/uSIaZ/SonlzTUiv14hVH9kAJHIrouh1pb4/
         Dwq9xdFs/SvlB5WPWvSybN/ndkaphhRmHv5MzAUeMHKZW8uG4TpKVNzP4zuRV4pjR6vg
         EP8vDzVGng9XiwW7+Niy8hxhz6hPY+IcjI65adc5nqiqcUl91yK2dMU21/fQS8GgcjB9
         9INA4arQdIt71zQe3j/O1r6kLotJwxCxzJtgZXEXow3X0AIyuA7q8YvfBa4snPkxk/jF
         YNTA==
X-Forwarded-Encrypted: i=1; AJvYcCWiM2xP7viF9MgEd3lPBRJ4ed4JCmzV5LrE4icGlj6ff9jOAsmX+3sF3Mowas6cTQNYnKt1EeN7YMmyfbsj@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdEjfVo43PeI287RLsI7d5pRieMVyq8mvPW/WXLWV29d5KElg
	/Qc52CGBN8JiL7pt5gB1gCMsRQQQ7Gg7c3h16UgEU4EfMh4nleOaA9kb6XomtpilLtoihkXQtxw
	CHuROwA==
X-Google-Smtp-Source: AGHT+IHGjq7Go/AIG1w1ZUCtUTeZkePmk/EP1evtkqBFa3AmrHkYDuvWgKiEVjh3RhYCOM3M4wyz9A==
X-Received: by 2002:a05:6402:35d2:b0:5be:d704:e724 with SMTP id 4fb4d7f45d1cf-5bed704ea8amr9755315a12.10.1724173870321;
        Tue, 20 Aug 2024 10:11:10 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f19csm6831134a12.63.2024.08.20.10.11.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 10:11:09 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso4483990a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 10:11:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVu72+JDpa6usUQay0+dtQd7QDFyTKlMYbzztjZ77+ODHjwZ3XGgSom+DE8hFjNdg2J5GRoFeEJ4Mru5gpt@vger.kernel.org
X-Received: by 2002:a05:6402:2350:b0:5be:ec7f:3bb2 with SMTP id
 4fb4d7f45d1cf-5beec7f6708mr7863247a12.0.1724173869043; Tue, 20 Aug 2024
 10:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820-work-i_state-v1-0-794360714829@kernel.org> <20240820-work-i_state-v1-1-794360714829@kernel.org>
In-Reply-To: <20240820-work-i_state-v1-1-794360714829@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 10:10:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
Message-ID: <CAHk-=whU6+8ndPZjXnebdW-LK+oVnp07e7EfY1M3yhdDpcinLg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] fs: add i_state helpers
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 09:07, Christian Brauner <brauner@kernel.org> wrote:
>
>
> +struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
> +                                           struct inode *inode, int bit);
> +{
> +        struct wait_queue_head *wq_head;
> +        void *bit_address;
> +
> +        bit_address = inode_state_wait_address(inode, __I_SYNC);

Shouldn't that '__I_SYNC' be 'bit' instead?

Now it always uses the __I_SYNC wait address, but:

> +static inline void inode_wake_up_bit(struct inode *inode, unsigned int bit)
> +{
> +       /* Ensure @bit will be seen cleared/set when caller is woken up. */
> +       smp_mb();
> +       wake_up_var(inode_state_wait_address(inode, bit));
> +}

This uses the 'bit' wait address as expected.

          Linus

