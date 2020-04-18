Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288731AF3BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgDRSuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgDRSuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:50:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7BBC061A0C;
        Sat, 18 Apr 2020 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=na4bJ3PkcifD0nFgc5n3XvGryFaz89gkoFznEG5QSiA=; b=s8O9bLPQ3/PwyhlXG8w8qqYbwq
        sTtpsGIripwqUAVAAsu2nj/XCKxMas3tSgjRxl3gHNtvArdEj1uffO6xT7tPA3EqF9wmB93jjToSn
        N4K9MdbnF1AhlTs/5V0mo2YU4ioGpwniS9b7RLbThV642vvH0Oaw4DQvAXombZAy6nkuiqaTG5ZtZ
        3ETZbMbDXUb4qlER1RXVuV+nxpkl9G+aWvUaDQqrcR0Iyoie1anJryeuc5zYhk4x+UQ4IP5g9eBoV
        vQvnY/lULm5KVOhnO0YdeCnzPEXXBNqZu/Zs1RAWjA3aKwPFfzK/pLRb/7u0sH8oOF7NyLx+KXYAJ
        bRYCu/FA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsXQ-0003BB-Ls; Sat, 18 Apr 2020 18:50:00 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Zzy Wysm <zzy@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
 <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3990866b-3331-560d-e5e3-6b51ae51c1e2@infradead.org>
Date:   Sat, 18 Apr 2020 11:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 11:44 AM, Joe Perches wrote:
> On Sat, 2020-04-18 at 11:41 -0700, Randy Dunlap wrote:
>> Add the do_empty() macro to silence gcc warnings about an empty body
>> following an "if" statement when -Wextra is used.
>>
>> However, for debug printk calls that are being disabled, use either
>> no_printk() or pr_debug() [and optionally dynamic printk debugging]
>> instead.
> []
>> +#define do_empty()		do { } while (0)
> 
> If this is really useful
> (I think the warning is somewhat silly)
> 
> bikeshed:
> 
> I think do_nothing() is more descriptive

Yes, I do too, as I more or less mentioned in the cover letter.

-- 
~Randy

