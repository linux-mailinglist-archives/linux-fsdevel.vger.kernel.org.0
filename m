Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81A4465E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392751AbfFMQvI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:51:08 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:42669 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfFMDgz (ORCPT
        <rfc822;groupwise-linux-fsdevel@vger.kernel.org:9:1>);
        Wed, 12 Jun 2019 23:36:55 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Wed, 12 Jun 2019 21:36:53 -0600
Message-Id: <5D01C4CD020000F90006C06A@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Wed, 12 Jun 2019 21:36:45 -0600
From:   "Gang He" <ghe@suse.com>
To:     "Randy Dunlap" <rdunlap@infradead.org>, <akpm@linux-foundation.org>
Cc:     <sfr@canb.auug.org.au>, <broonie@kernel.org>, <linux-mm@kvack.org>,
        "Joseph Qi" <joseph.qi@linux.alibaba.com>,
        <ocfs2-devel@oss.oracle.com>, <mhocko@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <mm-commits@vger.kernel.org>
Subject: Re: [Ocfs2-devel] mmotm 2019-06-11-16-59 uploaded (ocfs2)
References: <20190611235956.4FZF6%akpm@linux-foundation.org>
 <492b4bcc-4760-7cbb-7083-9f22e7ab4b82@infradead.org>
 <20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>
In-Reply-To: <20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Randy and Andrew,

>>> On 6/13/2019 at  9:18 am, in message
<20190612181813.48ad05832e05f767e7116d7b@linux-foundation.org>, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 12 Jun 2019 07:15:30 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 6/11/19 4:59 PM, akpm@linux-foundation.org wrote:
>> > The mm-of-the-moment snapshot 2019-06-11-16-59 has been uploaded to
>> > 
>> >    
> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.ozlabs.org_-7Eakpm_ 
> mmotm_&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0
> vmU6X8CMk6L2iDY8-HD0qT6Fo7Y&m=zWoF0Bft4OzQeAaZXMGI56DN7p9MjLynOay4PZYAlhQ&s=vYme
> DBOk3Nv08-ZA7IweIdaUk094Ldvmgzc20fjjzDs&e=
>> > 
>> > mmotm-readme.txt says
>> > 
>> > README for mm-of-the-moment:
>> > 
>> > 
> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.ozlabs.org_-7Eakpm_mmo 
> tm_&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0vmU
> 6X8CMk6L2iDY8-HD0qT6Fo7Y&m=zWoF0Bft4OzQeAaZXMGI56DN7p9MjLynOay4PZYAlhQ&s=vYmeDBO
> k3Nv08-ZA7IweIdaUk094Ldvmgzc20fjjzDs&e=
>> > 
>> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> > more than once a week.
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
Thank for this fix, the change is OK for my testing on x86_64.

Thanks
Gang

> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com 
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel

