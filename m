Return-Path: <linux-fsdevel+bounces-345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B558D7C8E37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 22:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA09283027
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 20:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98B25116;
	Fri, 13 Oct 2023 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484537A
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 20:18:34 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB4BB;
	Fri, 13 Oct 2023 13:18:32 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso307617b3a.2;
        Fri, 13 Oct 2023 13:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697228309; x=1697833109;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=biiMh+EC7I2O/QkjHEGy6sy8/18hylgh/BXPEq6Roxg=;
        b=X1TJTlMI9Dco3JnOtOcaHEkEfhG74fVgEUnpnYffaZGOcLtuqvWYxlj/WD6Lvxxk3X
         y0DsG/mIRie+hMhR+at6bXqxvUPGl2YVpa2De33WGI7SkB4bDLGyRyGehXTz+zq9bHJU
         roaKLUptiJNc1BanhA+x11UWkAEWXUFnuKeejilHv0+joNEn/ACgOSIUuXPfd8Lc4Sxg
         LBhaV360MKT+2ghXmG3sKAb5WoOZmz1MUQhO8MTkhXBW5oTgEbbEYYRXZhlo9iVkugV/
         h2OG1evMKRG1fazR7du22ipbD4bjviga5W+O+ozbAkhyo0cX6gm5XPZKN4miKySSUGck
         wnYA==
X-Gm-Message-State: AOJu0YxMvjXbz9I2xGjZRv0EUU0vPYKr2a9sTKqFg0zsT5fetjQSzsSW
	HRX2fjUFdRcv8W8uptBXE00=
X-Google-Smtp-Source: AGHT+IHNN2CY+TU6dgppGECjZqTp8YJQF2VjVGAWtME6kR7o5TSV2NhqC/8Ht8VG21ZHOMt6mZR8/Q==
X-Received: by 2002:a05:6a00:3992:b0:68a:49bc:e0af with SMTP id fi18-20020a056a00399200b0068a49bce0afmr30830853pfb.1.1697228308938;
        Fri, 13 Oct 2023 13:18:28 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id a9-20020aa780c9000000b0069266a66a6esm13810329pfn.139.2023.10.13.13.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 13:18:28 -0700 (PDT)
Message-ID: <94c58f6a-cdbf-4718-b60f-ba4082a040b5@acm.org>
Date: Fri, 13 Oct 2023 13:18:27 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 03/15] block: Support data lifetime in the I/O priority
 bitfield
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Avri Altman <Avri.Altman@wdc.com>, Bean Huo <huobean@gmail.com>,
 Daejun Park <daejun7.park@samsung.com>, Hannes Reinecke <hare@suse.de>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <20231005194129.1882245-4-bvanassche@acm.org>
 <8aec03bb-4cef-9423-0ce4-c10d060afce4@kernel.org>
 <46c17c1b-29be-41a3-b799-79163851f972@acm.org>
 <b0b015bf-0a27-4e89-950a-597b9fed20fb@acm.org>
 <447f3095-66cb-417b-b48c-90005d37b5d3@kernel.org>
 <4fee2c56-7631-45d2-b709-2dadea057f52@acm.org>
 <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
Content-Language: en-US
In-Reply-To: <2fa9ea51-c343-4cc2-b755-a5de024bb32f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 18:08, Damien Le Moal wrote:
> On 10/13/23 03:00, Bart Van Assche wrote:
>> We are having this discussion because bi_ioprio is sixteen bits wide and
>> because we don't want to make struct bio larger. How about expanding the
>> bi_ioprio field from 16 to 32 bits and to use separate bits for CDL
>> information and data lifetimes?
> 
> I guess we could do that as well. User side aio_reqprio field of struct aiocb,
> which is used by io_uring and libaio, is an int, so 32-bits also. Changing
> bi_ioprio to match that should not cause regressions or break user space I
> think. Kernel uapi ioprio.h will need some massaging though.

Hmm ... are we perhaps looking at different kernel versions? This is
what I found:

$ git grep -nHE 'ioprio;|reqprio;' include/uapi/linux/{io_uring,aio_abi}.h
include/uapi/linux/aio_abi.h:89:	__s16	aio_reqprio;
include/uapi/linux/io_uring.h:33:	__u16	ioprio;		/* ioprio for the 
request */

The struct iocb used for asynchronous I/O has a size of 64 bytes and
does not have any holes. struct io_uring_sqe also has a size of 64 bytes
and does not have any holes either. The ioprio_set() and ioprio_get()
system calls use the data type int so these wouldn't need any changes to
increase the number of ioprio bits.

> Reading Niklas's reply to Kanchan, I was reminded that using ioprio hint for
> the lifetime may have one drawback: that information will be propagated to the
> device only for direct IOs, no ? For buffered IOs, the information will be
> lost. The other potential disadvantage of the ioprio interface is that we
> cannot define ioprio+hint per file (or per inode really), unlike the old
> write_hint that you initially reintroduced. Are these points blockers for the
> user API you were thinking of ? How do you envision the user specifying
> lifetime ? Per file ? Or are you thinking of not relying on the user to specify
> that but rather the FS (e.g. f2fs) deciding on its own ? If it is the latter, I
> think ioprio+hint is fine (it is simple). But if it is the former, the ioprio
> API may not be the best suited for the job at hand.

The way I see it is that the primary purpose of the bits in the
bi_ioprio member that are used for the data lifetime is to allow
filesystems to provide data lifetime information to block drivers.

Specifying data lifetime information for direct I/O is convenient when
writing test scripts that verify whether data lifetime supports works
correctly. There may be other use cases but this is not my primary
focus.

I think that applications that want to specify data lifetime information
should use fcntl(fd, F_SET_RW_HINT, ...). It is up to the filesystem to
make sure that this information ends up in the bi_ioprio field. The
block layer is responsible for passing the information in the bi_ioprio
member to block drivers. Filesystems can support multiple policies for
combining the i_write_hint and other information into a data lifetime.
See also the whint_mode restored by patch 05/15 in this series.

Thanks,

Bart.

