Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27C6D90A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 04:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSCYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 22:24:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47944 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfGSCYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 22:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pD6WAPijEMJJx4TfSKuwSSTNjnIfbYYwvAbudp3cVxw=; b=2jWxASzuD/7gwyENW54yc7XFwC
        /YhVXItCeaRa3MFWXYFGtF/b9rpL6FFb4y2XG54FchNlk6VCbD/NdruODhtdf5HUh71Ay+nHopK8O
        dA6S02M4SxXgvkcjkYe032QnEhkQqYPSCBFqne+YRW9b9dYE1tFlV76XngmOI03QNPPmPukG0wPHd
        B///iV6MAu+sN+AcztaB+FyxlzMppxgmGTM/hZVHjItZVSdM7LSExF+WBRFl/91aMBWAFGIv48ZeX
        FURbxygy+kAV+hAk1ownBr1Q82WM/crUqCj/Qv/oWe3A2+g5W7buLQBpP1Ba+CTFKGJYlyKzmSHwN
        RdwUKF4g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hoIZX-0002Ej-Lc; Fri, 19 Jul 2019 02:24:35 +0000
Subject: Re: [PATCH] iomap: hide iomap_sector with CONFIG_BLOCK=n
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>
References: <20190718125509.775525-1-arnd@arndb.de>
 <20190718125703.GA28332@lst.de>
 <CAK8P3a2k3ddUD-b+OskpDfAkm6KGAGAOBabkXk3Uek1dShTiUA@mail.gmail.com>
 <20190718130835.GA28520@lst.de> <20190718142525.GE7116@magnolia>
 <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d63adfdf-7ac2-bc42-38c6-db1404a87d47@infradead.org>
Date:   Thu, 18 Jul 2019 19:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNASN5d_ppx6wJSm+fcf9HiX9i6zX4fxiR5_WuF6QUOExXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/19 7:19 PM, Masahiro Yamada wrote:
> Hi.
> 
> On Thu, Jul 18, 2019 at 11:28 PM Darrick J. Wong
> <darrick.wong@oracle.com> wrote:
>>
>> On Thu, Jul 18, 2019 at 03:08:35PM +0200, Christoph Hellwig wrote:
>>> On Thu, Jul 18, 2019 at 03:03:15PM +0200, Arnd Bergmann wrote:
>>>> The inclusion comes from the recently added header check in commit
>>>> c93a0368aaa2 ("kbuild: do not create wrappers for header-test-y").
>>>>
>>>> This just tries to include every header by itself to see if there are build
>>>> failures from missing indirect includes. We probably don't want to
>>>> add an exception for iomap.h there.
>>>
>>> I very much disagree with that check.  We don't need to make every
>>> header compilable with a setup where it should not be included.
>>
>> Seconded, unless there's some scenario where someone needs iomap when
>> CONFIG_BLOCK=n (???)
> 
> I agree.
> 
> There is no situation that iomap.h is included when CONFIG_BLOCK=n.
> So, it is pointless to surround offending code with #ifdef
> just for the purpose of satisfying the header-test.
> 
> 
> I started to think
> compiling all headers is more painful than useful.
> 
> 
> MW is closing, so I am thinking of disabling it for now
> to take time to re-think.
> 
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index bd7d650d4a99..cbb31d134f7e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -111,6 +111,7 @@ config HEADER_TEST
>  config KERNEL_HEADER_TEST
>         bool "Compile test kernel headers"
>         depends on HEADER_TEST
> +       depends on BROKEN
>         help
>           Headers in include/ are used to build external moduls.
>           Compile test them to ensure they are self-contained, i.e.
> 
> 
> 
> Maybe, we should compile-test headers
> only when it is reasonable to do so.

Maybe.  But I would find it easier to use if it were a make target
instead of a Kconfig symbol, so someone could do
$ make compile_test_headers

for example.  Then it would be done only on demand (or command).

-- 
~Randy
