Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10291AF3E2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDRSzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDRSzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:55:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D7C061A0C;
        Sat, 18 Apr 2020 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Fw5l4YeyjM9q5bGtc9HETB0eI3KSL+di5A5JibSeUVA=; b=ZSd4gPvRX+1EcEyWBtmo2xeq+k
        YGKz4bmzRQ0lBLMGURF5oh6CYWK4W10L7kKdDnAI5hJvRsl3/cWENuwUZYgrll4QOeY8IG2KAIwKm
        DmODoHeVwqhNbpPD2mueD4eauFer8yFIuqk42bawnd9he64bV/jQfHVxkRxNmOAMcICHspMdvF49L
        mwjxdxSsr1vLxgUV9OSBDAPsxY5sxHKI3ovi3k6+D0MPLbEOgd5u2ipYWdww6+1xj13RRsP3BbZTP
        5/uu3l5yRFjedkT+1vldVo7jjG4LvH/c3xDAix8dZm74bZ5+P4Sk4RUlA1MpmcdYVcPWYAQRtLCOh
        CMd3C1UQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPscv-0000Nr-Nv; Sat, 18 Apr 2020 18:55:41 +0000
Subject: Re: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-3-rdunlap@infradead.org>
 <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <722a746a-1438-60e3-04b2-c13eda2ad168@infradead.org>
Date:   Sat, 18 Apr 2020 11:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 11:53 AM, Linus Torvalds wrote:
> On Sat, Apr 18, 2020 at 11:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Fix gcc empty-body warning when -Wextra is used:
> 
> Please don't do this.
> 
> First off, "do_empty()" adds nothing but confusion. Now it
> syntactically looks like it does something, and it's a new pattern to
> everybody. I've never seen it before.
> 
> Secondly, even if we were to do this, then the patch would be wrong:
> 
>>         if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
>> -               /* fall through */ ;
>> +               do_empty(); /* fall through */
> 
> That comment made little sense before, but it makes _no_ sense now.
> 
> What fall-through? I'm guessing it meant to say "nothing", and
> somebody was confused. With "do_empty()", it's even more confusing.
> 
> Thirdly, there's a *reason* why "-Wextra" isn't used.
> 
> The warnings enabled by -Wextra are usually complete garbage, and
> trying to fix them often makes the code worse. Exactly like here.

OK, no problem.  That's why PATCH 0/9 says RFC.

Oops. Crap. It was *supposed* to say RFC. :(

-- 
~Randy

