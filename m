Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5268236B29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 13:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhDZL6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbhDZL6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:58:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B710C061756;
        Mon, 26 Apr 2021 04:57:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id B19EE1F41ED5
Subject: Re: [PATCH] generic/453: Exclude filenames that are not supported by
 exfat
To:     Matthew Wilcox <willy@infradead.org>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        krisman@collabora.com, preichl@redhat.com, kernel@collabora.com
References: <20210425223105.1855098-1-shreeya.patel@collabora.com>
 <20210426003430.GH235567@casper.infradead.org>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <a49ecbfb-2011-0c7c-4405-b4548d22389d@collabora.com>
Date:   Mon, 26 Apr 2021 17:27:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210426003430.GH235567@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 26/04/21 6:04 am, Matthew Wilcox wrote:
> On Mon, Apr 26, 2021 at 04:01:05AM +0530, Shreeya Patel wrote:
>> exFAT filesystem does not support the following character codes
>> 0x0000 - 0x001F ( Control Codes ), /, ?, :, ", \, *, <, |, >
> ummm ...
>
>> -# Fake slash?
>> -setf "urk\xc0\xafmoo" "FAKESLASH"
> That doesn't use any of the explained banned characters.  It uses 0xc0,
> 0xaf.
>
> Now, in utf-8, that's an nonconforming sequence.  "The Unicode and UCS
> standards require that producers of UTF-8 shall use the shortest form
> possible, for example, producing a two-byte sequence with first byte 0xc0
> is nonconforming.  Unicode 3.1 has added the requirement that conforming
> programs must not accept non-shortest forms in their input."
>
> So is it that exfat is rejecting nonconforming sequences?  Or is it
> converting the nonconforming sequence from 0xc0 0xaf to the conforming
> sequence 0x2f, and then rejecting it (because it's '/')?
>

No, I don't think exfat is not converting nonconforming sequence from 
0xc0 0xaf
to the conforming sequence 0x2f.
Because I get different outputs when tried with both ways.
When I create a file with "urk\xc0\xafmoo", I get output as "Operation 
not permitted"
and when I create it as "urk\x2fmoo", it gives "No such file or 
directory error" or
you can consider this error as "Invalid argument"
( because that's what I get when I try for other characters like |, :, 
?, etc )

Box filename also fails with "Invalid argument" error.


