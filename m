Return-Path: <linux-fsdevel+bounces-27371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FD960B1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0198F1C22D9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7091BD000;
	Tue, 27 Aug 2024 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="G1giUSWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04A19CCE7
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763110; cv=none; b=kCRhIV3ZcS1VzMbfBP2O6Zr8+cXFhxLfl9M5LUu1sAHa0EXdj27AnL2JBgDF3g6b+stjE4kcn0GqsAywnkMI+WoyZVRcWsBVd/gGj4LoIB/mtlmeqVLpkDDDJphyCX2zPoZn3YV6RdgT5zlzCWAWP0llXqbMF6i0jX7O+qe0sQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763110; c=relaxed/simple;
	bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G/TWsynNUnfF7u6cdciecicQ79sVPadXX97Mk1hNI5Hh6TdQM5Qu1Muj8NSZM9/tLP/nAghlYSunXglsoUQXk51ezAiDcU3bRZwhxXUnWw+dvLoRhZv+IKNu+CZHrNbHZ8oT8D6yE+iM76NwB8cUL8G2oKlsCNm+cq37ikImafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=G1giUSWT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bece5b572eso863993a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724763107; x=1725367907; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
        b=G1giUSWTLUShSyezgmAP5WTfaGBx/tLINNFnvAOp9ueN22h2VimoNhyMaip/SfsEft
         zze4dh1+xorUmC20Z7ipZm9EKBL4nP6eOMVU6Y1ZYfl35qZGhxvf5U5XunkwJpYD0UQL
         Ns7/qTTLiLy38nLKAQ/WUWW8QpdXf9NqA6NXuxnijOmti3G2W3JGr1e541DtqyWy7SRk
         qSqarZ44xodpwv2Fg0YDyOmjeOSHJxHtPXSAcM7FjHejC7gA5mc21S6hZAnmLv/PlXUF
         SC67/xI1xUZEtLmnhivMGH3DJjqKIzDT8HERVe9QJ37XBSzwGc1HoAZtiUHQFO6+0j1o
         sQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763107; x=1725367907;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIZ/9NAl6sknpOSyqXJf5pTwFKUE753sOw+rcvyB6VU=;
        b=CaHpONOXc4HkjoJU6HZhwWjngynqPiqQ876uKZhKnipo2Nb2Vd/HTJdpUwPjUMdIk2
         Skz1lkJFCpxxrhi+71kSNrvY5ZqhDfzpXzOeS5W5oSauIVVDt4uR/E5MNyZvHxlne3UW
         3b0Ux/ew9CrI5W66ww2R/MyO3GbgmH0pTY0Ra1u5wBl+ORy4UR/vCnLpaf+i2eNrhZQL
         NT8FcZrRmKEHAA4TiN/T3DPM/LgrxQlroEuFyGoQhEIIORoYm99HPgztPEDduIcU8iTd
         sugfe6v/nhWcZBKvxDg4VDVSzbroi9qnk5XIkKWqeoheEFtzV2PMmjrX7qxS28i+em6a
         K/oA==
X-Forwarded-Encrypted: i=1; AJvYcCUt7qbPgbQoQ1FR9DpyRZebIdt9qv4NcmhdSVWcbGVdOvMuaz16bePLlgdwr72/AIIfxSlzcdxdtw9MRHT0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Vpk0cgkm1eYLPJS/43pVRgN+BniSGMV7wfPPiCIWHvOqtYSJ
	cjBJ1FoQHdTkqDKahLK9HyKpuiCPQEOE8GijMLVpvJGtuNkq7X4Mc8T4X2Rzg5o=
X-Google-Smtp-Source: AGHT+IGI/KqUx0O1B5OMUKooRpbtrwcBTIHeYmCBtCsBzSzU5pJS6J8O88BgzLYlgAW1IzGiJylzZw==
X-Received: by 2002:a05:6402:51c7:b0:5a0:d706:c1fe with SMTP id 4fb4d7f45d1cf-5c0891f071fmr4899966a12.6.1724763107214;
        Tue, 27 Aug 2024 05:51:47 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c5b39sm985401a12.20.2024.08.27.05.51.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:51:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] affs: Remove unused struct members in affs_root_head
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
Date: Tue, 27 Aug 2024 14:51:35 +0200
Cc: dsterba@suse.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <761C500D-3075-4958-9011-DEE38B235A39@toblux.com>
References: <20240826142735.64490-2-thorsten.blum@toblux.com>
 <202408261307.F7D2AD650@keescook>
 <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 26. Aug 2024, at 22:48, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
> On 26. Aug 2024, at 22:08, Kees Cook <kees@kernel.org> wrote:
>> On Mon, Aug 26, 2024 at 04:27:36PM +0200, Thorsten Blum wrote:
>>> Only ptype is actually used. Remove the other struct members.
>>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>>> ---
>>> fs/affs/amigaffs.h | 6 ------
>>> 1 file changed, 6 deletions(-)
>>>=20
>>> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
>>> index 1b973a669d23..9b40ae618852 100644
>>> --- a/fs/affs/amigaffs.h
>>> +++ b/fs/affs/amigaffs.h
>>> @@ -49,12 +49,6 @@ struct affs_short_date {
>>>=20
>>> struct affs_root_head {
>>> __be32 ptype;
>>> - __be32 spare1;
>>> - __be32 spare2;
>>> - __be32 hash_size;
>>> - __be32 spare3;
>>> - __be32 checksum;
>>> - __be32 hashtable[1];
>>> };
>>=20
>> This is removing documentation, in a way. Since I suspect you were
>> looking at this due to hashtable, maybe just change that to [] and =
note
>> that it (and the other fields) aren't used, but they're kept around =
to
>> help document the format.
>=20
> Yes, I was looking at hashtable. I'll submit a v2.

I submitted a new patch instead of a v2.

Link: =
https://lore.kernel.org/linux-kernel/20240827124839.81288-2-thorsten.blum@=
toblux.com/

