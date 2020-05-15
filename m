Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8850A1D5ADC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgEOUrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:47:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45269 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:47:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id u22so1377457plq.12;
        Fri, 15 May 2020 13:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bl4gmCDPSUzHnX+jLpXyZUJERfeGYaFlQRMMArtCGYw=;
        b=oeOXGsr4+HBzYqZnxvIM2ZOj7Jn+xUjXCTSOan+GC9hFglZuNbccQlY1DDZsPy7gHl
         gpbwsRsp+qh0rFDCxsiOOkS+peI3zeLUS4mnTRnkg77WVrnLcvVH0iU4TPHKvNGuSmgs
         9OVmoU/wD51jBHwmjVbVf3vvO7fzwNvNSPD7VBmkfIFOE0OP39LctnuYeV5q3gOF4Tt4
         B7MkKNpnIa43QOuGsZUp3f4gEZy3g67FNILOxpAXAqnykLHeZKkgeJ4wFqAdUVEcel4Q
         HK9RStpZDTsaRB8PdEoIqP03zu4AAtSApppguTBnZCKnf+GzLl8rE4F3eLzx/eWD47Sl
         EOrw==
X-Gm-Message-State: AOAM533+AfYSBNNGDenxpFcF+WGyjrtoso8IfhSNCVwXo6tUH5nojLN7
        GQuuaVk3jIgTVvne8y56aKs=
X-Google-Smtp-Source: ABdhPJzvKeCybmqcU3uCZ47Ca1r5orOtVdlDMNpjFIpmiXjNhQsQ3lh6XlyPvdvbjVArLirXx76prA==
X-Received: by 2002:a17:902:7596:: with SMTP id j22mr5189994pll.226.1589575623031;
        Fri, 15 May 2020 13:47:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e12sm2387775pgv.16.2020.05.15.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:47:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A324540246; Fri, 15 May 2020 20:47:00 +0000 (UTC)
Date:   Fri, 15 May 2020 20:47:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v5 0/7] firmware: add partial read support in
 request_firmware_into_buf
Message-ID: <20200515204700.GC11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <1589387039.5098.147.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1589387039.5098.147.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 12:23:59PM -0400, Mimi Zohar wrote:
> Hi Scott,
> 
> On Thu, 2020-05-07 at 17:27 -0700, Scott Branden wrote:
> > Please consider this version series ready for upstream acceptance.
> > 
> > This patch series adds partial read support in request_firmware_into_buf.
> > In order to accept the enhanced API it has been requested that kernel
> > selftests and upstreamed driver utilize the API enhancement and so
> > are included in this patch series.
> > 
> > Also in this patch series is the addition of a new Broadcom VK driver
> > utilizing the new request_firmware_into_buf enhanced API.
> 
> Up to now, the firmware blob was read into memory allowing IMA to
> verify the file signature.  With this change, ima_post_read_file()
> will not be able to verify the file signature.
> 
> (I don't think any of the other LSMs are on this hook, but you might
> want to Cc the LSM or integrity mailing list.)

Scott, so it sounds we need a resolution for pread for IMA for file
signature verification. It seems that can be addressed though. Feel
free to submit the u32 flag changes which you picked up on though in
the meantime.

  Luis
