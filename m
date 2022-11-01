Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FF86151EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 20:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiKATIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKATIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:08:38 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5971CB10;
        Tue,  1 Nov 2022 12:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jGncNr+9QNlZo8KXg5MhbyqFcoA2B/B8tn3r4W46zCo=; b=QGLbK3TqSGIgV6+ibdyEazKkxW
        wzyCjmU5KFnPpK3fsg2FYAUAnPmorKDa/+aCWVuUxcT8ypNsGLZeAofIEX5dA+KMg2IdxUBDlyvEN
        Lu4+OSFy0gKKUXmgzH7eTru+QfRjQ+QKMxdQj4Uq6ZTFA///u8Fr5vK8334ynI7TRz5obOtaIbaVb
        2e3jz8cog2MwAtA/U1fQ2P+QvYIShFITpbDadZgjNGkmV3nEy49UHY3cK4hCbdnv0zMtpDrVTTnbj
        fM0AedKv4lixUmpCRJX1vx4Rcd4eG+79jxDwPlObrNoRasSgt+hdEPdr3Yv7Y6jql6cLwzPQ6HEbi
        5GSBGEdg==;
Received: from [177.102.148.33] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1opwck-00AT4B-AT; Tue, 01 Nov 2022 20:08:34 +0100
Message-ID: <69a6f69f-fd4c-f6cf-f56a-efcf6dc2db93@igalia.com>
Date:   Tue, 1 Nov 2022 16:08:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 2/8] pstore: Expose kmsg_bytes as a module parameter
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-3-gpiccoli@igalia.com> <202210061628.76EAEB8@keescook>
 <267ccf8f-1fea-7648-ec2b-e7f4ae822ae4@igalia.com>
 <202210120958.37D9621E8C@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210120958.37D9621E8C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kees, my apologies for the (big) delay in answering that! I kept it
marked to respond after tests, ended-up forgetting, but now did all the
tests and finally I'm able to respond.


On 12/10/2022 14:58, Kees Cook wrote:
> [...]
>> I didn't understand exactly how the mount would override things; I've
>> done some tests:
>>
>> (1) booted with the new kmsg_bytes module parameter set to 64k, and it
>> was preserved across multiple mount/umount cycles.
>>
>> (2) When I manually had "-o kmsg_bytes=16k" set during the mount
>> operation, it worked as expected, setting the thing to 16k (and
>> reflecting in the module parameter, as observed in /sys/modules).
> 
> What I was imagining was the next step:
> 
> (3) umount, unload the backend, load a new backend, and mount it
>     without kmsg_bytes specified -- kmsg_bytes will be 16k, not 64k.
> 
> It's a pretty extreme corner-case, I realize. :) However, see below...

Oh okay, thanks for pointing that! Indeed, in your test-case I've faced
the issue of the retained kmsg_bytes...although, I agree it's an extreme
corner-case heheh



> [...]
> Right, kmsg_bytes is the maximum size to save from the console on a
> crash. The design of the ram backend was to handle really small amounts
> of persistent RAM -- if a single crash would eat all of it and possibly
> wrap around, it could write over useful parts at the end (since it's
> written from the end to the front). However, I think somewhere along
> the way, stricter logic was added to the ram backend:
> 
>         /*
>          * Explicitly only take the first part of any new crash.
>          * If our buffer is larger than kmsg_bytes, this can never happen,
>          * and if our buffer is smaller than kmsg_bytes, we don't want the
>          * report split across multiple records.
>          */
>         if (record->part != 1)
>                 return -ENOSPC;
> 
> This limits it to just a single record.

Indeed, and I already considered that in the past...why was that
restricted to a single record, right? I had plans to change it, lemme
know your thoughts. (Reference:
https://lore.kernel.org/linux-fsdevel/a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com/)



> However, this does _not_ exist for other backends, so they will see up
> to kmsg_bytes-size dumps split across psinfo->bufsize many records. For
> the backends, this record size is not always fixed:
> 
> - efi uses 1024, even though it allocates 4096 (as was pointed out earlier)
> - zone uses kmsg_bytes
> - acpi-erst uses some ACPI value from ACPI_ERST_GET_ERROR_LENGTH
> - ppc-nvram uses the configured size of nvram partition
> 
> Honestly, it seems like the 64k default is huge, but I don't think it
> should be "unlimited" given the behaviors of ppc-nvram, and acpi-erst.
> For ram and efi, it's effectively unlimited because of the small bufsizes
> (and the "only 1 record" logic in ram).
> 
> Existing documentation I can find online seem to imply making it smaller
> (8000 bytes[1], 16000 bytes), but without justification. Even the "main"
> documentation[2] doesn't mention it.

Right! Also, on top of that, there is a kind of "tricky" logic in which
this value is not always respected. For example, in the Steam Deck case
we have a region of ~10MB, and set record size of the ramoops backend to
2MB. This is the amount collected, it doesn't respect kmsg_bytes, since
it checks the amount dumped vs kmsg_bytes effectively _after_ the first
part is written (which in the ramoops case, it's a single write), hence
this check is never "respected" there. I don't consider that as a bug,
more a flexibility for the ramoops case heh

In any way, lemme know if you want to have a "revamp" in the meaning of
kmsg_bytes, I'd be glad in discuss/work on that =)

Thanks,


Guilherme
