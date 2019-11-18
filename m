Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02CFFFD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 08:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfKRHxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 02:53:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:29559 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfKRHxa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:53:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 23:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,319,1569308400"; 
   d="scan'208";a="196047576"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2019 23:53:24 -0800
Subject: Re: [LKP] Re: [pipe] d60337eff1:
 BUG:kernel_NULL_pointer_dereference,address
To:     David Howells <dhowells@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
References: <9279.1573824532@warthog.procyon.org.uk>
 <20191110031348.GE29418@shao2-debian>
 <6853.1573834946@warthog.procyon.org.uk>
From:   kernel test robot <rong.a.chen@intel.com>
Message-ID: <35daca93-ff2b-2c7d-b837-72396ca0677a@intel.com>
Date:   Mon, 18 Nov 2019 15:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6853.1573834946@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Yes, it can fix the problem.

Best Regards,
Rong Chen

On 11/16/2019 12:22 AM, David Howells wrote:
> Actually, no, this is the fix:
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 7006b5b2106d..be2fc5793ddd 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -537,7 +537,7 @@ static size_t push_pipe(struct iov_iter *i, size_t size,
>   		buf->ops = &default_pipe_buf_ops;
>   		buf->page = page;
>   		buf->offset = 0;
> -		buf->len = max_t(ssize_t, left, PAGE_SIZE);
> +		buf->len = min_t(ssize_t, left, PAGE_SIZE);
>   		left -= buf->len;
>   		iter_head++;
>   		pipe->head = iter_head;
>
> David
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

