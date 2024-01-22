Return-Path: <linux-fsdevel+bounces-8483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C288375C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 23:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C971F24D16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DE348783;
	Mon, 22 Jan 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oiigjfjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D1482ED
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960970; cv=none; b=OU1UDKfmWXB5IoO1Gs+meQQzbIK7kEujx7ybV4Hl1R/NoA1/h+uM2IAGLVgkzRdTBofcrOUZWjsJvBu99A/aKHElq4+bLzniCjk0ubPyAN7HgEGQCooJ0RxiT2P4Bk4CG1RtGFyQ+Tbjx3Yk3mMp30IUNF0P3CZvOGPHFuzsD4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960970; c=relaxed/simple;
	bh=0hp4qAvrOKY8LC7aAKY29ksp0u/TQ0p/ryQA8d1FRbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBazDBIQYZIqospg8TR5LUwkNNp5P2jg+mX96f2JfAIASa5mqpLeyxzkRimQF54Vo4mKNEi8lEtYx5qocNn40W8KOdD7TqqSZn0/a2gkBHzgRulOPKgRx3SnBreisbWUvu1Ih+dzZl6gxcQ5cmyPX5btUf3+Ie7+oeAftjgqxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oiigjfjh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso3645869e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705960967; x=1706565767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=Oiigjfjh1FOT3dWADyiBvbCTmFIDuugvEH3QUxZafJns3L11Pt46kookMLfcfehMvY
         IRympvnxlfV6KykDmEKM5TfLsQrCvFcbhsOTugbQJQLo3gL2zc39zwFew3mQjtNwZuRZ
         xqMoofL4CzT+40rOdRkxhv9CY05jeScesslU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705960967; x=1706565767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOSAIaGnjvf6CCjF3fmWDAvl/DrTsNgSFwohRJOla+4=;
        b=dyq+sN5omf38IzJ46VvxzCJjCea6yCwL01w3ae6zMys+lDg/VMmjvSgCoUSv46SNga
         YPhIma1tNRJfd9Yx0gkcKBEfqKAV1jpCVbb8N//VDhYqzzPb8RgofYuJf9PdlWugCmtc
         YtK0MdF+Anal+SP5TNMm+l+927P5YxAxkKcBlaqJzsxhNK5qKzEKZXwcTfhLPBbESId0
         UeyVS65JkG4yQc4fCGlAthkiwY40tOISIiz9fEsl7sknPC/UW93/JH7If2O6iy2wN066
         UEx1p97m0lqK3lN8qFH2JJyApWXYsqs+yMgY4O/a1bf4+ChC+T+6tC1suJnHyTBQELiE
         5UQg==
X-Gm-Message-State: AOJu0YyeNdesDBsY5NuEFCHXmRF3F3BVLX/vQCfvfm81d9rEKjo99SOW
	SDRD2rHozjpXXcNmptuaqVIiBE62JT4cpZa936w0YPKGsgOuNlF5lFbkfyTWiY7/fl5p1EE+uRR
	3kGr6fQ==
X-Google-Smtp-Source: AGHT+IE0I+fi2v+QG0OzdXOV/pkkjDxJvd5UhA8nkFzDj11rXCtJiVDCrjkinjuSIh/BKso51ZKoMA==
X-Received: by 2002:a05:6512:1320:b0:50e:4389:12c5 with SMTP id x32-20020a056512132000b0050e438912c5mr2304725lfu.14.1705960966948;
        Mon, 22 Jan 2024 14:02:46 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id a25-20020ac25e79000000b0050ffb24cf99sm493475lfr.101.2024.01.22.14.02.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 14:02:45 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ccae380df2so36141681fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 14:02:45 -0800 (PST)
X-Received: by 2002:a05:651c:1a25:b0:2cd:f914:bba7 with SMTP id
 by37-20020a05651c1a2500b002cdf914bba7mr2536886ljb.34.1705960965293; Mon, 22
 Jan 2024 14:02:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116225531.681181743@goodmis.org> <20240116234014.459886712@goodmis.org>
 <20240122215930.GA6184@frogsfrogsfrogs>
In-Reply-To: <20240122215930.GA6184@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 14:02:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Message-ID: <CAHk-=wiODW+oNdoF4nMqG3Th7HhPGQNQekDvw16CvgKvaZArRg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] eventfs: Have the inodes all for files and
 directories all be the same
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 13:59, Darrick J. Wong <djwong@kernel.org> wrote:
>
>          though I don't think
> leaking raw kernel pointers is an awesome idea.

Yeah, I wasn't all that comfortable even with trying to hash it
(because I think the number of source bits is small enough that even
with a crypto hash, it's trivially brute-forceable).

See

   https://lore.kernel.org/all/20240122152748.46897388@gandalf.local.home/

for the current patch under discussion (and it contains a link _to_
said discussion).

           Linus

