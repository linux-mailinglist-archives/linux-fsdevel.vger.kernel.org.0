Return-Path: <linux-fsdevel+bounces-26863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AF795C334
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 04:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1655928472F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 02:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B21F94D;
	Fri, 23 Aug 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0To8DhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB741BDD0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724379920; cv=none; b=QCAyNm7ILS1hLEcirLDFuNIUdX7UNvF2p2/yRzMg5D9gM3oXYFiG8VI9nmii5ieGyF46vp7s94R2mF53WqJAbhRWm1dnxG2DHwrTpaOql2da15HVmlwmb0TEoCLi2eZyQpgfU92/dhBoXURDRP/dWsyK0BaWX+Cec5P3BJwTFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724379920; c=relaxed/simple;
	bh=o6S2YN549uQf7G8z1LSHPJ6PU5yIB0HjNFW98uVChrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4MYi41z99QjWEElbYlD0UDgTrwzzEqdao1ahGV86LHFuVVEff9UcIlD2ilZf1jQ+0OVyJilxpmNjjA2fvp/HL6P9TgfASP1vDf5swfk1k54GZpJtR3moiIUzOocTps8Qu9YAZ2DjnuPmZAbsyBVJga+jEyQ9Hx9bXidunb0wGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X0To8DhE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso175206566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 19:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724379916; x=1724984716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wjdocqlSu23OEKTJsnRFrf5F6bKR+cZ42qsi4I12ADE=;
        b=X0To8DhE8ZgRGU5LFTwN3IsBismTeaH2LHRjWm2JRdnTolotmlK0E4hUAR+Qa7S2Zt
         0cWyyWE1L/Q4P8SUNk+ftY9cBM8uMDg8mSSXE1DkQdfdgALPFWOPNHv8krwvgyFoDsEL
         VxVhv6Emn8zzzR0lu/uF7qcqoRPxeoLIqNbPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724379916; x=1724984716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjdocqlSu23OEKTJsnRFrf5F6bKR+cZ42qsi4I12ADE=;
        b=NrssoETCHL9FM524wt6DDM26QPS2c7xq4QAXnXWqqwO/PVHISGjnMLcdg922PmCaQg
         dXvAMykeOX+sQQlL6eRXBmb8B87bQO39d6ummwopF7K5yd0neTgeyy9SBlNLispRsau+
         fZ/YH7xp9vspKiVnDWb1HJWhrgGUzVFyJXTnFKJYrdBXkFvMFH9MJMx8oSs5nXnJeNNK
         GotKKJjkn2GukaQ/UqR+HjUlwkTSpg0zdpUOqbxB1GsYnVdh6oDvA6Mk8fgT28310Ptw
         BEmJKacD39VV7TwvNAjvZQANVN5uCC4eRXMQrHIQxO5BIuj+169dMUrcYAmAQFgAQsWd
         ua8g==
X-Forwarded-Encrypted: i=1; AJvYcCU1XyjkmcWIrGL9gYsTmMWTaR+8L0UDdvR/ejuOEKRl5K42sJisxfzQijjTY+3YsEq/NIReGn6Vzwn9aMvP@vger.kernel.org
X-Gm-Message-State: AOJu0YxGg7OCgW2RRkJ9J5EJ7mYCo/ek3JwRlcH277ghShzkDk4UchRY
	hOtHxR1ZRLeSWCqclYTGgr1vF77UWj/0eic2AvNHJKlH7kA/D/UK6r/nhN2jVn7qM2npGG+JQs+
	dL2jRUg==
X-Google-Smtp-Source: AGHT+IH1RoLLfJvdtjKY/DxLSIfWufLS0gtTHb4ZCl+y27Tsi3F3DSujU1flB7R+EoxLDZU4w7qygw==
X-Received: by 2002:a17:906:d54c:b0:a86:9ac9:f3fa with SMTP id a640c23a62f3a-a86a54aa691mr49510566b.50.1724379915922;
        Thu, 22 Aug 2024 19:25:15 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a5903sm190224666b.78.2024.08.22.19.25.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 19:25:15 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so1980495a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 19:25:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqleebseTaasy2KuFZTnFXyL0AuMPY+73nHEpZp6HnH+6UnN/utG5qf0CewSka6VNQRg7AU2BxQgNxsfH/@vger.kernel.org
X-Received: by 2002:a05:6402:2115:b0:5be:de37:80dc with SMTP id
 4fb4d7f45d1cf-5c0891ac3b1mr304940a12.37.1724379914551; Thu, 22 Aug 2024
 19:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
 <20240821-work-i_state-v2-5-67244769f102@kernel.org> <172437341576.6062.4865045633122673711@noble.neil.brown.name>
In-Reply-To: <172437341576.6062.4865045633122673711@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Aug 2024 10:24:57 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgocMvG7Lcrju7PgnWfUfsr3fEVOk=gwmGOhtTOdYdNjA@mail.gmail.com>
Message-ID: <CAHk-=wgocMvG7Lcrju7PgnWfUfsr3fEVOk=gwmGOhtTOdYdNjA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/6] inode: port __I_LRU_ISOLATING to var event
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 08:37, NeilBrown <neilb@suse.de> wrote:
>
> I would really like to add
>
>   wait_var_event_locked(variable, condition, spinlock)
>
> so that above would be one or two lines.

We don't even have that for the regular wait_event, but we do have

  wait_event_interruptible_locked
  wait_event_interruptible_locked_irq

but they actually only work on the wait-queue lock, not on some
generic "use this lock".

Honestly, I like your version much better, but having two *very*
different models for what "locked" means looks wrong.

The wait-queue lock (our current "locked" event version) is a rather
important special case, though, and takes advantage of holding the
waitqueue lock by then using __add_wait_queue_entry_tail() without
locking.

"You are in a maze of twisty little functions, all alike".

              Linus

