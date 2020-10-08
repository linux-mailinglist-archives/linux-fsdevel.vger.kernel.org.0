Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA292876B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 17:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgJHPG6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbgJHPG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 11:06:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702EC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 08:06:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o17so908385ioh.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxKtwUQfrtFYgPTxfC0Fr3xXNcfRnpRDzLAYbyjbzuM=;
        b=Gzcc57vRbr6VO4vEeBUtqil9Id3YUAK5ngOU2/LVbUCIgmxdivLIOnF+tE/ko9lDyQ
         dQISWMxo+FS4G6+N6GAhoZzeAm6F6gMVpE2fDBuDcbdhwUjzY7e5wibddcOjzIB17W50
         lyZv9z8nRRfNnz6FRvrdISVO65gmX8l7fk0gq2TK2qr6AMaioseYYjGGbG4qy8T3YY1o
         LT8eF3CC6HHsEdRKxCpj4yyN7WttblXGSo807j+sKPBC16+2OL+DtA3sapp/1oG/5zkJ
         PX1L8O7y0KWY6Krm+WFhvA+boEykxr3dbga4GF44LpxrIAsAJHG2+fYI44Ol+9Yduqgl
         EUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZxKtwUQfrtFYgPTxfC0Fr3xXNcfRnpRDzLAYbyjbzuM=;
        b=eWRff4aStJWAqKclE5AjZ7xurrEgpHMogCMGXxNhTQ3AolQNUAoIO3Tkoc6fAfVyCK
         ZDXncNJGbdo0EphEqz5XHMp+UcyDInrUIyY1dPnaeG6l7pyrz+WrtCvZ6dyAIdKA/Vhl
         1SUriBJoAsPkH+av9vTQ4OjREFdYraa/LSGTWWS31tkiWl8A5S2LNnYqVu5pFxWeiD6B
         7HfuV0oo9emPt3RpAdHSLeRcrKTjZRgGWZhXEHKCb7vUPiCZFTNFw34TgixteQUSiF78
         2lTdb1zbAsT7b1q1ZqxGO7MbhshSOz+c9gm1wx3wxar6Z1iDpK8wbGWWzYInknPjrYaO
         LpIA==
X-Gm-Message-State: AOAM531BDfO42WB0b/qLt4rMEzeEesdoGRBrow4nxBWX7vwENBDDnamb
        0eWiQMwrdinSbTmfNkNXm93lgQ==
X-Google-Smtp-Source: ABdhPJzh6GEeDAHNvf2NyuZLqbKGR56JcQdByd83UwZQfjgGYtgahxjk2v32Dj59boxf4SP+dAu9fw==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr6262905ioc.21.1602169617117;
        Thu, 08 Oct 2020 08:06:57 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c8sm601392ils.50.2020.10.08.08.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 08:06:56 -0700 (PDT)
Subject: Re: inconsistent lock state in xa_destroy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000045ac4605b12a1720@google.com>
 <de842e7f-fa50-193b-b1d7-c573e515ef8b@kernel.dk>
 <20201008150518.GG20115@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ecfb657e-91fe-5e53-20b7-63e9e6105986@kernel.dk>
Date:   Thu, 8 Oct 2020 09:06:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008150518.GG20115@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 9:05 AM, Matthew Wilcox wrote:
> On Thu, Oct 08, 2020 at 09:01:57AM -0600, Jens Axboe wrote:
>> On 10/8/20 9:00 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    e4fb79c7 Add linux-next specific files for 20201008
>>> git tree:       linux-next
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=12555227900000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=568d41fe4341ed0f
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=cdcbdc0bd42e559b52b9
>>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com
>>
>> Already pushed out a fix for this, it's really an xarray issue where it just
>> assumes that destroy can irq grab the lock.
> 
> ... nice of you to report the issue to the XArray maintainer.

This is from not even 12h ago, 10h of which I was offline. It wasn't on
the top of my list of priority items to tackle this morning, but it
is/was on the list.

-- 
Jens Axboe

