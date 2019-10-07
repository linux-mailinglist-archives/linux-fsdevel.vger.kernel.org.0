Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9D44CD9CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2019 02:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfJGAEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Oct 2019 20:04:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46157 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJGAEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Oct 2019 20:04:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id b8so748310pgm.13;
        Sun, 06 Oct 2019 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0OGHKPj+Wv5bJqZl+51TCg/isw7AhFW5RqOkp5nI8pY=;
        b=RbxYapSCPmtOvzif62cXaYKpWjbEj/Acwk/Pec1HgdvlFcj6qTE/b1FaaocjPpdZbI
         5RHuFu6c24q0fQG3/lVTrwMJopULCDK5xWD0SRCIVhjsAiYgkAj5bcYjrjQs9zgJ48JC
         NwHL4RG+EB9QWu4yH9rhlL6NCCJ4G8qt5i/2vr7nGzOCfP59oJSgktxzsXF7jVebT4q0
         nAzQ4OwKKZf2isV+MJtaE+55w4xv/Q4nH8+Tw1Eqrw57EMTGrxdmYDSakv2aBitfKu/m
         YXu1KSurW+vJx3mRDEuHKaLMOCh/2kJjFXXn23P5OehPGGTFNn2R74eoVEKHXw7e7vuC
         BiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0OGHKPj+Wv5bJqZl+51TCg/isw7AhFW5RqOkp5nI8pY=;
        b=lmeXznYnS093z+IJ6GcrA+Mn+jxnVsFy6i/bou0k88H0XaBYfrViVd34Zm1g20MgKo
         Gin121ykW7kXv9tZ/vzPk4rHZh0Trri8+cEMRqPObaSyAIqpa5OTRmKEwji78GkoHgpX
         vTATvw2ylHjpE9n9O4uNtwQBdLpqcW/fgPpdi7hYJG4w1T0vMOOduz47sKZGm0mDyUAG
         41owrh12S5lZfcJDpyFLv26z3yq4O4xES/SksVxNQUvJSti9WGguvLiysskPaqoyqubq
         69WqQfU0BUHsqz6A4iFNXQ2ZbhF6lLIYxa3KBgqBfRdPHfcyTZPC+y7MRvhGKSMagPMH
         GSOA==
X-Gm-Message-State: APjAAAV0U1rbVumfERnr3mEHt95PJs9FW2DkmevMqgviZbxHXHqR63q1
        98MCmDFz3X09BFmgQ7kZx7x/vhP2
X-Google-Smtp-Source: APXvYqxTcoktvi7Wqs0TBFmvZqRdSJTpKxwLszug0YozOpo72qXAHkhogNUlWB93Xo0nYv2fMRgJCA==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr30350725pfa.237.1570406652891;
        Sun, 06 Oct 2019 17:04:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y36sm2055693pgk.66.2019.10.06.17.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Oct 2019 17:04:11 -0700 (PDT)
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to
 unsafe_put_user()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20191006222046.GA18027@roeck-us.net>
 <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
Date:   Sun, 6 Oct 2019 17:04:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/6/19 4:35 PM, Linus Torvalds wrote:
[ ... ]

> Anyway, let me think about this, but just for testing, does the
> attached patch make any difference? It's not the right thing in
> general (and most definitely not on x86), but for testing whether this
> is about unaligned accesses it might work.
> 

All my alpha, sparc64, and xtensa tests pass with the attached patch
applied on top of v5.4-rc2. I didn't test any others.

I'll (try to) send you some disassembly next.

Guenter
