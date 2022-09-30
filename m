Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709705F1050
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiI3QyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiI3QyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:54:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F071D849C;
        Fri, 30 Sep 2022 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664556837;
        bh=ldg00G/wOIf7Qazf8S9AtlVvQqdt/1Q1UHQGxZlMAfU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dtvC2lxm4XY+waJRyTPKDh8o7AqtSxi/mqumk5ku35/hW+3uh/a8GtBVkBeV1cZLt
         YiiVX2ETdvxdjsWBhMdC83M9S7xj70phyNZNKs5oAWSRos+WS6j7dZVj/PUOt/5eMF
         Qgc743ru8Jjgooq+Xmgqyoab7Hn+M6HvrQ3fSDqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.174]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1oW4zr1rxO-00Cfc7; Fri, 30
 Sep 2022 18:53:57 +0200
Message-ID: <db7bdf7a-597f-398e-9877-01e898733664@gmx.de>
Date:   Fri, 30 Sep 2022 18:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
 <Yzb7Oh2Y8feej+Eh@alley>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <Yzb7Oh2Y8feej+Eh@alley>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aBlMY1mOVOI1dI1ab3QDjCUN0O+T72bechUGsrQ2kel+bzopEPw
 2sAUdeM/uWL6UZjE3QV/86EnRurXVWiTW9ZN3vzVXlLfeYV1oyNIod1hIkkkT/QiOcba+Gc
 FJffe6z4FFvuKQWG2uORErUXpg2hUxVItE/HOiUd+E7jwAVWh/vk/jCuTV7aVEqHZf/tEmS
 htfdSzdkp6/LN/NZcuehA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GoAoyRdZj6M=:OU0n8XiVPN+0X77mAvLulg
 JMNTFz0sjMpTIpgFEY4Wxxu2SkfiXz+9l9oWwsmR2c5+zhANSl2PANxOwGOaxtG4gHD6NJH6v
 ca+5UHmSmcQhCGiIXkJtrzXWEqSagoLZIRBjf+Px7x1QfTveQYvxs0Tio7txJVnprXAGjO1K/
 1F7rh0GhXv+dqwTeKr2mlAw9PK22xz1UaHECRnGtDRCMg4bS9hZEi1vPgZo2GEfLffNT/ThxI
 MxatXx7rro5GgUJgLh+NkmojA4jBry0ihN9LL/KBKOzh4vcfhnFnuD5JQHT2nYW7hXuJwrhnn
 dc8gIefMqqIfbktQyK3L6JpH7TPYjI2fcexcWmiTFy15kh+tmcvbuX1luUMcXLDUOfcQgZnjr
 Ky442hsRqatwI5bQwTGsaaymvghIXW613GaPG06lCvLRZrmZ/LJUBhS7kOln1+gRme/fa/TuO
 oLKjR4yB+8potCjdP/ypB2XbwoMxbcfvYbqlrR5Ilo4xC00vIYM6KPhIZer1TGsAFni2antqG
 dgc4Ua6YjvoXJwqtGL7zj/a3IPofpU4xPV2N1P+6/+0vSwYM3N1fkaO5MqC2AB1kUBud9t+4J
 nhYwtsslNbgMGs3CcceV9mJ4d1zK7IzYXeiZ6iaDhuaPsUyKdMtxhwmvdL7bXvJVjZToQkfOf
 5av/xyVoepIn/UrrExIcFi8Ji5L7gBQaQQuUinVycwnRKaDb4izzWXv/NlRUvQvR1FN4vLs6N
 ai/W4WsS3fwnqlZWftl2axYeDywN0qFM7YakxBXww3uflYRm3o8TRWtPbTqkvp8iHbYsYuYhY
 7sNlb1P65WRnqbdPzuEAA53HPjuRA0aD1j5vYArq0v5fAvfKqKS/9AjJ/vMOch7ptAY1FgqWU
 dAgGlQMn1RWaucwsnq0H/BwaiqhUxHba1Fx3cknxCaek0Sd0RIsbUyvdq0sYwFbj4n1MqSY76
 Xj62d/j+WqeIOHkIHDmQcdG5wrV4QTGF88CAXlsFIXgeOxv+uZI3FkxLNtobJXYIHMipwXQ3p
 NwUCwuf84pAJmHIe1eeav9ptjh3sXBwDcgJUTQBkwwC5LoVDEVxgh0z+R7QPC6vnYtAlLi4Ox
 JmXd5c+QtZXg8hG0yylsh4XXHsU2LZfFaTKt+jq2zoFy2Ac326G96hqYrPLsjEqynSCQ19hBT
 23oWB9GsWeoWjeVdGi2zkL8eAN
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/30/22 16:20, Petr Mladek wrote:
> On Sat 2022-09-24 02:10:47, John Ogness wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> Replace the open coded single linked list with a hlist so a conversion =
to
>> SRCU protected list walks can reuse the existing primitives.
>>
>> --- a/arch/parisc/kernel/pdc_cons.c
>> +++ b/arch/parisc/kernel/pdc_cons.c
>> @@ -272,15 +267,17 @@ void pdc_console_restart(bool hpmc)
>>   	if (pdc_console_initialized)
>>   		return;
>>
>> -	if (!hpmc && console_drivers)
>> +	if (!hpmc && !hlist_empty(&console_list))
>>   		return;
>>
>>   	/* If we've already seen the output, don't bother to print it again =
*/
>> -	if (console_drivers !=3D NULL)
>> +	if (!hlist_empty(&console_list))
>>   		pdc_cons.flags &=3D ~CON_PRINTBUFFER;
>>
>> -	while ((console =3D console_drivers) !=3D NULL)
>> -		unregister_console(console_drivers);
>> +	while (!hlist_empty(&console_list)) {
>> +		unregister_console(READ_ONCE(hlist_entry(console_list.first,
>> +							 struct console, node)));
>
> The READ_ONCE() is in a wrong place. This is why it did not compile.
> It should be:
>
> 		unregister_console(hlist_entry(READ_ONCE(console_list.first),
> 						struct console,
> 						node));
>
> I know that it is all hope for good. But there is also a race between
> the hlist_empty() and hlist_entry().

I wonder if pdc_console() is still needed as it is today.
When this was written, early_console and such didn't worked for parisc
as it should. That's proably why we have this register/unregister in here.

Would it make sense, and would we gain something for this printk-series,
if I'd try to convert pdc_console to a standard earlycon or earlyprintk de=
vice?

Helge
