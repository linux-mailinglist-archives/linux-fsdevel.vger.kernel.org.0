Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017071AF573
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgDRWcP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:32:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A952C061A0C;
        Sat, 18 Apr 2020 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=zyG1QPS3RY2nWyGdHwcEoZL1dyrlEFupJ3Qi8VlAHRo=; b=loO7QmrtjVUfmmDDXVlI56bim3
        vaQVMQJheKFM/fE/1PTtCTTNe5XzeE/U7X2nTTSIWa2jsTphcpKDjL38BHOFJmFjIERkw1AXdISWE
        voAskfcYnobN2Cg1+P9xUb2INjXTpWf5cHvlbdHJX8AvFR/Nh2KWcL+zidNsbp7aa5RWLcbm4tdBY
        Q0wqgJei4sy2H6/qPY4WvoBul6hgnZd/9ZU74LcYk0mKxiyoJ+abZZmI+6EKaHmhxW62rGd+bzcYi
        uN5aQpL4TxGWtDU3C4cNci1ZCHm1UWwy33ZzvpUBRGHVtwzMJ6QU7jRANEHTNyCknHb8PG26nUhi/
        eFavfSdg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPw0Q-0000cZ-8H; Sat, 18 Apr 2020 22:32:10 +0000
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "zzy@zzywysm.com" <zzy@zzywysm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "perex@perex.cz" <perex@perex.cz>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
 <d2e2f7967804446a825ec0ff61095e6640b5a968.camel@hammerspace.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c838fc1d-3973-9cd8-ecc6-8739af514dd0@infradead.org>
Date:   Sat, 18 Apr 2020 15:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d2e2f7967804446a825ec0ff61095e6640b5a968.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 3:28 PM, Trond Myklebust wrote:
> On Sat, 2020-04-18 at 14:45 -0400, Chuck Lever wrote:
>>> On Apr 18, 2020, at 2:41 PM, Randy Dunlap <rdunlap@infradead.org>
>>> wrote:
>>>
>>> Fix gcc empty-body warning when -Wextra is used:
>>>
>>> ../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty
>>> body in an ‘else’ statement [-Wempty-body]
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: "J. Bruce Fields" <bfields@fieldses.org>
>>> Cc: Chuck Lever <chuck.lever@oracle.com>
>>> Cc: linux-nfs@vger.kernel.org
>>
>> I have a patch in my queue that addresses this particular warning,
>> but your change works for me too.
>>
>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>
>> Unless Bruce objects.
>>
>>
>>> ---
>>> fs/nfsd/nfs4state.c |    3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> --- linux-next-20200417.orig/fs/nfsd/nfs4state.c
>>> +++ linux-next-20200417/fs/nfsd/nfs4state.c
>>> @@ -34,6 +34,7 @@
>>>
>>> #include <linux/file.h>
>>> #include <linux/fs.h>
>>> +#include <linux/kernel.h>
>>> #include <linux/slab.h>
>>> #include <linux/namei.h>
>>> #include <linux/swap.h>
>>> @@ -3895,7 +3896,7 @@ nfsd4_setclientid(struct svc_rqst *rqstp
>>> 		copy_clid(new, conf);
>>> 		gen_confirm(new, nn);
>>> 	} else /* case 4 (new client) or cases 2, 3 (client reboot): */
>>> -		;
>>> +		do_empty();
> 
> Urgh... This is just for documentation purposes anyway, so why not just
> turn it all into a comment by moving the 'else' into the comment field?
> 
> i.e.
> 	} /* else case 4 (.... */
> 
> 	new->cl_minorversion = 0;
>>> 	gen_callback(new, setclid, rqstp);
>>> 	add_to_unconfirmed(new);

Like I said earlier, since Chuck has a patch that addresses this,
let's just go with that.

thanks.
-- 
~Randy

