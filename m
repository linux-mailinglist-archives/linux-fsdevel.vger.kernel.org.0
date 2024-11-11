Return-Path: <linux-fsdevel+bounces-34262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94009C4250
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049A1F23D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96481A0BC3;
	Mon, 11 Nov 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="loBlbowO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634BF13C3F2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340944; cv=none; b=VP603mO9Geh4WCXliDd2yyVtDAxcOG/LoVQR5HvaiivNtT92wsRiMi7QDI9imUG01gHR1BpicZzhbjbdY3SvAaQKJh7njF3OAp3WmWS1nsAkcpAXdAV2Paccze7BeKXk4gFbgE3Bbq9YnwK/wGSmelGzPI5ymyLrcXGER6Tky/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340944; c=relaxed/simple;
	bh=0cy4vZC07EBotf6zsHDieoDVCUiCFiapabAEYNa0K+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNi3Q18dXg8an+8ur+goqV7rneOKTheLBMfDuUpPSo4AY9MOFYCKSZGfmF6jR8q6Wp+j2ewkzxK+41Jq3tZO3IBLyS3gXju9JuWOA/neAw+bDj5GeWctmbHRKgljM+tDDdVmGtfda1wycypaKUGKMCxmybgnRXd3yVBzadgXphI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=loBlbowO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b15eadee87so324635885a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 08:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731340941; x=1731945741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5RXHuOlZAH+7ofZB+9QXL8bQr7lreW4Be7wakDlo64=;
        b=loBlbowOSM1HY6/TZ2VLuEebQHt0yxoHipkbDXg8B/p0l3ULsWPPpV2kqex0du0x65
         nxZce0jG/29DRt3cEPM3ML3PsxhV2kMSLhiDGJSmGz1bs1ZwAffAHs2SDul+ayFP1rxp
         G6M8fv9XqLMlL8UkEigZRI1xqplgw7x2mh/hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340941; x=1731945741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5RXHuOlZAH+7ofZB+9QXL8bQr7lreW4Be7wakDlo64=;
        b=j0XNzC/3LcFOEBpNssAxnp6CfKUco4yR30gvn9f7Kb8gPQTV8CzzKodHx6/8FN6dRE
         9DMF/AU8WFH5E3MOnL34likDGMPldUBUbete538PjBzn1l0HX4MUMovDmRm+JEtykC1j
         tdZZa+ASYgZps8YO6SxqY5sBb7JdHf8scG0ZLeSGHQSy+IgjdcQI2ypJDZXsWu9M1NHp
         sQPXQy8S/rKtC4TUq1hlZk7FJDX7HHppgACXgsKf2XWuHI4ypbRRjIsImQHNv3Y60MwF
         06S8j0UWhgGHMMnzdAgS88x8eV4OzUxWJc9lDydpmfynhKG7Bmpvt1TBfvIRBPAuaH0f
         CWhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxIxXYMfhPFcHuX0FZSKe95Pnq1r8sbolrMaec5o93/BJOb7vtTrDeuLlSVVosfMhQKp7kCHE2F5eHfmPt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70fPFvKC/TpxL7r6scBVmFmrmFuSFT20eFx984Tcr6O5jMNrM
	F+25wm+7tYKepEHygEW5BzTQMktvj+xvt9LPBqJJFSnXItANo0cXSCT+KCOAvVGTbFF5ZPH1XvJ
	1eJWh7aLU2yTN5QF6C2yvvDQKPxEdF4eBxjc+zg==
X-Google-Smtp-Source: AGHT+IEzS6bn9VBDuiSqsmTqqR7yoEYiIEAZCo3Ki1JpF/6eT6bxu4vCzLf/m/6ToEDQe+0yxOneNkeSGRByBokbOR8=
X-Received: by 2002:a05:620a:40c5:b0:7ac:d673:2057 with SMTP id
 af79cd13be357-7b331d81ce2mr1982184485a.13.1731340941045; Mon, 11 Nov 2024
 08:02:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719257716.git.josef@toxicpanda.com> <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting> <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner> <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
 <20240625141756.GA2946846@perftesting> <CAJfpegs1zq+wsmhntdFBYGDqQAACWV+ywhAWdZFetdDxcL3Mow@mail.gmail.com>
 <CAJfpegs=JseHWx1H-3iOmkfav2k0rdFzr03eoVsdiW3rT_2MZg@mail.gmail.com> <20241111152805.GA675696@perftesting>
In-Reply-To: <20241111152805.GA675696@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 17:02:10 +0100
Message-ID: <CAJfpegtxcoUBWC46439+Dw_2z4RoKwahGtDNoKQRHHexMpP0LQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
To: Josef Bacik <josef@toxicpanda.com>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 16:28, Josef Bacik <josef@toxicpanda.com> wrote:

> My apologies Miklos, I value your opinion and your feedback.  Sending my mind
> back to when we were discussing this I think it just got lost in the other
> patchsets I was working on, and then it got merged so it was "ok that's done,
> next thing."  That's my bad, I'll be more careful in the future.  Thanks,

Thanks, Josef.  Sorry about getting a bit emotional, it wasn't totally
fair, given that I went offline for two months...

As Christian said, we can add a new flag for the un-escaped variant, if needed.

I'll make a patch, because I think it would be better if there was a
variant that non-libmount users could use without having to bother
with unescaping the options.  Maybe having two variants isn't such a
bad thing, as the current version is still useful for getting a single
printable string.

Thanks,
Miklos

