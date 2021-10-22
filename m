Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF04379EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhJVPcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbhJVPcD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:32:03 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBEC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:29:45 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t4so5467105oie.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LUtnq1wX3c9ZSKlFVqBQ9milrt9oUJPe3W7pJqk8fis=;
        b=Dt6Xe7RT9/rmETzyvm6KPZXudZiAHUA2T8XHt//MeIXHgfevOpKLZ+t5VvL4srw/Ba
         IQEzzktExKHA9fZfICrEpqT1kmakmZoRxQFEv+4IFM6Fopm+2rwRHhgAhC0W8wWc83rS
         oOh71WpSfXuHTo8oZnZGplwUy/o5P257gkK9AzYegblq//FMB6WsRJrP8apwa+7GnNP1
         10vtC0aguxaaRjQXa4kABPrDsqWyZa1BUPPIFw/DIKZ/uDIv8Vgz1rr1hu4xisGj2gcr
         7Y6f7k4EWgGMsoC0QmpSDGb6rzpmYI02gymq27osbsFKaiB0vsyY3jt2dt662L+3wHPu
         k3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUtnq1wX3c9ZSKlFVqBQ9milrt9oUJPe3W7pJqk8fis=;
        b=VheUgtA0kZ6iDF01Lzh7JUpZnTdYvpGG8odM1JxdyFA3I+H0eki5Hw3HkF8yXDtRt6
         GyIHUWQJvW5CdtPQAb6KNsvxryEtUtoU7FB5yDAaPF7iiwnYlUGFzyouVKKyTvQ+P8ea
         iVD6Kvxba8dx1emYC5QZ9MAR23eu9CrlWOMZ9j2MH96i9konGsL16HRIYo4hYdKL8EHw
         FOwBfos15oMEhlGHq5QgaHXAQgjvrO5zIk3PSiy/oz/mrtlH12uH/rIzMKep5ID484mV
         E1HDu8aEXOLzLCniO24gADT+P8LUW5Nev/fvioCWbzTa6A006trlt/JnTagfgQbIzzzs
         zaog==
X-Gm-Message-State: AOAM5308FuDJXpggc6cczajk/HMRGb570O10u7egW0ZYrcZvCo0/ejS4
        KRjqqD9Sq0aEwnCJlR8k7JJhhg==
X-Google-Smtp-Source: ABdhPJx1jjUdC1bsdaA7We5wTASWQ/NVsI6ael3sh50HPmv4zQ9u/R/KB+jBRoiRr7junic+9/3XsQ==
X-Received: by 2002:aca:ac0b:: with SMTP id v11mr10588962oie.155.1634916585185;
        Fri, 22 Oct 2021 08:29:45 -0700 (PDT)
Received: from [172.20.15.86] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id v22sm1491435oot.43.2021.10.22.08.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:29:44 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
 <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
 <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
 <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
 <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk>
 <x49wnm6t7r9.fsf@segfault.boston.devel.redhat.com>
 <x49sfwut7i8.fsf@segfault.boston.devel.redhat.com>
 <d67c3d6f-56a2-4ace-7b57-cb9c594ad82c@kernel.dk>
Message-ID: <67127b02-2b58-5944-8bfb-e842182d6459@kernel.dk>
Date:   Fri, 22 Oct 2021 09:29:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d67c3d6f-56a2-4ace-7b57-cb9c594ad82c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/21 8:19 AM, Jens Axboe wrote:
> On 10/21/21 3:03 PM, Jeff Moyer wrote:
>> Jeff Moyer <jmoyer@redhat.com> writes:
>>
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 10/21/21 12:05 PM, Jeff Moyer wrote:
>>>>>
>>>>>>> I'll follow up if there are issues.
>>>>>
>>>>> s390 (big endian, 64 bit) is failing libaio test 21:
>>>>>
>>>>> # harness/cases/21.p
>>>>> Expected -EAGAIN, got 4294967285
>>>>>
>>>>> If I print out both res and res2 using %lx, you'll see what happened:
>>>>>
>>>>> Expected -EAGAIN, got fffffff5,ffffffff
>>>>>
>>>>> The sign extension is being split up.
>>>>
>>>> Funky, does it work if you apply this on top?
>>>>
>>>> diff --git a/fs/aio.c b/fs/aio.c
>>>> index 3674abc43788..c56437908339 100644
>>>> --- a/fs/aio.c
>>>> +++ b/fs/aio.c
>>>> @@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
>>>>  	 * 32-bits of value at most for either value, bundle these up and
>>>>  	 * pass them in one u64 value.
>>>>  	 */
>>>> -	iocb->ki_res.res = lower_32_bits(res);
>>>> -	iocb->ki_res.res2 = upper_32_bits(res);
>>>> +	iocb->ki_res.res = (long) (res & 0xffffffff);
>>>> +	iocb->ki_res.res2 = (long) (res >> 32);
>>>>  	iocb_put(iocb);
>>>>  }
>>>
>>> I think you'll also need to clamp any ki_complete() call sites to 32
>>> bits (cast to int, or what have you).  Otherwise that sign extension
>>> will spill over into res2.
>>>
>>> fwiw, I tested with this:
>>>
>>> 	iocb->ki_res.res = (long)(int)lower_32_bits(res);
>>> 	iocb->ki_res.res2 = (long)(int)upper_32_bits(res);
>>>
>>> Coupled with the call site changes, that made things work for me.
>>
>> This is all starting to feel like a minefield.  If you don't have any
>> concrete numbers to show that there is a speedup, I think we should
>> shelf this change.
> 
> It's really not a minefield at all, we just need a proper help to encode
> the value. I'm out until Tuesday, but I'll sort it out when I get back.
> Can also provide some numbers on this.

