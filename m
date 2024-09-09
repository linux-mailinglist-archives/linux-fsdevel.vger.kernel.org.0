Return-Path: <linux-fsdevel+bounces-28966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0399725F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 01:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36C62B22309
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9DB18E77B;
	Mon,  9 Sep 2024 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6cTQc7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC118A6C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725926102; cv=none; b=gIwXsn83duJtZRuBYwbuD29wdIOW6qhQZHqkFctJFFO16jbaFgqsRCykAl542GXRpSEHAoDOl9rHfH1F0KT7MalsfGznX2fREfVr8JoG11v2Qem9U7a2meDfurHvk4xW24W92c9G5ciQ1p4iT/4sFtZPLAvv7myVVzuGB0oFwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725926102; c=relaxed/simple;
	bh=M1KoFSpNUOLVXT1kP5VICXcC5Vs8wFtp9teskKlY70s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=jHdrLfatHS2EnrVSW1aOxh7Vi/JFR5Y1b1bg7UvYxAc+iWnfDG+U7vNLk0bwUH6RSgt3+Bdfo4N97PtYrnrMRppv+JhD9RtJrs6v3uoKS9gWzTCzdpjWnqUAp3xbWI0ABIKiLalfPDHWPQygld1DXyHa0SGan8ey90A2TLorouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6cTQc7U; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-846bcb525f7so1526111241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725926100; x=1726530900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=E6cTQc7UZMiO4XetpoUFY5tCaa6W0UIdCJNmHgz3oasEO/R0ieuU7cplZNReNP/xuq
         wtIWq9g8AZXXxCQMP9LcY1A9VLZ0ibmZyU69T12/GEe3DcyFjrNAJPY7WQN7y+OQtayl
         d79qgWELFs1vXuAZJJ8phN3lvugX9A/GWkfqEvYo3ZiT7wS8fwiJBElyLUyg+6ynJWkX
         i+r7ma7gNRLJr9Ck0Qi6YSPofbwpYRhpMPn5QBrS8Tkwn7vD5RXUPEArVWl3BgAseIVT
         jHkTdt2zdqT5vigvdmTeHCfu11ohfeQNSLkW2WkADq3txHGJT9wUfiXDt9St9HvdfpEi
         DvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725926100; x=1726530900;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxX5C1PVQFhcpEMOTxZjcoasZZvFqrJMsr5iTanZpSY=;
        b=SQopwWe/WpAJZ9kKkurFDliejmfrNccuUf1v9QrW0+1hyLDer4qKLlTMiNKVJbwPym
         vbqpwuz4OUjsNTaPDc57FbRnJKqPE2PB8r4pJOGUEt2dVeJoZfvHbLxlEtrM001g/+Wa
         XilObb7jN/O3WaJfi/mFiGM3NBNZHBJPWKqoo1RF9aOHhINKICe82eNMwEgaA6HJmFbY
         2dMXN6G0cFs8DcVQfgTGqslgKjPKkNPBjqp1lGj3EUmrRFEdQZA5An0dCKAa8BDxF0iB
         Q50QQA6+jlr+OQ+LRfp5Smia9UTHbXYIQdpDOu6Vxj1prXkZchkwTqLc0m53MjFJkqts
         OLnA==
X-Forwarded-Encrypted: i=1; AJvYcCUjTCpyIINBEvSANPVIWRCQS31fmrJoKZCVZyr3J2HhJgOdC9ePDQXQb9Pdis+OdXwJt4AMBoaQCrgJnQK0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EOPRn4sA/qzKA894MunwiLKUkZxsowtOKiUrubNO096MAt/S
	mCBMUutkd2gzl6yQ8WGFDWcKIuwJk+T4CmHohwdKwLaxbxwCzav9gsv4lpOQcrZZ+fR33HO9PfP
	adprVBwyHA/1Wl3vQYaZr00HIkFU=
X-Received: by 2002:a05:6122:2a54:b0:501:1895:203a with SMTP id
 71dfb90a1353d-502142032f9mt15753352e0c.7.1725926100090; Mon, 09 Sep 2024
 16:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908192307.20733-3-dennis.lamerice@gmail.com> <346199.1725873065@warthog.procyon.org.uk>
In-Reply-To: <346199.1725873065@warthog.procyon.org.uk>
From: Dennis Lam <dennis.lamerice@gmail.com>
Date: Mon, 9 Sep 2024 19:54:49 -0400
Message-ID: <CAGZfcdkGw55MKTYxuOkCgu8kJU86jkERfLRJAP+J8Z6=0z1F+g@mail.gmail.com>
Subject: Re: [PATCH] docs:filesystems: fix spelling and grammar mistakes on
 netfs library page
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I'll be sure to revert the "fulfil" change
and correct the pluralization in a new patch.

Dennis

On Mon, Sep 9, 2024 at 5:11=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Dennis Lam <dennis.lamerice@gmail.com> wrote:
>
> > - * Allow the netfs to partially fulfil a read, which will then be resu=
bmitted.
> > + * Allow the netfs to partially fulfill a read, which will then be res=
ubmitted.
>
> "fulfil" is also correct:
>
>         https://en.wiktionary.org/wiki/fulfil
>
> > - * Handle clearing of bufferage that aren't on the server.
> > + * Handle clearing of bufferages that aren't on the server.
>
> "bufferage" wouldn't be countable and can't be pluralised, so the fix sho=
uld
> be "aren't" -> "isn't" instead.
>
> David
>

