Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7807AA186
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIUVDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjIUVDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:01 -0400
X-Greylist: delayed 4201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 12:42:47 PDT
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A522D216
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 12:42:47 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5DBAE1624;
        Thu, 21 Sep 2023 08:08:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5DBAE1624
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1695276502; bh=TX3HwdkmE4MzYgRaFjViDafPL824M36FBOqMSpRbUdQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rJtLwjnfXAu8GhKX2zGs01s96mHJexrISFBXuVSjH20E+PnXUGXfZAA/NMSjwhw7z
         n4Dxe5RNReB8pVi2bRH84Ayb1wQ9v8UJcUEyYH8mCKrBF4QGSIr9ZM+t/oDFdo7IGw
         gOHTzmLD5HIP3ChrbllaWNUM6Boer7KBdVaSvVZk=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 21 Sep 2023 08:08:03 +0200 (CEST)
Message-ID: <2a3b1a19-1eef-0574-cb24-43432713db3b@perex.cz>
Date:   Thu, 21 Sep 2023 08:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 01/11] sound: Fix snd_pcm_readv()/writev() to use iov
 access functions
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
References: <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-2-dhowells@redhat.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230920222231.686275-2-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21. 09. 23 0:22, David Howells wrote:
> Fix snd_pcm_readv()/writev() to use iov access functions rather than poking
> at the iov_iter internals directly.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jaroslav Kysela <perex@perex.cz>
> cc: Takashi Iwai <tiwai@suse.com>
> cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Suren Baghdasaryan <surenb@google.com>
> cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> cc: alsa-devel@alsa-project.org
> ---
>   sound/core/pcm_native.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

