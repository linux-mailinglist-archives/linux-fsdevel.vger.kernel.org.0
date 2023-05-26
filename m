Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B0971237E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243085AbjEZJ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbjEZJ0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:26:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852331BF;
        Fri, 26 May 2023 02:25:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6cbf02747so3563205e9.1;
        Fri, 26 May 2023 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685093157; x=1687685157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33W3DIYt68JCc1u4c3IHIWclixpfbjQ4h21dOvzyDuw=;
        b=CvvNWfFpQ3Ld/4CYyw7Xw62+CVZ8Psau5n52Twi4YWjNr5q3rQpPgQCv3bSHqVNQOg
         1mOE72h1EqZMonHUUcfqrzu/vsJH+0lX803aAnutUrpkYBrRsLBy0VGDYsnd7Z2w1hCh
         XXdECMzqzEm/BvE8gGyLBbplUgqVFh0XHMoxDvHfi5B2RUonAdJRwhd3IHCNZd6og5fj
         LQwt06eQOz+OFluI8lZhk0MH6PDV04YkytC0+ygQ9vbrjEUrbGUSu4P1uLEuAT85Qayg
         4TBpAtOEgFQhOH5ZjcjZdZ3wI5xyaoFCy+dqiU+eQ2GyK/EsudKbsvlW2NjQMLajFU+8
         HXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093157; x=1687685157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33W3DIYt68JCc1u4c3IHIWclixpfbjQ4h21dOvzyDuw=;
        b=Wdpwyh6UOBCIbF0gJYuJVRasEFWK+16it6Oa5aEavgo0uOhm2iD4TocJJAk+qz+VJT
         8Gp9xnDlj+r5O0XDqHL/bKd/fLv+m3q25ERxBs+tTSejie0d3ltEvUAeRwDbY9K1paQb
         ayqlGFhFu+9KQS03+G6zDwxlG4W0p9F75xttA0b9/t1gpNzl0I9XpsB0QBTBoJyUyOnx
         HKBSXAVSTpAzwLbODelmpPup/5gSmvcO3vNGx+X1DhJqOqfjX7q/Wca0ol6Fw9jR0aZL
         AgoyPmhhCRVTsl1oG4Vlek/LsIrFIOEp0uX2QPVeKrdg1AZvmFCXWjWF77kFqs5xid2e
         4f9A==
X-Gm-Message-State: AC+VfDy6sN14P7Yk6N4y8KFh0ZvwsEkIFJHpDkwlY7DPteFwC15ItPde
        BG/rXt9qseiK8XlVJL89fTEyCqynFfQ=
X-Google-Smtp-Source: ACHHUZ5qATJanUKkPm4qBKb8bF5/1byjJd31CEWo1ros2NS7T6k47Kd+YmqaqHRsSYNaDFQZ5JaRQQ==
X-Received: by 2002:a05:600c:214d:b0:3f6:6c0:7c9b with SMTP id v13-20020a05600c214d00b003f606c07c9bmr951472wml.15.1685093156586;
        Fri, 26 May 2023 02:25:56 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f42d8dd7d1sm8272494wml.7.2023.05.26.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:25:55 -0700 (PDT)
Date:   Fri, 26 May 2023 10:23:46 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Message-ID: <859fa154-a0ea-4f7b-9f57-7e36107982b6@lucifer.local>
References: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local>
 <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
 <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <520730.1685090615@warthog.procyon.org.uk>
 <522654.1685092526@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522654.1685092526@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 10:15:26AM +0100, David Howells wrote:
> Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > > iov_iter_extract_pages(), on the other hand, is only used in two places
> > > with these patches and the pins are always released with
> > > unpin_user_page*() so it's a lot easier to audit.
> >
> > Thanks for the clarification. I guess these are the cases where you're
> > likely to see zero page usage, but since this is changing all PUP*() callers
> > don't you need to audit all of those too?
>
> I don't think it should be necessary.  This only affects pages obtained from
> gup with FOLL_PIN - and, so far as I know, those always have to be released
> with unpin_user_page*() which is part of the gup API and thus it should be
> transparent to the users.
>

Right, I was only saying so in relation to you stating the need to audit,
for precisely this reason I wondered why you felt the need to :)

> Pages obtained FOLL_GET, on the other hand, aren't freed through the gup API -
> and there are a bunch of ways of releasing them - and getting additional refs
> too.

Yes that's a very good point! Sorry, in my enthusiasm for GUP reform this
thorny aspect slipped my mind...

As Christoph said though hopefully over time we can limit the use of FOLL_GET so
this becomes easier perhaps. Larger discussion on this area in [0] :)

[0]:https://lore.kernel.org/all/ZGWnq%2FdAYELyKpTy@infradead.org/

>
> David
>
