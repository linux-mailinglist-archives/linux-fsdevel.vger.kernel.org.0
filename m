Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC7217C02
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGGX7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 19:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgGGX7l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:59:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B93C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 16:59:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so19961686pgg.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 16:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t+MUHlMV05Venpi+dxgNFy9m2mM7Us7wpJwUgu+0RIA=;
        b=LafhCb4tq/+15NiiNOG2BKxCpeSoxaozRMft+310cV24Ytgchd8f5pyzQOSHeWZXfw
         sY1Dm+QXQug+61+HPKC9CsVVEyxHf9zqWNxuuTHnNPhg66oQiL6GpDh7ADEmoCmMSf41
         2+4zCqnrVxslrHZBmUrwZXf+GBK3TOSDNm1TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t+MUHlMV05Venpi+dxgNFy9m2mM7Us7wpJwUgu+0RIA=;
        b=LrWvH+CECCEHcnFNXStPSrr9N+79i+QjCjahs92Vjl94FY5DhL+u+SWacStEdQvjmh
         lOZOU4hU1YmhLaBBAzLm8GCZ2+tW9z6Hn00C9BaeJuNpks6lQTYkOELK0lkvuY4yfVsb
         T6V5r30y3UyYAupNXBg0kO69OXxyPdEiZTDf6eJEQzF0pQF/IviUCkkrka+urlYh9yEu
         CDbaSmw0hf/yl0Xqap12WoNfoJF3oQ1J5jonpzRtKBp8r8H5vYu1UmqA7h8GER9m2FEr
         0R5meCuYI7IfDtJYnVpV60R81bODOOGcrtf8IhLEPr/ADmxxFWOKCIDOpLt3x1Qb6832
         0odA==
X-Gm-Message-State: AOAM5338frB8Vm/OvYLLVCENDpJA56k4FmdGpHHzzmf2FqJ3mGWvknA5
        cFE1i5STk+p9UVZVcho5UB8udg==
X-Google-Smtp-Source: ABdhPJxrg7MIOsckToNcEU8cl8R/PG88U4PcKuHFAM793HgSei/rQl//+UCXuWhNnVDpB4swbIRxQw==
X-Received: by 2002:aa7:8651:: with SMTP id a17mr44429243pfo.48.1594166381010;
        Tue, 07 Jul 2020 16:59:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm10992837pfg.63.2020.07.07.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:59:40 -0700 (PDT)
Date:   Tue, 7 Jul 2020 16:59:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
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
Subject: Re: [PATCH v10 4/9] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <202007071659.38721F7@keescook>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
 <20200706232309.12010-5-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706232309.12010-5-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 04:23:04PM -0700, Scott Branden wrote:
> Add additional hooks to test_firmware to pass in support
> for partial file read using request_firmware_into_buf.
> buf_size: size of buffer to request firmware into
> partial: indicates that a partial file request is being made
> file_offset: to indicate offset into file to request
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

I am a fan of tests. :) If Luis gives an Ack here, you're good.

-- 
Kees Cook
