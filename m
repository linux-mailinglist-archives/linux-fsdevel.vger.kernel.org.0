Return-Path: <linux-fsdevel+bounces-41297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75315A2D83B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8721666C6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8E1F3B82;
	Sat,  8 Feb 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EI7NCwu1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E2241129;
	Sat,  8 Feb 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739041565; cv=none; b=oqbWD9pzTsGVEt/oMXYuVClBtHCDZmApQW4qImTBdyFWmuwyt5y9cn+RhqgF6OZDycc8EEgQHIe3fwTLtMZvNRM/rLs0YI2flnPV8OjRYcu6RXxwVxAwsy6QLuYiWNCcYBpXspm4YwbBKQd2py7aGRKmCry28xDuxOSCKIzzvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739041565; c=relaxed/simple;
	bh=Qc1TkbcgBnnMnlIp9FOCRpKhwBc8BU4DABnj5Kl+BlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2hWczqv0exJXjoX6aXj4+oFNTN6lopiJmCiG43yqCzVUS8X8Y82zw35xIDPtLQ1cgfsp5NUEXXqGZo24VcnPIsC/3QlYwJDaONPswHZ/vbnI8nbhIiNcDjjFX/GWU1ekCteE5RipToEbj6+79dhg6z34gJep0Rkzp3Rk9aA6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EI7NCwu1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f664af5so34611255e9.1;
        Sat, 08 Feb 2025 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739041562; x=1739646362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYUcGbynj47h/K2MRAirCRYD25qma3qo+katu8pukWY=;
        b=EI7NCwu1LVRGFJQj/eCJJNGMXWmw3ykt8dgPC4G788oWGZWxyvHCGULoJnh6WVEog+
         H/bFbYfoaBDwUS0gbUtkR/yx45F6LSHrBsMpiyywE0D8t7t0hJViBWmlplEVxAXrqgRX
         pnWwrO+6+jcZUnO6jAhSr4pyPsJSBhWetyaKz8MGseIlEUqW+5J4wtykOjjApI8UOf3q
         MejiB8ZJDS6DNmKY+5BFQr63jKrUyQerFlXBN2OFURiJaJXL8pMe9Y0/sKucS5q14sZz
         p88Jv6tGaWX1Okd7UNyxjG1OqVKtAGVESUl/arthQvZeQ4l65zmcnztkgvip7k7JvJsY
         CwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739041562; x=1739646362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYUcGbynj47h/K2MRAirCRYD25qma3qo+katu8pukWY=;
        b=Ay6+ct8z/7g6mAJs+7q2E7zvbt+IPBDJsDNHzuullTnhPbJatI1tZMs+/AWdBwBBZw
         VGVwMcLa/v2678P5HamtP6Nb2ZYuXZ+qh541C0H7G2MnDIlmb2d22OG81zzN7PxPMTkx
         nbwDdPciflvhy8KcV1ACEdnd8n9Qm1fiOgwjNAT7pONzM2P7HjA+HirHxs+jBexSdvLk
         xon+n8M+3xXK/B2kKP7tEGhj7xg6M68W5w2dgEaLkwYWk4ReqzvrZZFQFrZNa64gWBt8
         lkp5o9V6Eo4RewUH+Lnyu81eDSRuUmYZFfpBa+G6XcqULR5S2onC7LOh6IivyWZDUavA
         nZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzceV7j3xSUcqCZGCUtuExsI0+UGaX1gBLoCePrczV2FM1LXyTQkAOyaLri5pb9HYDf9KKc2cg3ZZc9wGR@vger.kernel.org, AJvYcCVerfEPgQbnt/BLKQjMTMTDOTC1CEYG5S6qoSFPLIVprRJiQ0z5dj9cYjw4TtEV9zFr4PA4rmGXtXC0AFII@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkJO5xFuzYIPSR0gEwYjRVLJhTJrHt/tK7GBcHR+G/aC4Tp6G
	Z1eowdY06JreZ41HvFtoriupAlWlj2XFSgEaFgpmbhLYoTHpabbP
X-Gm-Gg: ASbGncuPX7rHrJ2bRqpy4W7myyG0GE0vHxS6jWsGXlI8+KTZyedwgYJODyR6CBotBJr
	Ro8eKhB+bO78X0WdS8lsiAkIp5U74Ug5UNUzEEgApUYsrMaG+nHL7c+a2mmRjWJI9IA6y8haDQ3
	sN44NsAWht3P86thZWWxnkCS5Tn+DO5RN+yGin1pilIZxyd3JVPTRQB+RZ1RNX9z0fhV4++9KYk
	AKSYWH56GMho+1Idi5wwZCOboS1QIPSKNft1vaoCETKVUZTAw2sq74nkbQFC9O7cLoU8rg5YPkm
	F6JFDdOQMFxCH2sWObbtTyfOwfB8KA+R1VECz9L5sMseQ6Kun+DNUQ==
X-Google-Smtp-Source: AGHT+IFNblGNxETUk8E7MRlCMTVW8TiIJo2DWkRcz/DW61BV+9yJVn7u8lFY/mMHcmdPnM8exjHv7A==
X-Received: by 2002:a05:600c:1c0e:b0:434:f218:e1a8 with SMTP id 5b1f17b1804b1-439249a8455mr59395005e9.19.1739041561427;
        Sat, 08 Feb 2025 11:06:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dcae841sm91787425e9.21.2025.02.08.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 11:06:01 -0800 (PST)
Date: Sat, 8 Feb 2025 19:06:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>
Subject: Re: [PATCH next 1/1] fs: Mark get_sigset_argpack() __always_inline
Message-ID: <20250208190600.18075c88@pumpkin>
In-Reply-To: <CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
References: <20250208151347.89708-1-david.laight.linux@gmail.com>
	<CAHk-=wicUO4WaEE6b010icQPpq+Gk_ZK5V2hF2iBQe-FqmBc3Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Feb 2025 10:53:38 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 8 Feb 2025 at 07:14, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Since the function is 'hot enough' to worry about avoiding the
> > overhead of copy_from_user() it must be worth forcing it to be
> > inlined.  
> 
> Hmm. gcc certainly inlines this one for me regardless.
> 
> So it's either a gcc version issue (I have gcc-14.2.1), or it's some
> build configuration thing that makes the function big enough in your
> case that gcc decides not to inline things. Do you perhaps have some
> debugging options enabled? At that point, inlining is the least of all
> problems.

gcc 12.2.0 (from debian) - so not THAT old.
clang 18 does inline it.
I've turned off pretty much everything (except page table separation).
And there isn't much unexpected in the object code.

Can the 'alternatives' be flipped so the .o doesn't contain loads of nops?
It'd be nice to see the clac and lfence.

	David

