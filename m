Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DF37A9BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhEKOnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 10:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhEKOnJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 10:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620744123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
        b=CEU9bA4oAX1zOyq2nwJM3WWSt4ghcxxhh3LYBcPRXEERkcvnaAoblJQu2dkfPWaHk3Ob/n
        G3P2+txI/yackUUV5tyrQX0Aw72RfoM13RGsKqcitOck+S9zKDEIajAwjoRxYn8HdyKfh9
        jHmXR0BUwLOVIP14lMyAYej3oV9JxXg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-cIrV1_bEPgGdSGFCsjFGCQ-1; Tue, 11 May 2021 10:42:01 -0400
X-MC-Unique: cIrV1_bEPgGdSGFCsjFGCQ-1
Received: by mail-oo1-f69.google.com with SMTP id q79-20020a4a33520000b02901faafd3c603so9329446ooq.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 May 2021 07:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k/z7NrUJTKIBdoAINSyBpZ9NunsNsM6n4BDyTwrTstY=;
        b=cRwqGnKXrE4RDJOqZ9P2drMqW0OFeGaN4lZLxtf9DjAB+yQs/nAZhqvG75VwKLLKvr
         KfTkrWy6GJIBS3UBdyILr9h6ZZmkFuXH7Om6swUKSpNxqMT4fvhdnWczGDb19h7SyP64
         g7R2roTgDIVhl7aPYrlPi4EllCqBQKGEGxmtSQlwZ/2fGf15JhOMjubkyiOYBUftJ2kW
         apMpapXX4dbgQMULf2cqcJGSKeP0Dl8u8cGulnoLmo5a/QWM3UfkZDgJBcZGIdI65gNq
         VFwlXHhp0eok2P4n1LT5zkCL+8vgZqeS09yAFPnThJEEsrGstBwjg3iN/wsHuv/I26x7
         Z4eA==
X-Gm-Message-State: AOAM532QZEJhU6FQOD3uVFwfxKbOblFLchenFZ6hr7IKZG8Gnyqb2ypy
        +VpRVl/8ivpLiSiOLolcDs0W+tswV7AnRFS/6j8N6ur/ceGTcAHA2K1vmc71Nc0gR9+/Dz91MYO
        XCk+yg7uBDGVHtl90J7Wr/b19rA==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122764oon.2.1620744120815;
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiqcX0afnpWZRWy60CV/jDkD2+4bdEWed+5anrz6ezPzlAoWGMEGtTJiX4q+FFlUrQrMxegg==
X-Received: by 2002:a4a:ab83:: with SMTP id m3mr10122743oon.2.1620744120577;
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id o6sm3917266ote.14.2021.05.11.07.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 07:42:00 -0700 (PDT)
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <290eaac8-45d9-0bfb-94f5-9fb41e5a3e42@redhat.com>
Date:   Tue, 11 May 2021 09:41:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJpbEMePhQ88EWWR@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/21 5:23 AM, Stefan Hajnoczi wrote:
> On Fri, May 07, 2021 at 05:15:27PM -0500, Connor Kuehl wrote:
>> @@ -1245,7 +1262,8 @@ __releases(fiq->lock)
>>  		 req->in.h.nodeid, req->in.h.len,
>>  		 fuse_len_args(req->args->out_numargs, req->args->out_args));
>>  
>> -	fsvq = &fs->vqs[queue_id];
>> +	fsvq = this_cpu_read(this_cpu_fsvq);
> 
> Please check how CPU hotplug affects this patch. If the current CPU
> doesn't have a vq because it was hotplugged, then it may be necessary to
> pick another vq.

I'll fix this in the next revision.

Thanks,

Connor

