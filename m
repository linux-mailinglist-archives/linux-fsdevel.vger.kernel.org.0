Return-Path: <linux-fsdevel+bounces-50395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E71ACBD95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 01:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79693A29DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37F46B8;
	Mon,  2 Jun 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UpbcH3QQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4C130A73
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jun 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748905302; cv=none; b=aRM4GpnRHY6yYV6APlhu17yr1C7LW9AHbE2ipgPpBO3+OH24lk+K75Dr77qJ7u6t4ZeZ7vo9PtlpJo0j5Lno8cvoRli4BDUrGIrWZseys6GRZ1/l1TwNEHFonai40f+WB7pUHgt/0Jzj6FQNB0odORr7YsBb7z0Br7Sn0rWGciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748905302; c=relaxed/simple;
	bh=59eUBlhzOV2ckFatOfYqfREuM/wpDHlCvgZc8i4N5WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPtC6flPUlco44aN0UhRNZbzJ9dvPiSNp8Sk0k0budG65NvKiDMqQk+WmlgUEmyGlbzEgdTF/QRQzIXKrL7JONBYLWKbwB5kUoAEfE1d8tREPi9FREhWTQaO1YZstH0sZIYkCjgN7EJ4RObBAxVzmGycrq/LbL/UG0uVV2ijErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UpbcH3QQ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-86d01686196so103656039f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Jun 2025 16:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748905298; x=1749510098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+equ+3upmf1renBJmqziOzoGh1hJKKHZ35K0AIOI15U=;
        b=UpbcH3QQBt7xSsPgdsjrTchk3QKjaL7yNRJ1Oe5c3GsFMO5EIGKwNB7uQKrflaKVHS
         52gW/6xS+VbBx0LFHn6nz30qp7MXtt7rOQG8Myo+MqkhZJfWNP6v8cfHRB1haNgUf2ME
         Kih4RLqqetkQH+U1YSNu7UjpGyNWycY9GyZPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748905298; x=1749510098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+equ+3upmf1renBJmqziOzoGh1hJKKHZ35K0AIOI15U=;
        b=TJF3KjUruKL9JZzlDd3EjD1eqHygAZ+N9zt3m7fuiaMRKagwId9SbDto+8qAKknnr/
         2Oger53VrY4anxWWde/Tdcav1dpC4tD8FrmuVSRv+gkNy0f9Y5xpdkIuGhgCEuHOCTLb
         Wlw/2TiaJ7nH+gnqJ0LfLzLeZv47GyH8b1Pqv5ogEjp5eeFVHvDMw1LOeZX2p/gVkl7o
         B1mV3uRIvtphzenrO8/Vm5PqQBMYatd2PTfQS55vBD/feWv8WHJpwI7awe2CEZweCCH1
         ujw91uF/V3VI8iI4w1o0icjS8TB7HfmKi9pOmXbElFYPIFrmHU5blcbjmu9r/kCSF1XD
         riKA==
X-Forwarded-Encrypted: i=1; AJvYcCWi2+3AwJ1vE1PmmLqZYptC9eoHhZ04pl03KpYXGNsDkl5wxDL/29q6e/Dcp7h04xEewXIlHqPSrSy63cJ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4XFwh8ByPG3vc49jkPqiKDZYN8GTYdfmlUgd8v+QG0o93NWP
	iYOgMhCLYDGIpQhESB1jW6ed6C45pZ0fwzdoj+Lg9OhH5oc1yHwefpgPvGSf7eKTwIE=
X-Gm-Gg: ASbGncvcnjx2fKF/8TLouyDF++4L+dU/nt39KcEekHigZg1uCvtGU8ciPicm2zbm1sn
	o8IbXrWEyvHGrVGlxphPh1/NEvHDl9M0sYcdNGQXemFm9IPViRf1e89OJnpyqKezQt3APIrR/p8
	q00J+V86vxt3ldpqU5wFQUwyjFV3ebxb+U+bQ25rssdPI4OPcAZOOH5raxmY8/8aSuv64qmcmqs
	EIvHsZtGe1LuPo9nNy8LPGNOeKQ+hbTmrgLmeJnkXiNdT2lu2++0ZQAJteVNBdXWM9tQudmXXxt
	9gv1nVeSH5OQMUWUFJn360N0xbvi78koOwZuPeAkk5RSN09l/LFb3+DFFq6RRw==
X-Google-Smtp-Source: AGHT+IFrjcDEGLtTKfElBpGXOAhF3tHEPfd2K9yevIZkFCo/MB2Kge7c24XSTv/Nb7Ij2aX1xnrXCw==
X-Received: by 2002:a05:6602:6c12:b0:86f:4d9c:30a0 with SMTP id ca18e2360f4ac-86f4d9c3133mr1002247739f.5.1748905298567;
        Mon, 02 Jun 2025 16:01:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7e28daesm1972275173.44.2025.06.02.16.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 16:01:38 -0700 (PDT)
Message-ID: <053cab6e-1898-4948-8f82-ac082d85a20d@linuxfoundation.org>
Date: Mon, 2 Jun 2025 17:01:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: Add functional test for the abort file in
 fusectl
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 zhanjun@uniontech.com, niecheng1@uniontech.com, wentao@uniontech.com,
 Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250517012350.10317-2-chenlinxuan@uniontech.com>
 <57f3f9ec-41bf-4a7b-b4b2-a4dd78ad7801@linuxfoundation.org>
 <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAC1kPDOH+QZDjg46KRNmQQpH-_yLbQwMUGsiBk9gW1kqjyy9xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/25/25 19:41, Chen Linxuan wrote:
> On Fri, May 23, 2025 at 6:50 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> Also if this test requires root previlege, add check for it.
> 
> Currently, this test does not require root privileges.
> 
> Thanks,
> Chen Linxuan

Thanks. Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

