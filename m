Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B24179A00C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 23:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjIJVQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 17:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIJVQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:16:02 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91114188
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 14:15:58 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34f6fd04fbeso2293575ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Sep 2023 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694380558; x=1694985358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2Q/e9FABMnbJiVlA+l81WIj96q3GIBpGDriFNDSINE=;
        b=oTnmIY/RyxS7XMTVDen+JQclmSsLbtYHxQCxINH3F/H3ZD8ZwpPFMyUZI8PefaPmMS
         YhjfAYgrB7uodDB4gUG9tyww3qtehUec/vDzk9am7cRWuliBEgAjQByfZYE8T9MvZE4u
         pHhETZ52TRq7Dei8LnqRy2mMIkxKUFaM7bWLd60oOumohFZIPqq46ibOctuguoTqZdno
         FJc0zgct8NmxqfjpoBKPHjc1PA0XNXnOn3fSaw6d2Zh7HoFvuQStS0fQ4mCi3/jaJPYw
         P6ItAZGvcX2QO/mw9gYeHRQrNYnbwcT3wAEiZBIj02LGNf1E4NWVgjJZxja6jvQBeRYD
         3cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694380558; x=1694985358;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2Q/e9FABMnbJiVlA+l81WIj96q3GIBpGDriFNDSINE=;
        b=mHUjNPDaB00IcoDG4j9dj0K9t0Ulv7qztk6GLwquhp0HWeVkYK7s38Pm8cROTukwLa
         WvNW8AyzjXj/jV/vnPh+Qe5/b73ulwezSoeDXSO9pvwwGxN8bFc8G9XpXu6f0hnjn/bm
         b5JS4ofGGg6b20CaYsHkbQOxDhVJJywv8HhB5mLkjQ3gucTqVRLoa9AwnrfP8b3wTVfy
         qV+S4FbPpze+K8vLNZafhx2pHqy7sxX86XLIg2kf/TD5R+V+ixVBv9oJukQKAwB1brrr
         HIpnryYnaLzCqhcsam63x0Vb+Dqu4aaoLoueywSfoftM+VGdskQceVqGNtBPR6D70L44
         Qeng==
X-Gm-Message-State: AOJu0YzIASaskn4uDpKWlEaxv6sV00atsD/z5OkRmcCJQWCIQY9BsAOm
        qVIuYuCSreIfwOvb+vhSKi4HBlDfaOE=
X-Google-Smtp-Source: AGHT+IFtKQJRJu52kvtK9rfE/b719WGZQk49SrRB/+aJebwSdzUOAU+xIeNZ0r5sx5aWue8JxLaDag==
X-Received: by 2002:a05:6e02:2198:b0:34f:1e9c:45d5 with SMTP id j24-20020a056e02219800b0034f1e9c45d5mr10700253ila.32.1694380557679;
        Sun, 10 Sep 2023 14:15:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j18-20020a056e02015200b0034989674ad7sm1898093ilr.52.2023.09.10.14.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 14:15:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b1765a8-3c3a-d4eb-0561-11c67570c92b@roeck-us.net>
Date:   Sun, 10 Sep 2023 14:15:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <ZPyS4J55gV8DBn8x@casper.infradead.org>
 <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
In-Reply-To: <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/23 12:51, James Bottomley wrote:
[ ... ]
>> I think that's a red herring.  Of course there are advances in
>> virtual hardware for those who need the best performance.  But
>> there's also qemu's ability to provide to you a 1981-vintage PC (or
>> more likely a 2000-era PC).  That's not going away.
> 
> So Red Hat dropping support for the pc type (alias i440fx)
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1946898
> 
> And the QEMU deprecation schedule
> 
> https://www.qemu.org/docs/master/about/deprecated.html
> 
> showing it as deprecated after 7.0 are wrong?  That's not to say
> virtualization can't help at all; it can certainly lengthen the time
> horizon, it's just not a panacea.

deprecated.html says:

pc-i440fx-1.4 up to pc-i440fx-1.7 (since 7.0)
           ^^^                 ^^^
These old machine types are quite neglected nowadays and thus might have
various pitfalls with regards to live migration. Use a newer machine type
instead.

Unless the qemu documentation is severely misleading, that does not
include pc-i440fx-{2-8}.{0-12}, and there is no indication that the
machine type "pc" (current alias of pc-i440fx-8.1) has been deprecated.

Guenter

