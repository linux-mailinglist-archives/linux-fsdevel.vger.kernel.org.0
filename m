Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306CD29D3D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgJ1VrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727629AbgJ1VrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921622;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+J5ii6EZLhTqQCH/OEDhTSwFbyzMnC7lbpD84H+AYE=;
        b=NaoebUVT6O46G0FF3eZa55Iiur34FK9qwhlaUXhZ799qPDeeiZsEYUO1kga4MywpbofYeg
        2QtxJV+wRBOTgNwa1oXKbNEX3wvOUtcep4Wvfb5YeA0skdI1irUiXKQHMWvRXcoOMoKodn
        eQS1Sogcrp5GF5k3lWsMUYBQwqwFuak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-tbOc0l-tPvOW4EVvGYq8OQ-1; Wed, 28 Oct 2020 16:45:24 -0400
X-MC-Unique: tbOc0l-tPvOW4EVvGYq8OQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 774631009E27;
        Wed, 28 Oct 2020 20:45:23 +0000 (UTC)
Received: from [10.10.112.242] (ovpn-112-242.rdu2.redhat.com [10.10.112.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD9615B4B2;
        Wed, 28 Oct 2020 20:45:22 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
Subject: Re: [PATCH] buffer_io_error: Use dev_err_ratelimited
Reply-To: tasleson@redhat.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201026155730.542020-1-tasleson@redhat.com>
 <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
Organization: Red Hat
Message-ID: <71148b03-d880-8113-bd91-25dadef777c7@redhat.com>
Date:   Wed, 28 Oct 2020 15:45:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/26/20 5:07 PM, Andy Shevchenko wrote:
> On Mon, Oct 26, 2020 at 10:59 PM Tony Asleson <tasleson@redhat.com> wrote:
>>
>> Replace printk_ratelimited with dev_err_ratelimited which
>> adds dev_printk meta data. This is used by journald to
>> add disk ID information to the journal entry.
> 
> 
>> This re-worked change is from a different patch series
>> and utilizes the following suggestions.
>>
>> - Reduce indentation level (Andy Shevchenko)
>> - Remove unneeded () for conditional operator (Sergei Shtylyov)
> 
> This should go as a changelog after the cutter '---' line...

Thanks, I'll correct this.


>> Signed-off-by: Tony Asleson <tasleson@redhat.com>
>> ---
> 
> ...somewhere here.
> 
> ...
> 
>> -       if (!test_bit(BH_Quiet, &bh->b_state))
>> -               printk_ratelimited(KERN_ERR
>> -                       "Buffer I/O error on dev %pg, logical block %llu%s\n",
>> -                       bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
>> +       struct device *gendev;
>> +
>> +       if (test_bit(BH_Quiet, &bh->b_state))
>> +               return;
>> +
> 
>> +       gendev = bh->b_bdev->bd_disk ?
>> +               disk_to_dev(bh->b_bdev->bd_disk) : NULL;
> 
> I'm not sure it's a good idea to print '(null)'.

I've not seen any cases where we end up with null here, but I've only
tested ATA, SCSI, and NVMe subsystems.

However, I would think that if this does occur it would be more obvious
that it's an issue that needs to be corrected if the null ends up in the
logs instead of having the same output that we have today?

> Perhaps
> 
> if (bh->b_bdev->bd_disk)
>   dev_err_ratelimit(disk_to_dev(bh->b_bdev->bd_disk), ...);
> else
>   pr_err_ratelimit(...);
> 
> ?
> 
>> +       dev_err_ratelimited(gendev,
>> +               "Buffer I/O error, logical block %llu%s\n",
> 
>> +               (unsigned long long)bh->b_blocknr, msg);
> 
> It's a u64 always (via sector_t), do we really need a casting?

That's a good question, grepping around shows *many* instances of this
being done.  I do agree that this doesn't seem to be needed, but maybe
there is a reason why it's done?

-Tony

