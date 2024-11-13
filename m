Return-Path: <linux-fsdevel+bounces-34650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC29C72E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EAC286121
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142B20127F;
	Wed, 13 Nov 2024 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v7h69eml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0653C38DE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506871; cv=none; b=XOJBeXDwYzURMe+oqD1ClAENGijoc9wrZdJZuqFKijCJS5BcXEnGKfKSokgWZjL4p8foQiMR8OpU0l9G6ib/xMxhyAsybHYs9LZSl8yBp/WR+2Mk8al4A88nzCJjbhQjEuEwswEZAJUBgjnLccbl9OQ0RbzSVedDx+QQyJ2eNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506871; c=relaxed/simple;
	bh=LF/v2APQUH1XNOf6nW5RuGpUkrh2C2KCHmydIhInUF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7gnC/zeBSI1D70HHzeynkR+DAbT4C6a7+IuouuobkRCyog3XnGi0w2C5+iDCKXcQwGKJSEw4wF6i2/x1HoHGdvNc/q/MYfHTvmiqVTVbQ6L1BZrkLDIcelNiq1paklqSvVwBWAisf2iXVJ+IE1Uj/S61sSRvWG1PK/VLk5eVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v7h69eml; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-290d8d5332cso3293841fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731506869; x=1732111669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=v7h69eml6Jnb5nQMa+KFHYO2D4/5k4rT6wxVuBH/81dcsAmBMWGjz0XJHKwNoB/8NA
         s6S8RgqD5M2/uHouHrQvuRHSHGZzKifDfxSFr9poxw2tlWKwtVem7AMdxoZDrIwPFmQa
         su4WSFx9Zh4CRpc4b/pAAq37noZKjFiNdeoSaMROHn9Y0ejNkRKw4lyhNLPLDTabU1x6
         RPjnwORiVNDXIr98a1m7gVVfbxR+9f2yK9siE0q96QXWoj6J9JwI4hFqK7JUS2MXS+49
         YL+yMQX8mvY8U0gF8tOV3HhlsBX3Tg52+RADreZ2gmSnO8M4cKadJWP5BhXEteeQFaKN
         61bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506869; x=1732111669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=Pmct1q/AUSW9C3JP26JBaj8uUkkleIBlkG/yrnOkuP+jGaRkikYNwh4vKqiFMWELJI
         746nlNQ6VlyEF05uYk17S/1yxQw1EtagOASqjUHSP4LG6LW4noRxFdGHyql15NhaVerC
         DdV5wmBHO/3rNC1GNKNRDgRbx7H20gMHoJM7jP/D+tfle5Nv2y37/2Q8v2s/aBuXQb0w
         FyNh6r5W9HA1297GoXi5ne88mDH4QR3Ms7dJanN8VNJfDaNuOSmFTKksfOaH/wqAl8kq
         fHZx8G3/dMDTWhwtgvGWVqCeyiT1WswuP7X6Ro78oomv2PR4+G/MySLcYp2a+aNv0K9n
         rJcw==
X-Forwarded-Encrypted: i=1; AJvYcCXVE0lfBkIFzaQXnzdhYsUmWbxvFsxvmwSoMmuRWE3LfCE7IGqcwU1fYjPrIu+2raHdSYFwIEoPHL4BPZr0@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9/t8IxUVeNgkZyhvgq2rRTnIXIgFVLlTN33Zb6aXUnqEN+mO
	U6yq39y7MARJ99JkSNYqJXOAgyJNMjLD7t9wV63hU2HzPJTqlffLoVj0ookSWxQISU24lUpsN8K
	l20k=
X-Google-Smtp-Source: AGHT+IGEfZjJzvmYB5T7HmihIrZcBbzdyhAHtDcVoiQlMJqhmTC27u0FrzbpiAWxDQgEe32pakZQbg==
X-Received: by 2002:a05:6870:b254:b0:288:47f8:925c with SMTP id 586e51a60fabf-295600a29d9mr15655747fac.1.1731506868958;
        Wed, 13 Nov 2024 06:07:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e8fe5c61sm710128fac.23.2024.11.13.06.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:07:48 -0800 (PST)
Message-ID: <3ee7c9d6-78ac-42fd-b121-7f6694723e4e@kernel.dk>
Date: Wed, 13 Nov 2024 07:07:47 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] io_statx_prep(): use getname_uflags()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


