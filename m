Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 333E1A090E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 19:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfH1R42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 13:56:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbfH1R42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=txC6lWmtj+oio3KV1A+MTj6T0kKiVWesqXTX1rGGOBA=; b=LKooIElGmi3mimn66Jmi/piIy
        h26w0yjYnaxBkNZwN4gKDO8Id/Y52/+KAjAKoseje7a9rOcHqY/2jXKL4yGry1rZJN4PerPB2GV9F
        +1ORBhDGmuMcJfiBstbBHNhUoMCsu59F5YUMUaqGlMtJN76HJB2kb0zKvhw2DVlHnAT5uexkXdMv4
        YI+vz+O8lrz9HvReyswCbWKozO5WfAng6zxMJP1h5janNi7xZmaHqdMremixr6dxI6CTPg1WPovRR
        DSDb3WG3/ApsAfNG98speWsS0b752vw3rCYMs2+QkYU6pxAkCkxYHDgWjfnEah3gEsrLj1ThUy/Pw
        Urhi8R17Q==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i32BG-0001LQ-Fg; Wed, 28 Aug 2019 17:56:26 +0000
Subject: Re: mmotm 2019-08-27-20-39 uploaded (objtool: xen)
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
References: <20190828034012.sBvm81sYK%akpm@linux-foundation.org>
 <8b09d93a-bc42-bd8e-29ee-cd37765f4899@infradead.org>
 <20190828171923.4sir3sxwsnc2pvjy@treble>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <57d6ab2e-1bae-dca3-2544-4f6e6a936c3a@infradead.org>
Date:   Wed, 28 Aug 2019 10:56:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828171923.4sir3sxwsnc2pvjy@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/28/19 10:19 AM, Josh Poimboeuf wrote:
> On Wed, Aug 28, 2019 at 09:58:37AM -0700, Randy Dunlap wrote:
>> On 8/27/19 8:40 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2019-08-27-20-39 has been uploaded to
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
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>
>>
>>
>> drivers/xen/gntdev.o: warning: objtool: gntdev_copy()+0x229: call to __ubsan_handle_out_of_bounds() with UACCESS enabled
> 
> Easy one :-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 0c8e17f946cd..6a935ab93149 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -483,6 +483,7 @@ static const char *uaccess_safe_builtin[] = {
>  	"ubsan_type_mismatch_common",
>  	"__ubsan_handle_type_mismatch",
>  	"__ubsan_handle_type_mismatch_v1",
> +	"__ubsan_handle_out_of_bounds",
>  	/* misc */
>  	"csum_partial_copy_generic",
>  	"__memcpy_mcsafe",
> 


then I get this one:

lib/ubsan.o: warning: objtool: __ubsan_handle_out_of_bounds()+0x5d: call to ubsan_prologue() with UACCESS enabled


-- 
~Randy
