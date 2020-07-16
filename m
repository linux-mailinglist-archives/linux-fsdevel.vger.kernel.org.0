Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010D0222D27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGPUmM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPUmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:42:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E382DC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 13:42:10 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id p15so6232483ilh.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUE86W1UJN2bRiah1oXJUMER4mh/QPwIXSnuZ1uSW0s=;
        b=RrmG/J3jpWBsDDFF3A7QzDzaGOTgfYaEMM3x8YgAQpVrskHu3wjzPimoTM0kdHrFb0
         iNFr+wjScrrmoD7I50J4Zi3yLECilItoTsCVV0Em3VomnC/WFjs7rEp5q9JxO5JQvKTE
         U4MhySnQ32ELsNDjgkQAWozxYFACiG7bEbJ1pqOCuNj9ufEjtPEl0+isdbLbQxWE4jVc
         c9gWIhAoDv0MRdpB4OcjECdfW71Z27say8hMQmEYKwvEUFh+cdVeOsNTF8Mh+S5gQ+OK
         1H4uj01Y0OlKGFrRWvVGpeCud+BF9xejRZdB3AotngwZTVY4Wycr3unxNHxYMZ7e/Ggf
         Y2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUE86W1UJN2bRiah1oXJUMER4mh/QPwIXSnuZ1uSW0s=;
        b=hRQkC7QtJWfr2kh9fzlnOGO8ru6L15Kg/WfPKMXCaCUlIId+pwu7j9mkg1U2kvS9pa
         QT6Bzk7QGzPRo9yn+cNGklSRNtacMkAj5v3kTRyZHDGYc7agk0cRwxZHC39pEkKNRRtp
         YfF+xuqjlAVu5whiTRKiuy/3f1CT5NhUE8grNScL1zuAWI+Ar3YebP+QJB+/iibtEOJs
         ybtWs0fBVJCiEO64vnp5H7vVzg6EHRcRbqxyPgBhIDvyVILLvHnhOlCbS6bcEtuQ5cZr
         AAXlkQcMagwWQdE2flIKQUGVaPKN+O5AN2NoJ0XxSafdNkULRFXVeZwelN6WEfj38KHq
         i4Hw==
X-Gm-Message-State: AOAM531BXQuk4pDtf8HifIuMxQK2VyFl0LyVxNl/jy4HialZ1NA0gGXY
        eojLyRp9EuO3CCkQI4Xyy2/EPg==
X-Google-Smtp-Source: ABdhPJxe5TOhSxedrrbH1LVWGedg+qBDzWZbftnSxmv/RaY3P0vwR96U4ppS3jdcGEaLKRSKLaqsMQ==
X-Received: by 2002:a92:9108:: with SMTP id t8mr6735616ild.170.1594932130242;
        Thu, 16 Jul 2020 13:42:10 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e21sm3368142ioe.11.2020.07.16.13.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 13:42:09 -0700 (PDT)
Subject: Re: [PATCH RFC v2 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200716124833.93667-1-sgarzare@redhat.com>
 <20200716124833.93667-2-sgarzare@redhat.com>
 <ca242a15-576d-4099-a5f8-85c08985e3ff@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2f109b2-adbf-147d-9423-7a1a4bf99967@kernel.dk>
Date:   Thu, 16 Jul 2020 14:42:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ca242a15-576d-4099-a5f8-85c08985e3ff@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/16/20 2:16 PM, Pavel Begunkov wrote:
> On 16/07/2020 15:48, Stefano Garzarella wrote:
>> The enumeration allows us to keep track of the last
>> io_uring_register(2) opcode available.
>>
>> Behaviour and opcodes names don't change.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
>>  1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index 7843742b8b74..efc50bd0af34 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -253,17 +253,22 @@ struct io_uring_params {
>>  /*
>>   * io_uring_register(2) opcodes and arguments
>>   */
>> -#define IORING_REGISTER_BUFFERS		0
>> -#define IORING_UNREGISTER_BUFFERS	1
>> -#define IORING_REGISTER_FILES		2
>> -#define IORING_UNREGISTER_FILES		3
>> -#define IORING_REGISTER_EVENTFD		4
>> -#define IORING_UNREGISTER_EVENTFD	5
>> -#define IORING_REGISTER_FILES_UPDATE	6
>> -#define IORING_REGISTER_EVENTFD_ASYNC	7
>> -#define IORING_REGISTER_PROBE		8
>> -#define IORING_REGISTER_PERSONALITY	9
>> -#define IORING_UNREGISTER_PERSONALITY	10
>> +enum {
>> +	IORING_REGISTER_BUFFERS,
>> +	IORING_UNREGISTER_BUFFERS,
>> +	IORING_REGISTER_FILES,
>> +	IORING_UNREGISTER_FILES,
>> +	IORING_REGISTER_EVENTFD,
>> +	IORING_UNREGISTER_EVENTFD,
>> +	IORING_REGISTER_FILES_UPDATE,
>> +	IORING_REGISTER_EVENTFD_ASYNC,
>> +	IORING_REGISTER_PROBE,
>> +	IORING_REGISTER_PERSONALITY,
>> +	IORING_UNREGISTER_PERSONALITY,
>> +
>> +	/* this goes last */
>> +	IORING_REGISTER_LAST
>> +};
> 
> It breaks userspace API. E.g.
> 
> #ifdef IORING_REGISTER_BUFFERS

It can, yes, but we have done that in the past. In this one, for
example:

commit 9e3aa61ae3e01ce1ce6361a41ef725e1f4d1d2bf (tag: io_uring-5.5-20191212)
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Dec 11 15:55:43 2019 -0700

    io_uring: ensure we return -EINVAL on unknown opcod

But it would be safer/saner to do this like we have the done the IOSQE_
flags.

-- 
Jens Axboe

