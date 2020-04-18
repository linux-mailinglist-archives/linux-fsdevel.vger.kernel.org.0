Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5411AF55D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgDRWYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgDRWYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:24:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9106C061A0C;
        Sat, 18 Apr 2020 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=6BmXyiqO0wHj5DxV76+E1WoB5x4GFAz5ggF5vJlCwBY=; b=oxhW+B4vRTgqQBsuDwIsLFMEct
        6TX5T83DboBf3ez7X7kXQJafr/mSIetsMcmkxbozwlNZhrGP3KaBhB72DD90MaxwSTxz0xRfULyL6
        AvX4zavVft8NqRBtfqcYE2kitI1mQMkez/vCA6TpAShj11oJMTOdbM7o15E8RRIiAPkVoHCWwXASe
        A1EetPGnTH+meja3KBvzdtPeq+Nbub1BjZ119BN61NVOGGhALPjPbS/siMH++8AT0x7QlOdGIK5G+
        q5LOp3OsdL8SPeD26SqecS+Gp7dn5PPGGDyyTbrH2nVd3ur5IgeGTiwFOjWwfijvCRV7dqo/d/V99
        /QQogknA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPvt8-0003Nf-T0; Sat, 18 Apr 2020 22:24:39 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
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
 <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <144825af-536e-9f11-f055-7ff978ede505@infradead.org>
Date:   Sat, 18 Apr 2020 15:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 3:20 PM, Bart Van Assche wrote:
> On 4/18/20 11:41 AM, Randy Dunlap wrote:
>> --- linux-next-20200327.orig/include/linux/kernel.h
>> +++ linux-next-20200327/include/linux/kernel.h
>> @@ -40,6 +40,14 @@
>>   #define READ            0
>>   #define WRITE            1
>>   +/*
>> + * When using -Wextra, an "if" statement followed by an empty block
>> + * (containing only a ';'), produces a warning from gcc:
>> + * warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
>> + * Replace the empty body with do_empty() to silence this warning.
>> + */
>> +#define do_empty()        do { } while (0)
>> +
>>   /**
>>    * ARRAY_SIZE - get the number of elements in array @arr
>>    * @arr: array to be sized
> 
> I'm less than enthusiast about introducing a new macro to suppress "empty body" warnings. Anyone who encounters code in which this macro is used will have to look up the definition of this macro to learn what it does. Has it been considered to suppress empty body warnings by changing the empty bodies from ";" into "{}"?

I mentioned that possibility in PATCH 0/9 (cover letter)...
which should have been RFC PATCH 0/9.
So yes, it is possible.

You are the only other person who has mentioned it.

thanks.
-- 
~Randy

