Return-Path: <linux-fsdevel+bounces-30269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E555A988ADC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 21:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8627BB219A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F61C244A;
	Fri, 27 Sep 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oa2F/oQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEF13635E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466457; cv=none; b=tPTmseYUD68ysxD3HrbONDJx22MLXW3nzkgwYus6mtXIMvfiF6ruBrquSFLcZ2UFCZb1ZdoioFKV7i7dKwwhNUD+ZviHRMEoRPC7ZInOP3d97f5UdcODQRkkqe3yjuK4M9RACQm/PB8tf9iQ21nimd6K6LLxQ/vP4GMK4CjiiAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466457; c=relaxed/simple;
	bh=K8LRS5lXD/WAyJR6Fah4BgddLYPaV1DDmCZ44umWmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ8WR4t3SBilGzWhx24QRBfZNN+kvwQzZTDqEBnMVxaOj2vocSqJFFyeShhv2pDoaBzUeqZy23+CLkHhzjbIiaikSbVAD0mKLISwvZPJa0Rh2N+sieHx4AHf5SJgE1i7QGDJH5jErPyJqgMMWmswCFBc1KF9CUsw8WLiwT+42jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oa2F/oQ9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d3cde1103so316041966b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727466454; x=1728071254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53HOZed5FIyfCoU16tivT3Dit2MdvJuxNAeOr42Twwo=;
        b=Oa2F/oQ9dgPgO/NeiWR3W+Hb23hXNPwEMxrtlXjlorWsEoENeqF5ew7uyNzmIoSRq5
         qP8rePAsiKKl+iZ/yjXBZecdqMq0Tr4+ZHhOMtWZMAw1bDoR72WbhPN/ukvAQDzpDT8r
         Ce9kUPTistbmkAMpOv4E0m+Rb8NngeEf3Kb0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727466454; x=1728071254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53HOZed5FIyfCoU16tivT3Dit2MdvJuxNAeOr42Twwo=;
        b=PryhyX6/2GITnQEH1IeUFpIpTRgCcZRzT4GqXIK9BUJRXt7Ks0w4yAidDOaxW9CYg7
         7Sg5wgOj13gBfWM/WvOfRyK9Ch/ftEM0XPzzeY3udvtJM/Bz41gqvmWWRyv/6n5CK0yu
         yTmJlZi4w7foeoPTlTriSRnwyCkSlIm4J5+eIFVvb2zp75Lt3YATxThV3QRIoI71HkO8
         dgJLjkB40c4HFcRwraB0+fURaPjr2eq+0e5Dye7xiMS9nsk/hjkab62twucyFKg9bdqn
         bDAXToO9UJi0zDc7B6Gaokrr3v2hXOYjTWjMEDHfPxWUhu9/eUGC3JV6cC/Yhnlt4NsI
         HUbw==
X-Forwarded-Encrypted: i=1; AJvYcCXh9QlXo60eyQcbqRLOeuZpWb7icMTwlgnrzL4G6Sn39WJYhYGozJAc5UUS1knGz1HbhL0Yz0geUbnU+v68@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZtKcV0f6Ck+yWDHrLEYTJNrx+Sl1Y7qAYUe0B5Du6f+vUsw1
	f8p7/0f7HPMtwRpX5bHYaCzBAvI7vvP6/iCfCwE0cmJ3TGDDo74GgiGyxoLXWgZ8WOzT62EsQlv
	eoEAhsw==
X-Google-Smtp-Source: AGHT+IEpoMtC0vfWRy/hO3ArHcbxCJfjensktBn65xKLodBuoP6EpippqAi2Z8gtaCTd08aDYHIlDw==
X-Received: by 2002:a17:906:c115:b0:a86:4649:28e6 with SMTP id a640c23a62f3a-a93c4a98d6amr369216366b.57.1727466453780;
        Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5aadsm168340566b.79.2024.09.27.12.47.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8ce5db8668so393923766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSsFA40+gX7aIM2CollY1QPBWm7fcYUmUz8QEz9y9uJuIKheee5qsXsWXytJ8OZKPTJtM57+SJ0pqGTlo6@vger.kernel.org
X-Received: by 2002:a17:907:3f1c:b0:a8a:837c:ebd4 with SMTP id
 a640c23a62f3a-a93c4926f43mr470113466b.27.1727466452677; Fri, 27 Sep 2024
 12:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
 <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com> <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 12:47:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Message-ID: <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Amir Goldstein <amir73il@gmail.com>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 05:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Too quick to send. I messed up the Fixes: tag.
> Now fixed.

Applied.

However, just for the future: please send patches that you expect me
to apply with a very explicit subject line to that effect.

I get too much email, and hey, I do try to read it all (even if I
don't answer), but I'm really really good at scanning my emails
quickly.

In other words: sometimes I'm a bit *too* good at the "quickly" part,
and end up missing the fact that "oh, there was a patch there that I
need to actually react to and apply".

That has become more true over the years as the individual patch count
has gone down, and *most* of what I do is git pulls, and most of the
emailed patches I see tend to be things that are for review, not
application.

Yes, I picked it up this time. And maybe I even pick up on these
things *most* of the time.

But I still strongly suspect that to make it more likely that I don't
miss anything, you make the subject line some big clue-bat to my head
like having "[PATCH-for-linus]" header.

Because even just a "[PATCH]" is likely to trigger my "patch review"
logic rather than something I'm actually expected to apply, just
because I see *so* many patches fly by.

This was your daily "Linus is all kinds of disorganized and
incompetent" notification. Making things obvious to me is always a
good thing. It's why those "[GIT PULL]" subject lines help not just
pr-tracker-bot, but also me.

Thanks,
                    Linus

