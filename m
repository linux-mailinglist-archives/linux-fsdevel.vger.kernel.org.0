Return-Path: <linux-fsdevel+bounces-71285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3096CBC77B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E65D23007CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDA248868;
	Mon, 15 Dec 2025 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVdF7WLy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71383B8D7D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765773029; cv=none; b=AGzNtsBxmOgpkmTp4/H8+fc4LjJlu92LZeU0Q/OFiNEIYhhr4CbQZ8EaFDDauDf+FOjgDCFkT99+7w2F0wg8XYYkSTjKFOCsyZ2A81/IPtq7gH42xRLj7VxuiySMN/SeQaNwReQO22xw21QVFHocJ76kiQm4DqBiVe6nfDjk+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765773029; c=relaxed/simple;
	bh=5RdSHD/SuZdS8arm/ht6k8igR3g2z33LiOYvsTYg0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rTrf9jPJVCT+QvQcCRdxH1uwAABU28AluKLvOCYHMuA0OJ4ktQL1+15V0WFI4n0jrK2GuXocr4wfhFUIhS6ziDDmaXUXphE2k9iZ/HcqGmx8fVYwafZHeFNUtSPuEQ3M4qCbKrYs1xQi8psSTSEjFPtGubripbihWudRLhRFWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVdF7WLy; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ee2014c228so22210001cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 20:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765773026; x=1766377826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RdSHD/SuZdS8arm/ht6k8igR3g2z33LiOYvsTYg0v0=;
        b=JVdF7WLyfB44Sy1VKC+lM7yvwLiy00Xv0/jkpUFcakL0cZKhA/z7meSPIRlX0vaGcA
         E8CHAh/vb/uzjF1IBzJE6zYF3iyFo/S3PSDSVFEUB+j3v42+haNFde9MgQa7J/TR+gPc
         tFFmYZph5jRpjNaxETC92c8VDvVZAUc0Arg8y+Iwcv/lgBjDoU7vDLCM2M5SP+6lWfU5
         FZ6NBxnl7ph0KD8c5rVefv36E+07LVWbHFHag+tOAsm5uwRcQZwNG4G40RNP1CB7xpB7
         hOJB5VhtndtXkMzbLM28sdaWtZNKue3EkQ3NCHzWOZZT9Glhqyb9ZD2VB/3QAaYVQYvI
         pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765773026; x=1766377826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RdSHD/SuZdS8arm/ht6k8igR3g2z33LiOYvsTYg0v0=;
        b=HXO7aQkXdWUnVOF5LFbhO9rzdX3ZJq1onYKli0EWnQTzR62uLyu1a45ApPOpop1Q9E
         YJSrDzSMgLGlDgkt2Fpi4TQmzqU2BNTczQCiiHzi1wbayd2Fgxnnp6g1HgfrSLSuFwdL
         yBji19PzK3AHi+YHOjUesQIQa6BX4ktOmMdbvBy0VpbnTs352EYFa1z0xgaGo3LZVNPK
         3t9Df5zI6cQWpilBG0B+rK/QLRnx1JkZk3tnhDZdT0clKULnhk2GYvpDNPhGo8jARzOw
         hKSCbAjn8QEZUyZJsoeqfqaGJbI0UcIDV1AdM4lAI+wiL9sOYWfjCohYefW9agi99prP
         U/7w==
X-Forwarded-Encrypted: i=1; AJvYcCUbfhczEqdphvuh4nKfrvFyYIzOx5De/14e9wpmxXYJQJqOMaRzkZCawbh+dOwwJZbvQ/3gjSBC4sT80Qs1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Fs6u/rIhvERYu+Wf8wCDm1+jnqYhj/fqsxFYFTODNnWCAnrP
	t5Di52W+WK0wreqFQr2v5UE7l81g7647KmWbLlW8naFexENGLE5p+EXyiU3xn8Ug9G6ccE7dqDr
	uAQeg5tKgW6wueXPZyxkORwbFws+2wqs=
X-Gm-Gg: AY/fxX45yyxcqljbWdWB/6ngk2Ed6qEC8D47SY9sboHlIt7L3luF0VEhGXdrEFU6DxK
	s4czV2LCJTq7VCZjD6AQNA1/X7mrcecQ3JvaRmv750t0EPtIH6osfFndicK7khiS8Ggie1OcEqU
	56cRVsXhVk/pBRHXw9UA0RydBYMA4gRTxBPzTw9paIacjvSdHMPrU8rEqGboYpNI0CWEokLR3uU
	5W+KvUgE58H+JkDhqPxVpFbKyB6o3Cedq+hb12VfVsAkyJpE4bJ4xWJMOlVTnAkor7hucvmWbAB
	3MosfvDWWmU=
X-Google-Smtp-Source: AGHT+IGS4m1kE91WVL6a8xi0UcDBwnwM3yZe9ipR8qRrD8yT9X8b/3kflvYGSmCXCWLo2/1zMhUzShDiEbxI9wzFHXM=
X-Received: by 2002:a05:622a:144d:b0:4ee:1c81:b1d1 with SMTP id
 d75a77b69052e-4f1d04ae9b3mr139988811cf.22.1765773026636; Sun, 14 Dec 2025
 20:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com> <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com> <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com> <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
In-Reply-To: <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Dec 2025 13:30:15 +0900
X-Gm-Features: AQt7F2ocf8zZzKcnWnWj1psV77g8tfmmoKyh3c7Rnyl8PU7MXdQqQKAfzVoQo74
Message-ID: <CAJnrk1aSEaLo20FU36VQiMTS0NZ6XqvcguQ+Wp90jpwWbXo0hg@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Abhishek Gupta <abhishekmgupta@google.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 6:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> Hi Abishek,
>
> really sorry for the delay. I can see the same as you do, no improvement
> with --iodepth. Although increasing the number of fio threads/jobs helps.
>
> Interesting is that this is not what I'm seeing with passthrough_hp,
> at least I think so

I'm not seeing this regression on passthrough_hp either. On my local
vm (on top of the fuse for-next tree) I'm seeing ~13 MiB/s for
iodepth=3D1 and ~70 MiB/s for iodepth=3D4.

Abhishek, are you able to git bisect this to the commit that causes
your regression?

Thanks,
Joanne

>
> I had run quite some tests here
> https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8=
fc58@ddn.com
> focused on io-uring, but I had also done some tests with legacy
> fuse. I was hoping I would managed to re-run today before sending
> the mail, but much too late right. Will try in the morning.
>
>
>
> Thanks,
> Bernd
>