I think this incremental should fix it, also providing a helper to
properly pack these. The more I look at the gadget stuff the more I also
get the feeling that it really is wonky and nobody uses res2, which
would be a nice cleanup to continue. But I think it should be separate.


diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 8536f19d3c9a..9c5372229714 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -831,7 +831,7 @@ static void ffs_user_copy_worker(struct work_struct *work)
 		kthread_unuse_mm(io_data->mm);
 	}
 
-	io_data->kiocb->ki_complete(io_data->kiocb, ((u64) ret << 32) | ret);
+	io_data->kiocb->ki_complete(io_data->kiocb, aio_res_pack(ret, ret));
 
 	if (io_data->ffs->ffs_eventfd && !kiocb_has_eventfd)
 		eventfd_signal(io_data->ffs->ffs_eventfd, 1);
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d3deb23eb2ab..15dff219b483 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -469,7 +469,7 @@ static void ep_user_copy_worker(struct work_struct *work)
 		ret = -EFAULT;
 
 	/* completing the iocb can drop the ctx and mm, don't touch mm after */
-	iocb->ki_complete(iocb, ((u64) ret << 32) | ret);
+	iocb->ki_complete(iocb, aio_res_pack(ret, ret));
 
 	kfree(priv->buf);
 	kfree(priv->to_free);
@@ -499,8 +499,10 @@ static void ep_aio_complete(struct usb_ep *ep, struct usb_request *req)
 		kfree(priv);
 		iocb->private = NULL;
 		/* aio_complete() reports bytes-transferred _and_ faults */
-		aio_ret = req->actual ? req->actual : (long)req->status;
-		aio_ret |= (u64) req->status << 32;
+		if (req->actual)
+			aio_ret = aio_res_pack(req->actual, req->status);
+		else
+			aio_ret = aio_res_pack(req->status, req->status);
 		iocb->ki_complete(iocb, aio_ret);
 	} else {
 		/* ep_copy_to_user() won't report both; we hide some faults */
diff --git a/fs/aio.c b/fs/aio.c
index 3674abc43788..cd43a26b2aa2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
 	 * 32-bits of value at most for either value, bundle these up and
 	 * pass them in one u64 value.
 	 */
-	iocb->ki_res.res = lower_32_bits(res);
-	iocb->ki_res.res2 = upper_32_bits(res);
+	iocb->ki_res.res = (long) lower_32_bits(res);
+	iocb->ki_res.res2 = (long) upper_32_bits(res);
 	iocb_put(iocb);
 }
 
diff --git a/include/linux/aio.h b/include/linux/aio.h
index b83e68dd006f..50a6c7da27ec 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -24,4 +24,18 @@ static inline void kiocb_set_cancel_fn(struct kiocb *req,
 extern unsigned long aio_nr;
 extern unsigned long aio_max_nr;
 
+/*
+ * Take some care packing two 32-bit quantities into a 64-bit, so we don't
+ * get sign extensions ruining the result. aio uses long, but it's really
+ * just 32-bit values.
+ */
+static inline u64 aio_res_pack(long res, long res2)
+{
+	u64 ret;
+
+	ret = (u64) res2 << 32;
+	ret |= (u32) res;
+	return ret;
+}
+
 #endif /* __LINUX__AIO_H */

-- 
Jens Axboe

