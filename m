Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7D5505DB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 17:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiFRPqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbiFRPqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:46:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77FDFE6
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 08:46:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so6221569plg.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8xQ7lMuzExHtz2ku3JLAWvRJax2ANV2IpJANxV6Hy88=;
        b=vhcYKAeAkQLyl/+kumsqQ1SfUdZqMx0bODI+i3pyokmzLJ120CuXzsBPFrDzyREnO/
         asBVsK9f3h5/U5erizjL0CBDAvoL+90vxJlXH6H1RPSQKklx2Kn0IHruOkaX0sC1ld1E
         HxP/HdyyoHr5DUd23p4HU9VR14s9vg7GS7iz/sS7OeuOXCoHho0Kq3ddC+tcaPp+qk3y
         7N6LE8x69fRbdxpXJc7st1Qh9u8/ppVU1dmNGJEbh99GqjL0ybZYjtiW3jawUsJEVg+F
         FRXwEOwlHn7VGQ/KfuKvhG0y0As4k/k6NAreBxOYIn7V6eExoqap68h4tm+u3KLYm9sa
         cXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8xQ7lMuzExHtz2ku3JLAWvRJax2ANV2IpJANxV6Hy88=;
        b=g8RyBgCv9YKN/MiNMgr8Ii2MlnpWqeK3J5ZB7ux8ZNHUGbMa7zz3xBkXz6vIT4HyaC
         9zTNer89CuWU4ElL2gk/Fh5Drb9xe8yzsEPf+A4BtPYLIrcgbFBvXVjD2mnVxazS8Reh
         9XQ1AD+2Rv4jfCNIRumtGA915PSTu4x685yNAznXFJ0cbWoEmGpRtZ0mA8FvxuqGRGiC
         yXBU2YeKrJhrQUeUh+9Bv2BMud4rrND59gM+PG3a9oH29GQcttIviDYnU0F4NjX+OL3s
         ZOCpwclSUmVWz2TNUU1FUQhwBv4ymZSJ4MQEu5N3RIKAShrB611C8/cpyB2JOjAwrrU3
         ukqw==
X-Gm-Message-State: AJIora+S/pnQPlCXbxqCAT/noQS6fuxT5aHNjIoogpmtaATRwgi35YdV
        Smq8YfZq+mCv/KZQ4NxZaY9pLu/4g6YLHQ==
X-Google-Smtp-Source: AGRyM1u08ywN8H2MHkb8p/93ZFTsuddSHk4s2j6aalD1g1TWxZpBX+rggN0pq2LwSXlP4+mUwk6DuQ==
X-Received: by 2002:a17:90a:6602:b0:1e3:17e:6290 with SMTP id l2-20020a17090a660200b001e3017e6290mr17025294pjj.37.1655567181758;
        Sat, 18 Jun 2022 08:46:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z28-20020a62d11c000000b0052517150777sm455617pfg.41.2022.06.18.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 08:46:20 -0700 (PDT)
Message-ID: <d915ea59-f2f6-3400-57d6-29ad9f56c007@kernel.dk>
Date:   Sat, 18 Jun 2022 09:46:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC] iov_iter: import single segments iovecs as ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <b3e19eb1-18c4-8599-b68d-bf28673237d1@kernel.dk>
 <Yq3s/K31CxG/H+lJ@ZenIV> <Yq3wKSRDEUxXA3Yi@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yq3wKSRDEUxXA3Yi@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/18/22 9:32 AM, Al Viro wrote:
> On Sat, Jun 18, 2022 at 04:19:24PM +0100, Al Viro wrote:
>> On Sat, Jun 18, 2022 at 08:08:08AM -0600, Jens Axboe wrote:
>>> Using an ITER_UBUF is more efficient than an ITER_IOV, and for the single
>>> segment case, there's no reason to use an ITER_IOV when an ITER_UBUF will
>>> do. Experimental data collected shows that ~2/3rds of iovec imports are
>>> single segments, from applications using readv/writev or recvmsg/sendmsg
>>> that are iovec based.
>>>
>>> Explicitly check for nr_segs == 1 and import those as ubuf rather than
>>> iovec based iterators.
>>
>> Hadn't we'd been through that before?   There is infinibarf code that
>> assumes ITER_IOVEC for what its ->write_iter() gets (and yes, that's
>> the one that has ->write() with different semantics).
>>
>> And I wouldn't bet a dime on all ->sendmsg() and ->recvmsg() being
>> flavour-agnostic either...
> 
> Incidentally, what will your patch do to one-segment readv(2) from
> e.g. /proc/self/status?  Or anything else that has no ->read_iter, for
> that matter...

Yes indeed, that won't work at all... I guess this has to be up to the
caller, we can't stuff it this far down.

-- 
Jens Axboe

