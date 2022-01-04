Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E8484764
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 19:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiADSEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 13:04:15 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:43254 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiADSEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gQt+rsQM2B7+yEGYuuKhCQquw5+qO0kTX2uHBXUI904=; b=kdEqKQB6hlKRYbeVXE/Xa0r/vi
        QSuS/8K5Lx/wy6dDYwEjQPE9CVIiSoP1fupEeKKvT67w83NGtO7LOujyggqmgJo8ayvLCCtN9DSYB
        x7tUMXJM8PdUjzlVKtc5fKorLPFHGym3XuzKQOUJZaoeZuJRjRnewEcxtrx7aqj5FOgKcjuGI6kmV
        8PhALYlsb/KPOy3t6lcMdDyFpk20a/wBqYdzZRRuplOcuhzUOnJow/mh5P5jWigwb++HLnBgPCxFx
        +k74jDFDsEVI0FKDAuHmVIJiVSZ+r+0eSq8DUuZn+7Lbc/8r4gNFvJ36qbfjKehOWoS8W9UuYupRl
        e9C+ck8A==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n4oAL-0009Yn-2h; Tue, 04 Jan 2022 19:04:09 +0100
Subject: Re: pstore/ramoops - why only collect a partial dmesg?
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
 <2d1e9afa38474de6a8b1efc14925d095@intel.com>
 <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
 <a361c64213e7474ea39c97f7f7bd26ec@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <c5a04638-90c2-8ec0-4573-a0e5d2e24b6b@igalia.com>
Date:   Tue, 4 Jan 2022 15:03:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a361c64213e7474ea39c97f7f7bd26ec@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/01/2022 14:00, Luck, Tony wrote:
> [...] 
> Guilherme,
> 
> Linux is indeed somewhat reluctant to hand out allocations > 2MB. :-(
> 
> Do you really need the whole dmesg in the pstore dump?  The expectation
> is that systems run normally for a while. During that time console logs are
> saved off to /var/log/messages.
> 
> When the system crashes, the last part (the interesting bit!) of the console
> log is lost.  The purpose of pstore is to save that last bit.
> 
> So while you could add code to ramoops to save multiple 2MB chunks, it
> doesn't seem (to me) that it would add much value.
> 

Thanks again Tony, for the interesting points. So, I partially agree
with you: indeed, in a normal situation we have all messages collected
by some userspace daemon, and when some issue/oops happens, we can rely
on pstore to collect the latest portion of the log buffer (2M is a
bunch!) and "merge" that with the previously collected portion, likely
saved in a /var/log/ file.

The problem is that our use case is a bit different: the idea is to rely
on pstore/ramoops to collect the most information we can in a panic
event, without the need of kdump. The latter is a pretty
comprehensive/complete approach, but requires a bunch of memory reserved
- it's a bit too much if we want just the task list, backtraces and
memory state of the system, for example. And for that...we have the
"panic_print" setting!

There lies the issue: if I set panic_print to dump all backtraces, task
info and memory state in a panic event, that information + the
panic/oops and some previous relevant stuff, does it all fit in the 2M
chunk? Likely so, but *if it doesn't fit*, we may lose _exactly_ the
most important piece, which is the panic cause.

The same way I have the "log_buf_len" tuning to determine how much size
my log buffer has, I'd like to be able to effectively collect that much
information using pstore/ramoops. Requiring that amount of space in an
efi-pstore, for example, would be indeed really crazy! But ramoops is
just a way for using some portion of the system RAM to save the log
buffer, so I feel it'd be interesting to be able to properly collect
full logs there, no matter the size of the logs. Of course, I'd like to
see that as a setting, because the current behavior is great/enough for
most of users I guess, as you pointed, and there's no need to change it
by default.

Let me know your thoughts and maybe others also have good opinions about
that!
Cheers,


Guilherme
