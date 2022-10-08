Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FA5F85FB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJHQEF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 12:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHQEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:04:04 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A056B4B9B8;
        Sat,  8 Oct 2022 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zaZ/mPgscZeTQBmEdnlzf830pxwenjFv4EmShpxkNCM=; b=CNLJk1cfHuQZRS/GsXZHrioG9h
        IvJkfnKvVjzRd4gTdXicEMqn6Ge0QY3MmDv2vVtEXGgo9UZMznHySO91rUlJUodKNJRSJdeplpnK7
        itqyR2AsSJF65034vXt7rB/yLZo/yh9lwaL32fBX2aUAYuzDNqIrGiKWkuX+lN33kE1zmBRZ19qXx
        tXKfbPZMPJaNvocHD6Ri3m0thkOkn6MaCqL2jiMNBgE9kH3wlYtW4l4Cb2C+UrnaieENoncts+7QS
        FQpiw+Yltx+kAJpzdS5h5k91x4QYyCxWA8ljgT6Tc6bEawErEY1iQrwF/gN4lCyfDhvqKP/oL1MJM
        BJflD2Jw==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ohCIt-00Ee7g-G9; Sat, 08 Oct 2022 18:03:55 +0200
Message-ID: <dbe57a5e-7486-649f-7093-6da6312a71ee@igalia.com>
Date:   Sat, 8 Oct 2022 13:03:38 -0300
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXHSSSZ59tihHDNDamczxFCRH8NHzT-eKaZ7xNyqVXW1Hw@mail.gmail.com>
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

On 08/10/2022 12:53, Ard Biesheuvel wrote:
> [...]
> So one thing I don't understand about these changes is why we need
> them in the first place.
> 
> The zbufsize routines are all worst case routines, which means each
> one of those will return a value that exceeds the size parameter.
> 
> We only use compression for dmesg, which compresses quite well. If it
> doesn't compress well, there is probably something wrong with the
> input data, so preserving it may not be as critical. And if
> compressing the data makes it bigger, can't we just omit the
> compression for that particular record?
> 
> In summary, while adding zbufsize to the crypto API seems a reasonable
> thing to do, I don't see why we'd want to make use of it in pstore -
> can't we just use the decompressed size as the worst case compressed
> size for all algorithms, and skip the compression if it doesn't fit?
> 
> Or am I missing something here?

In a way (and if I understand you correctly - please let me know if not)
you are making lot of sense: why not just use the maximum size (which is
the full decompressed size + header) as the worst case in pstore and
skip these highly specialized routines that calculate the worst case for
each algorithm, right?

This is exactly what 842 (sw compress) is doing now. If that's
interesting and Kees agrees, and if nobody else plans on doing that, I
could work on it.

Extra question (maybe silly on my side?): is it possible that
_compressed_ data is bigger than the original one? Isn't there any
"protection" on the compress APIs for that? In that case, it'd purely
waste of time / CPU cycles heheh

Cheers,


Guilherme
