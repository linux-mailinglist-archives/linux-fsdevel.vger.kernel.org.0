Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60095CFD4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfJHPNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 11:13:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49264 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJHPNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n9gVsTQoLIpJ4eS0KFKk7R+iymLPEUHSXXL/0IdbObc=; b=JMGKonHEQVur9Sq5Sq3k8dN0T
        4OZshzWN36oTT4jtZaLlzV/GCokyKEms2KFYrc+jovUii/X/qutVCYI9TCGqoVcbmHltEpx25jFwf
        WOsmnpxwUhQjo7Dc6eBZvpD75ip9wtVO38IaV6ZgSQ4oB2w5pya/5oNiD6qb5bI893I6VEv6XfyHU
        m6S+fl02cMDKxr4tTUHseDUqr+KBThNTJS3WuR652bjq7xR9OKGpne9wfZhORWGsy6uCfGqB9qMdL
        CumHGiUbd8NOp6WBBx4+LQEtxDSVQctNKdBj7CBH7fiEXh83pGw6gRcyHR0wDoi6R+7PRKL0LC5Tr
        mtHMWbXFw==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHrB7-0004kH-41; Tue, 08 Oct 2019 15:13:33 +0000
Subject: Re: [PATCH v2 linux-kselftest-test 2/3] kunit: allow kunit to be
 loaded as a module
To:     Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Cc:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        changbin.du@intel.com, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Knut Omang <knut.omang@oracle.com>
References: <1570546546-549-1-git-send-email-alan.maguire@oracle.com>
 <1570546546-549-3-git-send-email-alan.maguire@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3459e950-d8f0-edd1-2f23-ec9f520058f5@infradead.org>
Date:   Tue, 8 Oct 2019 08:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1570546546-549-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/19 7:55 AM, Alan Maguire wrote:
> Making kunit itself buildable as a module allows for "always-on"
> kunit configuration; specifying CONFIG_KUNIT=m means the module
> is built but only used when loaded.  Kunit test modules will load
> kunit.ko as an implicit dependency, so simply running
> "modprobe my-kunit-tests" will load the tests along with the kunit
> module and run them.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> 
> ---
>  lib/kunit/Kconfig  | 2 +-
>  lib/kunit/Makefile | 4 +++-
>  lib/kunit/test.c   | 4 ++++
>  3 files changed, 8 insertions(+), 2 deletions(-)

> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e7896f1..6024627 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -484,3 +484,7 @@ void kunit_cleanup(struct kunit *test)
>  	}
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
> +
> +#ifdef MODULE
> +MODULE_LICENSE("GPL");
> +#endif /* MODULE */

That ifdef/endif should not be necessary.
Did you try a modular build without them?

-- 
~Randy
