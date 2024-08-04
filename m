Return-Path: <linux-fsdevel+bounces-24952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F7947025
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 19:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BBB1C20AC2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B0B137930;
	Sun,  4 Aug 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a20N6OPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5E2E3EB
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793665; cv=none; b=AWgpk8JOJOm6/pcFSvbY2DwhaKJTGyX6juthj4FRfejcwca63xipEMzSolCBjXAIelp3l5fJUjamF5sDCRbRsmbo/qXw4h4JLWVq6mgGjSEvr3IGW54OJG7HV+dS/JAdFQszqcUCqPNd61UwRKiT4i8Ms9nlPLy8IRom5XhXTn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793665; c=relaxed/simple;
	bh=bOgLAWiryn7xEv3dr/gbDtDBKa2ZiHm5hldnXh/vfMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ir2DEaTgOM/OPyiv1KndDeBsjEO7Oe8IcfGhJzBdMBymdCsU/yE/LT9BEYGHzOGj9nhg/TgpetZFmFOHS3cIm4sSfXHcYs4m0Jjtl6nNoF6iNjj3eOFF2swavTeP3YuQfjhaN90yB7L2BnZe9bSbGZzDlwtNkCmn5DjL5cYEYk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a20N6OPA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aada2358fso803624866b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 10:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722793661; x=1723398461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFhZkSjf7SjBgrgKTzxQPt8eoEIiy87wk6mCd461L7Y=;
        b=a20N6OPACT4t7hJSur6lcM6D4ohi4Alagq07VgYjymdFB7MkWhWnww++mSPfM7UQqq
         9O3azp1TmEXLYLvsa6kXS9PZAVO0skTAoPrLcILWThoF8bo8JxVg6hZGm7vKi+ZAG/lA
         yAfDzQYzgCs4wGTPwNlToLWD8Jh4r8EbqZG0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722793661; x=1723398461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFhZkSjf7SjBgrgKTzxQPt8eoEIiy87wk6mCd461L7Y=;
        b=ufRmv3liKKxBAGSxOiJ5eeHN+2BKzXi+7EbGb21EIkJ+acScTre1dQX6NNZtyZRTzy
         M3ppJiIRYLidrdJ+RST/7H7A6LBpMm1i6I2i77lgssPKWN5nWCMa0ygOy5b7WiZCYXra
         qWh4yyJr9zqKUq73vhF42J+SQopNekFt8BTvY0UU56nxEOXiItMEzbhMYwWVcD1QgbWq
         KK1HoxboxCWw9o52M5Rg9Y2rQn4fjM/BofU2FOmehMMxZ6VngzpYZ32yIzJJN9E794wa
         gggdDriP+iQDnIsvSvFOEBtm1at9Xuuvi0VaCAZW61ILN47VphN0SVmutAnYxiu0pHgq
         eYgA==
X-Forwarded-Encrypted: i=1; AJvYcCVaPLUxV26eVk254f4MVsjtTI/d4J2Ctj9vXbokAikgxuFIQV24gJq+LjWpbvmMu2d0yNSePyIXp+kNLU9M/SmJq3pDXEp2k3uZJQn/Lg==
X-Gm-Message-State: AOJu0YyxIR6xVGYpYqScv7Yu2Y3rVdCk850sdfNR4/o+z4/snSdil4Qz
	GeFNpBOejiwszgVPESYXFO57ljmjgp7OsHztByN6Hd/CyD0wr8UPLJz6RF5yBDKmrwnzTeMQiZs
	tM76v4Q==
X-Google-Smtp-Source: AGHT+IFhTqABZaEsCJ5hs1ksa9pE7rVYL9n6LwjvDGEAYU5+72uZdnZ0UR5cPTXmUu/+t6mCYqUTCQ==
X-Received: by 2002:a17:907:3184:b0:a7a:bae8:f2b5 with SMTP id a640c23a62f3a-a7dc62d867cmr792725666b.36.1722793661460;
        Sun, 04 Aug 2024 10:47:41 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cdddsm351443666b.81.2024.08.04.10.47.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 10:47:40 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aada2358fso803619466b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 10:47:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvlkLSpMhymoI+ggAsP1DR+hbf44FfGTQjPtHQOQZd1grwCMBLmpAW2m63rCpstyNrBqzFWgV7kqlkWr+VarkJ4J6A/MGp+4rm3aLZBQ==
X-Received: by 2002:a17:907:804:b0:a7a:130e:fb6e with SMTP id
 a640c23a62f3a-a7dbcc21307mr914595866b.15.1722793659883; Sun, 04 Aug 2024
 10:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net> <20240804152327.GA27866@redhat.com>
In-Reply-To: <20240804152327.GA27866@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 10:47:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Message-ID: <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Brian Mak <makb@juniper.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 08:23, Oleg Nesterov <oleg@redhat.com> wrote:
>
> What do you think?

Eww. I really don't like giving the dumper ptrace rights.

I think the real limitations of the "dump to pipe" is that it's just
being very stupid. Which is fine in the sense that core dumps aren't
likely to be a huge priority. But if or when they _are_ a priority,
it's not a great model.

So I prefer the original patch because it's also small, but it's
conceptually much smaller.

That said, even that simplified v2 looks a bit excessive to me.

Does it really help so much to create a new array of core_vma_metadata
pointers - could we not just sort those things in place?

Also, honestly, if the issue is core dump truncation, at some point we
should just support truncating individual mappings rather than the
whole core file anyway. No?

Depending on what the major issue is, we might also tweak the
heuristics for which vmas get written out.

For example, I wouldn't be surprised if there's a fair number of "this
read-only private file mapping gets written out because it has been
written to" due to runtime linking. And I kind of suspect that in many
cases that's not all that interesting.

Anyway, I assume that Brian had some specific problem case that
triggered this all, and I'd like to know a bit more.

           Linus

