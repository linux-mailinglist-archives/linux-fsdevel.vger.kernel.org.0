Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500A316EEB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 20:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgBYTLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 14:11:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38501 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgBYTLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:11:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so13154pgn.5;
        Tue, 25 Feb 2020 11:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6fj2i98wrBqHNFBClWRPI0aXIGQwNsnnkHZjmeFx4vo=;
        b=lEmnenjDQ2KVRDWbKgSezI5Y9S8HulB2boliEz/CIatSs7pal+yLKXus2dAQKcc8LX
         TnTu6evVNMB5AFZAiBL5L/0Y+tEsExAwiZbkh8KkBVmyXV37DRwgjo4kIGhTYMRzN640
         9kwkEwnsRs/C/nzTUBppNb8rsAJm+9ICP7ygdS10CVfnHO4yQ1U3waNFCPpRLBV7B2s9
         L4XjYATIPTELXyBUKL5DkT9D9HAuZsh8KRUU1oGNJIgF9yzCaPJ+wkOZMyG/q3lnMDh/
         eqDoCIOFAZHgIETVWFbOK7UCY6/h+W+Q6EQDdD2++5clWLHdGKXE0lB/IE6thDr5VGcV
         QgUw==
X-Gm-Message-State: APjAAAXj2550UR9JP2QfjExfG0C3JND9uApKkZ/I/u1DfSuf7dJdRWmD
        uyhV7VyyYhG/d71rFCGiXHQ=
X-Google-Smtp-Source: APXvYqwPLMBR9bomYY3aI/v3GcwJxrQRcety3+JoHAeMIv2R3wYeF8p6mSSAyFUeGQtBIirNlQUkag==
X-Received: by 2002:a63:48f:: with SMTP id 137mr2886pge.245.1582657875635;
        Tue, 25 Feb 2020 11:11:15 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s125sm17944724pgc.53.2020.02.25.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:11:13 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 59BFA40297; Tue, 25 Feb 2020 19:11:12 +0000 (UTC)
Date:   Tue, 25 Feb 2020 19:11:12 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
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
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <20200225191112.GX11244@42.do-not-panic.com>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
 <20200220084255.GW7838@kadam>
 <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
 <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:13:08PM -0800, Scott Branden wrote:
> > > > +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
> > > > +{
> > > > +    size_t val;
> > > > +
> > > > +    mutex_lock(&test_fw_mutex);
> > > > +    val = cfg;
> > > > +    mutex_unlock(&test_fw_mutex);
> > > Both val and cfg are stack variables so there is no need for locking.
> > > Probably you meant to pass a pointer to cfg?
> I am following the existing code as was done for
> test_dev_config_show_bool(),
> test_dev_config_show_int(),
> test_dev_config_show_u8()
> 
> Mutex probably not needed but I don't think I need to deviate from the rest
> of the test code.
> 
> Luis, could you please explain what the rest of your code is doing?

The lock is indeed not needed in the functions you mentioned, so you can
also remove the other locks as a precursor patch. It would be a seperate
patch.

  Luis
