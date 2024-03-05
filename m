Return-Path: <linux-fsdevel+bounces-13623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94088872143
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60E21C22B69
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6536186630;
	Tue,  5 Mar 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eiY3nWBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39586625
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648120; cv=none; b=sqaufOXtpWlBSzzi3c5sfKjF13teVN+KMl6LdOTRJo/eXlrzZY27elPgfJ05GUVpfcst0QBEbdb6x0tewwpKvBB+5Gmr2cx8oMfqRGLt9CA5ejfkEiJKD1UenEbbCB33GrjWbQhXRAOmMT+kMSLj4c8Er2j1HvP60vufDYVbypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648120; c=relaxed/simple;
	bh=8nsWlzP2W44EEol+t4k7Wnh5+4K8n/hwLlP/1B+1Mu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ja82WercsEXOStVDZCh7NEpAhMLg6wrQnHotVLnefWIYoZAVn9CQwd8kjURGW8Z9K9XlYHSnJ+3vIEwlRKtW2UG+gSwHjRkyXBMFWly8ioxc5vsl9RHkgZYWEAqdL7F6VQEdawcolDh2LtB32Q9qzJuykGt5kT7MhtWGY/c5pHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eiY3nWBZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e447c39525so1243530a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 06:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709648117; x=1710252917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57+rlM9fWzNjihPDAn1YCzQ37AB6iXBRlsrnu5oaV/M=;
        b=eiY3nWBZsU09CBDnSh8WA0xQB18dufhab/fONHfND1K9Mi/6VOfaI+fgNOntmVFcb/
         gDeURHmNEpbsk3l+hu0lVUXxyAFnrPYp8uWhCSV3tLHvVG2H0LWsa7gmmuPAkutRYG9e
         3VP7L57taxs9Yuzf3XYROedrMHXzKCx+BZUIvU3DhMytkqa6/q968t3/XLPhsbdP3aRo
         06purB3h8gl/Z/uxAXLs6878yg6MrDY5w0lnXCKEWXvMOFoMiEsMv54+IIcNvZBH+B1N
         K0Q6e03af7e2OWI2JjaZGpzpYVn29fXlKyFCh8HUqGoCOf6DYZXOz7TFgXuNMnmvXgyX
         nEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648117; x=1710252917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57+rlM9fWzNjihPDAn1YCzQ37AB6iXBRlsrnu5oaV/M=;
        b=nzodvg9JBao7x4uR+ZjIkKbricAhraXcYT/IbMTrNDI4GijaZUf9Votlh28aVzn260
         oAWJPWTSOrm0ySjSNk3iiPpmK66ZMCWryMrOrxiru7HfLSxwub0PvWD4skDkr8DKLstw
         3gdFwznMn1Bnt7Tb3um+BR2YgkSh1CFcFjqdfORcILuppHHILg957+EITO6MxUhllRuH
         C3tZjc1lIHaQHPvws5vlHdiaFmpmR3VM+KKQJLeAtvR+pRO0xChAfMPoFJVy8B+N8pMS
         EDFQ0+yhRX4n1v5YgAHiiDV+J5cYqg0++xajL6/lpy6N2K4/0eUuKZ+9qH70JO1RW3w0
         Y7Sg==
X-Gm-Message-State: AOJu0YzhIMiWHfkOaAXaR+EqSL7EFs6LPa71/WnBv8OsJv0KAeptgFWs
	+IoSsjHojVTNgq9veiTHeuxAi2a9vwjFl/UboBdsOIQGosHHGk4VbRSMgVTTwe0=
X-Google-Smtp-Source: AGHT+IFemI5YpqjqjbQdoIwxvWkrmZbi7NNc6JvgoaNXUGV4jW0zo0OIZLLgDykbRHoTN1bni9BOIA==
X-Received: by 2002:a9d:4c9a:0:b0:6e4:fa99:5bc6 with SMTP id m26-20020a9d4c9a000000b006e4fa995bc6mr494244otf.2.1709648116880;
        Tue, 05 Mar 2024 06:15:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id h16-20020a63f910000000b005dc85821c80sm9043053pgi.12.2024.03.05.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:15:16 -0800 (PST)
Message-ID: <00f46388-e61c-465e-bbc2-15c0bae4ec6f@kernel.dk>
Date: Tue, 5 Mar 2024 07:15:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb
 conversion
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Eric Biggers <ebiggers@kernel.org>, Benjamin LaHaise
 <ben@communityfibre.ca>, Eric Biggers <ebiggers@google.com>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240304235715.3790858-1-bvanassche@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240304235715.3790858-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 4:57 PM, Bart Van Assche wrote:
> The first kiocb_set_cancel_fn() argument may point at a struct kiocb
> that is not embedded inside struct aio_kiocb. With the current code,
> depending on the compiler, the req->ki_ctx read happens either before
> the IOCB_AIO_RW test or after that test. Move the req->ki_ctx read such
> that it is guaranteed that the IOCB_AIO_RW test happens first.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


