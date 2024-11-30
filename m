Return-Path: <linux-fsdevel+bounces-36191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32789DF350
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C730162D21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C671AAE00;
	Sat, 30 Nov 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJ6a9l2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B8132103
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002794; cv=none; b=iGl6CWxkdHoSQdFk1vzcvqv71qJYcD3gVD3X6kVx2kx2NgYsQYc/1XNitTLxSAp8p0C+xU16uilzuZ5kpc9lCp6OhypS8Dg5Ghrs/K49rUTzXpo/TYO+5ni22zN6bptn3bI/A3TLDc2AakkXLLB6NDm9s5eDZojul9y5yJncnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002794; c=relaxed/simple;
	bh=QIh5LPdBUUadt5QzHZ7uB31Jw1WDhsvFhK956BLp8P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OChXZV3Eud50VkT+gzp/OPngKCdn1PKXh+q46La6rZt8kIktolW4cuuqZtWyJIZynXktcnUJeuMGWtqVHuu2OkQqsWPKcqvDwDJ76q50WOkKRZ42edpa5hpW1oXjxXRbRt7eHoA7B3SvZjKDLimK01cE6rLHRkAzo1reVswSbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NJ6a9l2D; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso466812166b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 13:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733002791; x=1733607591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=NJ6a9l2D1YPUBuBIRuuzcM8s4stRr1IfjhkcsoBdn7cXxJffzU+gdeJcqMIt0yUIqQ
         ACsFbvpKRmxflqxns1LcaFRiZ26SnY5CKsgGcD6Ll+6GvEqn/hPAEAbu7kikn3CehATK
         Jj2Ew2ESTkaZTp4Y0oCSokWOe955wgYBpnoW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733002791; x=1733607591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pw67/dEHvgxdkhQ24l1tOBa/DcJdy1WA/fl+pLzPNUA=;
        b=s/deBkYIaOO+fpKxbOR+URaHpLNZmuzt0qiCSEV/kcVSbCBWVwWGbtPsqlfyQSUGu8
         dYlMllWIdMNThGkRB0ej0YH6HqNDMZKHTBDhf/Xcub9bLQwuHxV8NCAvh7p4+rUg6ZqU
         fR+MJmY+RY+76oa/SRzzQgE7yPiAAJTbkxSqxdQx3Ss+yff5CkthCmGR3ICXddtvMFCU
         NrIU9J/pYxyxoGvYTy2JLnu40oDJSUj4PWEeS3BTGLrJG+/1uHvDgdcFs+k/l0u9q2JI
         wnGhoJWW1iaWkHk5VXjfWon7eG9LIs+tzdvQi8cakBnInFdT7ETdGpklO2euLq+kx6cv
         snoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU542H8Niv9tMxSHwmqGVz0KMQmrTci3TN72p5cUTFWutNLbMNUJr1Se6JE+yj6FLlMq3xtrLRc68WeBOK@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwdFs68jmG6c8QISflGl4c7DUioA8VNsVE5GU/gXrxe0IqbV0
	nn+OeT5X/jLgt+okY97l7N2msRJP+FXLj+Idp+V5P3kdOCQC75re44xiqZ5sJ3uQ30axIEQDkXO
	fmNn/yQ==
X-Gm-Gg: ASbGncvsoOCG1Gq1fY+QBXjInCZ1Xtl5jsHO2MipV8PSFKHvWikOO8mf9GCSpp0fBPz
	IFJvVs1MfDv8GbaaBBd3S/VV+blXWD+5Fax8DDuM0v6RUH2Xjzgli1KzAsDyeQ5M6LmAA2ibRA1
	/5cyGIbCHCUszrqyBQsTH2rCFR3cZgx0LmL90g7DUPKYQPHW5eJS4jKm8Y6HJyBE3gh9E3UpSSX
	V/LHJZTPLoNx1sN5fR18svtyBKyY7pcdSE4avlv9DmUURhrXuegT6y9LwnrGcNvUNgp/Bww4cr9
	ztniIbQd9UdnvqUoJM3gJWPh
X-Google-Smtp-Source: AGHT+IFgmBdR54S0tqaFLwSGvF/RLNBmf23ofGAk4r4hhjiSW/N0yM3/Cew2DIORLXWwULVauOgz9A==
X-Received: by 2002:a17:906:c4d5:b0:aa5:392a:f5a7 with SMTP id a640c23a62f3a-aa581066f35mr1232491866b.57.1733002790654;
        Sat, 30 Nov 2024 13:39:50 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d40e9sm318144266b.78.2024.11.30.13.39.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 13:39:49 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa54adcb894so379527366b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 13:39:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvAza+HPm9vmZwN/2EPt1D8XfmM3DJXojV03n/ltGlQeXsdpbM15E3LNfHyYX4GBy9U94yjrN9ycLJr4QC@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1355585766b.23.1733002401515; Sat, 30 Nov 2024
 13:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
 <202411301244.381F2B8D17@keescook>
In-Reply-To: <202411301244.381F2B8D17@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 13:33:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
Message-ID: <CAHk-=wgSsP6w=wLeydMiZLjNwDaZrxyTx7MjFHo+BLXa+6YtVg@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 13:05, Kees Cook <kees@kernel.org> wrote:
>
> Yeah, this just means it has greater potential to be garbled.

Garbled is fine. Id' just rather it be "consistently padded".

> This is fine, but it doesn't solve either an unstable source nor
> concurrent writers to dest.

Yeah, I guess concurrent writers will also cause possibly inconsistent padding.

Maybe we just don't care. As long as it's NUL-terminated, it's a
string. If somebody is messing with the kernel, they get to the
garbled string parts.

           Linus

