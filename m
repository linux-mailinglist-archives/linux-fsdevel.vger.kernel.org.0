Return-Path: <linux-fsdevel+bounces-13001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A341186A007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A9D2833CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5B51C5A;
	Tue, 27 Feb 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8FRmN7G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315051C45
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061600; cv=none; b=iiBv2QO8lhpu8TIFpSyBFZaH5FvBDyIHgPRISfYgCIFo6DCfB1MAbdx5LLH6rOChvNJ84/nAjYLJ5lkUcBEgOybUrtV7gwG87s6RKOMzvp5vnGssNaNQb2VCrF8RYgQwlnMtaDe711uUM8YnOZE5ygY+AH3EizgrCr7Nd0r6k1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061600; c=relaxed/simple;
	bh=9peoPGj5/q2TCXLI7bAA5jfvvvRoQUDfAQ/2Yiq5k4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFTL0HM4c2rCr5UzJ//rWsQboJ2GQ6gsHYvr9qEUSrH0bulJGwoux2p94EocEueFOGCwOrTZT/VjGVS+hWaQ2TgwtQop7OdsMPoGiD3PLbK1PRU1OzqqTS38nEBDmFmxRcrL1mNU0XKtkYhnARxeTBuj/hHhGf97W1PcF+MUUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8FRmN7G; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68f51ba7043so29623926d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709061598; x=1709666398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFlVe52vmcgUbosXiq3PvhtKw3e5WR/xuo/RXP0QKdQ=;
        b=J8FRmN7G1cTPMDhakWRhOT6loxTg6TijS1t51/nkG6x6hjdjM2hKVmZyeGoK6vaOoE
         WbMpifvEHZtQWPXN4+OxXpLRKzR+PXRVTd7wBQqoOX2c4Rer66VAfreyOi8uz5TrGjo2
         MhMtjrSQTrPDioY/E+KlSO3MMPR/C6IPGquynsfuiRYhS5cwXub+HzbyCmoYnsgBX9uR
         ndQFd6GfvOmfWqGP9HtzDUQY5WpbggNms1vbk50plM3HPlP30gg4DLiztUhMPFw6lDZF
         DeOz9I/KEdukkGopgrDcsEUxndNvkVgEgSc5hbm5qMY2AYHS8+3EJnQ06waNnyLGeKmg
         /gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061598; x=1709666398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFlVe52vmcgUbosXiq3PvhtKw3e5WR/xuo/RXP0QKdQ=;
        b=ZZYJPRvRa+Kn+kQXWFY/Z1g4adMIoqz4efq3Yhk9ToFYhYPEqOtlG/tuKqMPm3Apyy
         sFp3pwiWjzeRgRyBYein3MoW0DDRSgBUsx00DSlW2L7U/dai4MbwrZLCdGZui1QQLyHo
         5TAQ6593mT7W3MgVHwvQpbasVdNimqFlk96Flnu3//N7plkBAcRFjEwgEv2/k/vGLz4T
         PorflyvlUquZRX1Bl4yJSeAmFqf0W31dmlU7xiGYCn+lM3o5CqoEgw4F1uZO9vt4ZMuj
         9ySuT3h8djET9HojZfHaes3+rtao+0Tq7cWpyQNUVnQmdXT525p6xJXZpjzcR7mu5s9a
         YLfA==
X-Forwarded-Encrypted: i=1; AJvYcCVVHR+utbudHRQOzZGsFgkCyRcmmZyYsWZE5sJ7AjNXybxIc4Sy/eUhKLGgFltlKv7Y9v9kI49P+XTe7IqI9oa7wcnpy7FUTH9a1LGQIQ==
X-Gm-Message-State: AOJu0Yy5hIoR08B324i+Wr+DcNd/gKe4nLdTWMPlGR1GSj1Lc/97t+n3
	XC+ewdWwsiKzr9VmH4HfTRXCj9tXEDH98DP3QAgYv2mXnX0AgF6GkEGCaZBZ/sRe8L42SNHaiWx
	QPRcx3vrfJB8V5kfaj9HV8porC+o=
X-Google-Smtp-Source: AGHT+IF6Pqba4Oj62dZ13qPQvtYdvjrUkeT/SQV1cTgBldVT7BNnaCz22tJX+822l2+6tdXEWyPDoZQQA1gXB2THr/A=
X-Received: by 2002:a0c:f144:0:b0:68f:e46b:47f with SMTP id
 y4-20020a0cf144000000b0068fe46b047fmr2884598qvl.17.1709061598463; Tue, 27 Feb
 2024 11:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
In-Reply-To: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 21:19:47 +0200
Message-ID: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
To: paulmck@kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 8:56=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Hello!
>
> Recent discussions [1] suggest that greater mutual understanding between
> memory reclaim on the one hand and RCU on the other might be in order.
>
> One possibility would be an open discussion.  If it would help, I would
> be happy to describe how RCU reacts and responds to heavy load, along wit=
h
> some ways that RCU's reactions and responses could be enhanced if needed.
>

Adding fsdevel as this should probably be a cross track session.

Thanks,
Amir.

