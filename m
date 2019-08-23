Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1020C9B3AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfHWPnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 11:43:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34683 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfHWPnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:43:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so5997922pgc.1;
        Fri, 23 Aug 2019 08:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6gbuFk04+ij6vjmtC7dZeomrE2Z6PDlZ2TY3DqrgL8=;
        b=QLHgDm6HNsuMn1HGjbjWhkhHiVW/zxBjbUayNy5D+dcbxqiz9I+U1mH0tmY54MQv2q
         fU2IdPInVpjANNuMtJVE0F3wF8ZdZy/PR5tdM9aS+PEeifYpl9kceNglF7KQpCwcrUyX
         7cwhbazJ9p1AIkyjlzQxmj18Lfvf+9eUoBEskXjaXiVyKrX7/Kj5hNbW77M0x7tH8gWN
         MSGRQhsYKO1ajzBVm9V3MRtbLc+sL18N1F8MZuXIe0emHEfe3zmd9hnNtvzyeFqt3UNY
         7hbyD6pPzhri8EhIsEmC2gX6ZIyCdqDMGh7tik86ZilVPKXDmn34BE0XoUNIg1JTfmOW
         cntg==
X-Gm-Message-State: APjAAAV9uZY2P/abchMRjCbAk7jsSUIvV1C8mclOqR4ptSjV9zXik8Za
        MOiHA+KP6+pCJJaFJfaXRWg=
X-Google-Smtp-Source: APXvYqyGepRg8opgN4YZqwET+ErU3AX2HBuZhRJljwXDyVt43xrYXNA7jgKoM0AGGKBYpjHvI4ZwPg==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr6060133pfs.114.1566574983158;
        Fri, 23 Aug 2019 08:43:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j10sm3060768pfn.188.2019.08.23.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:43:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 50B72404D5; Fri, 23 Aug 2019 15:43:01 +0000 (UTC)
Date:   Fri, 23 Aug 2019 15:43:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
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
Subject: Re: [PATCH 3/3] firmware: add mutex fw_lock_fallback for race
 condition
Message-ID: <20190823154301.GT16384@42.do-not-panic.com>
References: <20190816000945.29810-1-scott.branden@broadcom.com>
 <20190816000945.29810-4-scott.branden@broadcom.com>
 <20190819053937.GR16384@42.do-not-panic.com>
 <16823ee6-c52a-b3b5-caed-79c00772fa68@broadcom.com>
 <20190820012655.GU16384@42.do-not-panic.com>
 <s5hd0gwrx4j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hd0gwrx4j.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:31:40PM +0200, Takashi Iwai wrote:
> So, if any, we'd need put a mutex around the fallback loader code.
> And, the mutex should be rather per device, not a global one.
> 
> Or we may trick it by appending the second parallel caller into the
> same wait queue, but the code will be more complex, so I don't think
> worth for it.

For now I'm thinking of a new API with a devname prefix to the driver.
I'll have to test if that works, but not sure if I'll get to it today
before my vacation starts (today).

  Luis
