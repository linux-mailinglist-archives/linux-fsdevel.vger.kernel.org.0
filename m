Return-Path: <linux-fsdevel+bounces-15344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553088C40B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F40D308DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC27745DC;
	Tue, 26 Mar 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FckqzQAe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1774E26
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460717; cv=none; b=NdumA/oAndBRLApNoMt0BV20PjOaE8YdHnPWfd1ndVuylap/CN1xVD6pXZsAARSBc0x6vX5fjpA8cXd+FKevrFFRH9CLYB4IB0FaOSi7dE8PR6Gx1R3LwrjgalI1JPar1paoaOWA9kzBN3LitIkI4uSSPqB6NNIsdIJajRVH1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460717; c=relaxed/simple;
	bh=kFGkg8AD9gZFSmwjP/iAecBmg11atro9VYxxJlo1fWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKCizzbOtbNm1olOCUPrvhW5A58E9zS7bQO5R87xQpaVnhUuJmUSDSA1svbEW0NGWAtC2Gk1N1eEQSXMsGet1sx1cA4FlsYbFlt0Wm7Lcj1mWySAxbvUld9OlT+gWjiLXqXzlXJdomMJZy4ti5mpW5gbFzVbdMHFWhihrzZbeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FckqzQAe; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-476573535f9so2195404137.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 06:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460715; x=1712065515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6CFIsPoIauKZBqshqHp0Tfq5JZS7/GYw0tJCvyXUDs=;
        b=FckqzQAe3PWQ/P0aqQzQlGHrgpkqB4T+F9ZyMrCBxFki4hTf6Q8KL5ZpIGVXhHcaAJ
         gNG5QI1rfrnGjY12JkN9ki+0yhYtI2duY17+Nu5DXoaCmGHOz6SeccOFG3Cc6ikNaUiL
         Lp0zVcqgP3FAEkbNvHmf/Tw2UDA5X3MhDBINwYZWn7y4kEqyuJSfqlG+diJIrn2UPMNg
         2JMIS1WJcHw7RLCtk4yfNnF6JD9TkEc161ZxtyAUNoSR9RFs0vGaisODuilxDRiE/uR0
         ZNEb4Ym2ggdOd52xJ2/jA0o7aZauHN7NO5fSvElmO1zFVLy695LgrSyceTbToriPO9VM
         I2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460715; x=1712065515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6CFIsPoIauKZBqshqHp0Tfq5JZS7/GYw0tJCvyXUDs=;
        b=reHdx+YlB13tZFkSM762zjVdHBpbVJJsA5CS26ZbWJOMu1V2VTzeArOloL+QUw804s
         bhJEC9ivE6C+cV8HGpSmDO8osoAJg24oSZVDtlxMiybV1M5YP3TCEd6nmzUV9wouwrMO
         RkZMxfhSfCdxVGE5ZX66kdfiyNjs6Zg0Tn5wwMP0JNpOblIFQaPQ3uMoUoCfUFW1yN5A
         WMDXAH0S3Nfbk6/x9mRuNesiKv7XZafy1c4jtBRZlP6b2HhMFqiuLKRuJpX7LdcbMqV4
         CS8idf54hiUOfsQANxO6r2zvE9j8dh11Zjf/TxP/Ybmg9aJKmDRsymhz3ufzoM/2TL0w
         31sg==
X-Forwarded-Encrypted: i=1; AJvYcCX/5fJG6BbyJuFrJz9BXYVc3YXXYhW7UJInO6y8D5B+WaoKqSKxVuE/P9i9XGm3FQNbQzUqdzxlg6gU9zlBMKQZCCjmBlwPQyPvJYtOqQ==
X-Gm-Message-State: AOJu0YwfSSNaJQTgxTYnlaX1bzGMNZLssG1zPd3pTDeF9z+CigW6JyFS
	ppmWbhoAYq8hZ3aHA3VZulAyQ93ZSO44o5qAgOY0gFhr9SrzpBCgyPGbjuKLmSxgsRxHnXgeKZF
	ObO5IffRQ918u4LNt0KJ5oJ3ynxo=
X-Google-Smtp-Source: AGHT+IFqrJNEWrzG0Ero6le2NPrqt+W43On//IsUbutGmw0oFdEgRJQtpdc4g0hsPnwoTFqxsW6rxIESkWheoE6P8bg=
X-Received: by 2002:a05:6102:358a:b0:478:2bfd:2e53 with SMTP id
 h10-20020a056102358a00b004782bfd2e53mr2021666vsu.27.1711460714592; Tue, 26
 Mar 2024 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOuPNLjQPo8hoawK73H7FOVitQHp21HHODExO+7cguGrtURKWg@mail.gmail.com>
 <321330094.101965.1711390802883.JavaMail.zimbra@nod.at>
In-Reply-To: <321330094.101965.1711390802883.JavaMail.zimbra@nod.at>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Tue, 26 Mar 2024 19:15:03 +0530
Message-ID: <CAOuPNLik9B0spBUYOVSekAns+zf=-zemit=DoVt0r6Us71p=Gw@mail.gmail.com>
Subject: Re: linux-mtd: ubiattach taking long time
To: Richard Weinberger <richard@nod.at>
Cc: linux-fsdevel@kvack.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Richard Weinberger <richard.weinberger@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Richard, Thank you so much for your reply. Please find some
comments inline.

On Mon, 25 Mar 2024 at 23:50, Richard Weinberger <richard@nod.at> wrote:
>
> Pintu,
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> > I have tried using fastmap as well, but still no difference.
> > Are there any other techniques to improve the ubiattach timing ?
> >
> > Logs:
> > ----------
> > Doing from initramfs:
> > {{{
> > [    6.949143][  T214] ubi0: attaching mtd54
> > [    8.023766][  T214] ubi0: scanning is finished
>
> No fastmap attach here.
>
> Make sure to set fm_autoconvert:
> http://www.linux-mtd.infradead.org/doc/ubi.html#L_fastmap
> If set, UBI create after a few writes a fastmap.
>
Yes, I have set fm_autoconvert=3D1 on cmdline and enabled fastmap on the
other logs.
{{{
[    0.000000][    T0] Kernel command line: ... fm_autoconvert=3D1
ubi.mtd=3D54,0,30 ...
[...]
[    6.702817][    T1] ubi0: default fastmap pool size: 170
[    6.702822][    T1] ubi0: default fastmap WL pool size: 85
[    6.702826][    T1] ubi0: attaching mtd54
[=E2=80=A6]
[    7.784955][    T1] ubi0: scanning is finished
[    7.797135][    T1] ubi0: attached mtd54 (name "system", size 867 MiB)
}}}
Is there anything missing here ?
Can we increase the pool size ? Will it help to improve the timing ?

> Speaking of other techniques, you can improve scanning time also by
> tuning UBI for your NAND controller/setup.
> E.g. transferring only the amount of bytes needed for an header.
> Or reading without ECC and re-reading with ECC if the header CRC-check fa=
ils.
>
Sorry, I could not get this fully.
Is it possible to elaborate more with some reference ?
Do we have some special commands/parameters to do it if we use initramfs ?

