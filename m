Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2D81AAE96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416196AbgDOQon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416181AbgDOQoe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:44:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C5C061A10
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 09:44:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so198808plp.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdVhlXTVp5GfPwUXj6VUlKKGPig0Mq5LnblaVWQhsNw=;
        b=EwXM2PRVYwopCctyukNi1Jy9/hg/z0XO7R6ERA5H8lQeF+oXDnWxXzaBvG4/tpnaJk
         EUS2ZH0ou2TLvBuWGGsNknwi3M1uPK00CvyRUMX/rprb0NidhH4cb7OvpZxH10W+Osnk
         G83vC8Ey8RWVcyBCcgTMDej9RphYZAOY/eHB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdVhlXTVp5GfPwUXj6VUlKKGPig0Mq5LnblaVWQhsNw=;
        b=WHCbqcLheRw9nuJSDNyIrqPaM5XGzfvqebnMXOpLE9SFzeSJS6RAjGXzk9yQ1ZAeZD
         oBhvRAZbuXy9In0nxAmDR2yn607gVLsCPHHVzv+eN9deMbdtI5U7x+c8/aBITFu4Q+/j
         sV8WPgossz+3TvOQ27OP1hPGgJNRMtjzo8QqGWVZF9zgAhqrQBWx0L0oo1ZK7K7VSGPb
         Uj+/kAsFxL4uoz/akEgc7LsYmkyo3dJIfzBisWSPQdGM2sYYjsQFRKiZml8o3gTkFSkY
         nf/eXJ5SpAA8afb+f/jFMB9EqI2UNsBwtP5eQ0QkJHU0aW00bgu5qMXwHDQJvzKHDQsg
         5hYA==
X-Gm-Message-State: AGi0PuY+uWCJXS/Zv9xqEcM51Nwp1D2GHTwv3O5wfqVvQ6/fWVhluDgN
        NDJ4wmoUo5ejfFQp2p8mNELw3A==
X-Google-Smtp-Source: APiQypJgMZ6xJFMYuPvklbyB28ygbw+op9ku2YKu7rWsqqyQB/c5p+WB+5D1gw/9Ht/E/DrwxvRBRA==
X-Received: by 2002:a17:90a:dac2:: with SMTP id g2mr139955pjx.112.1586969073762;
        Wed, 15 Apr 2020 09:44:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q70sm14494021pfc.206.2020.04.15.09.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:44:32 -0700 (PDT)
Date:   Wed, 15 Apr 2020 09:44:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] test_firmware: remove unnecessary test_fw_mutex in
 test_dev_config_show_xxx
Message-ID: <202004150943.01DF9E85@keescook>
References: <20200415002517.4328-1-scott.branden@broadcom.com>
 <202004142010.C0847F5@keescook>
 <e2b95fde-0ab7-c0d1-2c64-cceffc458673@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b95fde-0ab7-c0d1-2c64-cceffc458673@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:28:18AM -0700, Scott Branden wrote:
> Hi Kees,
> 
> On 2020-04-14 8:10 p.m., Kees Cook wrote:
> > On Tue, Apr 14, 2020 at 05:25:17PM -0700, Scott Branden wrote:
> > > Remove unnecessary use of test_fw_mutex in test_dev_config_show_xxx
> > > functions that show simple bool, int, and u8.
> > I would expect at least a READ_ONCE(), yes?
> I don't understand why you need a READ_ONCE when removing a mutex around an
> assignment
> of a parameter passed into a function being assigned to a local variable.
> 
> Could you please explain your expectations.

Oops, yes, you're right. I misread and was thinking this was reading
from a global. This looks fine.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> > 
> > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > ---
> > >   lib/test_firmware.c | 26 +++-----------------------
> > >   1 file changed, 3 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > > index 0c7fbcf07ac5..9fee2b93a8d1 100644
> > > --- a/lib/test_firmware.c
> > > +++ b/lib/test_firmware.c
> > > @@ -310,27 +310,13 @@ static int test_dev_config_update_bool(const char *buf, size_t size,
> > >   	return ret;
> > >   }
> > > -static ssize_t
> > > -test_dev_config_show_bool(char *buf,
> > > -			  bool config)
> > > +static ssize_t test_dev_config_show_bool(char *buf, bool val)
> > >   {
> > > -	bool val;
> > > -
> > > -	mutex_lock(&test_fw_mutex);
> > > -	val = config;
> > > -	mutex_unlock(&test_fw_mutex);
> > > -
> > >   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> > >   }
> > > -static ssize_t test_dev_config_show_int(char *buf, int cfg)
> > > +static ssize_t test_dev_config_show_int(char *buf, int val)
> > >   {
> > > -	int val;
> > > -
> > > -	mutex_lock(&test_fw_mutex);
> > > -	val = cfg;
> > > -	mutex_unlock(&test_fw_mutex);
> > > -
> > >   	return snprintf(buf, PAGE_SIZE, "%d\n", val);
> > >   }
> > > @@ -354,14 +340,8 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> > >   	return size;
> > >   }
> > > -static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
> > > +static ssize_t test_dev_config_show_u8(char *buf, u8 val)
> > >   {
> > > -	u8 val;
> > > -
> > > -	mutex_lock(&test_fw_mutex);
> > > -	val = cfg;
> > > -	mutex_unlock(&test_fw_mutex);
> > > -
> > >   	return snprintf(buf, PAGE_SIZE, "%u\n", val);
> > >   }
> > > -- 
> > > 2.17.1
> > > 
> 

-- 
Kees Cook
