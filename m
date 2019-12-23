Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2046F12980D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWPYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 10:24:15 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44978 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLWPYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 10:24:15 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so14253495iln.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2019 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WilbydB+UKr1SzkUHg8x3xXiGfhNAfLR7GuOgFshD5k=;
        b=c2Vus433Q1Ju34z34fpGxMH2ROFDnDR10PD88nAoWNolKjtxFyw9T/Cp49WH8uPbpB
         82nNyuWjP3HlBHcG+fj5phPKZH5bf44LvdKiEJdv01Zdqg5VbV6Bgu2wklQRJG/41oRl
         CeTnWzKIYcUW3SMJEnCc69/tMTiYqI3ijkJGcetO7FAnIjxTwZnnqHvvqWFpLmoRVCgB
         cxVxeJdyM0vgF6KxN+R8+k4DnnzHjAO+9IXyCpQbgxf1KvB7xEhRGiQqHv1VgKFgZCut
         8+KhaRTtopx87SsQEIUywv3z8wpYxLX5L2GpVOxHKLMEzERPe2AfrJ3othe7PBsegL3w
         ahzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WilbydB+UKr1SzkUHg8x3xXiGfhNAfLR7GuOgFshD5k=;
        b=ZJ9JPMpKyF1AKZD5fywnwuRMIB3TcGrj54Qmz3oraN6J3H6sCJJQpuFenbucN0K1L3
         yTOhA7TEAxmSClFdVlIE4bbeCqNRaTfVC39SM4iKHbU4vrOi5/OjRE2XJycLpv0NmqZ8
         CJEJ3GyPAli8+ulcu7/l73Js4GO9IdRzEMw5pj/QglXNw3LxfwLiIUpNpz++SOBNZ8lv
         ouwQUOg0waCA4n6QxFDoFCDzpRO+rP+OyF3ulLQAo+8Em1nQJIAB9YzH8U6hMZ/p4agU
         +gY6Ek8mcUo8HJ7IwwNpmaKW5D8zFeKe8UaIjAphVruERxKngWXdkxFhKGvhw6TsQEcn
         6x5g==
X-Gm-Message-State: APjAAAWbg+Xyr38nr7vXeYY/w0hezdY+Tzc2iyRJmagDko4kW2W9m374
        qGtp8P14PUOofw0Z5HIVjFDhBQ==
X-Google-Smtp-Source: APXvYqzJP/C8jMJ7kN2dKdauDk9qZyXpIrXvMJ8SYTiWmZgujuatSI/hrubMFa0zxrjasToaIcEIcg==
X-Received: by 2002:a92:911b:: with SMTP id t27mr25430083ild.142.1577114654056;
        Mon, 23 Dec 2019 07:24:14 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a18sm9028671ilf.43.2019.12.23.07.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2019 07:24:13 -0800 (PST)
Subject: Re: [RFC PATCH] io-wq: cut busy list off io_wqe
To:     Hillf Danton <hdanton@sina.com>, io-uring@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
References: <20191222144654.5060-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c7985b10-52a2-5bb6-d393-f888c4658dd1@kernel.dk>
Date:   Mon, 23 Dec 2019 08:24:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191222144654.5060-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/22/19 7:46 AM, Hillf Danton wrote:
> 
> Commit e61df66c69b1 ("io-wq: ensure free/busy list browsing see all
> items") added a list for io workers in addition to the free and busy
> lists, not only making worker walk cleaner but leaving the busy list
> to be at most a nice vase. Time to remove it now.

Thanks, applied.

-- 
Jens Axboe

