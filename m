Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE97A9941
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIUSMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjIUSMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCFA645BE;
        Thu, 21 Sep 2023 10:32:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C1591FE17;
        Thu, 21 Sep 2023 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695302058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr4dJrGCAHGoorv5nC8n0VYn5plN0T8DDF/tRgAs9xw=;
        b=yQ9zS8MLtbBzIv4XI+Fx8UAy9OA58BxnvA0q2n1vhQLjUSsNzM4w4MdLAlqHixUwTRUdoz
        XubkwoYkWO2vMUvbTapSgZvfIRIZERoGsyfrIx8lbCcnL4Q5xOqDi0chiiy+ZoYKd3EIit
        dDKtvAuqYXOAhz9Frc0BAj0JX4LPLQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695302058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr4dJrGCAHGoorv5nC8n0VYn5plN0T8DDF/tRgAs9xw=;
        b=956IPJl5aJAhxsQTTbR4rPzctFBiEm6NaXj8nUVK+t2LBvTby0r5Safd7j/+V6jKUnW38T
        CX4LhyiTf45bK1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5F23134B0;
        Thu, 21 Sep 2023 13:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o5KBJ6lBDGVtMQAAMHmgww
        (envelope-from <tiwai@suse.de>); Thu, 21 Sep 2023 13:14:17 +0000
Date:   Thu, 21 Sep 2023 15:14:17 +0200
Message-ID: <87o7hvzn12.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v5 01/11] sound: Fix snd_pcm_readv()/writev() to use iov access functions
In-Reply-To: <20230920222231.686275-2-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
        <20230920222231.686275-2-dhowells@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 21 Sep 2023 00:22:21 +0200,
David Howells wrote:
> 
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

Reviewed-by: Takashi Iwai <tiwai@suse.de>

Would you apply it through your tree, or shall I apply this one via
sound git tree?


thanks,

Takashi

> ---
>  sound/core/pcm_native.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index bd9ddf412b46..9a69236fa207 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3527,7 +3527,7 @@ static ssize_t snd_pcm_readv(struct kiocb *iocb, struct iov_iter *to)
>  	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
>  	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
>  		return -EBADFD;
> -	if (!to->user_backed)
> +	if (!user_backed_iter(to))
>  		return -EINVAL;
>  	if (to->nr_segs > 1024 || to->nr_segs != runtime->channels)
>  		return -EINVAL;
> @@ -3567,7 +3567,7 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
>  	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
>  	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
>  		return -EBADFD;
> -	if (!from->user_backed)
> +	if (!user_backed_iter(from))
>  		return -EINVAL;
>  	if (from->nr_segs > 128 || from->nr_segs != runtime->channels ||
>  	    !frame_aligned(runtime, iov->iov_len))
> 
