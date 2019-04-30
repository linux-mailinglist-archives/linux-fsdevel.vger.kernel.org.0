Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D248FD14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfD3Pko (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 11:40:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40648 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:40:44 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so5438834itb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XNf8bzdAk7mxTr6wScNWfO8BGhgDHiA4fX/BoxjAgcg=;
        b=pMof5wcmJ0LUqTFWWx4o2UtD3ppRgg7wMYsJig8GBxGxFsaz8YDswmVyFuUC8L9haM
         bWTgvhVjsU7i2tU5J5gY8uHiQab/D4HZfxpO8YYD9fAjqoS1HHfSt/RGl4j7LBfQur/h
         +NCs/7bcJt/sz/jlshrOdNKgR3eS8+TtkAkJfoQvXm5vxZnfymtzkVwupVD7qfR8ntIq
         1lALHnkb1nwY16vTa96XC6oOTdS0oDV/8f3ObhmGAuv4UMsPpWmR6lYZbp5v1GDjYRxn
         CqBmKZ0W/9QcYSaX37tnpp7TfeTvlqNb3yQTNIYEBV/8DrVPscX8x/MfDSW+2AG6eEeW
         YDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XNf8bzdAk7mxTr6wScNWfO8BGhgDHiA4fX/BoxjAgcg=;
        b=KWnLUVbHe5511wI2NmJHgs7As5RaAu/AUMjanf8CH30R1cG7zuSVFa8XvBBGN1PHa+
         TCEmH49yBqXcyWWCqygfOvgsijpHYLfkRfXIz1MMInL2Un0rRHo/GrLwg4UpMiI17xaG
         K10Yl6RWE2pO5hK6NJKoLVSjDpGR5vrL1ifpKC4qqloLr7ukN8pNpR2X/40hfxVcK6sS
         r72I08fh+6UNhs7CKcLkSkUYjvDk/x45FjSPdhr42uNTHw0kw+5pSMrV1dyjYKwioru4
         mGjT08FaciHTEmWTwXXq4wqQv4UQWn+nuBJZ+syla+uViIFJAo6OLPP9gJHJWObtE3PJ
         WVNw==
X-Gm-Message-State: APjAAAVnJOvu0MmlHnLQqnTUvouk9ypJzOO4LimNzzfW1d96cQKI3ra4
        ioJj6i9O+f9lmTl9v+jBgF6wbmFmI9x9ww==
X-Google-Smtp-Source: APXvYqxfp6Ww8YqTZgXv2Jj5nFCT4fYt1D4ewxgCPh/R9FaoqX4KHB9Mz9oRto40hSaRFi8+0OXZnA==
X-Received: by 2002:a24:690f:: with SMTP id e15mr4476417itc.42.1556638842645;
        Tue, 30 Apr 2019 08:40:42 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c13sm10047157ioi.28.2019.04.30.08.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:40:41 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] fix handling SQEs requesting NOWAIT
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <7bcb0eb3-46d1-70e4-1108-dfd9a348bb7c@stbuehler.de>
 <20190427183419.5971-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5d0c13a-8cd3-4744-524b-d63b7355c60a@kernel.dk>
Date:   Tue, 30 Apr 2019 09:40:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427183419.5971-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/19 12:34 PM, Stefan Bühler wrote:
> Not all request types set REQ_F_FORCE_NONBLOCK when they needed async
> punting; reverse logic instead and set REQ_F_NOWAIT if request mustn't
> be punted.

I like doing it this way, so we don't have to touch the other callers.
I've merged this one with my patch, no need to have two separate fixes
for it.

-- 
Jens Axboe

