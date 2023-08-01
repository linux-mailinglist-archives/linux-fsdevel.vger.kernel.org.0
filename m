Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3EF76B827
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbjHAO7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjHAO7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:59:39 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B89122;
        Tue,  1 Aug 2023 07:59:37 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40fbf360a9cso12574981cf.3;
        Tue, 01 Aug 2023 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690901977; x=1691506777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re83epYEGAxkxHedXjaq8xzla1lDRq5bwOjxObe6kmA=;
        b=AjcKhRMG7Tn4kqu/M2vl6iY01gZ6kGwQRUrhlDkYY07dCE1ECs5r5aB5Uj2Pv934gH
         LQFwOxjOGs4Ko9tVWpg+fmBwhdajvRUhCFRNrW3LIeT7rOG7kVUYv46KXpEtRRIwjWF+
         SGjzn7hUxvXUCDJdOGvblVR3XmYgBIUjb0fIW+7aQUSCM5ZNGEshGBBPc04u304UVll8
         aHkOCuskswn0/6NXYFFltR8pxcztW4xhANbBG5Azem4lRATS7DcZkWxca3zjjxeSYysd
         6Gtimjp1ylxtdIaXLN3eyGMB/7A9t/j0nf/BoORYzWTkafCIC8mEosH69ql35KUUX+RG
         FbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901977; x=1691506777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=re83epYEGAxkxHedXjaq8xzla1lDRq5bwOjxObe6kmA=;
        b=HfibK9xLE3gfQRE4RAaPHcJ+W5m8a/4ucTKFH08sCoeUN3W/myMf809K3rZGsMzdgQ
         rho0KJvYpUsOYWj4ZO4438R5zGPR94UA6KRNv557uN6kwe9OV0Bw/wjxsvi7juLygIGN
         rDFb4csHOlMJQUyFK1Hs8lHdnTD/kYi6wB25MW5rdBLAaUdrMuDMZG+IDLe6V/s5L9Ic
         rUe1jUPLLc0uIQv6nVsa45SNkdjZCgrIkRf2H0EFUOOMFgf+AH4aPiGD46o7sbUQRpfc
         zxdI6xxb+NM91uxbeqXUfSq7qOgd7yG1JqTsLoRw/pezMxV89Bc+OYTi03GXG02BZvap
         dt3Q==
X-Gm-Message-State: ABy/qLZDWoqlFVYmzbsmgFVdV3Raqi3s/pj80X7JoLA7Igs4y5KaOsln
        4GDO/GGtb/7368IEVSJkvfw=
X-Google-Smtp-Source: APBJJlErfXjF8pYZdwrKxG91Ge8pM6l3z9gx62O1NDpCQDtrWiq6If1QCo0+ZoR8+RhK/uqCdBz5Mg==
X-Received: by 2002:a05:622a:64e:b0:403:1c7a:6c70 with SMTP id a14-20020a05622a064e00b004031c7a6c70mr17000763qtb.38.1690901976867;
        Tue, 01 Aug 2023 07:59:36 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id c24-20020ac81e98000000b0040fd72bca22sm446392qtm.10.2023.08.01.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:59:36 -0700 (PDT)
Date:   Tue, 01 Aug 2023 10:59:35 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Message-ID: <64c91dd7ebb09_1c09b429484@willemb.c.googlers.com.notmuch>
In-Reply-To: <1410190.1690901255@warthog.procyon.org.uk>
References: <64c9174fda48e_1bf0a42945f@willemb.c.googlers.com.notmuch>
 <64c903b02b234_1b307829418@willemb.c.googlers.com.notmuch>
 <64c7acd57270c_169cd129420@willemb.c.googlers.com.notmuch>
 <64c6672f580e3_11d0042944e@willemb.c.googlers.com.notmuch>
 <20230718160737.52c68c73@kernel.org>
 <000000000000881d0606004541d1@google.com>
 <0000000000001416bb06004ebf53@google.com>
 <792238.1690667367@warthog.procyon.org.uk>
 <831028.1690791233@warthog.procyon.org.uk>
 <1401696.1690893633@warthog.procyon.org.uk>
 <1409099.1690899546@warthog.procyon.org.uk>
 <1410190.1690901255@warthog.procyon.org.uk>
Subject: Re: Endless loop in udp with MSG_SPLICE_READ - Re: [syzbot] [fs?]
 INFO: task hung in pipe_release (4)
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
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > > I'm also not entirely sure what 'paged' means in this function.  Should it
> > > actually be set in the MSG_SPLICE_PAGES context?
> > 
> > I introduced it with MSG_ZEROCOPY. It sets up pagedlen to capture the
> > length that is not copied.
> > 
> > If the existing code would affect MSG_ZEROCOPY too, I expect syzbot
> > to have reported that previously.
> 
> Ah...  I think it *should* affect MSG_ZEROCOPY also... but...  If you look at:
> 
> 		} else {
> 			err = skb_zerocopy_iter_dgram(skb, from, copy);
> 			if (err < 0)
> 				goto error;
> 		}
> 		offset += copy;
> 		length -= copy;
> 
> MSG_ZEROCOPY assumes that if it didn't return an error, then
> skb_zerocopy_iter_dgram() copied all the data requested - whether or not the
> iterator had sufficient data to copy.
> 
> If you look in __zerocopy_sg_from_iter(), it will drop straight out, returning
> 0 if/when iov_iter_count() is/reaches 0, even if length is still > 0, just as
> skb_splice_from_iter() does.
> 
> So there's a potential bug in the handling of MSG_ZEROCOPY - but one that you
> survive because it subtracts 'copy' from 'length', reducing it to zero, exits
> the loop and returns without looking at 'length' again.  The actual length to
> be transmitted is in the skbuff.
> 
> > Since the arithmetic is so complicated and error prone, I would try
> > to structure a fix that is easy to reason about to only change
> > behavior for the MSG_SPLICE_PAGES case.
> 
> Does that mean you want to have a go at that - or did you want me to try
Please give it a try. I can review. It's just safer if it's trivial
to review that the patch only affects the behavior of the recently
introduced MSG_SPLICE_PAGES code.



