Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8A1AF39E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgDRSqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725824AbgDRSqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:46:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BDEC061A0C;
        Sat, 18 Apr 2020 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=VISMEuIrdwsT06Me0Ojm4dxgrzpFN+IXsxHmlBlB8Qk=; b=nqtHk9RcEHVzyndzlvZR0ApTMu
        IN1fIO34WRJMJqoiVj7+SryUcbwhljitvqy/ICpkyIIe3BbMMImIye+e0/hX/bK155cyiYWUCLYSi
        BtcqtD6RrusuGCd9kZzO2uiwoFPl/pFtQB+EGVC0bUi41qqnl4Vd22sCWLoaS3qMDLJU6B+8Y/b3B
        pwlcV/D8BHV05r1/Bqcf3oReONTpcDhMqDTzxTxGSy3/capPzIfLqB6dlPwacRlKAaiVeGpJyRWHw
        KugYiErRe0UugJTz9HVHOvQZE01XSsMXRBvnxI0dM+ehHI+0RgwUw4Yb5V/AkkYq+jOPkS4NBxqRm
        SktMceiA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPsU6-0002Y8-4x; Sat, 18 Apr 2020 18:46:34 +0000
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
 <20200418184111.13401-6-rdunlap@infradead.org>
 <20200418184409.GP5820@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3998d056-e115-4e36-2705-eea132cce7de@infradead.org>
Date:   Sat, 18 Apr 2020 11:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418184409.GP5820@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/20 11:44 AM, Matthew Wilcox wrote:
> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
>> +++ linux-next-20200327/drivers/usb/core/sysfs.c
>> @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
>>  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
>>  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
>>  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
>> -		;	/* We don't actually care if the function fails. */
>> +		do_empty(); /* We don't actually care if the function fails. */
>>  	intf->sysfs_files_created = 1;
>>  }
> 
> Why not just?
> 
> +	if (alt->string)
> +		device_create_file(&intf->dev, &dev_attr_interface);
> 

Yes, looks good. Thanks.

-- 
~Randy

