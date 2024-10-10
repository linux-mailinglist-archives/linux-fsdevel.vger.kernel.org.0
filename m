Return-Path: <linux-fsdevel+bounces-31638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE769999488
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A461F23CDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE21E284E;
	Thu, 10 Oct 2024 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duYBIzAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779491C9EBB;
	Thu, 10 Oct 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728596394; cv=none; b=ZEG3EO3LmWfkhHf/+JHewqg4w5Z3wxDX3kKcfHnSSwjdyrgFanwFsnFKQCeevOrQlzhvII4FnJczGzbHNRjez6f7oYkLwQb/IqHgG2SGTHcAl2LE1QXoa2K+XbIXi4srIlUz2fbQPbYS/tu+EoOM22u1AM4B6XPoxQuI+6tDNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728596394; c=relaxed/simple;
	bh=sAL6tvxL7TkJaJnYVUXx9mAHsz+JpJwVRL7bctnfK7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQjHyyzPZ6uPKQLJUu1iislbCWboBQ1pdallZ0TuI7J8LpmV3h1jckjmM/ubcnI2nf2M38vvMyvT/V/LsGuUu52ozIa3qDHb2ihSYvn6mWf5t0KxeI6qBV9G51c3iLHUZjp65oX3UrsRVw3gGcVpXwEngcOeC3lUkdCr0P9SSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duYBIzAv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fac275471dso13468321fa.0;
        Thu, 10 Oct 2024 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728596391; x=1729201191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FF4v77tUiHknJjjsfC13TN4fd/UAbD5A6Ni6iYYEH3A=;
        b=duYBIzAv4lvSdi594BqW1Q86lZW/95VYgie3/kBMCONwZIr+sTEfdgimS/kquZr64C
         DqAH9fPs1FWtyjZjexFNCoTLse7PgVF9muIetDx2sYLEWaUiHl9rB5cxEudxVoFN1529
         zphYDZ1dYgcsEGp87CgrMTrNkiInuaHvSIb5XhE4tCFiyTOyIwflXq5psOdXwWjyO6MA
         83AIVV4/qpTL0t+yIBL0DWynPANZv5alD6V40l+n2bVeoGRRT4EsgCjK8nF9X8afj23v
         GRfetm0U2iPsav+ORgaW2llnnOOtGs2MSNCr/aNGqdG1cSqt+EUFoDnx69XaYCBayMDM
         oHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728596391; x=1729201191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FF4v77tUiHknJjjsfC13TN4fd/UAbD5A6Ni6iYYEH3A=;
        b=t/2nUaedseJqbtzX1A5miCYs2eErUI5WPCyPxccRxJ1iHyWP0l1cOqRmlN/bL12N9G
         Ro+0oPtFqemuczBEuFWVsijdUPjQDdWixjN3YESf8BNQROAMMa90c/zIykQW1iJKc27C
         QZCnqPsBJ0MPav+mlzky6LyWy5n4f+3OTA2jtRrHcygR53L6x/W/Qweq/xOjg+0Eebjz
         tL/k2rXvgmfKePqhRA55M74sHp/0wiihOezEFEty6nlXLFNJ0bXB+L1xBktnC/hki5KO
         G1DvTgTiQ4YwY3FTHb8OEY3gx4PWyoXEtRaWKm3DEhwOri1qmrsayIOQwh0j9flohiYF
         hMCA==
X-Forwarded-Encrypted: i=1; AJvYcCUySrkavLejuhAeqsRfLLMZ6CaHt8v6zfGfWb3Y8UTCLOA0QHO7Y8QJa+UxriLO1LvAucCa9SYvnU/VXV2MvA==@vger.kernel.org, AJvYcCUzkdnLzaM0wFLU3vY2/CRBKih1F5gQkif1p68Ut8Z40mV37HjS6Adn86P2/cEZoK6OfPuWkwh0rh4=@vger.kernel.org, AJvYcCWmT5yp+y0IEqNh+DoqLnrG1VIgDCoFPV2MSjHRvIivWFm3BDfU/z+LccxfAIZ25BTgpMSJ/ox27PhDeIef@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO9zOXRUZo+gihIkMw/qJL7nfj/CSO/UdHI7M5HCLf7JxKAl5
	ymMN2Ml50MG+xMY0frIuagoiKLcM6q8vZtM28GJXomkMXpM17TgGVeLg+rD9tIT4m39RXVMAJMw
	U81A50siZcT3xMYsxA3zlCkmfBdA=
X-Google-Smtp-Source: AGHT+IEhHiCtho5ZAZJ1EQLtUzYBwqNgiXO9+ywmxuSamLa+NAVuf9dcih68IXfAmcj/6x7/2iTEk0IFhLzYZ78sWa4=
X-Received: by 2002:a2e:a548:0:b0:2ef:2c40:dd67 with SMTP id
 38308e7fff4ca-2fb30da01a0mr1833071fa.3.1728596390301; Thu, 10 Oct 2024
 14:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9khQo8o_7qUj_wMS+_LRpmhy7OQ62nhWZBwam59wid5hQ@mail.gmail.com>
 <20241010141309.52527-2-tamird@gmail.com> <f7fba2fa-cac9-4ecd-98e1-adb2cac474ab@infradead.org>
In-Reply-To: <f7fba2fa-cac9-4ecd-98e1-adb2cac474ab@infradead.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Oct 2024 17:39:13 -0400
Message-ID: <CAJ-ks9mz5deGSA_GNXyqVfW5BtK0+C5d+LT9y33U2OLj7+XSOw@mail.gmail.com>
Subject: Re: [PATCH v3] XArray: minor documentation improvements
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy!

On Thu, Oct 10, 2024 at 5:35=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> > -You can then set entries using xa_store() and get entries
> > -using xa_load().  xa_store will overwrite any entry with the
> > -new entry and return the previous entry stored at that index.  You can
> > -use xa_erase() instead of calling xa_store() with a
> > +You can then set entries using xa_store() and get entries using
> > +xa_load().  xa_store() will overwrite any entry with the new entry and
> > +return the previous entry stored at that index.  You can unset entries
> > +using xa_erase() or by setting the entry to ``NULL`` using xa_store().
> >  ``NULL`` entry.  There is no difference between an entry that has neve=
r
>
> Is the line above supposed to be here?
> Confusing to me.
> Thanks.

Ah I think there's a latent sentence fragment there.

