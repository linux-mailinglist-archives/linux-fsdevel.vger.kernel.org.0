Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182B5263608
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIISat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgIISas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:30:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE623C061756
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 11:30:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so4259918ioe.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=98xyvtYgbwa5J67c7RkI6GnQwliGFXe74W0JhOQBOmc=;
        b=Aai15vFl3dYqGw9K5b3xK4POAF5zorYpaKKRyIxIZqV4MkjapQJdc5WoBCxIdDvoQe
         7FdlRAedwzY1qpqwlJ5d+oVkEoZFtbyilOo5PeMvP4vfl//XjFD28AIWbmbRXihnb49x
         JbVoj7qo0eWkzJVqnZ3EfR9rqCRwG9dCMJoxkLi4ToOLHhfZC3SzjOM+82YB9SjmG1R5
         a33hxHQK4Io4do/ldHL0Nwp+Us6ESgUxv94eNJDwEE8kOAIZj98CWh42I5BQfrPOtm/D
         GfnSrPywZHKaSWgiqluDNEtHluhP8WGr1YnzmI21OdCOYBTano9T1NdzUMKvE3YznXEE
         +6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=98xyvtYgbwa5J67c7RkI6GnQwliGFXe74W0JhOQBOmc=;
        b=E5+881qmMdVwx03hLGQ7bjbLke44pLiELjl9D0pZAlxJTMObtQ/OQ8zruy0sMXv/8y
         i8fOyxLR3DXx1OddM62F+WDedTGF6D/l6+QxuYKrxb4OHJRBbRauBTj3l3uM+PE+Cjyx
         y61q6Rgs/sM8pw0xq4gxeEo8QF9oIGJmcMzOvoNegmq6m45AIJK1FqKqfSZuswM1jOly
         Xvvi2sUKVbnXUVn3X+pJMm4JuxDJPyxzAtamC/7asj6wOzHtYwyBs9YtePwg/X2/teXt
         oVeBil8ajNqZEZv/h9417xOYkL/KXcYsBo3ajOLNxFuLcNxca+6/UpYjvj2QPISal6gl
         06EQ==
X-Gm-Message-State: AOAM530oDPBOihPqBabz6/YqJtyALThLjliv10RTQnH3pTIdO3Vxk471
        RsfSuPrvH4Hld9Wy0RulxZf8ijbH4o5YXaEd
X-Google-Smtp-Source: ABdhPJzDQCDM7qsjK2rY35N17lqTgsC2hAs5QECTlf9biMd54YdHkaHJRtjNBTH3FQACUVf86OCMNw==
X-Received: by 2002:a05:6602:2f88:: with SMTP id u8mr4410307iow.175.1599676246841;
        Wed, 09 Sep 2020 11:30:46 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm1501725iow.26.2020.09.09.11.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 11:30:46 -0700 (PDT)
Subject: Re: [PATCH for-next] io_uring: fix ctx refcounting in
 io_uring_enter()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200909151900.60321-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9080c3fa-a726-b664-f634-0ea7dfda80e0@kernel.dk>
Date:   Wed, 9 Sep 2020 12:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909151900.60321-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/20 9:19 AM, Stefano Garzarella wrote:
> If the ring is disabled we don't decrease the 'ctx' refcount since
> we wrongly jump to 'out_fput' label.
> 
> Instead let's jump to 'out' label where we decrease the 'ctx' refcount.

Applied, thanks.

-- 
Jens Axboe

