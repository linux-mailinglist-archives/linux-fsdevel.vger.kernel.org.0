Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C479EFAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjIMQ7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjIMQ7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:59:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300B3586
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:58:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fb7074348so3561265b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624339; x=1695229139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VhP70vpj5PWFB+iYZacvcg8zeDYG8Ksg0ttAfb+9X8o=;
        b=SdKAVvDbn9LWrufA9SdBaQxcIRabwlEfcIKj6MflobuYrd80Kw2QUGbFgotvTwu6G/
         /XZNJ8HBVVfytO9ujDIzJaWoqPSM89oqgbAGd26bd1ZRAeCs3vKZPt7gTugup11yAjgw
         w1cNaTHck1bCovE5Hb6MbO5bKDm4oHtkrefNfr0e5GDXR+1CsyYLLLF4HieoFZkZlB6n
         wLWNMOIoB8TX+p7XzD4w5+O2r5+Ramq+FCVKCYRB1yw/S7xPvGekAHxSv4kWX0P8d46N
         fXKtBJOVhJf/1C7OwMeqtsuKfRKgwNTOhLlIvvLRwmDuQgiuueOLj+m5EQiHmKnu0aRy
         goPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624339; x=1695229139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhP70vpj5PWFB+iYZacvcg8zeDYG8Ksg0ttAfb+9X8o=;
        b=JURA/gNNLzk8sqC/0ncruUo3LmRG06vF0ofj/bDF4j8uWhH3Dl81m4yCq1zj7V/8/w
         2EIfR2rA3uJPIEow4BjQ/srmfT2qfZ4t17sJGlybGzGfSIIGngt15pmlXc90zAMabZFX
         IoZWbEC9CCMPI8iix+o1u6ddAzjB3hglVeZK9u2YeXpeWjD+w3Q2GF/8YkdMzRhOXXUS
         9u9DhTWkrFdTYVzqLw8eQvB7zHI5/RttqOTr4qb5ED3LPjEvmtxyRZsLeUMSgCO4TGY+
         yh58DChqjQZSrO5ppESf2LsrMPIdRXQcU9654iATNc5DmPtBh5fv24nv2vv4+CCxYbCT
         PcQQ==
X-Gm-Message-State: AOJu0Yw7D0XL3VFIXcWVBtkL6KVM7DLsTn4WaVSmOUGJ6qRe72kJuyZb
        ccNTcUcr9eAa0dxW/646NqA=
X-Google-Smtp-Source: AGHT+IEdNGA7PfuA3xFF1w8R7AbLW+d4wMBhhxXFmjkkmb8MK8Uh2by7i6flZmzYEosSJae2BQExGQ==
X-Received: by 2002:a05:6a20:4327:b0:13f:1622:29de with SMTP id h39-20020a056a20432700b0013f162229demr3210638pzk.7.1694624338645;
        Wed, 13 Sep 2023 09:58:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n23-20020aa79057000000b0068782960099sm262425pfo.22.2023.09.13.09.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:58:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3fb55cc7-8c50-2ba1-3e51-483b19a66f91@roeck-us.net>
Date:   Wed, 13 Sep 2023 09:58:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Content-Language: en-US
To:     Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/13/23 09:43, Eric Sandeen wrote:
> On 9/7/23 6:18 AM, Steven Rostedt wrote:
>> On Thu, 7 Sep 2023 13:38:40 +1000
>> Dave Chinner <david@fromorbit.com> wrote:
>>
>>> Hence, IMO, gutting a filesystem implementation to just support
>>> read-only behaviour "to prolong it's support life" actually makes
>>> things worse from a maintenance and testing persepective, not
>>> better....
>>
>>  From your other email about 10 years support, you could first set a fs to
>> read-only, and then after so long (I'm not sure 10 years is really
>> necessary), then remove it.
>>
>> That is, make it the stage before removal. If no one complains about it
>> being read-only after several years, then it's highly likely that no one is
>> using it. If someone does complain, you can tell them to either maintain
>> it, or start moving all their data to another fs.
>>
>> For testing, you could even have an #ifdef that needs to be manually
>> changed (not a config option) to make it writable.
> 
> This still sounds to me like /more/ work for developers and testers that
> may interact with the almost-dead filesystems, not less...
> 
> I agree w/ Dave here that moving almost-dead filesystems to RO-only
> doesn't help solve the problem.
> 
> (and back to syzbot, it doesn't care one bit if $FOO-fs is readonly in
> the kernel, it can still happily break the fs and the kernel along with it.)
> 
> Forcing readonly might make users squawk or speak up on the way to
> possible deprecation, but then what? I don't think it reduces the
> maintenance burden in any real way.
> 
> Isn't it more typical to mark something as on its way to deprecation in
> Kconfig and/or a printk?
> 

I think that commit eb103a51640e ("reiserfs: Deprecate reiserfs") is a perfect
and excellent example for how to do this.

Guenter

