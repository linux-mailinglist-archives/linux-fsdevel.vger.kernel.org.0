Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30A10EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfEAV5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 17:57:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55149 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEAV5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 17:57:16 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so929673ite.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 14:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TuzrgtFnewRP7Az/ul/8XSuGGtyu58jE0oPsW6+MEAI=;
        b=zuyE1eDhKGoj82/2Fhg7aMy0ci0Lu6OK6LcYuEMrFei7aUhMOqFe47RYDBR/Aacen8
         TrJPQpuBATcYNwAAE6U/kA2vkesbB0WjaF91oy3F6MPM5mipLNUNFL0wdeWGh+zqRte/
         dum7CIT49PHZcYDSApfFGppqqZi+FoXzckJExcxI2DY+LTQS4IxLNWpWR2c1eMJN5SsZ
         XSMoNyHq5lAA4adtPZgQSXeqUaQC/NJtax9oywb93ubkG8W1A1eM991B/nYCVwjmKKr4
         lqPbiEbj4s6lFBZSie8BQf9oQ7ZM5ACsOEEfUZxju7jyxAdQdSCrkPlROKKHUeQ/sI4C
         rE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TuzrgtFnewRP7Az/ul/8XSuGGtyu58jE0oPsW6+MEAI=;
        b=cMYDSCgytXoh86MrgESdl+3FEBZTiJwx/JQjrbtivRpztsexXz9U+uNmxwZyT3b9DK
         ocuHAFzjPOMHfoE3XE9eqkwxVI9DqPQbY++F6X8X7HjU+0gY8sLVIEHKwqG3u0PuoiLr
         LMlSAY2AUp0EleqQrzUcmeaMd1ynNqVFW9wbzolj4pPV1a+jp1tpvbOX949++fiF/HBX
         0P4Io0VyPkw4NiBTxJEvUz/So7ddwfPD/cmPcjGMQRPwY2i3oVmJqACMVecha8Ib/R9P
         IUCMzP2JlTcXWWwyfR/0C1G5wpnMt20SM6/Itlh3on/7TPL3X/TQx2RPZc1EU20xDKKr
         AD9Q==
X-Gm-Message-State: APjAAAVy6uFLNwp2Ar0l9KdW50BM8l8Hm3l5P+u5DV1myN34mDsgq2ai
        fTybbZVdcH4sY52QoRmfpq4DvVc9KANSJA==
X-Google-Smtp-Source: APXvYqz9/cdAtBgYCfg98tPbhFuc2v8QLYYXTs9aHihYSWRS5MJM6E2fMfiggX556KpgYaSpi1Dw6A==
X-Received: by 2002:a24:2e4f:: with SMTP id i76mr9619870ita.171.1556747835400;
        Wed, 01 May 2019 14:57:15 -0700 (PDT)
Received: from [192.168.1.113] (174-23-158-160.slkc.qwest.net. [174.23.158.160])
        by smtp.gmail.com with ESMTPSA id d133sm4004433ita.5.2019.05.01.14.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 14:57:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] req->error only used for iopoll
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501115336.13438-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f9499cb0-8e00-8e82-0acb-edf1c5556f21@kernel.dk>
Date:   Wed, 1 May 2019 15:57:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501115336.13438-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:53 AM, Stefan Bühler wrote:
> No need to set it in io_poll_add; io_poll_complete doesn't use it to set
> the result in the CQE.

Looks good, I added this for the 5.2 series. Thanks.

-- 
Jens Axboe

