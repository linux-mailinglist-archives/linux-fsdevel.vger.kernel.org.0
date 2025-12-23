Return-Path: <linux-fsdevel+bounces-72002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F38CDAD65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CFAC30281A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C2304BBF;
	Tue, 23 Dec 2025 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gstYNE7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E72C3276
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766532527; cv=none; b=LKMR/JygZK17inNrHcEsbwQTRQphxfsmmioLiHXpUIOOoi5Gwt8RP7vt2qh2AJ8x1ZYkN7P6twnRoNe1xQyXO50Hh2+9nPXWw81IyCJLDFZGUksRVIfD1uy/LpJmNRzSOiL69xlvAhDYSHA7aKstRJYa0gmVDjK5S1vhusAmQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766532527; c=relaxed/simple;
	bh=Ewgqq1KmvOhY6jcdBRhpO/Z6OT0Sy4ZdrGk0824JHlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LkDBGCwxPFpALdDEP0hUrhe3FrJHLExJJ8stJdq6GAfZtheDK4JaW8vOUkCbgCzS+uSI+4v2W2EKBLxJGD/DUrmGnSGgSPUrVFHg80dCBZrcqvks+sJP/LqNjh28hiJrmtNims9NHpv71CpYns/eYOLwBNoRQvZkHRp40Jbl6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gstYNE7N; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so6653138a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766532525; x=1767137325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HF7yLcUWe4HmHudN3DL413Nx4aShOzfb5BjH2UBTc9I=;
        b=gstYNE7Nmpket5s46BEm1dbN1cF8/M7aum7R5UtA9m8oICKBV44vrB5XuXo7GpmVTN
         iMz64P+VNJEphJuyyDFXAABsX6EhCbowBKJmiGayu+p2jKR/qzqa8yLBEVe4eDKbb7HQ
         3p00ny/EDw5ud+uzHe761NZCQEIDHNTDBFkfHz3TKw2cXLmEXRMXdDsQ63zAVumJd7+c
         RSwlEz3txLhK/5uH53jpMjtt3Oa5ppun8ZozGWX4AvR0gEVD451wSOyYA3lEyexPY94O
         LKpVstoh1CSpV+WSnu23Yi71+8YJyJQjGm6yrMO1blPlWBTFn+gGR227Z9Zgd3yOwjEl
         9s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766532525; x=1767137325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF7yLcUWe4HmHudN3DL413Nx4aShOzfb5BjH2UBTc9I=;
        b=ZHSzF+/TiYlvIlm4ArdIyixC3UexhUHaU16Hu0+hsKXxnkU3RuGs42MgAN8FN7Qh7y
         DJqcu3l6ikHR4D6Htgq4RgZMDVvTEL+6/7o/VE7vNP1dQC4GK7KM2FEKjJEtDBV1rc36
         IjpAX/4d1YIxSH+zhdq9NdfOTOcL1dRMc3802uxeqPgeaCHiM5CcL1IHkvUfr9/CDcHp
         jEKo1yyLQ8/LlCzOMqgCX1QN7xgShlW+oJ/9Xt46sqVVLBaDDGmVZgFJA/HzXF4dXr5B
         hiShb5+L/X2LXApLgmF1bS2p7rQsx10+LHdRQKsogUEFbDHj5kA/xXOCSnBPzscdul68
         k5Iw==
X-Gm-Message-State: AOJu0Yz8BlK3Jy5wtPGGjpG8GTfSl6rlC2+d4PDBhBcjC5a2pl85MNTV
	gwTsXxb5rLm7apnXE61OWhLMEzCb/46gmoyGTZZPkLF7JkrH3HA/iVA33htvByHsdx7OtrBp5xT
	mZ1MYWuO0Sj5k1MrVqLy1AZYEEIoNE1nN6tJSogI=
X-Gm-Gg: AY/fxX51jm8zjAoK9GXlLCAwHK84agM3QbkrFyHwIpW5VyWxG/tCRSkgFZhAe81UYGh
	Cxlx/YjnicUP9jpgEDw/5fVt0bUP1DHEd1Mvtovbf1Kv31kUy3+TMVw6cBODBjWO09jn9YXTEUW
	Y56LE18Jz41WLaswQGUsC9kPWQt7Fuy/PSP6qa2aLLmSt3ZA5ubzK5+jR2OdgwcnYV7SC1zglQ/
	fG3g5ll6zxnXLQ+Cat2EJNGeC4X75Y1ZN9K7uLkiMctNjAdnKXBuyN4lJI+reZrbQXCBHBp
X-Google-Smtp-Source: AGHT+IFON9NRp9v+YkrxlikF97a5Hles3JJ++NOJqu8J3DPJYHwB9jw9wqA19B5yUejSi6uyk1YsvtxRMg7qLuuGav4=
X-Received: by 2002:a17:907:d87:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b80371d69e5mr1696006466b.52.1766532524253; Tue, 23 Dec 2025
 15:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219125250.65245-1-teknoraver@meta.com> <CAFnufp2YtYGioCtFyTpNufh2Kc3=8HRrpfTdsF9pZ6O0aCkSdA@mail.gmail.com>
In-Reply-To: <CAFnufp2YtYGioCtFyTpNufh2Kc3=8HRrpfTdsF9pZ6O0aCkSdA@mail.gmail.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Wed, 24 Dec 2025 00:28:08 +0100
X-Gm-Features: AQt7F2r33NHblPlN4FScrJGfuWDSiUQdbW2AclDxMsulZVEfQ7CWkiOtF7y0tsE
Message-ID: <CAFnufp1LcTCLtCrd=iLxD7DPaOouov=BW=Scj_yXJ+Pn96RKLQ@mail.gmail.com>
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno sab 20 dic 2025 alle ore 13:45 Matteo Croce
<technoboy85@gmail.com> ha scritto:
>
> Il giorno ven 19 dic 2025 alle ore 13:53 Matteo Croce
> <technoboy85@gmail.com> ha scritto:
> >
> > The overflow check in rw_verify_area() can itself overflow when
> > pos + count > LLONG_MAX, causing the sum to wrap to a negative value
> > and incorrectly return -EINVAL.
> >
> > This can be reproduced easily by creating a 20 MB file and reading it
> > via splice() and a size of 0x7FFFFFFFFF000000. The syscall fails
> > when the file pos reaches 16 MB.
> >
> > splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
> > splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
> > splice(3, NULL, 6, NULL, 9223372036837998592, 0) = -1 EINVAL (Invalid argument)
> >
> > This can probably be triggered in other ways given that coreutils often
> > uses SSIZE_MAX as size argument[1][2]
> >
> > [1] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/cat.c?h=v9.9#n505
> > [2] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/copy-file-data.c?h=v9.9#n130
> > ---
>
> I've found a simple shell reproducer, it might be worth adding it to
> the commit message if the patch is considered for apply:
>
> $ truncate -s $((2**63 - 1)) hugefile
> $ dd if=hugefile bs=1M skip=$((2**43 - 2))
> dd: error reading 'hugefile': Invalid argument
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s
>
> Thanks,
> --
> Matteo Croce
>
> perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

Following a discussion on the coreutils mailing list[1] I think that
this should be fixed differently.
I'll be back with a v2.

[1] https://lists.gnu.org/archive/html/coreutils/2025-12/msg00097.html

Regards,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

