Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB0729E22A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgJ1VhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgJ1VhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921027;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uR9Z8bMBXR69RPlglBm0bN7dgJ7Q6KSE6tN4OWKsw1w=;
        b=V3Vnqo3W69x91ljxkR0jPyDbQTKf77z01Rjeo722S5rybm68BbXSjRt4hLtkqk0R5CjeqX
        Wf9drefsglZ9TJk+CM7PIYTtI7T+LFyp0xIu4XDgC4yEjzLNkNgzcdSyMCMt2rxlCoEyxZ
        7mDZuYjdaOTUyC58AArIf31DyQr+GdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-89meDqHMPlOcnmzl5Dv72Q-1; Wed, 28 Oct 2020 17:05:39 -0400
X-MC-Unique: 89meDqHMPlOcnmzl5Dv72Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835BE64152;
        Wed, 28 Oct 2020 21:05:38 +0000 (UTC)
Received: from [10.10.112.242] (ovpn-112-242.rdu2.redhat.com [10.10.112.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEFA25C1D0;
        Wed, 28 Oct 2020 21:05:37 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [PATCH] buffer_io_error: Use dev_err_ratelimited
From:   Tony Asleson <tasleson@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201026155730.542020-1-tasleson@redhat.com>
 <CAHp75Vfno9LULSfvwYA+4bEz4kW1Z7c=65HTy-O0fgLrzVA24g@mail.gmail.com>
 <71148b03-d880-8113-bd91-25dadef777c7@redhat.com>
Organization: Red Hat
Message-ID: <ec93ba9e-ead9-f49a-d569-abf4c06a60eb@redhat.com>
Date:   Wed, 28 Oct 2020 16:05:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <71148b03-d880-8113-bd91-25dadef777c7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/28/20 3:45 PM, Tony Asleson wrote:
> On 10/26/20 5:07 PM, Andy Shevchenko wrote:

>>> +       dev_err_ratelimited(gendev,
>>> +               "Buffer I/O error, logical block %llu%s\n",
>>
>>> +               (unsigned long long)bh->b_blocknr, msg);
>>
>> It's a u64 always (via sector_t), do we really need a casting?
> 
> That's a good question, grepping around shows *many* instances of this
> being done.  I do agree that this doesn't seem to be needed, but maybe
> there is a reason why it's done?

According to this:

https://www.kernel.org/doc/html/v5.9/core-api/printk-formats.html

This should be left as it is, because 'sector_t' is dependent on a
config option.

-Tony

