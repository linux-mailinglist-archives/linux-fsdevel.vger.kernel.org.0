Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6791212F06A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 23:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgABWwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 17:52:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729267AbgABWwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578005569;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ro2StskuuiOygh3NiDGUwqcaIG+MVEbFmsA628V+UI=;
        b=SCBk3wIxwb9pdp+fP/alTzw77cyYCR8+uFouVB5FimpjkivLzT9nSEHAcgUAkum0GaGkWa
        nqeIIFLRWeSmwy8TWyL1LmF88fw6N3jhQc8C5z3T7Fc5u5u9ru65DaEstvPLIxMFLjOzsA
        1Zvluax8XU+igWXzkICr+y9/ghDFQf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-d7SrF8PNMAe1zwPJniqu2g-1; Thu, 02 Jan 2020 17:52:46 -0500
X-MC-Unique: d7SrF8PNMAe1zwPJniqu2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4306B107ACC4;
        Thu,  2 Jan 2020 22:52:45 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3147B5D9C9;
        Thu,  2 Jan 2020 22:52:43 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 0/9] Add persistent durable identifier to storage log
 messages
Reply-To: tasleson@redhat.com
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <1577148654.29997.29.camel@HansenPartnership.com>
Organization: Red Hat
Message-ID: <833ef311-1918-3b47-18bb-bc59aabd0ba8@redhat.com>
Date:   Thu, 2 Jan 2020 16:52:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577148654.29997.29.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/19 6:50 PM, James Bottomley wrote:
> On Mon, 2019-12-23 at 16:55 -0600, Tony Asleson wrote:
>> Today users have no easy way to correlate kernel log messages for
>> storage devices across reboots, device dynamic add/remove, or when
>> the device is physically or logically moved from from system to
>> system.  This is due to the existing log IDs which identify how the
>> device is attached and not a unique ID of what is
>> attached.  Additionally, even when the attachment hasn't changed,
>> it's not always obvious which messages belong to the device as the
>> different areas in the storage stack use different identifiers, eg.
>> (sda, sata1.00, sd 0:0:0:0).
>>
>> This change addresses this by adding a unique ID to each log
>> message.  It couples the existing structured key/value logging
>> capability and VPD 0x83 device identification.
> 
> I understand why, and using the best VPD identifier we have seems fine.
>  However, we're trying to dump printk in favour of dev_printk and its
> ilk, so resurrecting printk_emit instead of using dev_printk_emit looks
> a bit retrograde.  It does seem that ata_dev_printk should really be
> using dev_printk ... not sure about the block case.

I'll re-work the patch series to move towards dev_printk_emit.


Thanks
-Tony

