Return-Path: <linux-fsdevel+bounces-39796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A21A18759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 22:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DFD3A4D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C151B6D15;
	Tue, 21 Jan 2025 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="xqeSI5y5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9093D1F63CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737495168; cv=none; b=MIezZLVwwsLkZ5Y28sQ+58oKWQ/BubF3TqRW9rV10EdixC+3l05HQ7Na9Ix1na+elJwg0sx62CZBrPsERcZWBN1AWVhCURpmU6mWqA2jhyRoMCrM2iMaUT91oYVazPLq0iBlZm4aTw9n4W7MmvfVQFylTRxpTnpLRbpm05n5JKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737495168; c=relaxed/simple;
	bh=mZGQJ9qM9wL0AF6hn+07vaoj8R7Cyv/0eyy1hrPErQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgWjM92IbU5pWdO/TYm1YErLLpWEd5c8x5iXp/F0+c3CPh/xBrkuxRlJ6+rY2njuv/qyDnCg5/WcZdca/4LyCceHcyqeJpMqhVgWfmafTHzQSxSVgXsUiFEPttlu9nOen6YclTS598vCLzfelZL4QkM1pNkT40UYs4wkMcV/mWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=xqeSI5y5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so111519415ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737495166; x=1738099966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2z+VO5hBqe82IWhQkgPhbx9IkjfSZEcveJavbqToXmw=;
        b=xqeSI5y52hy5Z1JLFHl55tNig1DPoUoTCx57o7UED/Ob47rFKLfDW7rRxk+8SBCvQM
         KVt4i4y2K31QsCLVMDmMsX0ireQimG9YYjrT/JWVXlu8Ad3klDWG5ipNIw9jas22VvUx
         6Yszd160KPfLH1MyZU1Or/8NPzlLvsJPrcClliRogeMFIj+0zutPsqyDNeiI9IshIB49
         uzirfitDycnHPINjvwBoK/LcwMMy4JB5RP4uKtBn+yqDwE4MyIf6n6yjmnpHxs+mD1vB
         NH+zbQTD7n56YZ5ugtcFz4C1CMAwvnUtEKiUGMiwyUtxrvOwnvjlsdZorNcS+g6mIFpQ
         /RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737495166; x=1738099966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z+VO5hBqe82IWhQkgPhbx9IkjfSZEcveJavbqToXmw=;
        b=c1ylkl/okBgKjrlGCSi8sMDQmNmNfa7U9ZyCIZjcewJp6Vtj02S2sJYDb52igapS1H
         xtXpSsiiQ7aIPxKfx5VpeqrNvrV3E7iaroEblRSbP7ZkNyoyIWbce4A2MiAUg8fPgilC
         F6OE90LJLGilLv0x+9NVQphIzy9Vec7pN/DJobkXO/Ooj4hKlj8pBOZU4oYjI1AKDZGN
         Er91ezmWum0+gBwPNWfDfxX7L5izTMp/0ijGue2WUskpHo0Weq+FnfZnp87ZEuKqE38R
         qgfYN8wzBMkMmL2b2H70G4d3Hs6erwe1VbASFm6/aSVOkh6mYud3pOOK20ye/NinzjjR
         7vog==
X-Forwarded-Encrypted: i=1; AJvYcCU8N+dCjEeKigjuLEzbjlubzGzirecSHB6LfacdXQjQ/kfw7z0ZywgWodpXr/yFgKpGNt+UqB23IhZ8MvNQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SY1nOD7z7LcuJrpLX9c8XKtkeE7lTmaDXTL0deIiLVncbzsz
	tq0LP+RUREMq1kgi3PdAU1HWkGfd0XF/2GMSx9GEp8I+cNhyq2SKoUduoPn/l8k=
X-Gm-Gg: ASbGncuRREPtISIyyMB008SIORfggYWapbgEkTW6ouZZFqgbH8LmZ6DMUt05PICKVZ1
	jtQu3s5GinN4Gz0XSLaGqtdoIgTjnrDug13WrtvqZF/otmk/6lJtkR9YGQ/tYKGKwJa9qJMv/bC
	17hwLq2g5tXfSmUnhvpK3EnUfL8SDbGWo8a2C7x6NzZ759m6hquPXSxmvsaFGzM25q/fTIz51Ye
	lhbVdXkUY+b9n3IQco0yLOGH5JQjxSNS46e6J1OPwVfznkbUFmI/GbNTs+yGzluQC/RpiqF59PD
	k058O5BiGFYpZ1Z5cOGwC4xNLv29ZWcRQnZkCPqhRKIl7A==
