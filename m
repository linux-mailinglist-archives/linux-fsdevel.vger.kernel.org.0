Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47E33F7DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhCQSMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 14:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhCQSMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616004724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=M/8wk+c8uCxkBKXzxhY1/fHK+UnPj3X55jlGEDBVrLc=;
        b=dbGsM7kFJXr8aX6FfftgjNZidM1LY9j17yjsd7oEfj3uTRHdkyvHrFpE8RqFNpiKEdNdSc
        voZeShV0bBjfO4NxXy8/oMUC5kXKzwQGoXXK4zyaZSXIuISSLQ6gF2cmod8gV6c83b/tFk
        +2qTr6KeZXaEOixXZeVtI/dJizb7a+s=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-nbdnJ96wNmqqMlQlItTMCw-1; Wed, 17 Mar 2021 14:12:03 -0400
X-MC-Unique: nbdnJ96wNmqqMlQlItTMCw-1
Received: by mail-oo1-f71.google.com with SMTP id w12so19683937ooe.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 11:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=M/8wk+c8uCxkBKXzxhY1/fHK+UnPj3X55jlGEDBVrLc=;
        b=JTP0wAYwOlIe5sAnLzTGa85+qHey2HYYWPYL24k/cPS3TPHf2pZ7mghCoT2CAsbAi8
         caaJAL9Plq2xzW+sW7RMT/YCyjKE76D072axX97FE1uvklmN07iTwOsoiM7yTuE1HfDm
         cCxYWiHmS0ZMyhp0HTxY2XwrH9bto2XksXXsgMtQZ+auBTIwNXLit+uVr6ZCco7SWK6K
         9IBEb93SUkMjHoQpC+s3hS4u9LggA27EMnd2+OK2fq1QRY3dKpJag4Ntw+BoEHRJkmXt
         B73HSv4GONlNMaey940c+C1az2sLnAif3/hDL7cd9p7KTcDn0yEtwQGmKbxpy5/nchhh
         Or0Q==
X-Gm-Message-State: AOAM530P5uQTSiV22aPYmzudP443Xb3bFn2/0ZTJcjhAhhBiGvC5a9s/
        wK0VMbBLkk9YROVmrbnDLHdb45vFFxGDyFjkjc7V7PZ9dRuX9k8gn/znc8zn1FIxE4z6vDwFwYB
        kUJNNwvAVK2Or/C+NI+VBM9M/Ng==
X-Received: by 2002:a4a:d1da:: with SMTP id a26mr4317794oos.58.1616004722608;
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww8AhR/73C+UNIg8Lem4xJuZS6lxi84nBv5r8MgLJ4vyoet3NjRw7SHlvEvBi5lLx5F90B2w==
X-Received: by 2002:a4a:d1da:: with SMTP id a26mr4317776oos.58.1616004722394;
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id x135sm6603556oix.36.2021.03.17.11.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 11:12:02 -0700 (PDT)
From:   Connor Kuehl <ckuehl@redhat.com>
Subject: Question about sg_count_fuse_req() in linux/fs/fuse/virtio_fs.c
To:     virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <810089e0-3a09-0d8f-9f8e-be5b3ac70587@redhat.com>
Date:   Wed, 17 Mar 2021 13:12:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been familiarizing myself with the virtiofs guest kernel module and 
I'm trying to better understand how virtiofs maps a FUSE request into 
scattergather lists.

sg_count_fuse_req() starts knowing that there will be at least one in 
header, as shown here (which makes sense):

         unsigned int size, total_sgs = 1 /* fuse_in_header */;

However, I'm confused about this snippet right beneath it:

         if (args->in_numargs - args->in_pages)
                 total_sgs += 1;

What is the significance of the sg that is needed in the cases where 
this branch is taken? I'm not sure what its relationship is with 
args->in_numargs since it will increment total_sgs regardless 
args->in_numargs is 3, 2, or even 1 if args->in_pages is false.

Especially since the block right below it counts pages if args->in_pages 
is true:

         if (args->in_pages) {
                 size = args->in_args[args->in_numargs - 1].size;
                 total_sgs += sg_count_fuse_pages(ap->descs, ap->num_pages,
                                                  size);
         }

The rest of the routine goes on similarly but for the 'out' components.

I doubt incrementing 'total_sgs' in the first if-statement I showed 
above is vestigial, I just think my mental model of what is happening 
here is incomplete.

Any clarification is much appreciated!

Connor

