Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F01165433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbgBTBWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 20:22:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43379 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTBWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:22:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so1023704pfh.10;
        Wed, 19 Feb 2020 17:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e66XU0nEoA5qfNXWLeMAQwu6IxKmeV1IChHBVZH9fZk=;
        b=c1yKwx8m+HVIJQboFbLSAZ+3HAg48GUgwXTmg/LWG7ELX0lDLLCvGkwn6LVGlifdXN
         TWK8Ula3By43vN3PPJdr3vFJqRzEDSlUjryKFNy7jr3yGnRdvTg8heh7TF/4Rq02UxDo
         Livy3q0dLF2du9O+K0vXzdHeEdmhw2uxjxf/wZoopgBG6+Fp2GdZTBGi4hOq6UqN6byp
         RLv2oCW4CGz0LXGauQfyttEbRFQl0ft4dHL4FWGOybIiAT7uU6PZXim3lzT1ifMbfW8I
         DDZZ12kPPJOowb2xCMPmWbkzHz+toSWk0b72wpzhpJIsJ4GQziz3b6PukyBXx3JNEf+/
         fCMQ==
X-Gm-Message-State: APjAAAViAscJn8RdCbuJHLwHF4UxXDh1oRbotyM43/EKGoZQ1AzLZWhC
        IQQijCkm9vCXgry33JQ0Srw=
X-Google-Smtp-Source: APXvYqw3dWDdJVdt4sc0Bvx5FVv68mBP8ks6VkDsDXnz/suX59U3WQKFkGJYnaRq222Z5IyP3TMQ2A==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr29983093pfi.105.1582161757397;
        Wed, 19 Feb 2020 17:22:37 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t8sm944926pjy.20.2020.02.19.17.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 17:22:36 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A678F402D7; Thu, 20 Feb 2020 01:22:35 +0000 (UTC)
Date:   Thu, 20 Feb 2020 01:22:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
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
Subject: Re: [PATCH v2 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20200220012235.GU11244@42.do-not-panic.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-3-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220004825.23372-3-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 04:48:20PM -0800, Scott Branden wrote:
> Add offset to request_firmware_into_buf to allow for portions
> of firmware file to be read into a buffer.  Necessary where firmware
> needs to be loaded in portions from file in memory constrained systems.
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Thanks for following up Scott! However you failed to address the
feedback last time by Takashi, so until then, this remains a blocker for
this.

http://lkml.kernel.org/r/s5hwoeyj3i5.wl-tiwai@suse.de

  Luis