X-Google-Smtp-Source: AGHT+IGZEznLQ5Um+JBR6TKG957+zkA76vrcTibAAOp+k631ZLhJk3i6dSnSnD1MtqWUOKH6iUYyqw==
X-Received: by 2002:a17:902:dacb:b0:215:5ea2:6543 with SMTP id d9443c01a7336-21c35546dcbmr293502835ad.28.1737495165826;
        Tue, 21 Jan 2025 13:32:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d403e3bsm83156705ad.238.2025.01.21.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:32:45 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taLrW-00000008p1b-3Nxf;
	Wed, 22 Jan 2025 08:32:42 +1100
Date: Wed, 22 Jan 2025 08:32:42 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: xfs_repair after data corruption (not caused by xfs, but by
 failing nvme drive)
Message-ID: <Z5ASeoYWtPxi7RDt@dread.disaster.area>
References: <20250120-hackbeil-matetee-905d32a04215@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120-hackbeil-matetee-905d32a04215@brauner>

On Mon, Jan 20, 2025 at 04:15:00PM +0100, Christian Brauner wrote:
> Hey,
> 
> so last week I got a nice surprise when my (relatively new) nvme drive
> decided to tell me to gf myself. I managed to recover by now and get
> pull requests out and am back in a working state.
....

> I honestly am just curious why xfs_repair fails to validate any
> superblocks.

Ditto. It should be doing the same checks as the runtime validation
code...

> This is the splat I get when mounting without norecovery,ro:
> 
> [88222.149672] XFS (dm-4): Mounting V5 Filesystem 80526d30-90c7-4347-9d9e-333db3f5353b
> [88222.632954] XFS (dm-4): Starting recovery (logdev: internal)
> [88224.056721] XFS (dm-4): Metadata CRC error detected at xfs_agfl_read_verify+0xa5/0x120 [xfs], xfs_agfl block 0xeb6f603
> [88224.057319] XFS (dm-4): Unmount and run xfs_repair
> [88224.057328] XFS (dm-4): First 128 bytes of corrupted metadata buffer:
> [88224.057338] 00000000: f1 80 cf 13 6c 73 aa 39 55 20 29 5c 2a ca ee 9a  ....ls.9U )\*...
> [88224.057346] 00000010: 5a 0f 56 de ff da 93 5a 95 f2 01 ff 9f e7 6f 86  Z.V....Z......o.
> [88224.057353] 00000020: dc 90 f4 ad 8b 7c 6d 47 87 1d b6 47 80 25 d0 d5  .....|mG...G.%..
> [88224.057359] 00000030: da 36 1c f4 ee 22 e0 f4 b4 19 9a 74 bf d2 7d 49  .6...".....t..}I
> [88224.057366] 00000040: 2e 1c 0d 62 a9 93 7b c0 53 b5 52 b7 eb 58 d3 52  ...b..{.S.R..X.R
> [88224.057371] 00000050: fc 4b 13 cc 42 c7 36 88 1d 52 28 ef c7 20 cb 39  .K..B.6..R(.. .9
> [88224.057377] 00000060: f7 db 9a 83 2c eb 23 52 b3 1a 85 bb d6 5e ff 4b  ....,.#R.....^.K
> [88224.057383] 00000070: c3 3d 88 a6 dd bf ab 2a 94 1d 2d 19 6c b5 d1 e5  .=.....*..-.l...

Yeah, that's garbage.

> With xfs_metadump I get:
> 
> > sudo xfs_metadump /dev/mapper/dm-sdd4 xfs_corrupt.metadump                                    
> 
> Superblock has bad magic number 0xa604f4c6. Not an XFS filesystem?
> Metadata CRC error detected at 0x55d6d5e1c553, xfs_agfl block 0xeb6f603/0x200

That might be complaining about a secondary superblock, not the
primary. That would explain why it mounts...

> I can generate a metadump image if that's helpful and there's interest
> in looking into this. But as I said, I've recovered so I don't want to
> waste your time.

I'd like to have a look at the metadump image of the broken fs if
you've still got it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

