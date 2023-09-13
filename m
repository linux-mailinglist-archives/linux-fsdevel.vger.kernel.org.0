Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B8779EF65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjIMQvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIMQvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:51:54 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 09:51:50 PDT
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77D5FDC
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:51:50 -0700 (PDT)
Received: from [10.0.0.71] (liberator.sandeen.net [10.0.0.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 49094B4F;
        Wed, 13 Sep 2023 11:43:56 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 49094B4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
        s=default; t=1694623436;
        bh=EvcgROoSev0pcQW1Oyo3IhLaJtsOie/yH7zcZ0b+Fq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=s5EI+/bfYDYSB5+8dGyH1FPB2/zqA2w3EGbb3xNZDb8FV7AX6FAPVc0p5ypAFhLLE
         KapKtjtOE9RmV2DcdyzdMtbG0CX1mjsD4L0GTmybNYAwF2Yyc/ZPFxNFeyuS3KvzLO
         ZlFOa/ONqpn+EEAdb11HnmH3tzpUSM2UsFEbD/0bZuXe63E/Ol8/M02CHhLZYNpgvu
         U4pzex2CXi9hJaqTsMt4azB/F4CPCP/ZBqGb6+UcMK3LW4jNeb6+8R0ygXPv0IJL6T
         rhTBEx+j0p63NbbDJY5t28lyL0zqSG0q+5lJFn9V6bUAfrxMoD6Sd6MgGQ6T+0hQSw
         yqVsV4u0iFI0g==
Message-ID: <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
Date:   Wed, 13 Sep 2023 11:43:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
From:   Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20230907071801.1d37a3c5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/23 6:18 AM, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 13:38:40 +1000
> Dave Chinner <david@fromorbit.com> wrote:
> 
>> Hence, IMO, gutting a filesystem implementation to just support
>> read-only behaviour "to prolong it's support life" actually makes
>> things worse from a maintenance and testing persepective, not
>> better....
> 
> From your other email about 10 years support, you could first set a fs to
> read-only, and then after so long (I'm not sure 10 years is really
> necessary), then remove it.
> 
> That is, make it the stage before removal. If no one complains about it
> being read-only after several years, then it's highly likely that no one is
> using it. If someone does complain, you can tell them to either maintain
> it, or start moving all their data to another fs.
> 
> For testing, you could even have an #ifdef that needs to be manually
> changed (not a config option) to make it writable.

This still sounds to me like /more/ work for developers and testers that
may interact with the almost-dead filesystems, not less...

I agree w/ Dave here that moving almost-dead filesystems to RO-only
doesn't help solve the problem.

(and back to syzbot, it doesn't care one bit if $FOO-fs is readonly in
the kernel, it can still happily break the fs and the kernel along with it.)

Forcing readonly might make users squawk or speak up on the way to
possible deprecation, but then what? I don't think it reduces the
maintenance burden in any real way.

Isn't it more typical to mark something as on its way to deprecation in
Kconfig and/or a printk?

-Eric

