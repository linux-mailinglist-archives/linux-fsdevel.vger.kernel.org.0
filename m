Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BD576B990
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjHAQVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHAQVc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:21:32 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698AA10CC;
        Tue,  1 Aug 2023 09:21:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so32751086d6.0;
        Tue, 01 Aug 2023 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690906890; x=1691511690;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbSMI1pM5BL/Rcx+SHHHJQWHYkudnJt5P2sO7jyRONQ=;
        b=QdY0LlPQGghBINvaX1uWUYE/O/3PckWYkfPeHstDW3clb6OfvvfaAx+hrbuSVee2es
         7Cx/eGIYJzs3guQ8DKtDuPB8WVNMcsi4ouuxFDIpySEiJEFswH9eSasNpQ4/BIckoPw6
         wmxT6g52yZN4GMSPRRVSrcHUiuqBn5gV6Hv6OmIBHUb0rKFjMtLY++zKtUAm7FTFdkx8
         T7+glmhMRsIRQUyynThwuc6gV2+0UIeT5BK1DSsxa4IWeasTCDITICAg7vWxf7HC8ou9
         LEUGVeSJHV0sEjqCncGvdbnSifUrIAtOt7AE4FFP0VWaVa6Ii9oJwrWz3hZm9u/fCrko
         ssuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906890; x=1691511690;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbSMI1pM5BL/Rcx+SHHHJQWHYkudnJt5P2sO7jyRONQ=;
        b=lRhoBFKbKV4rGintqFzfumKzUCkJQdXZI5rv15mLCCUH0oQFOq3VqTi4XGBGp5vqiN
         +raCeuJxBAqFA6VHeVQe5JBI3WyMzcpDZBME54P4a258Sum52UoElDXm+TYiv3wU58wV
         PZWikTbVHYUQZqMnjl7I/U4PMhDpFYDWsNMlYB5wdpAJpxKUKOMi7AUPTg07Iev4VA18
         rPV1hRHC+/dfcFRlvoh0ffEmZw3xQ/ov3GsAaMm89noLnFs8T5mCi61fK0ne/F9NIFeC
         PPxPK7he1TRe/cSwPKEDumOaNpb6gii4wTB006We5mfyqRwy5XklJFIgEXYqDC39Wi+K
         /chQ==
X-Gm-Message-State: ABy/qLYs/0cbcv96LAqRH5FiqSsuVwfgJ/NLL13+pLwmKngymB6mgOLc
        5E76R1g7PKuycpgA7G5YYsE=
X-Google-Smtp-Source: APBJJlEHVlSxvb372Wef6KVZVhEPeHYmFrRN3Wy8AwDZxmYQSxBbUKw2xNM8zeDFdQTtE3vpxs6e+Q==
X-Received: by 2002:a05:6214:21a9:b0:635:f546:83d0 with SMTP id t9-20020a05621421a900b00635f54683d0mr15333418qvc.11.1690906890461;
        Tue, 01 Aug 2023 09:21:30 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id s7-20020a0cb307000000b00637615a1f33sm4750978qve.20.2023.08.01.09.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:21:30 -0700 (PDT)
Date:   Tue, 01 Aug 2023 12:21:29 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com,
        syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Message-ID: <64c93109c084e_1c5e3529452@willemb.c.googlers.com.notmuch>
