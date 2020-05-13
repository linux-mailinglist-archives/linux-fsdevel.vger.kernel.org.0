Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1AD1D03AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 02:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbgEMAfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 20:35:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40096 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAfN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 20:35:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so7208208pfx.7;
        Tue, 12 May 2020 17:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yRB9XgmnIGPrh7vcOIMg8BEgGvSJ/DYpyFSMRxz7MlA=;
        b=gs5MuHvBdt1wRgcswgS/5smzf4y9h715ss/sH+rLoi0o+KVOeEBpFBG2opJm1fBpLZ
         wHBah/TK9GPzCKjzSAEdroojhbBwrNg8utD55Q7Zo0JsDiqk7jnhhYfklUMZPpH/tGv+
         TDXxR+Cwq3uxkQY0xz6fddTC6hlY2cOMIKU+DSy30aEk2xMuMebuRBR/+aqaEL7vpChS
         nFyTXdvHdM1rDYwHgcfePF79F1aXykdMwj4GTrqeodETT8BwDz7Tct4L6KkBTi0Shkvz
         R0UOWoPPnl0dhfOFEqOsvpLSZpX9JnnVQlTj8KOcU66twdYWTKSw1cpu3UFFwz6Mbho/
         Jxow==
X-Gm-Message-State: AGi0PuZIumLcJio5JPYPmyT7QwlM79BY2R2xcHXM5r6H+E9DltiojcB4
        ZNEeNAWzXEXzpZWjPsGKYDw=
X-Google-Smtp-Source: APiQypLLwXxPGfFaEOZNFPfNDspb7DfI9yifHyIr96tKek8IpY5phU0AU/Lauy1dnCXSHfFD/0zcTA==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr22226762pgk.193.1589330111714;
        Tue, 12 May 2020 17:35:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ev5sm31222654pjb.1.2020.05.12.17.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:35:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A45FF4063E; Wed, 13 May 2020 00:35:09 +0000 (UTC)
Date:   Wed, 13 May 2020 00:35:09 +0000
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
Subject: Re: [PATCH v5 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <20200513003509.GI11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-4-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508002739.19360-4-scott.branden@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 07, 2020 at 05:27:35PM -0700, Scott Branden wrote:
> Add additional hooks to test_firmware to pass in support
> for partial file read using request_firmware_into_buf.
> buf_size: size of buffer to request firmware into
> partial: indicates that a partial file request is being made
> file_offset: to indicate offset into file to request
> 
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> ---
>  lib/test_firmware.c | 146 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 136 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 55176b0a8318..d1d2b48ed40e 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -645,18 +762,24 @@ static int test_fw_run_batch_request(void *data)
>  
>  	if (test_fw_config->into_buf) {
>  		void *test_buf;
> +		unsigned int pread_flags;

Same thing here.

 Luis
