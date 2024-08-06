Return-Path: <linux-fsdevel+bounces-25055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0A94867C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 02:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F88F1C20BC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 00:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739FA35;
	Tue,  6 Aug 2024 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qqyh8JCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82765625
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902667; cv=none; b=ZF/IoA+WWWt3SDEqtl/tZQaWyjSSsqvfR6mGNQSKQrH46b88NdZdIEngy6DXVQ1O6HNHm5KJb4p49XGAbj14ABzYyRnkIAbDOHFdalcB18U6k2wpyH6/vA8EzjyiVao0snO99rlW8OuGdmNnSBS2Clir1GCMrfs4aKo3CGKrl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902667; c=relaxed/simple;
	bh=Xb5we0hKtC1a+HTJAPm9udt3eWIIdwbM1HzM7ETPluQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h14aW4q8TarBKVf0ECLi8PvkpjbnDCTyDBUWeBkMvS4dKhn/EG9Bu4+7h31ocEca/HGh93HZ9lA/Ojf/PAwAgkCiDMLplQaT7HVxwx/E/ofcBw4MqgRvObVK+2OH/s6rZz/fRTrjr6QrfflCAUvm77krEzaaL+28lob3US2ifT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qqyh8JCp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f025bc147so106721e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 17:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722902663; x=1723507463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTCkS44Tetf9a0oPeBsgznPySw61RsXspIyra6WCpIU=;
        b=Qqyh8JCp+15nmvH3r1dqNXAVZr0PpdDc0mXpLeR1t+vCS5tOs8YKBLKxjmMi0UohlL
         zYLNy4jBcsR85GjlPM9c25dOKD+30+Z0wlkRnJjrBzkCZhl4bA9hLDURvy2UEYfnmlts
         In+AiQxLNTmX1NCcQojIlScZ4+3haPB2Fs5co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902663; x=1723507463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTCkS44Tetf9a0oPeBsgznPySw61RsXspIyra6WCpIU=;
        b=hE5FJcOoLaJBECLlpgDbwX4mGEiLBHnn895GcHes3iOy3ZSVbinxbm9CoOkQ8OvAGT
         imSuN4qbZpM4Srupu32181oVljN/aremsKQIY27ElGELnVAOBxJ/9Ou3ttM2yuTJKoKp
         t+pEAwtW6NJZhgEK7y3uywx9AYGFwiSY/hWz8p4d3ElMcdCTbaA42PSu+bCazOz2yZfN
         Z7FIiXjkjS60+REDv4X9TBpfgip1L40Vy0x7vBTdVhqrzz87rNGedmmNZS5OwaCM/wg6
         vWaR5aieJN5utp0pTMYgSCVjoW9pwxl4/RiiSMlBN5MnuO6pm1b7udJQXlSoTNcvuD5z
         nP/A==
X-Forwarded-Encrypted: i=1; AJvYcCWAFzFnmuvw71pc9Q4K5dzbkT4punDjU9fCr4GYqlBYIkNcghO1NCniDMMmLjrNv4fLr/cDqPNny4XupqFXU6kJW7+VLaXDwQkb1qCssQ==
X-Gm-Message-State: AOJu0YwQA78gIPJGAuZzIaHJUDBUHbQTHog2QYVxbv8oI1n0lowpTW6U
	94hrUYZSu5jkpijIqAuIjC42zMrPfgqDJ+zakFSVFbx7D8qr0tNXpohYN0mQHEyEUP4DHi40EmB
	8XZebUA==
X-Google-Smtp-Source: AGHT+IEx2FZONdOE2oD+jwbLssIF2bl4icAEd5GeOw7EV/4b0ioeylDLjLdfBgzCEQXLrFwCb/o6dg==
X-Received: by 2002:a05:6512:1588:b0:52e:9fe0:bee8 with SMTP id 2adb3069b0e04-530bb363092mr8247039e87.8.1722902663208;
        Mon, 05 Aug 2024 17:04:23 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8860sm491532266b.209.2024.08.05.17.04.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 17:04:22 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so40434a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 17:04:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWQj/OjyMj/cZXY7fTwZtJDo9pSGJ9liOA7zBupaH2XYzkJno5DxnoJp9m94Kv4A2vb/d6a3r/7tAMwXe5utipOqQdWH2eq901mpsxHA==
X-Received: by 2002:a05:6402:5254:b0:5b8:d362:3f35 with SMTP id
 4fb4d7f45d1cf-5b8d362412emr7826553a12.37.1722902662242; Mon, 05 Aug 2024
 17:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803225054.GY5334@ZenIV> <CAHk-=wgDgy++ydcF6U2GOLAAxTB526ctk1SS7s1y=1HaexwcvA@mail.gmail.com>
 <20240804003405.GA5334@ZenIV> <20240804034739.GB5334@ZenIV>
 <CAHk-=wgH=M9G02hhgPL36cN3g21MmGbg7zAeS6HtN9LarY_PYg@mail.gmail.com>
 <20240804211322.GD5334@ZenIV> <20240805234456.GK5334@ZenIV>
In-Reply-To: <20240805234456.GK5334@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 17:04:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
Message-ID: <CAHk-=wjb1pGkNuaJOyJf9Uois648to5NJNLXHk5ELFTB_HL0PA@mail.gmail.com>
Subject: Re: [PATCH] fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 16:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> So... do we really need that indirect?  The problem would be
> seeing ->max_fds update before that of the array pointers.

The reason is simply so that we can have one single allocation.

In fact, quite often, it's zero allocations when you can use the
'struct fdtable fdtab' that is embedded in 'struct files_struct'. But
the 'struct fdtable' was a convenient way to allocate all those
bitmaps _and_ the 'struct file *' array all together.

That said, I agree that we could just then put the pointers to said
single allocation right into 'struct files_struct'. So the actual
indirection after the allocation is pointless.

And yes, I think it's entirely a historical artifact of how that thing
grew to be. Long long long ago there was no secondary allocation at
all, and MAX_OPEN was fixed at 20.

Because dammit, twenty open files is all you ever really need, and all
the bitmaps fit comfortably in one single word even on 32-bit
machines.

Those were the days.

           Linus