In-Reply-To: <1420063.1690904933@warthog.procyon.org.uk>
References: <1420063.1690904933@warthog.procyon.org.uk>
Subject: RE: [PATCH net] udp: Fix __ip_append_data()'s handling of
 MSG_SPLICE_PAGES
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells wrote:
>     
> __ip_append_data() can get into an infinite loop when asked to splice into
> a partially-built UDP message that has more than the frag-limit data and up
> to the MTU limit.  Something like:
> 
>         pipe(pfd);
>         sfd = socket(AF_INET, SOCK_DGRAM, 0);
>         connect(sfd, ...);
>         send(sfd, buffer, 8161, MSG_CONFIRM|MSG_MORE);
>         write(pfd[1], buffer, 8);
>         splice(pfd[0], 0, sfd, 0, 0x4ffe0ul, 0);
> 
> where the amount of data given to send() is dependent on the MTU size (in
> this instance an interface with an MTU of 8192).
> 
> The problem is that the calculation of the amount to copy in
> __ip_append_data() goes negative in two places, and, in the second place,
> this gets subtracted from the length remaining, thereby increasing it.
> 
> This happens when pagedlen > 0 (which happens for MSG_ZEROCOPY and
> MSG_SPLICE_PAGES), because the terms in:
> 
>         copy = datalen - transhdrlen - fraggap - pagedlen;
> 
> then mostly cancel when pagedlen is substituted for, leaving just -fraggap.
> This causes:
> 
>         length -= copy + transhdrlen;
> 
> to increase the length to more than the amount of data in msg->msg_iter,
> which causes skb_splice_from_iter() to be unable to fill the request and it
> returns less than 'copied' - which means that length never gets to 0 and we
> never exit the loop.
> 
> Fix this by:
> 
>  (1) Insert a note about the dodgy calculation of 'copy'.
> 
>  (2) If MSG_SPLICE_PAGES, clear copy if it is negative from the above
>      equation, so that 'offset' isn't regressed and 'length' isn't
>      increased, which will mean that length and thus copy should match the
>      amount left in the iterator.
> 
>  (3) When handling MSG_SPLICE_PAGES, give a warning and return -EIO if
>      we're asked to splice more than is in the iterator.  It might be
>      better to not give the warning or even just give a 'short' write.
> 
> [!] Note that this ought to also affect MSG_ZEROCOPY, but MSG_ZEROCOPY
> avoids the problem by simply assuming that everything asked for got copied,
> not just the amount that was in the iterator.  This is a potential bug for
> the future.
> 
> Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")
> Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000881d0606004541d1@google.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: David Ahern <dsahern@kernel.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: netdev@vger.kernel.org

Thanks for limiting this to MSG_SPLICE_PAGES.

__ip6_append_data probably needs the same.

I see your point that the

  if (copy > 0) {
  } else {
    copy = 0;
  }

might apply to MSG_ZEROCOPY too. I'll take a look at that. For now
this is a clear fix to a specific MSG_SPLICE_PAGES commit.

copy is recomputed on each iteration in the loop. The only fields it
directly affects below this new line are offset and length. offset is
only used in copy paths: "offset into linear skb".

So this changes length, the number of bytes still to be written.

copy -= -fraggap definitely seems off. You point out that it even can
turn length negative?

The WARN_ON_ONCE, if it can be reached, will be user triggerable.
Usually for those cases and when there is a viable return with error
path, that is preferable. But if you prefer to taunt syzbot, ok. We
can always remove this later.

> ---
>  net/ipv4/ip_output.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 6e70839257f7..91715603cf6e 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1158,10 +1158,15 @@ static int __ip_append_data(struct sock *sk,
>  			}
>  
>  			copy = datalen - transhdrlen - fraggap - pagedlen;
> +			/* [!] NOTE: copy will be negative if pagedlen>0
> +			 * because then the equation reduces to -fraggap.
> +			 */
>  			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fraggap, skb) < 0) {
>  				err = -EFAULT;
>  				kfree_skb(skb);
>  				goto error;
> +			} else if (flags & MSG_SPLICE_PAGES) {
> +				copy = 0;
>  			}
>  
>  			offset += copy;
> @@ -1209,6 +1214,10 @@ static int __ip_append_data(struct sock *sk,
>  		} else if (flags & MSG_SPLICE_PAGES) {
>  			struct msghdr *msg = from;
>  
> +			err = -EIO;
> +			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
> +				goto error;
> +
>  			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
>  						   sk->sk_allocation);
>  			if (err < 0)
> 


