Return-Path: <linux-fsdevel+bounces-27238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B002195FAEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FBF1F21CC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B1C19AD70;
	Mon, 26 Aug 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="y+MJuduu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D219AD5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705336; cv=none; b=ZV4u40rQKwCTEC3VfipXTbZ+ZRkyYEiA2XIzcnboA+1gQfCQUk2xFpqP5KooJlvPRF4ixRqBroXJQw6rTRUAXywjLcK2XkzQfXqebsqGEQBWuFTjZoMkG/Kcpwt/Z92hCifsyJ4+oqUsgMxKF119Jgx8Qi2cDIaSLcsrOXgEfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705336; c=relaxed/simple;
	bh=EhuGWj0FdQ6Y5ZHeFjg4yfpc364FW13L+Ifwl2Budao=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=K14KrWBSaYOkH6xDxCeWO3qSvao9xhE1hEsjPLTy36/qZWaybgSKilF9c/TtP0sjsy5Dq3JSwr/DDPwq4StIaW+tnPtz6DwPTWPaucATpkqbVxUFYI5bgGndz4+AOzgcDnW9F2/nm4V17r7vTtBbrhLrvWaIqGYVNN5/EjASBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=y+MJuduu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334b61b6beso772789e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 13:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724705332; x=1725310132; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXLB9zkEdo/4dH8derdyK4VwB9yZuo2dG39pnlUjD2g=;
        b=y+MJuduubw6VB3t5MJD1bMg9NGEFNj/Qd7gQq8pG7sOrrZunXTrMthphPwW4rpFxRv
         wDHWlPTEvJsKYUuC6dUuP5Q2d4ZGeUhUsn8H+nkY0Y5pnVugXiDGBrgh3mw2v/Kl0YRo
         QmQNld6E1yjHqgYFU/Hgct3s9DHYWX++kUCBNTLVuDDkD9Akw9Zb4JwHX0Wl1n/2iMx/
         x+uqP5LnVzh4jqy85WrVgrI8DrPyE3UYkCZ2DfAYAejtle+5aJlP1PHwyQ/L9Br2c249
         h/IZRLyf6+JHAfHpbwbP0LOrBLCRYg+4sgtU+oJWEf1rfnQE98KqCwK80Und5P15K5sm
         fzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705332; x=1725310132;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLB9zkEdo/4dH8derdyK4VwB9yZuo2dG39pnlUjD2g=;
        b=Yn+ZkbH5eANzbfAdBPuwoFfDJwj7uGHbSStkf/1Hz8baZa2q2kwKX3+CnlaPdDKKK6
         iB1qU9SZvk3bJ+6b3xuj9p/HSu1XuDamkDQMzHY7E65SAcQiu/Bvr+aLBMHTyJgw2H07
         7wCTdKA3pkDFCoDF62/m3g4hef+FWO/WUwo2fOkeuNgOE+Me3Gz3ktklA4/qeKFYEPjv
         N5bujTSRyXmm1I8GJYnvf+NDterUFp8cAa2GdPBFeOk7gnMmRfzukMa55EsNq2dnj9sw
         jqCMSAVjFuyoQ5533ZRWhY6rAecNKNGbicATPoMZqGT0tXYuQjh5NFq8Vn1T2YQhsswZ
         hgzw==
X-Forwarded-Encrypted: i=1; AJvYcCXH2+N+J2hTQV0igVUgOnyOo2kNVNha7U+kMxxbFJBCk3iLIgdunkDJbutuXSutXQ042VJE5j0sBTnqZRx1@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTiAqXu+GRXI2GOt2d18uBpLbcdgsKipo9Z0bPGbjogge5Wxh
	k1tLPEwoVWMnoopYRJboV+PICU1DbYE3EV7NbfzHVioScvD9CMGAQ35HsvqPGWU=
X-Google-Smtp-Source: AGHT+IFh7iDNHL3zLwfm2HC+viRd+9tBqo6FndoMyhmB3E5TI9dHA3hsphEOU6Shuce0HutNHgqW3w==
X-Received: by 2002:a05:6512:b8d:b0:52e:ccf4:c222 with SMTP id 2adb3069b0e04-534387c4d10mr4745357e87.9.1724705331999;
        Mon, 26 Aug 2024 13:48:51 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:8cae:d35d:b93e:b368])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d6b3sm18675766b.105.2024.08.26.13.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2024 13:48:51 -0700 (PDT)
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
In-Reply-To: <202408261307.F7D2AD650@keescook>
Date: Mon, 26 Aug 2024 22:48:40 +0200
Cc: dsterba@suse.com,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <9EB1D6D7-DD1F-433D-BF6D-7DAC53EE4BAF@toblux.com>
References: <20240826142735.64490-2-thorsten.blum@toblux.com>
 <202408261307.F7D2AD650@keescook>
To: Kees Cook <kees@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 26. Aug 2024, at 22:08, Kees Cook <kees@kernel.org> wrote:
> On Mon, Aug 26, 2024 at 04:27:36PM +0200, Thorsten Blum wrote:
>> Only ptype is actually used. Remove the other struct members.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> fs/affs/amigaffs.h | 6 ------
>> 1 file changed, 6 deletions(-)
>> 
>> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
>> index 1b973a669d23..9b40ae618852 100644
>> --- a/fs/affs/amigaffs.h
>> +++ b/fs/affs/amigaffs.h
>> @@ -49,12 +49,6 @@ struct affs_short_date {
>> 
>> struct affs_root_head {
>> __be32 ptype;
>> - __be32 spare1;
>> - __be32 spare2;
>> - __be32 hash_size;
>> - __be32 spare3;
>> - __be32 checksum;
>> - __be32 hashtable[1];
>> };
> 
> This is removing documentation, in a way. Since I suspect you were
> looking at this due to hashtable, maybe just change that to [] and note
> that it (and the other fields) aren't used, but they're kept around to
> help document the format.

Yes, I was looking at hashtable. I'll submit a v2.

Thanks,
Thorsten

