Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E3217E74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 06:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgGHEiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgGHEiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:38:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66217C061755;
        Tue,  7 Jul 2020 21:38:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so1485179wmi.3;
        Tue, 07 Jul 2020 21:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06Hzq2VRyI6UIt88Dp3b82i5/9v//2xu8xecyFLZ6F8=;
        b=p8q3DCgqjwzsoCr7bSNkRvfBW4kSwZKR6Yn4LN/XneUEg3TfLt+TnMkBnDooJB2adw
         7Ctv+ExHMl9a14uHnLMjD24lI83nztqURJDfQKLrSRtgb1Nv3VOE09B2TdPLhedkAqZj
         y+VQniCP9WvlhgsCAoIYtBS9ttVFG1wltvpAj8K6i2fnSX8FfXmI/TcXoqxZflp8JB23
         UW80W0VvIj/SolCiVVuyCuGejIPfIylgx7BMbc3csLCEtA9EPtsnnFAiZ4eHr332s2pJ
         Ek7XnYg9VwDsEnL02WnwQEF169FYBLswe843gYZw+G3CGvLT/80L+0A9OouSFQoKgGOu
         AC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06Hzq2VRyI6UIt88Dp3b82i5/9v//2xu8xecyFLZ6F8=;
        b=kWRJuOkSpVjEz1PumhnuyEwesvqVsD2ABmIbmFep59H6jgn2Tq0uoXrYYGR5HF42l6
         0fpT6qSpEzY/hXFi+K4Ck/ype8MAjRN/wjtIvth6q4I7yUo32kx+hKWjnwFVDFNou2E4
         KoDkN/ap2vmoO3ue4qJXvKPIz9BNVLcl8/xZf7yrhzEkqvmdzbQsV5/HB3OFytL5JMZY
         zbha9WyGjddZdJx2J4wvBFavcxPo4m16xyZ9BtRyqdgHo0vL45mRMkdDlLoSzoQXsQFm
         Jj7yTFc9GzP+C3F0TJM7pFFETgrvUzGXZ3+9OK3A80XL2bwNwdIjW1akTcbTByXRPRoK
         TgCQ==
X-Gm-Message-State: AOAM531MHQ0Wjny6R6F3Oi6aeWzBOIr5RY17RZddNOzbuzaIKc+aImny
        3bhHkvONG656p8fVEdEmuZkpdNom
X-Google-Smtp-Source: ABdhPJzFNbynHxzghcviq7OHt7Ns5zaJAl0bcRMp1hwy3+kBx3Go3m/5LroH6bVLAX0SonyxRMi8pg==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr7224279wmb.69.1594183100840;
        Tue, 07 Jul 2020 21:38:20 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w128sm4489452wmb.19.2020.07.07.21.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:38:20 -0700 (PDT)
Subject: Re: [PATCH v10 0/9] firmware: add request_partial_firmware_into_buf
To:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200706232309.12010-1-scott.branden@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c8bbabe6-0b25-a816-f95d-8af63010eaf2@gmail.com>
Date:   Tue, 7 Jul 2020 21:38:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706232309.12010-1-scott.branden@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/6/2020 4:23 PM, Scott Branden wrote:
> This patch series adds partial read support via a new call
> request_partial_firmware_into_buf.
> Such support is needed when the whole file is not needed and/or
> only a smaller portion of the file will fit into allocated memory
> at any one time.
> In order to accept the enhanced API it has been requested that kernel
> selftests and upstreamed driver utilize the API enhancement and so
> are included in this patch series.
> 
> Also in this patch series is the addition of a new Broadcom VK driver
> utilizing the new request_firmware_into_buf enhanced API.
> 
> Further comment followed to add IMA support of the partial reads
> originating from request_firmware_into_buf calls.  And another request
> to move existing kernel_read_file* functions to its own include file.

Do you have any way to separate the VK drivers submission from the
request_partial_firmware_into_buf() work that you are doing? It looks
like it is going to require quite a few iterations of this patch set for
the firmware/fs/IMA part to be ironed out, so if you could get your
driver separated out, it might help you achieve partial success here.
-- 
Florian
