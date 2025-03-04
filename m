Return-Path: <linux-fsdevel+bounces-43167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867AA4EDCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B997A5834
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636E253B75;
	Tue,  4 Mar 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S3qwXdlU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491372E3399
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117791; cv=none; b=RZ9i01B82c3CKmaQDzf8Y4gT+8dQir7F7YY2/txK7KyeISiCIHQVHNuvzy01qkTWT+YjkXu3BSsgy32yApRxVjaxYpP0FjbEHdhyDBGNc7/bUq2s7gh7F+g1RSrP/WjQl/brewUI0BwtJppdRzzoNoCs6g0iHC8vEN5KCDxBg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117791; c=relaxed/simple;
	bh=E/lviPldO8UrFKTRm5MbYphpUidw0Pz3EPd+7yG78tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2tC6xxPK0XH27eMAX/9MGKgQJ2XGdH31eiW+mQZwb+pvdchZHF8DYpCvuCe9n9C1li6dv2G/nQHBwRb/+kM+4zao1VtcegzoDbqm9bELZkmfuG5HHfr12JFDi46MITXtkLpBmZYp7gIBWWg+obY/WOtigxZ4Ecl4abXES8RcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S3qwXdlU; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso239467a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 11:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741117787; x=1741722587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfKi6jfA60js1G3b25D6zcCk7LBDMWoylnUtR/UrCsY=;
        b=S3qwXdlUFMOqSyw0oxK6rlku0jS6jkraFs7IvRneb555Pgs5N5ec+e9lRWkrwNLebc
         uuvnAzMyY0ZsaZfRXoJZL4OdYDq2lpCq1fib7hGYp4XA2Y14H+fxeJu7ZDG+mUClA+nv
         hVLHnrVIWY/rvG8yk5rYt7a8FAVuKIpAkMWDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117787; x=1741722587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfKi6jfA60js1G3b25D6zcCk7LBDMWoylnUtR/UrCsY=;
        b=BNKeIEdAZdZDpZgJICwRp2ZyZ6LbN8jhOY4ZTWeBHB2OChnyIMFYGNUtXCZw+ifeDe
         rSQzXG6Ak9GPFgUKpHG2d/TFUR4I+8GzpkxFRDJLDhj3eOxtZbms9niCcrtkS+Fli8XF
         o6v8EROUBAHwrbtaV4nErQFqc54lkbsAJJ5g/kYzRe9kSWLNFyqM6Ma0CPeKJxFKe6oh
         gSieYdedikDqmJ64bO1BLmxnyYzmO5Z5UBiZ/iwmb2iZStt8i7RFSDV7CwhpVdIZ7xG5
         P+k4ijnmgb7WaWPXCHlEg4Om99S36pWatfvmS+yJSlcbkLr+CgKOMmKx3ifPaJ878v9Q
         SeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCURxIYYQULcMNz62UFDDzkh52xkEgJN1HooE3DqWMsWmn3AbKTO6+NSZE45V9dvpoUyhFHocd2xUAbp5+VU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ZLNCmdFBZrctKg/YlUhEz3TM6LB3EgIq7F9lvWYotS3h7EgK
	T3T2tVoROMqReVkga3DseDoFRqqBRL+/C0NmFZehiXx+btjBU2h98cs4dIch0VuGFAdNq0R1C1N
	k8qEdlw==
X-Gm-Gg: ASbGncvw6Ffh/uSAIZdLaloa3TzJjPMyuAVx7JnI9SBJ7iMXNSZrN/tPWFeLNCS1/3F
	kSgNG2exKz9A+ORIQOsuk41v3/SxvPoJeRyFGBHO1FYadu0u8T52upf3XqKzavGKHTh+I0NBDT7
	QS2E/IoV1kdvROnU9KLPKZQeQYf/pfKAUZACKJ8y7t9pfFO/k9g0Y0NbcLhs77x7ll/nQWmON4r
	KPL/TTf+SyZ0+DM2Glltz2ogFcT9V2vv56Kg8vdQ443zhXmCbhrEDMf6ZrJJW+fMHxjwVdZmfX0
	858RszB7POq/TL3KWnYm4ZaOnprRzpkP0G6/EXxlOeh3SPE1JD6febbpJ9HofWBPN48EJAQiFYQ
	HEi4c81s6wh61qNCjD3g=
X-Google-Smtp-Source: AGHT+IG7XOB3N8j2dKqZlbbiaGxy40EeXU0//Nqnyaqc1jyXt+DHTrNVBKrzHjGKc0rV9neU+mjOYA==
X-Received: by 2002:a17:907:6d15:b0:ac0:4364:4083 with SMTP id a640c23a62f3a-ac20e8282afmr44374766b.0.1741117787184;
        Tue, 04 Mar 2025 11:49:47 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e3ef2f9dsm255283366b.45.2025.03.04.11.49.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:49:46 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab771575040so21423266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 11:49:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6i9jh2dyJEPAZIaFA9IDa2PlVhJqURJobJIwZgs7qDqqHPVDcfn836LrUI1hatUTxZNO6GmwWwF4WjNqD@vger.kernel.org
X-Received: by 2002:a17:907:6d15:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac20e8282afmr44370366b.0.1741117785955; Tue, 04 Mar 2025
 11:49:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com> <20250304154410.GB5756@redhat.com>
 <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com> <20250304193137.GE5756@redhat.com>
In-Reply-To: <20250304193137.GE5756@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 09:49:29 -1000
X-Gmail-Original-Message-ID: <CAHk-=wierLhQ7EWZKmzNRhBPh6cxCeBDoe-Av8Z0F=8NDXj_gA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrk3jtSVTjA57AGzmLsR0KaZmt8Rg4MlMimec-gk9RnYLUm_72TU3Ug_Lk
Message-ID: <CAHk-=wierLhQ7EWZKmzNRhBPh6cxCeBDoe-Av8Z0F=8NDXj_gA@mail.gmail.com>
Subject: Re: pipes && EPOLLET, again
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 09:32, Oleg Nesterov <oleg@redhat.com> wrote:
>
> I agree that my test case is "buggy", but afaics it is not buggier than
> userspace programs which rely on the unconditional kill_fasync()'s in
> pipe_read/pipe_write?

I'm not convinced any such users actually exist.

The reason kill_fasync() is unconditional is that it's cheap. The
normal situation is "nobody there", and we test that without any
locking.

So we've never bothered to make any changes to that path, and there's
never been any real reason to have any "was_empty" like conditionals.

               Linus

