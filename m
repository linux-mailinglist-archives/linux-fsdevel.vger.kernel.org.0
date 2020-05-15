Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4A1D5AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEOUoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:44:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34302 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOUoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:44:23 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1556771pgm.1;
        Fri, 15 May 2020 13:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=31jlI11UdSuUne5CytA8aXHN1DKoQTYg2m0ehqqjq1w=;
        b=Nr+wW/S0YqcnjY3rjCXDlQrzv69mSln+17NZYJDLMkCwVVBL60VVJL9eMr6Fjr6FRe
         y1vMkFjtrFGZvpZYEa4V3B+VFXvBeYsjOW2yFXWIfCdbaw8qGUfXgEfA8JnEd77NpHkM
         K1exf67FVJxF5dISa4eBFkR92IPx3QOCu6wdB7WU5RtOb9BL2gYFfQ/2I/ChL48SUQ3u
         G2LvSldXyL79rsseNGTBQ7rylGTgVizsuMJ2MFwUO3d691/WAldvB4HSwfzwa9T3iPO2
         zG6gdZZVIqOLNwHh3qh2ljcXbfk/ikpthkFBFGZEobrRlhhfFTdOM5Qc2nNrK74Ow5no
         boWw==
X-Gm-Message-State: AOAM531L1yg6BCFa3ACHakiMnjYtZArjgDej+/Xw3filWH3cQxXlEKmD
        DlxfYWMHZ6LKoL7ZCdGelQBK/j14GqeJ1A==
X-Google-Smtp-Source: ABdhPJw7XG8gdnNFvqQp/E+s55309E2Xi/QpwKoZegblz+akssDO8WQKCDIfy7AdJqwWny83PlCUZA==
X-Received: by 2002:a62:e70b:: with SMTP id s11mr5672379pfh.32.1589575462477;
        Fri, 15 May 2020 13:44:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f6sm2707575pfd.175.2020.05.15.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:44:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B5A6B40246; Fri, 15 May 2020 20:44:20 +0000 (UTC)
Date:   Fri, 15 May 2020 20:44:20 +0000
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
Subject: Re: [PATCH v5 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20200515204420.GB11244@42.do-not-panic.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-3-scott.branden@broadcom.com>
 <20200513003301.GH11244@42.do-not-panic.com>
 <3919bb12-522d-11fd-302b-91dc0fcff363@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3919bb12-522d-11fd-302b-91dc0fcff363@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 11:35:06AM -0700, Scott Branden wrote:
> On 2020-05-12 5:33 p.m., Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 05:27:34PM -0700, Scott Branden wrote:
> > flags? But its a single variable enum!
> fw_opt is an existing enum which doesn't really act like an enum.
> It is a series of BIT defines in an enum that are then OR'd together in the
> (existing) code?

Indeed, in retrospect that is odd, it should be a u32 then. Please feel
free to fix.
 
  Luis
