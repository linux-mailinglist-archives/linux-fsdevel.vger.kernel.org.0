Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E93166B61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgBUAOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:14:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45197 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbgBUAOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:14:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so86153pls.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 16:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=j9NfYN7oFcDu+7se145xCzZu7AyP4VVa9xyrU8e8kGg=;
        b=XWxniDG1LOh43SJp7z2UJovq9YWn0rOeMwHcyEGODF0mipdAE2OM29lnoAol7jNm2k
         GxF8H2F583pmx5hr+jvzunS+dWiBD7ZKqR0kswOHWmaIKeJ1zv2SoF3BHniIwkFFazT3
         aHPsj7/ErkiG7rXIa1poz4II56IxQtU96xc+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j9NfYN7oFcDu+7se145xCzZu7AyP4VVa9xyrU8e8kGg=;
        b=kNu+IV++2oIPueYU94bR5oPe8jNZXEoBizIJ29Nht6p8Etny97txVgcPmlrcBPFb5r
         Diidz+8Skgtmr5RhUK1D/hQ62HFj94yjg+ir5jNQHbHdqnicgaRAZOwiljJ71QVSRk4E
         WpCmCNe5f4/GaN8XrEVs3oN0GsXpbSZ6Gl5DCIfsH3wYtUTodQUV03G7DDHiGHm1st0S
         89vy0LcPRUciMcCI6liVJZKbCsXHZgbVhzSpXLV15xvDNx920BWcALAZk5pcjDOEfNTU
         8dMdH3UOJPmsPLHpUnAtTMmUb05EmR5tRjJttUONoGllPnE56rk3w4sOIcuJb93qO1nq
         PWyQ==
X-Gm-Message-State: APjAAAUIIFfCZzwGw494BKu8YW4XrLPpU1pn6TM7NSbrmTF8PZ9ZB0zv
        k6XPHOUxN5fqibschNBOKsFNNg==
X-Google-Smtp-Source: APXvYqx25cvFDEfSsVWYxxtiPJ4i/HB4cCqI6AWGUOOODbhBmUcXo4ZQNzLPzimdl5BHFsOLWIwruQ==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr6400987pjg.111.1582244061214;
        Thu, 20 Feb 2020 16:14:21 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x8sm701336pfr.104.2020.02.20.16.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 16:14:20 -0800 (PST)
Subject: Re: [PATCH v2 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Andy Gross <agross@kernel.org>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-3-scott.branden@broadcom.com>
 <20200220012235.GU11244@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6a810f3c-3e17-fba6-b00d-4333ffa2ecca@broadcom.com>
Date:   Thu, 20 Feb 2020 16:14:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220012235.GU11244@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

On 2020-02-19 5:22 p.m., Luis Chamberlain wrote:
> On Wed, Feb 19, 2020 at 04:48:20PM -0800, Scott Branden wrote:
>> Add offset to request_firmware_into_buf to allow for portions
>> of firmware file to be read into a buffer.  Necessary where firmware
>> needs to be loaded in portions from file in memory constrained systems.
>>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> Thanks for following up Scott! However you failed to address the
> feedback last time by Takashi, so until then, this remains a blocker for
> this.
>
> http://lkml.kernel.org/r/s5hwoeyj3i5.wl-tiwai@suse.de
>
>    Luis
I responded to the email query.  Hopefully this addresses your concern.

Regards,
  Scott

