Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4FA217DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgGHEJ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgGHEJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:09:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30AC08C5E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 21:09:58 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so3043527wmc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 21:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ilI7WEFMs52fTeVVrHkeXBa9IJvQJ7qH+weqiuJJPTs=;
        b=TbBzfxZFfsLMcGtGC78q2HblBN9s7ulUr/wTidJf6gF2sH0F3lj7FerTPtq8wbqsvY
         wf6vCxP7JZbWvKDHhlqMlpDIk0yNDclKwTZwmm4HtDzyi0bppXy7QSWfkpSGHtyFWlzB
         v6Zd9iPuBbYIQJZi5tpgLxfTbvnN4znPIvxqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ilI7WEFMs52fTeVVrHkeXBa9IJvQJ7qH+weqiuJJPTs=;
        b=SSMEA3gjXHT27XTNnIAe3F+PAQoREhxuRS2N0iOjyeViUAtr5wMHEvfmkVjdtcwQdQ
         ybAW+SY9DMCx/kruGQ+Ng//qihZp1+aHERobylLVlhsU5DbO2Aa7435uKTimfx4a2kIO
         cPSouwgCpOdp80fMrygVpDFePL02B3RbA6ImmrdK8nqJZPX6GB2R7yVrRHIb3JjtynvD
         zAXXZf9jgbRDEMVSwVwWZtYIHeFS5r1KPSxjJ9qZYyj5zkd2oBSITA6SdvGtnNT6RLsg
         OUk//qQpdZRgdFqIK2VWrAqNLdLmY9hmAjox64n/sbEk6p+ByEu5MD0ChjrXM6W/0Gci
         qMFg==
X-Gm-Message-State: AOAM532YkHH7yIFgPQ4jBN7FPC3gJzf1hTnndTQoc/g4Mzhw3OJajzUv
        gsdc4zT3AvmCOkH57xYm98QaVw==
X-Google-Smtp-Source: ABdhPJzMkMfdY/Rbu2MnIw7q0PnF3+oC3R8Ea0tD3Cc39M74dTsRNErCUO25uk9h+2k7iyJC+vvCqw==
X-Received: by 2002:a7b:c7d2:: with SMTP id z18mr7413564wmk.149.1594181397195;
        Tue, 07 Jul 2020 21:09:57 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w2sm3467154wrs.77.2020.07.07.21.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:09:56 -0700 (PDT)
Subject: Re: [PATCH v10 4/9] test_firmware: add partial read support for
 request_firmware_into_buf
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-5-scott.branden@broadcom.com>
 <202007071659.38721F7@keescook>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b62a45d4-3df0-9e2f-f328-153277b8236e@broadcom.com>
Date:   Tue, 7 Jul 2020 21:09:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202007071659.38721F7@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020-07-07 4:59 p.m., Kees Cook wrote:
> On Mon, Jul 06, 2020 at 04:23:04PM -0700, Scott Branden wrote:
>> Add additional hooks to test_firmware to pass in support
>> for partial file read using request_firmware_into_buf.
>> buf_size: size of buffer to request firmware into
>> partial: indicates that a partial file request is being made
>> file_offset: to indicate offset into file to request
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> I am a fan of tests. :) If Luis gives an Ack here, you're good.
There were not even any tests for request_firmware_into_buf before I 
started this partial read support.
Fortunately those base changes have already been accepted so I think 
this change is a simple addition to those accepted patches.
>

