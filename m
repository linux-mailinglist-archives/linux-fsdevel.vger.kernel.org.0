Return-Path: <linux-fsdevel+bounces-10779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAC84E3B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523311C22BE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87757AE53;
	Thu,  8 Feb 2024 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O4KCol6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D51E525
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404855; cv=none; b=GG/KsBfd1Nj/pOHg2PQIW9SjLlGKc8QMvEVcPyUfJz9issAbhcBTxfcwZ9Xmyl647W1kUypKwQkW+AFbs82UECh9Fk740Cf4peX1pFxMrIuhf9e6UzKhplH/y8QLfbNFsolMaBDE3T5o8MZj1/kKwYUqYeRXnDwn9vitRSgn94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404855; c=relaxed/simple;
	bh=s0GfJANuIRWv3JniBiwVDxjFClb1POiP9NYLVlujUVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcIQkVf2vTFYRn8l/H3pHAjSPcfmKxQOvcEqE305LihkPujoSy6qU8rgMaXpXXIVvvfgwajyJy6keg67aX0nMxEANI78KOsImhe+AibBA7ITlnwhi7ZQsXvY55WjoQoOjV5eDr91JpAmDYK3Ee/XKoJ0BCDWu5a8vuyKsN6jAj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O4KCol6D; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361a8f20e22so1385095ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707404851; x=1708009651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3cQa1QhQ9E0c+aggEX+liAqxonZdRQfqUOCEPMfcGs=;
        b=O4KCol6DyyFzysev2joMqQnMPPU0H6wgW+km1q0jCZkLo/FmlYhNZrNZpgYZfgYZcV
         WOOe3vhs2p6bezHPayyNU/daxk2EMmbbJ4sHtf2rhgG+uxerX7Pu+W4NbHhWKYUpBb6m
         4UT8TZlkwnFI4x9U8SAloVH5JQ2qr92Svbxbatx8H1mdap8OJ4cfWxnewveaJja01lBX
         DFGs/AW3LoZkFNOLu574GUnoFGIBHjYRA9hMq83jRUnxNRk25gPjXwdue0aDaIP3yA9j
         Vk7IgzToPDVFsU99h+0ehjVwn7RwGwWTCvbWDgPDhH19eQiUKciuAt32aBczFs8xBIxE
         wa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404851; x=1708009651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3cQa1QhQ9E0c+aggEX+liAqxonZdRQfqUOCEPMfcGs=;
        b=SiMXtS6GlJJnmF5nIdSJIUukyVtIoOHIPrXYlfABcdsDgQnd+5AFA9+IfMYxtAFQ6R
         XqJhjCgijLNI5m3Sjgud4lTAuuUhRF6Lri2bjE/pSiVcSw4TpCm2MNAG+5ZqkwyBoA6a
         E8g2ek8OXaIZMbeeSR6JeQw7qns9eRaZb5cxSfPbqKelHUriyErsJU8nOrLl7kJmmHgs
         n9Xolnh9GVphiN21Pfztmf563i6wXNfyiBlNCEI+Rqw6fCi8hVJDP06YAJPPFiYgt4CM
         rjtlxDmRafxt9R0UeUsXjiQgCv2p7tRaNVcEpOFaw57nt8YLTzJLrTlbOPN+WfCXhF14
         6axw==
X-Gm-Message-State: AOJu0YwDKS53WOdLw80xI7IQs3Kml1WVFH7m4rCghI03pZB4XnioTpnx
	9zOeDBgrPSQcCQ0LLc+zHz8SrUMdc/AZdXETSCc5xW4adLWz+rvCvd1x2Vm0s28NqQyjQIjZcLd
	W1WU=
X-Google-Smtp-Source: AGHT+IFP46b/A/1gqUZBCimSbsUBbJ++aoAP1ROTsoXGDnLUmU7HA11TpZusm9I1g0sn9M02vDmNuQ==
X-Received: by 2002:a5e:990c:0:b0:7c3:f75f:7b12 with SMTP id t12-20020a5e990c000000b007c3f75f7b12mr7211974ioj.0.1707404851231;
        Thu, 08 Feb 2024 07:07:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUq4vvaPj2KRALpS44SWWE/CmNMH8fL/38VEqBxGBf6wVRw9QdVfu6XEf9NvV52ARIm0OB+mLzZbl1G3GDZFHN9DZwFhQb2KMj6m+Mz4bzrDk6SP3A+awnYt7DG+UYrFDT
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id c7-20020a02a607000000b004712aee5509sm893933jam.134.2024.02.08.07.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 07:07:30 -0800 (PST)
Message-ID: <f44a64c6-ec61-4b64-a983-39c456f39e2d@kernel.dk>
Date: Thu, 8 Feb 2024 08:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] Add do_ftruncate that truncates a struct file
Content-Language: en-US
To: Tony Solomonik <tony.solomonik@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
 <20240202121724.17461-2-tony.solomonik@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240202121724.17461-2-tony.solomonik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 5:17 AM, Tony Solomonik wrote:
> do_sys_ftruncate receives a file descriptor, fgets the struct file, and
> finally actually truncates the file.
> 
> do_ftruncate allows for passing in a file directly, with the caller
> already holding a reference to it.

Christian, this looking good to you now?

-- 
Jens Axboe


