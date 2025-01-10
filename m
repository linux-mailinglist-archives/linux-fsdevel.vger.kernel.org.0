Return-Path: <linux-fsdevel+bounces-38882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D37A0967C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FC83A8CCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFD211A3E;
	Fri, 10 Jan 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g1aQxVtB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB08211A08
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524531; cv=none; b=MwoCqZxrSbiM+ARljSOQ8wTO7NDQL5TB/Fi5sj5yLVmWTdEaIpZzDpI8h7Wh9nZDEx21hmmUGYgwgU4V36QHi3v/0w1GccIM7h//c64uroWVyU7mFMN/FE7GB+OCqRQjUPjRmwFiNJbnMK4Q09/q6S3QhI8csmPdAeXo+gXBYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524531; c=relaxed/simple;
	bh=PT5KbB8STzieb8SI43c9r4bJRZSyJCdnd4NCbGpXFZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l6mE0Wt5/e3gKOnShj9egjj0uJE9iFOG5o1qDtn9R3jBXfyobyVBGUr3aZXm9Z0gtmTjJi4CD7rLnL504YY2qpCdfkNaBBltdU2pCMJ/e4nkUbNuJbcsF6ooijCT5ImEw5LKGcUj1snAKQZzMrAQcHEfPu3O6R41NUJS+GTzvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g1aQxVtB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6df83fd01cbso9322646d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736524527; x=1737129327; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+4DHniq6Jwfm/qrHjg7vshNTs6ZZXTUjwzCd53ai3s=;
        b=g1aQxVtB9sEhUJIZs/HmU/oTV2vlRxnHfwx8Z9mBDGICh/YnW5Mi443b/X0NO7M1Au
         bzNagGCVSE2LfcL1aq6CHWyM16DibiNB4Ml0MabriqzGVzD2ziRnkk1M10BHWXdVcnT7
         E6xlPqkAskO78ARUUgbhBEukUHJMGFpkhTaXlQrx/9QCze35MwMDAkVyUUjmsx4rnuml
         AIFZFtsIxrr67yTXUX2u10+zuCixlzGHXUnVu5NX1oYoDLqorQ9yoFXajEm1EdO5K5KI
         DMc/DX7cSdJUIZNKhBYduCkSpXJemZmGGgACvObtKX6Yixc3VBD5FBvwTh445LU83fw8
         J8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736524527; x=1737129327;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+4DHniq6Jwfm/qrHjg7vshNTs6ZZXTUjwzCd53ai3s=;
        b=Xn+8CwoB0ETykVL7Y8SkPaJQG3y5FSV91GozWHaCNHFnPWs6hzu0XocgxezDhJFUcc
         oHpPhFUR8GzvB7ow+M6iI3eOu+exCP3qRVP22MWiRBqd2LxUz4ovvaIHagHgDkNyhYzB
         x9hzefo+QywxTqyKHsnmDnPVNanQe6gwx+66DUw8d3S7vD+UA6hhpQ7xmnrWe5np/Jqn
         LFqQ4ccOVzmhlVl5nlYb+DODGLwjRExKmke4BodUv5KKtaPxdRii7QIPP0PYQOSKUent
         H8UBi8bZ+BXpg+7hNz6w4hMKuI3x5u+sKerJprwI+6NSsHAkacdWgm+kHCuHQedW6Aan
         TD2w==
X-Forwarded-Encrypted: i=1; AJvYcCVgIv7807x71/5KU2z4nZBoBZCDLwZilxURg2s9vAbEtPNQ9dNMk89ArnzvKtzHRcawzrcrfQnlmvFnfNYp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6nHwZOtaKnmDe4PlRZyiPC7vdI9Za649HRspwXgBKvV9vVlH1
	LZ2UAsF+r48doImraZ5xgP+8n2B22+AeNRdO1q83R1KZa3HAcemQq9DsSjbTTfk=
X-Gm-Gg: ASbGncsXboaw1eZlSpDa+cmPjnDUazUMyNr79OY3CT19GNabiDK3Bv8q8nVVAg06NUG
	bRxNZZY2BQvF0ssL/M9nuKZ/RQBv9q57wO+0dr5RHCnDkomO8ZXRmS5rejiHPQPHKu8uwb85vqa
	U+p2piGMFeoHXqPKU1rwri1mmRtxCOzSce95+k6H0uqALrHRFTTnb2fjd1Du0rV05JlLwKbYZvg
	xdRQI38Ii+QF6vd4SdeG50PiHBAkIVd16G1s0Siv+o0T3Eo2iFkiW6sa5/xedN9SYW54rBRTFXx
	aMdN6vvczzbmNEWAH3s=
X-Google-Smtp-Source: AGHT+IEu9QWoE1yj8ljZXJZo7UtmDZAvNDTGtvJsoZEgk/j6xFlgrRvToReL+/TBCH5oXr0zA/7vWg==
X-Received: by 2002:a05:6214:e6a:b0:6d4:3b7a:313a with SMTP id 6a1803df08f44-6df9b2d36c0mr158944466d6.32.1736524527444;
        Fri, 10 Jan 2025 07:55:27 -0800 (PST)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade733e9sm10375056d6.82.2025.01.10.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:55:26 -0800 (PST)
Date: Fri, 10 Jan 2025 10:55:25 -0500 (EST)
From: Nicolas Pitre <npitre@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] binfmt_flat: Fix integer overflow bug on 32 bit
 systems
In-Reply-To: <f946074f-60ed-455f-bcc7-4364f15b9603@stanley.mountain>
Message-ID: <4252467r-08n8-4oqr-3910-p5n1pq8so9s5@onlyvoer.pbz>
References: <5be17f6c-5338-43be-91ef-650153b975cb@stanley.mountain> <f946074f-60ed-455f-bcc7-4364f15b9603@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 10 Jan 2025, Dan Carpenter wrote:

> Ping.
> 
> regards,
> dan carpenter
> 
> On Wed, Dec 04, 2024 at 03:07:15PM +0300, Dan Carpenter wrote:
> > Most of these sizes and counts are capped at 256MB so the math doesn't
> > result in an integer overflow.  The "relocs" count needs to be checked
> > as well.  Otherwise on 32bit systems the calculation of "full_data"
> > could be wrong.
> > 
> > 	full_data = data_len + relocs * sizeof(unsigned long);
> > 
> > Fixes: c995ee28d29d ("binfmt_flat: prevent kernel dammage from corrupted executable headers")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Nicolas Pitre <npitre@baylibre.com>


> > ---
> >  fs/binfmt_flat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> > index 390808ce935d..b5b5ca1a44f7 100644
> > --- a/fs/binfmt_flat.c
> > +++ b/fs/binfmt_flat.c
> > @@ -478,7 +478,7 @@ static int load_flat_file(struct linux_binprm *bprm,
> >  	 * 28 bits (256 MB) is way more than reasonable in this case.
> >  	 * If some top bits are set we have probable binary corruption.
> >  	*/
> > -	if ((text_len | data_len | bss_len | stack_len | full_data) >> 28) {
> > +	if ((text_len | data_len | bss_len | stack_len | relocs | full_data) >> 28) {
> >  		pr_err("bad header\n");
> >  		ret = -ENOEXEC;
> >  		goto err;
> > -- 
> > 2.45.2
> 

