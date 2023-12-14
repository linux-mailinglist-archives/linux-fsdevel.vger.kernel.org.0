Return-Path: <linux-fsdevel+bounces-6086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0A813716
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FF5281AF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8761FD2;
	Thu, 14 Dec 2023 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ez7aJSHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697E511A
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7b709f8ba01so72330739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Dec 2023 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702573056; x=1703177856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=ez7aJSHpNmVv1H/2VNFP+XRnCwtwjnJuPlbf1RujMYUaS5TwF5i+UNRIG0kGeCIrva
         E9BiVSdjOhuv0m0V3fqlTFbkLAjIN7e4RY1MPfeOiNCCmYJsZNs8jQ+4TBeae32aKCZD
         UljhMivp5KgHETOdFfEWvUogrhyAC0vXh/sEkILqKeKalS5IfnE4yVo4ICVAWmn9r4Gq
         lAhIDibydYmaCd1rPHNETO/INYLBbsOUlTGdAqWHuwVX3ADMbqm6s3p+PTTYLRjlhwNs
         6BBlw9bVdDYlgFbADzocb/SBtRkDmUuuEV947Q1DC0O+IQcC68X4GmhGATOCDaE4a6Ga
         ovCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573056; x=1703177856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bF6JAIGkdcWEDAxYfIlQw3OSyrt6nxRKSkcWVcaayZU=;
        b=kdDd3UBdsOS6DMJn1KEMAUdfg3Wf6BS5du8umxthn8yEleNdrlr33iafYEp2AAOHcS
         lxlqnkZmOIo6uZ+vZvvBC/mQ/PIxCIP2nACYyef83459/WX4k1tQE115LyIPNGGOcUC3
         ddowevokdKT9ru3VYqa19rDR5yxqlG9UekV1Uxn6Q2yCAsmjKkJmYN7fsqbsiWdfav8O
         dhWlMNw6ocfdA/r4AUIZ0G+AAJ8fb4WvgvgbwN+p86LdkisppXDO3TMAepmeIJUDehXs
         C4X3UVX3u2AJJCx2GDoOLAm2/BIbJzkCHwIh6vRQ7Ec4rP8/K3WunkICMBCEdIjT86Lm
         9uFA==
X-Gm-Message-State: AOJu0YxjrI5Ua79qkghm08PJOz7SxbokE7rVAEEtH0ESRS28B5508P8z
	YQaLcytjI84xGAHWtWgUG8oYRA==
X-Google-Smtp-Source: AGHT+IFlw+XRTrT7e71YKSTcDQk//pRdpkg0t26kRH8ZiJIsDpZhk7PFQa8ipkgdwGtQW7W2DeCpYw==
X-Received: by 2002:a05:6e02:1bac:b0:35f:692e:2049 with SMTP id n12-20020a056e021bac00b0035f692e2049mr8161692ili.2.1702573055728;
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bn14-20020a056e02338e00b00357ca1ed25esm1231116ilb.80.2023.12.14.08.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 08:57:35 -0800 (PST)
Message-ID: <3d025aeb-7766-4148-b2fd-01ec3653b4a7@kernel.dk>
Date: Thu, 14 Dec 2023 09:57:32 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
To: Christian Brauner <brauner@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Tony Lu <tonylu@linux.alibaba.com>,
 Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
 Karsten Graul <kgraul@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local> <20231213162854.4acfbd9f@kernel.org>
 <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231214-glimmen-abspielen-12b68e7cb3a7@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/14/23 3:50 AM, Christian Brauner wrote:
>> Let's figure that out before we get another repost.
> 
> I'm just waiting for Jens to review it as he had comments on this
> before.

Well, I do wish the CC list had been setup a bit more deliberately.
Especially as this is a resend, and I didn't even know about any of this
before Christian pointed me this way the other day.

Checking lore, I can't even see all the patches. So while it may be
annoying, I do think it may be a good idea to resend the series so I can
take a closer look as well. I do think it's interesting and I'd love to
have it work in a non-blocking fashion, both solving the issue of splice
holding the pipe lock while doing IO, and also then being able to
eliminate the pipe_clear_nowait() hack hopefully.

-- 
Jens Axboe


