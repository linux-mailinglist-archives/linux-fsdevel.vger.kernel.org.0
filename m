Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E434D91F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 22:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhC2Ujb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhC2Ui7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:38:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DDC061762
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 13:38:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c204so10652145pfc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zkHWfQmcvkX73ALmQtfT/dMgLtpUYjokLV5A+ra7aPA=;
        b=NGD/oGDdTsHlXc0LBNKLLFrOdp5PDi57ozZMqjYlu6LPG3rlcjDn1Sbf4dB9vl9p08
         pRwVhxszXvNSxUYCe3itM4pcSztQ0AdPMuK1iczBcgKRR/ylTBe4gnPT8GMp8sOFqwYm
         4fNSoJxDKzf3UurJkPmZXXe0FcA3X9evAEXVQVAD/OXsunRw2kQyXZ4F6HN033rFtCoY
         pGprFloHW6w/CsLCSrUdJimSqpQcY8CatDe5KNDvX4rjLzrsGb4sYzX7QXrPMKnXuhXP
         tF45Bip9Bxlwp+ZI4rfmXeKZMpcqsRadfcRFJQd3Vem202FQOonlIRQbcKyYJaujS3qw
         4FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zkHWfQmcvkX73ALmQtfT/dMgLtpUYjokLV5A+ra7aPA=;
        b=lbf0kFEVgOq0AqCWKNP4gfcxiJpFi9NTYLDa1ubPCUXrRwlwXZi9kSqthzN5ITxVol
         ILGlhsonBEhUBsoxxyH3n3SVAKB35m0l8PO3tauIUbS5SoAnMstMxOntnd3bRVYCh5dj
         vUWvtWQ4POaJMYgGxJxpcnP+nbd57Ism9xoKXVEqcZa8RuGa9huZ6BbaZgmbt0XYmLMt
         3p/gVy1E4zzeYEc8NRlC34ytSSSWwKBoNxu/ufiiq/b1eJdON8/1x5+9TjfORFBSDsof
         aV4AQZkVhFEa/iMR2Ote8qQHkIsUliTIcELJOLZE7Ao4f36OKhaGPBObu9nf09noiQpv
         tWpQ==
X-Gm-Message-State: AOAM532IFCxojiaheNDQSGBTL1KXAXrlTmO8q2fvZKybjZfFL5qyzj1d
        2X15b7jzkj6orGxu/ZL3lEO9g7Z4MQOg0w==
X-Google-Smtp-Source: ABdhPJx0li6XjdkZT3HqOc9PM9ncGiYgOib2tmuYH82gsurb9DJZSezE+S2huOzia/8ziYIjuRkGUA==
X-Received: by 2002:a05:6a00:b45:b029:207:16ba:12c4 with SMTP id p5-20020a056a000b45b029020716ba12c4mr26878935pfo.31.1617050338125;
        Mon, 29 Mar 2021 13:38:58 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id fv9sm487081pjb.23.2021.03.29.13.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 13:38:57 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] readdir: split the core of getdents64(2) out into
 vfs_getdents()
To:     Lennert Buytenhek <buytenh@wantstofly.org>,
        io-uring@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
References: <YEuNMc5LlGftOHW6@wantstofly.org>
 <YEuNlKWpQqGMCtL8@wantstofly.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0301cec-2ec3-a3ea-40bd-7d00845705a1@kernel.dk>
Date:   Mon, 29 Mar 2021 14:38:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YEuNlKWpQqGMCtL8@wantstofly.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/12/21 8:49 AM, Lennert Buytenhek wrote:
> So that IORING_OP_GETDENTS may use it, split out the core of the
> getdents64(2) syscall into a helper function, vfs_getdents().
> 
> vfs_getdents() calls into filesystems' ->iterate{,_shared}() which
> expect serialization on struct file, which means that callers of
> vfs_getdents() are responsible for either using fdget_pos() or
> performing the equivalent serialization by hand.

Al, how do you feel about this one?

-- 
Jens Axboe

