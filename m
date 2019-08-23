Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4979B77E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbfHWT4v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 15:56:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44018 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392373AbfHWT4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 15:56:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id v12so7126091pfn.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2019 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FYTRVOUyodl3Y4MOOfrDquojBPwPvHQa3bd0t+obIek=;
        b=CbEHObgKjJpbHN1oZh4pOMIH5mUHa33/hNLK99CTRxdBPdONQ5KKkUkFmqlasemH6L
         merAVOVyx5DcQxPPbVJLQJtiW9RTbxz4nazl+knP4n9o34EmvQx+v9w3d8CEbby18rw4
         PZtRY4Uw0e+jQ6wSGHrmGIvnzAKOOBlxvrqPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FYTRVOUyodl3Y4MOOfrDquojBPwPvHQa3bd0t+obIek=;
        b=ZEGrOiMvR8Q/OJ21iOkZMvhkLWVUPrCaRoRi6JnLZf5GJu5mu+v9iHGiWnNDzkmTBd
         +8xklz3ktukFKy3o4v8+no9EQE61N4C2eSz0ywiSq+G49NtnH0Dkd2slxxnM/qrYMrt7
         9jCeU+93QMSQB6IU1AVjtXaYtR3dM5ONz4GXmXoR9JnaVXiEbgR1en2N5WS2/lKJUjKW
         nhu55uP/qRC7CCTUtiY2gn6hz5TparAPxiX0vg58ptQcekWK39tmgwK+izGaGentT83q
         eS5FjoRevNwv2fawASaMTtPIHOBEMd6gkRATIBnw9MdB6IAyVmuiwFaj+XfEnEnbP/5i
         ukFg==
X-Gm-Message-State: APjAAAVQLaTWJ/A4uKjAfhO7bDMa18JU0MFvtI0ygAn9clthxaTX1Y8d
        yGUhuIkbhST3Dxmb9ZlpjbE1MA==
X-Google-Smtp-Source: APXvYqxVqZT3jcFr4ernORkUXpLdFWPDt3yD9zn4XXs7FBtd+nkfpKKeLaqlQLza0A30/JAeL9DTSg==
X-Received: by 2002:a17:90a:ad94:: with SMTP id s20mr7155476pjq.42.1566590209928;
        Fri, 23 Aug 2019 12:56:49 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z19sm2593052pgv.35.2019.08.23.12.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 12:56:49 -0700 (PDT)
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
To:     Luis Chamberlain <mcgrof@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
 <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
 <20190820012655.GU16384@42.do-not-panic.com> <s5hd0gwrx4j.wl-tiwai@suse.de>
 <20190823154301.GT16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <95736fe7-31e1-ab6e-11f6-e209951402a9@broadcom.com>
Date:   Fri, 23 Aug 2019 12:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823154301.GT16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2019-08-23 8:43 a.m., Luis Chamberlain wrote:
> On Fri, Aug 23, 2019 at 12:31:40PM +0200, Takashi Iwai wrote:
>> So, if any, we'd need put a mutex around the fallback loader code.
>> And, the mutex should be rather per device, not a global one.
>>
>> Or we may trick it by appending the second parallel caller into the
>> same wait queue, but the code will be more complex, so I don't think
>> worth for it.
> For now I'm thinking of a new API with a devname prefix to the driver.
> I'll have to test if that works, but not sure if I'll get to it today
> before my vacation starts (today).
Have a good vacation.
>
>    Luis
