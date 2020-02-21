Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734B5166B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 01:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBUALP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 19:11:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45946 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgBUALP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:11:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so23612wrs.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2020 16:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wXSbqjr+PXHQhEGWLVIbHnU0mAYhDxXp177C2dXLvkw=;
        b=OR4qbGMZ3kSLXHwlfMWDnVjvxT0c/b5fmtDsqdt6bhn6yadSOJmNHGjqCWZm2yVRAO
         ed/pScZ8+lYgnYH+P/9lFgMRmFo+EmDPQWLLyTUT3CJO+a8D2eeHF7rdlZaG1BnbIa9D
         tNOFC7Kt+sV47VYFwmPjmlJ/tZzxGLf0wgzqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wXSbqjr+PXHQhEGWLVIbHnU0mAYhDxXp177C2dXLvkw=;
        b=t2zwkE0+Qa2kaihO0qlWZ40mJ5ERuhBQni/E4kXzt8CY+ozPo8Nl2XpMFVucMRr8NZ
         z3hzZnNcte8PFJsU5VyEQ3bfujpZQxiPNtJm0x8rIOi6rNuBrDYX5r6s8U+LJ27VC8y7
         otBX5/rbb9UYF579FNAKproGgyHLB/trtNnpWzXWStY7fqeT3sUu/ehsf9CYlhoRJXCS
         RvIBkVFobWoCxW8qqJQDFAS2mFTvxGKYQwk2X6EDiaVwS/VVWB2jwNnD5/jhlEaJdGA6
         nRPe9Vsg8dMF6NEdiBqpg8Gueuqeve5o0L+s+UDbYZca6mC0acpRYSw43NVLqKCFEgXJ
         0bbQ==
X-Gm-Message-State: APjAAAXZfzkvsJ25vGHbafhsQ2bvxFqqFqUnIx3bdNX+OcA2N6D274dB
        g79yUpUyY2Zwps2sbcxQQBmiEA==
X-Google-Smtp-Source: APXvYqyZNpXUITw974Gj1d7jmXjJf2j4kz6bDP4xvQnH/etFM/nRGojeEXJirHn2sJxv9V2yWs/+Pw==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr44375580wrt.408.1582243873022;
        Thu, 20 Feb 2020 16:11:13 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q9sm1553085wrx.18.2020.02.20.16.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 16:11:12 -0800 (PST)
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
To:     Luis Chamberlain <mcgrof@kernel.org>, Takashi Iwai <tiwai@suse.de>
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
        linux-kselftest@vger.kernel.org
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
 <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com>
 <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com>
 <s5hwoeyj3i5.wl-tiwai@suse.de> <20191011133120.GP16384@42.do-not-panic.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e65a3ba1-d064-96fe-077e-59bf8ffff377@broadcom.com>
Date:   Thu, 20 Feb 2020 16:11:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191011133120.GP16384@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2019-10-11 6:31 a.m., Luis Chamberlain wrote:
> On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
>> On Mon, 26 Aug 2019 19:24:22 +0200,
>> Scott Branden wrote:
>>> I will admit I am not familiar with every subtlety of PCI
>>> accesses. Any comments to the Valkyrie driver in this patch series are
>>> appreciated.
>>> But not all drivers need to work on all architectures. I can add a
>>> depends on x86 64bit architectures to the driver to limit it to such.
>> But it's an individual board on PCIe, and should work no matter which
>> architecture is?  Or is this really exclusive to x86?
> Poke Scott.
>
>    Luis
Yes, this is exclusive to x86.
In particular, 64-bit x86 server class machines with PCIe gen3 support.
There is no reason for these PCIe boards to run in other lower end 
machines or architectures.

