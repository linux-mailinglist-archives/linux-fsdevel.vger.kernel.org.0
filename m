Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BBF1AF3FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgDRS5e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRS5d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:57:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76398C061A0C;
        Sat, 18 Apr 2020 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=v6goMSiM3JqD5eRdn45ZDeyVAxJCt3W7fqpeEGrJJtc=; b=KyiJJMamxfOIjVFL72tLsYD7re
        sd31vDw2o9XAGj4cjlL0iY4LlaG6HfVp+RX/eAnF8cs7BFGA7rm1P50OIDl4CJaSxdZP9IFpIodWa
        qKFndBfM+66S0aonynhdQTK/wJPSVS1Y4GHEToI5QjfeKxEM5UcdrBqdzJ3gwI+cd+itnETKujVao
        no3xr+EdUuBl8Nn1gwFz9atcofq1XkfodTx5dSOb3avPvgI/1CgyqkUdIR/uY0+1yXAWS0ASg6Ion
        xZd3LmWJA+40BpAwWMUlGbYNQaWIgBlBDowZN86RmjMlnIBdG8kobJ5e86SBZIZs/svVAtt0wyDuC
        yjEBGuCw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPseh-0000VM-7j; Sat, 18 Apr 2020 18:57:31 +0000
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To:     Joe Perches <joe@perches.com>, Chuck Lever <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
 <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c13ddc03-dfb4-9664-ce38-fc56389b67cd@infradead.org>
Date:   Sat, 18 Apr 2020 11:57:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 11:53 AM, Joe Perches wrote:
> On Sat, 2020-04-18 at 14:45 -0400, Chuck Lever wrote:
>>> On Apr 18, 2020, at 2:41 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> Fix gcc empty-body warning when -Wextra is used:
>>>
>>> ../fs/nfsd/nfs4state.c:3898:3: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
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
>>> 	new->cl_minorversion = 0;
>>> 	gen_callback(new, setclid, rqstp);
>>> 	add_to_unconfirmed(new);
> 
> This empty else seems silly and could likely be better handled by
> a comment above the first if, something like:
> 
> 	/* for now only handle case 1: probable callback update */
> 	if (conf && same_verf(&conf->cl_verifier, &clverifier)) {
> 		copy_clid(new, conf);
> 		gen_confirm(new, nn);
> 	}
> 
> with no else use.

I'll just let Chuck handle it with his current patch,
whatever it is.

thanks.
-- 
~Randy

