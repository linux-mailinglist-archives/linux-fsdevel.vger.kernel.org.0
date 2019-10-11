Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E90D4145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfJKNbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 09:31:24 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41597 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbfJKNbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:31:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so5806977pga.8;
        Fri, 11 Oct 2019 06:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PoH5MwnZ8mABUE4xEY3uv3HD3AizjwGwq9FYbMsqiJI=;
        b=Dd1ZRQUqxJbJ4XmorKsIkCtEacO2eN09lx8ajkjbqAfiJu29ijb20yUVFhLES2aTAC
         4QL7Kndoe+PxN+LYdFsp2lGfyuVNxnUBXgGL/HFakv10SrqS3+YzRMMBGS/5AuM0qlDn
         VwX4247mLRYbydvGYCP7gGBNU2Uu7H+peXDi/cJUx3mDSY340fLjw2+5GB8Wc28eCZrS
         n8QyxrNZjj0KNuY4OPv/yTNr5LKizc2oz1sB5GJD9k262ioPMubB2zzLWSBYfH526Ws9
         AO5vQdOSr9WbeYAmcunbARwBa9vpuV9n8vty5ILql8hK+8i5Xpwgcg7QhX6eYZNQRz83
         4QFA==
X-Gm-Message-State: APjAAAXticFZNFAla4guUMdajszLoyuuDSFyefuqrKwJeTlx08PUfEfJ
        ZBOLRBXD44y6QqNk+1pUpKY=
X-Google-Smtp-Source: APXvYqx8TVKU23vxfiCJYNLm8ZBGLiP4x+3bYJYdBArplQPvFpQtfe3pjF2ftceD826I4XWYVhs9MQ==
X-Received: by 2002:a17:90a:9f94:: with SMTP id o20mr17787166pjp.76.1570800682200;
        Fri, 11 Oct 2019 06:31:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d4sm7744375pjs.9.2019.10.11.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 06:31:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 61BD5403EA; Fri, 11 Oct 2019 13:31:20 +0000 (UTC)
Date:   Fri, 11 Oct 2019 13:31:20 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
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
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] firmware: add offset to request_firmware_into_buf
Message-ID: <20191011133120.GP16384@42.do-not-panic.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-3-scott.branden@broadcom.com>
 <s5hef1crybq.wl-tiwai@suse.de>
 <10461fcf-9eca-32b6-0f9d-23c63b3f3442@broadcom.com>
 <s5hr258j6ln.wl-tiwai@suse.de>
 <93b8285a-e5eb-d4a4-545d-426bbbeb8008@broadcom.com>
 <s5ho90byhnv.wl-tiwai@suse.de>
 <b440f372-45be-c06c-94a1-44ae6b1e7eb8@broadcom.com>
 <s5hwoeyj3i5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hwoeyj3i5.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:40:02PM +0200, Takashi Iwai wrote:
> On Mon, 26 Aug 2019 19:24:22 +0200,
> Scott Branden wrote:
> > 
> > I will admit I am not familiar with every subtlety of PCI
> > accesses. Any comments to the Valkyrie driver in this patch series are
> > appreciated.
> > But not all drivers need to work on all architectures. I can add a
> > depends on x86 64bit architectures to the driver to limit it to such.
> 
> But it's an individual board on PCIe, and should work no matter which
> architecture is?  Or is this really exclusive to x86?

Poke Scott.

  Luis
