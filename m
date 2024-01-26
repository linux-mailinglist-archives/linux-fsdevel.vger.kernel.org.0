Return-Path: <linux-fsdevel+bounces-9135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B583E6C0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9B2B213A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF0B2375D;
	Fri, 26 Jan 2024 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mg8KCWC7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610748790
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311055; cv=none; b=AzfWPWbl5Q+NRUwygiM258Zy1TAcBPAtrrEewblp9qOQ7/L53yANQZwI5rQYfdwF/poRXkNzlheQWoSvqSp82hGaF6+lrbRMkFyRKZ6vwB9iiVhekDMvDR+Q/Nl8tju+Kwk3c6Ty41uDAIizd+LzOpjwqnHC5byMSc8qoBuunLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311055; c=relaxed/simple;
	bh=QmVspYtlmSmjhcCoSiCpOR9/r0lxSB1GXdq7WVzBRp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ST7VrvTHbbr3vdeiQuZAlJARsWKZRsgcnSWvnbdol1jkh46PeN2/mbHaPdrG/xlhKFkMd3buPCY5x3axvpWCiTjSvWU9T9UODdhFlSRLWkZ1FgO1hUekH68TkX7S3cePiiXLDNaE+ZqM1rGeXItlr6gsFPsyeSPrtv9Pao4F4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mg8KCWC7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5100fd7f71dso1961268e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706311052; x=1706915852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VC+HuLvY2p6RWyDAc32xlp18wOorWJVU3mokVs6SBvk=;
        b=Mg8KCWC7ftFgTMxx63cRE+MeYtyaEvDFAaR6eOLYpTKbjBePAgmi8GTy/aUmLcBQFL
         Frzdy4Z3j+8IMyf6XEB4LLR9QaZSgi0P7LTOFhYA+tI01y/opJYak8ykUQxidXlx2ke1
         p97RAG3+tmE8KreC/b2qzOfN1qMzdaVWV3o/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706311052; x=1706915852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VC+HuLvY2p6RWyDAc32xlp18wOorWJVU3mokVs6SBvk=;
        b=r9feZ4q/SLDvKiKNR4TbybADJV3OWvYZ6dLa8sl+8fNMXQwxiveosb7j09yJ0mDJ1u
         5o7lt42Jw0hmsk2uj3yGrLxWf1AwL1SK+vytYCJ9oHqbgEtHKcfKFTp5QyItS0uezprt
         1BV4ecO/UAUK2G6G1g6rWEHjJ7iGgLA3DbwSbFZ7MV4CWgx+wt0Hl9JBDl2rBz6TWi8b
         MfO/33UI8FTWPz5WRFLgFOy8vrSVbacGYiobXtZ08uZ8DEL6EIezHbyEC5zdUjz+mGqY
         vv//yb1xgflwA5jQ2H8lAh9bG0JDuJD5ZogZ7quGBvzUq+WhnDpH49GtoUbz6gMKaCL7
         rsjQ==
X-Gm-Message-State: AOJu0Ywg0GusGks9GId5EriD/b5G3jOPaeTDIXe2Hl02O6Re2EoIRyzh
	XyEmFBuZl3DVuzlFxikcCuzMawBZvIz111XYXYcyCdZnYTyycO54xpFeVqgMo0BkwVlS6Bng1HA
	va8Nyrw==
X-Google-Smtp-Source: AGHT+IGPnLsKpHfKZvgKWbqZPf5so2w/bmtnsUn3lBRLxkselsJQbmCKHMBoQ7UbXuu9WHl1BP+ihg==
X-Received: by 2002:ac2:558d:0:b0:510:1a35:8bf with SMTP id v13-20020ac2558d000000b005101a3508bfmr278581lfg.51.1706311051966;
        Fri, 26 Jan 2024 15:17:31 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z20-20020a056512371400b0050eebe0b7d2sm318392lfr.183.2024.01.26.15.17.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 15:17:31 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so5523321fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:17:30 -0800 (PST)
X-Received: by 2002:a2e:7c19:0:b0:2cf:4a53:90f with SMTP id
 x25-20020a2e7c19000000b002cf4a53090fmr374339ljc.7.1706311050498; Fri, 26 Jan
 2024 15:17:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
 <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com>
 <ZbQ6gkZ78kvbcF8A@casper.infradead.org> <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
In-Reply-To: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 15:17:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
Message-ID: <CAHk-=whqu_21AnXM9_ohxONvmotGqE=98YS2pLZq+qcY8z85SQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 15:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 26 Jan 2024 at 15:04, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Maybe we should take advantage of that historical oddity.  All files
> > in eventfs have inode number 0, problem solved.
>
> That might not be a horrible idea.

Note the "might". I don't know why glibc would have special-cased
st_ino of 0, but I suspect it's some internal oddity in the readdir()
implementation.

So considering that we do have that commit 2adc376c5519, I suspect it
would just be more pain than its worth to try to teach user space
about the whole "no inode number" thing.

It might be safer to pick something like -1 instead.

               Linus

