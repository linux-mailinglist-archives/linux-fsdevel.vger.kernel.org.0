Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5626712F09A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 23:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgABWyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 17:54:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729405AbgABWyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578005642;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15CQpc4ye1yHxOgZq+RNTAriJ+ZhSxpEpKwtlFpdSD0=;
        b=IWiq66IKwWq+lVnRv7uZwI+2YlYdxYEZEH6cp/P5CHeQQqvoGFIQTa+dJ3GWxJxrR7bgV4
        91P/bDwvM7ak6HJ9k3jTehoZ18CJccmnmVBUk/vZZwwU8tXoH88V2hlJ2RpArZ9I/tRZH/
        5SgfxbJXfXv2bj2exeWflI4MndQGjVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-J3F73UBSNGyHyGNyjjECEw-1; Thu, 02 Jan 2020 17:53:59 -0500
X-MC-Unique: J3F73UBSNGyHyGNyjjECEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63240800D48;
        Thu,  2 Jan 2020 22:53:58 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2D560BF7;
        Thu,  2 Jan 2020 22:53:56 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
Subject: Re: [RFC 6/9] create_syslog_header: Add durable name
Reply-To: tasleson@redhat.com
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191223225558.19242-1-tasleson@redhat.com>
 <20191223225558.19242-7-tasleson@redhat.com>
 <1577148851.29997.32.camel@HansenPartnership.com>
Organization: Red Hat
Message-ID: <fe598a6e-6d3c-162b-85ec-5aa1e631e441@redhat.com>
Date:   Thu, 2 Jan 2020 16:53:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577148851.29997.32.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/19 6:54 PM, James Bottomley wrote:
> On Mon, 2019-12-23 at 16:55 -0600, Tony Asleson wrote:
>> This gets us a persistent durable name for code that logs messages in
>> the
>> block layer that have the appropriate callbacks setup for durable
>> name.
>>
>> Signed-off-by: Tony Asleson <tasleson@redhat.com>
>> ---
>>  drivers/base/core.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 93cc1c45e9d3..57b5f5cd29fc 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -3318,6 +3318,15 @@ create_syslog_header(const struct device *dev,
>> char *hdr, size_t hdrlen)
>>  				"DEVICE=+%s:%s", subsys,
>> dev_name(dev));
>>  	}
>>  
>> +	if (dev->type && dev->type->durable_name) {
>> +		int dlen;
>> +
>> +		dlen = dev_durable_name(dev, hdr + (pos + 1),
>> +					hdrlen - (pos + 1));
>> +		if (dlen)
>> +			pos += dlen + 1;
>> +	}
>> +
> 
> dev_durable_name already returns zero if either dev->type or dev->type-
>> durable_name are NULL, so the if() above is pointless.

Indeed, will remove redundant checks in patch re-work.

Thanks
-Tony

