Return-Path: <linux-fsdevel+bounces-5154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BEA808AB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DC61F21008
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5744373
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp+GKGfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27239AD8
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 12:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE94BC433C8
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952739;
	bh=puRx1ipYIGtYAFFNq4TaxK5K1R9/uSM3CDD1BcQabnE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=bp+GKGfHizv9pjTI0aw8Ca6KlDp7hLfSCBonSRW5M0lKEUrbfye0VypFnImcBZIf5
	 tO98bsf+SDmxC0AFBH2dyD3yAUj2sucGzJg826op6tZLEJfwJlfE9oqKrmKOkHkIwU
	 m6fMnTxYLxMejQARmvHIS4jkuqUBqPw/5ktixHuhrqP/Ob9kaGBt7jtQjUqYcjqgU9
	 o+Xl25tFAMPc+tlHwKNmPg8cRAjwiipiqAFBz6Ubq3V+kDIB/1hKINSdZY+DKAj3T9
	 UotlYlVMSus2m6zgCUxqzXKhTyZeHSdPwHCiv8cwaGg525/UrQA8k7pJ6VSJvczKUA
	 CSrmF6Cfrr6YQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5906048e9e3so285107eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwbpkKSP89iR+VXF53B4DHyhnfLu6ZtLF5hnSKGJxS0yD9KYeFi
	uC973s4eWn1+m+g/hk7pxd2fTRgH1rx0xhFpCTA=
X-Google-Smtp-Source: AGHT+IE0Q4nlBHzLOM4GQN+Dxl3X2yNrpxnjddE/VmjcWyUfoRrEJTzKENQmQVT3KhYFVPYff8KBia6R3VcR/MHaAcQ=
X-Received: by 2002:a05:6870:aa87:b0:1fa:3df6:29fb with SMTP id
 gr7-20020a056870aa8700b001fa3df629fbmr1409196oab.2.1701952739177; Thu, 07 Dec
 2023 04:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5a85:0:b0:507:5de0:116e with HTTP; Thu, 7 Dec 2023
 04:38:58 -0800 (PST)
In-Reply-To: <1461149300.81701918783708.JavaMail.epsvc@epcpadp4>
References: <CGME20231205160306epcas1p35c3e3fc9ef2c8651eac58a8d6c194880@epcas1p3.samsung.com>
 <20231205155837.1675052-1-sanpeqf@gmail.com> <1461149300.81701918783708.JavaMail.epsvc@epcpadp4>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 7 Dec 2023 21:38:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_y_HNKcKfUEVMQAX-gdj0P-7o=Hu+yR-OrrDpY+yTiSw@mail.gmail.com>
Message-ID: <CAKYAXd_y_HNKcKfUEVMQAX-gdj0P-7o=Hu+yR-OrrDpY+yTiSw@mail.gmail.com>
Subject: Re: [PATCH v3] exfat/balloc: using hweight instead of internal logic
To: John Sanpe <sanpeqf@gmail.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, Andy.Wu@sony.com, 
	Wataru.Aoyama@sony.com, cpgs@samsung.com, 
	Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"

2023-12-07 11:40 GMT+09:00, Sungjong Seo <sj1557.seo@samsung.com>:
>> Replace the internal table lookup algorithm with the hweight
>> library, which has instruction set acceleration capabilities.
>>
>> Use it to increase the length of a single calculation of
>> the exfat_find_free_bitmap function to the long type.
>>
>> Signed-off-by: John Sanpe <sanpeqf@gmail.com>
>
> Thanks for your patch.
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev.
Thanks for your patch.

