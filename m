Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74EB5F8676
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJHSNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 14:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJHSNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:13:06 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1364F3A14D;
        Sat,  8 Oct 2022 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TNYuzkx0DGl3YY6akP9WyoKTqZEYCLgGMvwC1YP1f64=; b=r5/3dX3zF7a8uN5Kl+ACSNY7+Y
        K1LkEsk20Z3soFvyj7DObMgWbKDraV5UTMKJGyS66DQ3tmD/yRDci/EXB0rkPuqNWCTKrFIqnmeHg
        42jKGSlx35qXM/Infto9WGwr6lsh0iEop8rrUCby1wYU1SIGpZHLEcJUZqweJmA7YjKKas1LoNBtS
        mpL1KF7aT/mDVw1cv6NPKzquRjNjXUmOnr2A9gcywj0TwLw5Tq81/8MYamsb/6QwsOcLPPTpFSgTr
        9boC0N//x3X1rlOd5RDQd2DhDAf4Kjc+AOfxttrO/b4eaNSq/Ygv2IuXtSnfTMj7hkL1JzPrehN+g
        upwMqbKg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ohEJk-00Elx8-5F; Sat, 08 Oct 2022 20:12:56 +0200
Message-ID: <ebbaebc5-24e9-2787-843a-414ea286e35b@igalia.com>
Date:   Sat, 8 Oct 2022 15:12:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/8] pstore: Fix long-term implicit conversions in the
 compression routines
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-6-gpiccoli@igalia.com>
 <202210061634.758D083D5@keescook>
 <CAMj1kXF27wZYzXm1u3kKSBtbG=tcK7wOwq6YTwpFg+Z7ic4siQ@mail.gmail.com>
 <202210071234.D289C8C@keescook>
 <11e03e8d-7711-330d-e0d4-808ef9acec3a@igalia.com>
 <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
 <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com>
 <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXHjS+gywpoZ26_Bn76Z_5ohhtoD7ruH0bBYaAQzBY9tuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/10/2022 14:52, Ard Biesheuvel wrote:
> [...]
>> This is exactly what 842 (sw compress) is doing now. If that's
>> interesting and Kees agrees, and if nobody else plans on doing that, I
>> could work on it.
>>
>> Extra question (maybe silly on my side?): is it possible that
>> _compressed_ data is bigger than the original one? Isn't there any
>> "protection" on the compress APIs for that? In that case, it'd purely
>> waste of time / CPU cycles heheh
>>
> 
> No, this is the whole point of those helper routines, as far as I can
> tell. Basically, if you put data that cannot be compressed losslessly
> (e.g., a H264 video) through a lossless compression routine, the
> resulting data will be bigger due to the overhead of the compression
> metadata.
> 
> However, we are compressing ASCII text here, so using the uncompressed
> size as an upper bound for the compressed size is reasonable for any
> compression algorithm. And if dmesg output is not compressible, there
> must be something seriously wrong with it.
> 
> So we could either just drop such input, or simply not bother
> compressing it if doing so would only take up more space. Given the
> low likelihood that we will ever hit this case, I'd say we just ignore
> those.
> 
> Again, please correct me if I am missing something here (Kees?). Are
> there cases where we compress data that may be compressed already?

This is an interesting point of view, thanks for sharing! And it's
possible to kinda test it - I did in the past to test maximum size of
ramoops buffers, but I didn't output the values to compare compressed
vs. uncompressed size (given I didn't need the info at the time).

The trick I used was: suppose I'm using lz4, I polluted dmesg with lz4
already compressed garbage, a huge amount of it, then provoked a crash.
I'll try it again to grab the sizes heheh
