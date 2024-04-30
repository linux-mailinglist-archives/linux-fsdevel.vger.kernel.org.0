Return-Path: <linux-fsdevel+bounces-18367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05298B7AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A3D1F23BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC039173345;
	Tue, 30 Apr 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In4TrlxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB96172BCB;
	Tue, 30 Apr 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489143; cv=none; b=j0lGmgZD7CX6HGBBVxpUtrGawyVom0oOuUI6NRnO4sHwm6XkDl6pv61wc2+enKIA6zvumyZYeF3C/KxRSaPwLTDfGZI2sbCqN/gCrNu9WjzxqxrxZrANegLXLXc0f2LIiqCnOjCjw5mFLB5y+8t/8igsCrB0sIWauA7YzIsqf/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489143; c=relaxed/simple;
	bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFtfxmKH8TldDL0BgFAUPimB7v3h+Sgj19Wo/dvwtbv1tjxuFgbe7UVWOKCDmEMPGawKjVga1CDeqdsnUGt8DBElcDFIXk9dbU5paRKh4jSVHlu7t3/Ej6aZgjsr1OKIA8g9BHOz1EWJ6Kry/C3TWYkTMroiWps0iBdS4G6LwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In4TrlxU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dd041acff1so67257441fa.1;
        Tue, 30 Apr 2024 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489140; x=1715093940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
        b=In4TrlxUn/3B20SsfTFKsru6wYVF+M8ItJQGZTkH94H0wUQJ5Dns+FiCz42AkLS68a
         rLL549AKp6D51F7U5X9ErsE1qsQZDbP4g70YvCAqOFX55rtOtNkCr9BnBnsep7Tpc/Lg
         utJrYdKTccy952/EW+oZQzSpH1U9tzs7JJkutQiXoYmgw8HbgwFCA80z8zKLXIR920at
         Yn0X8L/wnFCIHgutsihqgEiVC8nWkOUyaNED4VeUFhjfZ9IFHrybkKc8dvQHCCJcOYFP
         r6D8YiZGbmcAl+1mFA3XXky6ICbga6InluTqSZvVmk+xSpinH/ezM0IF6of7xxqehzmL
         qULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489140; x=1715093940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/e+NK6Czol+7PAxT9nfpaxf/IU9cfQ6ydxY3hYa29qI=;
        b=wi4xb1TOVJUFWIHw+/wql24Cqb+zEd3pTAKJMbwkFIRr/SYf3nTOatnb9TbMP8hOZb
         nfvl4lbMkYJY8ksPwoUAN1WZs4/RfL5fernKpaHU6Xgut2hi1VIQ0xMUg9j738zRV1bH
         hOrcA4cJ3Bfumx3nfGvIIxDygkQoDzlhjJfkJyUlTF6G6Hdmhcz+amjrph6XdwfdgRqe
         HAof8R5+tQ2grI/TmfbFcneGiKKlN/9NmAyKdoP8lpicJZ6jRZlkg3EMAze1C5516dSR
         tYzVqZp++lyH/Abk6PJeMhaHxfdKeCcjJlUXaO2oRI+Asnam+Cy1Cu7k8I+nA9uKzaCK
         H0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQLoe+DgSmyZfprIC5chJnXoywLKCiMi96n0WYEoIk2h/yPiZ+somCQYWhlcigTXLRQdjVe4w8v+vJ1NE5TFmoi16SBC64vCVEEETwIP+6XIVy0h43vSCg4c/C5H/MGCj6GDe7J0GCAzzRo1jZ0fyWiwog7WUP5qF6txCmMiW2s73+VUVOBtY=
X-Gm-Message-State: AOJu0Ywu29FwKOFAsguDvo1B+dS+sWshtY8ohBwUGvT5QuM+jONwgfDQ
	LjB4Pttt+Ww53d890noylN5BmYDRzcUfBEwOy7H7FfxvmcDLiO4jpE/YgQ+Eb5l4f6mPhZeGWDL
	gukpX8YtsK5Bxx5diY1C1Wc3i7LY=
X-Google-Smtp-Source: AGHT+IH1ix0BqVq9FIQTiQZX/OFdgb0zFuvm/XZ1HQbS+UYTDWVWBCztGEQwH9uF9Er2JGQROqanY7i0WYIkpAAzanE=
X-Received: by 2002:a2e:7a0a:0:b0:2d8:45ff:d606 with SMTP id
 v10-20020a2e7a0a000000b002d845ffd606mr7232211ljc.50.1714489139376; Tue, 30
 Apr 2024 07:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430140930.262762-1-dhowells@redhat.com> <264960.1714488463@warthog.procyon.org.uk>
In-Reply-To: <264960.1714488463@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Tue, 30 Apr 2024 09:58:47 -0500
Message-ID: <CAH2r5mspax98XVdEyYaupSFqh=M5zjcwckjta8H9=e+N-dnrmA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] netfs, cifs: Delegate high-level I/O to netfslib
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Paulo Alcantara <pc@manguebit.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, netfs@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - I think it is easier for now if Christian picks up the series in
his tree due to the VFS dependencies - if we start hitting merge
conflicts with my tree later we can consider changing that.

On Tue, Apr 30, 2024 at 9:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Christian,
>
> With Steve's agreement, could you pick this set of patches up also?
>
> Thanks,
> David
>


--=20
Thanks,

Steve

