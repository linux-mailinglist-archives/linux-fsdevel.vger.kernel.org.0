Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182739B826
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 23:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405221AbfHWV3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 17:29:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36104 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfHWV3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 17:29:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so7311475pfi.3;
        Fri, 23 Aug 2019 14:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tHc2UDznI/uoDADxr2vQBdjC4lDElZPoW7dMZcPdM2Q=;
        b=m2dginuydqnbCe8vxP0ntkIoZHFCc3EB2k3XGvkrRKngxa34uBnGCjRmOhBRW0uhZJ
         KoEIp7+xjseLZiMLy6xSmC2acDa8qX7kqQNgAZ+IPGXdWy/7zHDRKJXzL5gGu68itb9k
         4o2aIEA4fC6dBIsf3BfgMbP6jQdCJnBFAyql3vj4UW3t3/Ld9Jn6ctpCC7liXOcQDreJ
         MoT9NVl/N0sgxePWMmqZPHw+u3HwERHeOTtJDFj67NHYW7Mo8D1M2dEm8p56xIik9iSr
         LlXQh7uz5+yc7Hs8gW3sZAwNgfBkV6HO5YDxYpncg4jctwrzpqLEEpqcGi4tHQfOZ66G
         p0+A==
X-Gm-Message-State: APjAAAVmFk7MKjHw6+IxSuju98Ry9UjZhy9nLKjBoWWufffU2WujLl3H
        TSn9JSBBG2PmZpORZp/Szc7+7XfM
X-Google-Smtp-Source: APXvYqxNyAjgfQduz6dW+l+bgFvSrwQm451XbPDad0xibowVRhhovyr8KMcZhhgAtL2K2wTE+28YyA==
X-Received: by 2002:a17:90a:1202:: with SMTP id f2mr7076664pja.39.1566595775063;
        Fri, 23 Aug 2019 14:29:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d128sm3626577pfa.42.2019.08.23.14.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 14:29:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A98D6404D5; Fri, 23 Aug 2019 21:29:32 +0000 (UTC)
Date:   Fri, 23 Aug 2019 21:29:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
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
        linux-kselftest@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 1/7] fs: introduce kernel_pread_file* support
Message-ID: <20190823212932.GY16384@42.do-not-panic.com>
References: <20190822192451.5983-1-scott.branden@broadcom.com>
 <20190822192451.5983-2-scott.branden@broadcom.com>
 <s5hsgpsqd49.wl-tiwai@suse.de>
 <5227a1bb-52e5-d547-2650-b06bee259012@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5227a1bb-52e5-d547-2650-b06bee259012@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:55:30PM -0700, Scott Branden wrote:
> Hi Takashi
> 
> On 2019-08-23 5:29 a.m., Takashi Iwai wrote:
> > On Thu, 22 Aug 2019 21:24:45 +0200,
> > Scott Branden wrote:
> > > Add kernel_pread_file* support to kernel to allow for partial read
> > > of files with an offset into the file.  Existing kernel_read_file
> > > functions call new kernel_pread_file functions with offset=0 and
> > > flags=KERNEL_PREAD_FLAG_WHOLE.
> > Would this change passes the security check like ima?
> > I thought security_kernel_post_read_file() checks the whole content
> > for calculating the hash...
> 
> It passes the fw_run_tests.sh.  How do you test the firmware loader passes
> this security check?

Its not a security check per code, its an audit of the code, to ensure
that no new cases are not covered and its why I had CC'd Mimi. The
question lies in *if* the approach exposes a new interface which cannot
be attested. Its unclear to me if we can attest currently through
security modules the fallback interface, as there are not APIs with a
respective callback yet.

  Luis
