Return-Path: <linux-fsdevel+bounces-441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD57CAF65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF0A28178F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02FF30FA3;
	Mon, 16 Oct 2023 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073030F8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:32:54 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689F44B4;
	Mon, 16 Oct 2023 09:32:38 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso911650a91.1;
        Mon, 16 Oct 2023 09:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473958; x=1698078758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ4qnCj7cgF2uTYw67Ao8nqWGK1nROVf78cl6b1udKc=;
        b=dzu725f9MGv079GrGZeFUyIZKz06wn6fENwm15Xfb8p7L1JhhcXxEoJby+JNxglRB0
         Loyfj/qS3V9FDGTvF1YhxF+NOUp6gOjs9tiB2RJ1gECeYLjPb5tfeAvdPBNHH3Hf+PiJ
         fIeZbXbS8H794V4C5b03B51XHNyQ8Lo5yHbeggdstdEfaOsOlsu8lOqFqOUUqilZbRIZ
         m7aTPjuCIHCX1LDV/feMl9gVf+2krpZ86y2wRvIwZKBL/5YRizTCMGmaNKBc1+m+mil3
         N1jRi340kg0qLfYTNYEqqCa3uX8+UKX0O0RTe9l6l/XIQKttNmbo6A5teSwUjp7um9p4
         A42A==
X-Gm-Message-State: AOJu0Yx4arMIW2XBhbe74IQ5YLWdG5vdAHXbiVxMYMmmqwlmzzzigSgL
	NAzfQ1Q0wCKLnYF0WfyAUKI=
X-Google-Smtp-Source: AGHT+IEeRmYVhkdCFEplFGdTEJXlcUDSRc7OfdLPuXJUTbY+17vp84Qvpg6cTN+zUsGknLaGd/2qmQ==
X-Received: by 2002:a17:90b:3d90:b0:27d:661f:59ac with SMTP id pq16-20020a17090b3d9000b0027d661f59acmr3845554pjb.38.1697473957647;
        Mon, 16 Oct 2023 09:32:37 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id rr7-20020a17090b2b4700b00268b9862343sm4917723pjb.24.2023.10.16.09.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 09:32:37 -0700 (PDT)
Message-ID: <c0bd476c-452d-4993-acc8-749bd9585791@acm.org>
Date: Mon, 16 Oct 2023 09:32:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Avri Altman <Avri.Altman@wdc.com>,
 Bean Huo <huobean@gmail.com>, Daejun Park <daejun7.park@samsung.com>,
 Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <20231016061737.GA26670@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231016061737.GA26670@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 10/15/23 23:17, Christoph Hellwig wrote:
> On Fri, Oct 06, 2023 at 05:19:52PM +0900, Damien Le Moal wrote:
>> Your change seem to assume that it makes sense to be able to combine CDL with
>> lifetime hints. But does it really ?
> 
> Yes, it does.
> 
> 
>> CDL is of dubious value for solid state
>> media and as far as I know,
> 
> No, it's pretty useful and I'd bet my 2 cents that it will eventually
> show up in relevant standards and devices.
> 
> Even if it wasn't making our user interfaces exclusive would be a
> massive pain.
> 
>> The other question here if you really want to keep the bit separation approach
>> is: do we really need up to 64 different lifetime hints ? While the scsi
>> standard allows that much, does this many different lifetime make sense in
>> practice ? Can we ever think of a usecase that needs more than say 8 different
>> liftimes (3 bits) ? If you limit the number of possible lifetime hints to 8,
>> then we can keep 4 bits unused in the hint field for future features.
> 
> Yes, I think this is the smoking gun.  We should be fine with a much
> more limited number of lifetime hints, i.e. the user interface only
> exposes 5 hints, and supporting more in the in-kernel interfaces seems
> of rather doubtfuŀ use.

Thanks for the feedback Christoph. I will address this feedback in the
next version of this patch series.

Bart.

