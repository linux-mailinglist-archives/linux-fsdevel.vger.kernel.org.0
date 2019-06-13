Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A885644691
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfFMQwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:52:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfFMDFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 23:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5347sLkcqdCaDr4KbIIf3bKPXQaQU7AVUw40AwlLk0E=; b=gf4dv7WU5lUnCVxWX1b/VbhuEP
        RpAMKwYyUlhgcAdDBmtQ/bz/ehU3elbdJn89YliwF//sPf0+wbq8mbjoMZbkAAQy3GEUTYilX4iSj
        k/MtsOknTvg2JkzcbSuGPMoJIAd1IqE+0bhPaUj7Ck/jBLsepF1XEmo5T3V4WLhxVkr261JgfaI+q
        kJdtOMZfu7WKBScGQVBpA4dS8b+VasmQTV9rhm1DmyISlPeT+ImRMVI4LVCJpBHXKH56hgyQZ+xL8
        8Mm8BTD5aVCrnkDcvN3rqEi+H2BBxYlZt6vaok0WqL/4pL/2cGXo4h4qLmCehl6qYrFBo+IjcXnE5
        8GXZHODg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbG3Y-0006L6-IB; Thu, 13 Jun 2019 03:05:40 +0000
Subject: Re: mmotm 2019-06-11-16-59 uploaded (ocfs2)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20190611235956.4FZF6%akpm@linux-foundation.org>
 <492b4bcc-4760-7cbb-7083-9f22e7ab4b82@infradead.org>
 <20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a412fca5-7204-7001-cc1a-f620ea6f64bd@infradead.org>
Date:   Wed, 12 Jun 2019 20:05:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/19 6:18 PM, Andrew Morton wrote:
> On Wed, 12 Jun 2019 07:15:30 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 6/11/19 4:59 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2019-06-11-16-59 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>
>>
>> on i386:
>>
>> ld: fs/ocfs2/dlmglue.o: in function `ocfs2_dlm_seq_show':
>> dlmglue.c:(.text+0x46e4): undefined reference to `__udivdi3'
> 
> Thanks.  This, I guess:
> 
> --- a/fs/ocfs2/dlmglue.c~ocfs2-add-locking-filter-debugfs-file-fix
> +++ a/fs/ocfs2/dlmglue.c
> @@ -3115,7 +3115,7 @@ static int ocfs2_dlm_seq_show(struct seq
>  		 * otherwise, only dump the last N seconds active lock
>  		 * resources.
>  		 */
> -		if ((now - last) / 1000000 > dlm_debug->d_filter_secs)
> +		if (div_u64(now - last, 1000000) > dlm_debug->d_filter_secs)
>  			return 0;
>  	}
>  #endif
> 
> review and test, please?
> 

Builds for me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


-- 
~Randy
