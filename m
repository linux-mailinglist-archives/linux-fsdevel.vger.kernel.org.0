Return-Path: <linux-fsdevel+bounces-3253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9775D7F1BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B34CB21105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C7E241EF;
	Mon, 20 Nov 2023 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F99E;
	Mon, 20 Nov 2023 09:53:39 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6b709048f32so3904099b3a.0;
        Mon, 20 Nov 2023 09:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700502819; x=1701107619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCH7HsfxZyNKS4xvjNZFcM1/0qvi5cluvh3gjYcX/Oo=;
        b=CqFPjEEWwyE92xUSnTm0Yx88PKO6aoLhIHj703g0HCyjTDeAXjXnyLL7OyTNdSrrcI
         86S5vycT79oIdsZ3lmExJoNILGTNLGCDDg/xRzswt+b9z9WCcnpZ9E2Zn2VaCzAat1XI
         BMEsfYW6qDrZaO9WdS2R4A6vcIxZnd/JVEpYdDeA70f9BlNOvBwPevbKxdkGtvDAQ9AS
         3/DYxfIJuQGwubcbtxdIQSpxEaKCON8+eREr/QHl6puQjgSfxRCx38482fLL89p20SvS
         7emBdfqwy+fRZJXMshnu+GpJvPPzIzXTaptBXhicRcv9RiJGnLuPLMqoZiJp9KbVUXky
         Fb6w==
X-Gm-Message-State: AOJu0YztW1ez5lf2voyTu07zHNztPXPaJmTPHVi7mjkVir3CD3EQh177
	yKIHdaViJl5Rc1H3/CUJOsE=
X-Google-Smtp-Source: AGHT+IGocGAbCRsKVUkvtlceOyrIHQHb3TEGuUFRwpdeXuYf4heD8o/cy0oJYXR0d9LYyXQX9rU9Ww==
X-Received: by 2002:a05:6a00:84a:b0:6bd:f760:6ab1 with SMTP id q10-20020a056a00084a00b006bdf7606ab1mr7253438pfk.14.1700502818665;
        Mon, 20 Nov 2023 09:53:38 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1f10:3e70:e99:93ed? ([2620:0:1000:8411:1f10:3e70:e99:93ed])
        by smtp.gmail.com with ESMTPSA id b20-20020a63cf54000000b00577d53c50f7sm6293672pgj.75.2023.11.20.09.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 09:53:38 -0800 (PST)
Message-ID: <12ed0d8c-5b4b-4b3d-b323-2b6cd113dd28@acm.org>
Date: Mon, 20 Nov 2023 09:53:34 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] fs/f2fs: Restore data lifetime support
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Avri Altman <avri.altman@wdc.com>,
 Chao Yu <chao@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20231114214132.1486867-1-bvanassche@acm.org>
 <CGME20231114214215epcas5p43476e8ccba9bfccc87dac59bcb5a5e62@epcas5p4.samsung.com>
 <20231114214132.1486867-6-bvanassche@acm.org>
 <da181fff-59af-b9fd-dd18-781b5ec13cd7@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <da181fff-59af-b9fd-dd18-781b5ec13cd7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/23 23:36, Kanchan Joshi wrote:
> On 11/15/2023 3:11 AM, Bart Van Assche wrote:
>> +2) whint_mode=user-based. F2FS tries to pass down hints given by
>> +users.
> 
> It does not pass down fcntl/inode based hints.
> So I wonder how users give the hints in this case?

Hi Kanchan,

I will restore F_[GS]ET_FILE_RW_HINT support to make it easier to test
the changes in this patch series.

Thanks,

Bart.

