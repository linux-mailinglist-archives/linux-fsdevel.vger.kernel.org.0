Return-Path: <linux-fsdevel+bounces-12713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3B8629F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 11:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92593281CDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D2FBE9;
	Sun, 25 Feb 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoGJljOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E2EED9;
	Sun, 25 Feb 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708857454; cv=none; b=TxRD2Rpcjb4RoihGjZ75gnYHF4IL5ev3Q7S1SF5hNSX0YFDlgECB+x/v23cb9tZG6GxwTjYXG2XP53IXll6s4XNbQSNypBIDpefSxR4b/X24Fs3gy0dvhNW6dc0z5ja8P5k26Ab0EkE9UXsWHNfCTXDn/XVZ9x+xa1is0YiPS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708857454; c=relaxed/simple;
	bh=8XceSC4XiQUGjHtYGKw/HJe1WVYOdwDDvvEmr9+sP4M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jPyeuX9X7324woGeCYVyQML1HFE3/ezkpDYRTtbbCkPCxTS0LlGd8VdNp5PT9AOFvyD6mzR1ClwxdldZ8w3c2iUq/kEfgRddLp5qi/aloGGJ50CMufisy8NEmZ4vrRPerPEWoZh71iQR3Bj8SfE10KXcDq3+FqQhEULnpUU1L0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoGJljOH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so2776707a12.0;
        Sun, 25 Feb 2024 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708857451; x=1709462251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8XceSC4XiQUGjHtYGKw/HJe1WVYOdwDDvvEmr9+sP4M=;
        b=GoGJljOHLclDyJi4K3Y8ai8XYNg4jN1dGsEL1lSeS57iz0BT+nUEfO+ODDvO2eJlxe
         i1GUii+7A8sYi7CpBP1MQOJxRFFWJgpkTjU3+k9MR9kxP1/bj7Tc08/RfGInULmpu9ma
         eeiDJefogfpSf9+M8UyF7uSgM/RONapMXThsA+GmOYKxSSsc0nxsCD3h/sXCtCi40Z9E
         UvNMnenkZAEUfNn/dIibXy6IlqKJsIbBe8/n21gzGEbCGNSsslILqOqZ/xaPTxYlWPa5
         8sxfEJUsDYERUIVzFKqLz1JNVVKtESJe35bQ1trlcapXwdR/zIZmKIfAUu1XaLpcWdei
         e+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708857451; x=1709462251;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XceSC4XiQUGjHtYGKw/HJe1WVYOdwDDvvEmr9+sP4M=;
        b=qVlIiVhaSz8WUNRlfi3Vfj2czHaoUWLgJRW44UAfUWmFjP+kzB25UCRppMP2Vem/cz
         lNAK0A1Joaz+7LCCVthpy85O/02C6H97s+rVQW/UDXFxZrRLKLeourUREGq+iAcRQ2t4
         xy/jFnYFaeXkt9INcdR7eqcqsEQEMBya9DpQCEwSwXM2YU3HXQUZICru+7iIECWq0rS1
         1Jaj9Swx1Yn72tEO2hO80TaIvuRRs0lk27U8LEkjIfQEPQ4jxU4+DAf4xXVRLUTqYTAk
         jxC77HlX7ghJCSus3DLu5COSrlFAlGnIi3svcOIrW8mJo18bRxlXdkWNynsV9+SKw3Um
         ggFw==
X-Forwarded-Encrypted: i=1; AJvYcCVg1ml1M0+GMLPIJFH0gH/w2BSt9FkfPuj50RqhH1G+2uihNu4S0visGFHw/m99yht8WgBqNq37x/eQKXg178CXuDZ9zl4fr25tPz9aLcJa9kvZq7VBgzsUyULl5z0EXoqGZp550SdzINorX57t+5kkR02rr9VAvpCu55Dpe6yU0k8yom2/m9g=
X-Gm-Message-State: AOJu0YzsJzukwJ4ZkMEqofp3ZN147VN89hnxoJx8BkqruADSNJTXt9WW
	WAky91cjI5Ye7tygYRZRxTtqFzAsdf1KkM5vBwTUhuqJdgzEPsns0HLBLS1OAcEYBlHpLUv4n2z
	sJoLWshr/Ybj9kJ2bVM5nzGxoFg==
X-Google-Smtp-Source: AGHT+IHJZR2wD5h5B3N8I5CHHJ9KO3tgNlwvjXn0nXNnar074d3BlB5jN34vc79PlKK3aBA4SyrSImPGpG1wG8CRJUk=
X-Received: by 2002:aa7:ccd8:0:b0:565:7bca:eec0 with SMTP id
 y24-20020aa7ccd8000000b005657bcaeec0mr2993509edt.23.1708857450979; Sun, 25
 Feb 2024 02:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 25 Feb 2024 13:37:19 +0300
Message-ID: <CACVxJT8T8u+XK7GnyCus19KDVqfquGbAM-0x8bSFgKTeqhD2Ug@mail.gmail.com>
Subject: Re: WARNING: fs/proc/generic.c:173 __xlate_proc_name
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> WARNING: CPU: 0 PID: 429 at fs/proc/generic.c:173
> __xlate_proc_name+0x78/0x98 name 'R1/S1'

proc_mkdir() didn't find 'R1' directory.

In other words, you can't have slashes in irq names.

