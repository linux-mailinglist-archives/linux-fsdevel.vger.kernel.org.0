Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E116CC608
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2019 00:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfJDWrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 18:47:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:11370 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfJDWrA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:47:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 15:46:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="186397805"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 04 Oct 2019 15:46:58 -0700
Date:   Sat, 5 Oct 2019 06:46:40 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] fs/userfaultfd.c: simplify the calculation of new_flags
Message-ID: <20191004224640.GC32588@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190806053859.2374-1-richardw.yang@linux.intel.com>
 <20191003004505.GE13922@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003004505.GE13922@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 08:45:05PM -0400, Andrea Arcangeli wrote:
>Hello,
>
>On Tue, Aug 06, 2019 at 01:38:59PM +0800, Wei Yang wrote:
>> Finally new_flags equals old vm_flags *OR* vm_flags.
>> 
>> It is not necessary to mask them first.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  fs/userfaultfd.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index ccbdbd62f0d8..653d8f7c453c 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1457,7 +1457,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>>  			start = vma->vm_start;
>>  		vma_end = min(end, vma->vm_end);
>>  
>> -		new_flags = (vma->vm_flags & ~vm_flags) | vm_flags;
>> +		new_flags = vma->vm_flags | vm_flags;
>>  		prev = vma_merge(mm, prev, start, vma_end, new_flags,
>>  				 vma->anon_vma, vma->vm_file, vma->vm_pgoff,
>>  				 vma_policy(vma),
>
>And then how do you clear the flags after the above?
>
>It must be possible to clear the flags (from
>UFFDIO_REGISTER_MODE_MISSING|UFFDIO_REGISTER_MODE_WP to only one set
>or invert).
>
>We have no WP support upstream yet, so maybe that's why it looks
>superfluous in practice, but in theory it isn't because it would then
>need to be reversed by Peter's (CC'ed) -wp patchset.
>
>The register code has already the right placeholder to support -wp and
>so it's better not to break them.
>
>I would recommend reviewing the uffd-wp support and working on testing
>the uffd-wp code instead of changing the above.
>

Sorry, I don't get your point. This change is valid to me even from arithmetic
point of view.

    vm_flags == VM_UFFD_MISSING | VM_UFFD_WP

The effect of current code is clear these two bits then add them. This equals
to just add these two bits.

I am not sure which part I lost.

>Thanks,
>Andrea

-- 
Wei Yang
Help you, Help me
