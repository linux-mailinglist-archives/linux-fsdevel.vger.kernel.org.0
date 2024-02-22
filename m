Return-Path: <linux-fsdevel+bounces-12441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C62BB85F5E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BCF1F221B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80A13C47E;
	Thu, 22 Feb 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GZoO4p9I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2538F88
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598346; cv=none; b=Ru7h/rtawWgriXpguPnAiQAtA+mtxqqQ10pGGlsb8LqlxQKJglHIwBKITClOWRe6qNrbxAKCPrKtGeQ9+yP+0hi4zphGjV2L+0WlG8agE3QUBBwEdZglz0vlrP41/VZfLRxV9STwIw/YhaxHqiMH6AxNbNTPxhnYAAXsaaDk3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598346; c=relaxed/simple;
	bh=AKORqv8uFNp+okBNkTZVz8Y5eevlILbT2u63pny6Q6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABsCrhpfBtcuC5pAuTY89wKD+aJlBZj7mOlBnz38tttLoRoGErgOQW7DxyGz1I6HhT8YHcTsYgad5ob5OTqHuFXXTfSK2ttR37dqZx86FN7Va5zR/QiWU0genAfSgQlxycY+RmlcF5trP7f9E6RhCorEku/vSFrq32Mu9LA9FOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GZoO4p9I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ee69976c9so478284766b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708598343; x=1709203143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKORqv8uFNp+okBNkTZVz8Y5eevlILbT2u63pny6Q6E=;
        b=GZoO4p9IFr0ggbd6sNm3OCaKg/VmSLhUylMIDZUW31oIqntkTmtWPSvPjBpRX55h1C
         AScevPkF3XW6EnI/X3NW0jTXlMlxn98aEvzVL3tfPyXWOq2791vr+QhoVAwW4nI2Vh10
         I4ii0s6LVTOw+BhbTBUMngpiEaiq98eoOLd/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598343; x=1709203143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKORqv8uFNp+okBNkTZVz8Y5eevlILbT2u63pny6Q6E=;
        b=F7uesqiQsTYIBrEEQwiZgt+5CwEm0/mC2W03LN6xkkSKZJtju22RXJbWVXg5/40EDW
         3YPx2vlJYYxztFJ+QtNETDcAoybdNupOFl9EN6NjorxBc1iF5qp8z3Hrh+FiTErp+Upy
         q21R92K/YJh0aR6sM7FM6IVFV7pmGOCqi2un+kX1UlNIlC9bYlzNwV3jonVQEvyqD0Ss
         X86sGCqm1p7gibsluSnaJoDCZUscRzT8a6Dr/v+j42Zt17Qdv9brs57VzS58bA2NpwEc
         Sd4tDqGENh0hmTHZyJzAfTb9ibiDrhthhVhQDq6QIuN0q13ObUwUoIH4apLbxRmPOzQl
         Dm3w==
X-Forwarded-Encrypted: i=1; AJvYcCXnmOSDvxbyG3ae0//HxLb13B4u/r3AWSWikTjq3AbEBCytDU0pWe5j+LTuBuIjdXw9B+2kx9+EpeOMKfmixLG+yIBFo6KTDyfTUiHDog==
X-Gm-Message-State: AOJu0YzIsKMtzKgvXYaYVU5w+lzNVQ1KFmyaeN6Fk9cQye3T4cShlFNj
	F/eSK/7heLZ5F9AWVSxDJwc24QFAAZ5snQkUMgBFz5BWKj9IWHOAsY6E+4Nb2NzeO4+/yKiONHD
	XH/LiQeBbWVn84N+yVA/uBZT1UjsJiHMh4JWVgA==
X-Google-Smtp-Source: AGHT+IGnw+g+0BUGCkHQr/7kiZQogN6Z44c5Vh/mJARPE1yJHykMkt9Pr8GSPIdn4HhOwkPjIaMGYnootKRLuyXawlo=
X-Received: by 2002:a17:906:1d55:b0:a3d:d1da:1247 with SMTP id
 o21-20020a1709061d5500b00a3dd1da1247mr11797802ejh.56.1708598343308; Thu, 22
 Feb 2024 02:39:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bb0571-a6e0-44ea-9ab6-91c267d0642f@gmail.com>
 <20240222-verflachen-flutlicht-955cd64306f8@brauner> <a0e19bdd-15b0-4b90-b27c-26ba52a72135@gmail.com>
In-Reply-To: <a0e19bdd-15b0-4b90-b27c-26ba52a72135@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 11:38:52 +0100
Message-ID: <CAJfpegs+wH8NNqc6E-D0teBjc8yj_2uM6Otykcz-PJtj0MpjQw@mail.gmail.com>
Subject: Re: Can overlayfs follow mounts in lowerdir?
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-unionfs@vger.kernel.org, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, Enrico Mioso <mrkiko.rs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 at 11:34, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wr=
ote:

> Can I bind mount /tmp/ to my temporary virtual root and still make use
> or overlay to don't touch underlaying system?

You can bind mount read-only, or you can create a separate overlay.
For /proc and /sys the only option is a r/o bind.

Thanks,
Miklos

