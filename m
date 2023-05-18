Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C279B707EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjERLMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 07:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjERLMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 07:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E78E2123
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684408251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2NcxE0RsPLg1062LoNjrlWE+UkODXkzpmwXqpBZxwM=;
        b=Q75Ku+K/i4++egPTCvPSjwHGBa/llYxkdwJ2W37x0OunxbJ5wXYzIfjYxdhu/0YbfFgDtO
        xCvB7wK0PWXzCt/wE50uvrZHjiQt9I3mG8Xe5yOe75m1n6og4Ps3mPAzaF6aMbgc4EjO8W
        uq4u+OYyYE1t06QhI4fyOe5ZfKGUQ/c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-4MLwm6fwNl6cwqRSKJxuSw-1; Thu, 18 May 2023 07:10:42 -0400
X-MC-Unique: 4MLwm6fwNl6cwqRSKJxuSw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f38280ec63so3678401cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 04:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684408242; x=1687000242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2NcxE0RsPLg1062LoNjrlWE+UkODXkzpmwXqpBZxwM=;
        b=CI0XTgQt3sQ6LivDpvdNlPccZZVVCrHo/3K9NF7pN9UpscXhEsgEBwQECfiEiaofEA
         rDW0ROeILMR2Md7mFn/jHklPeFBnGfl/zuUiPXPd/WnTPC+bFNUHsliF9qHnBbUPdfkB
         kY/QtXzq/fvad3kErLFqYtEAF5HNRGI0xXUO1Uz95XNC2EsZNw4WhO3+h4ba4NFlt0bV
         oXXqLkuAx3D120Ki7p/V/TOcwbCSVtVDo3lAU+1uFXeJxPpG5desCIWoU7mks2JxYUND
         HAEDmEc8OaxR/VpC8JDcadop0oKkxXT8fr0JijLWwObbZYhqCA7mQW/J570biyt55r7s
         8lFg==
X-Gm-Message-State: AC+VfDylsTBz0j1/fdzr6j7stfSvljURa7uUL1uaUzo6FDEoHVVIXCjh
        4O/gdtPy8PXxO0DSZ38jrdqMBIr8XqLlW4HYpFeVTYLJJhLjd3TJTAVd1JNbll5ApJMjd5e3RjM
        nQhmabVFnm9CQFikD9eJpN/LxGw==
X-Received: by 2002:a05:622a:1896:b0:3f5:16af:17d6 with SMTP id v22-20020a05622a189600b003f516af17d6mr10872314qtc.3.1684408241973;
        Thu, 18 May 2023 04:10:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6/qnltyKsyZE/L1ktIzrQ0Ew9Hs0O55TEKxNZfIrmlEZhxbrHczL9qgtv+7D/SlwBQzv+leA==
X-Received: by 2002:a05:622a:1896:b0:3f5:16af:17d6 with SMTP id v22-20020a05622a189600b003f516af17d6mr10872258qtc.3.1684408241691;
        Thu, 18 May 2023 04:10:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-175.dyn.eolo.it. [146.241.239.175])
        by smtp.gmail.com with ESMTPSA id n7-20020a05620a152700b0075784a8f13csm318352qkk.96.2023.05.18.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:10:41 -0700 (PDT)
Message-ID: <78a9f2e83af3ab732e9cedd46c1265b7366cd91f.camel@redhat.com>
Subject: Re: [PATCH net-next v7 03/16] net: Add a function to splice pages
 into an skbuff for MSG_SPLICE_PAGES
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 18 May 2023 13:10:36 +0200
In-Reply-To: <1348733.1684405935@warthog.procyon.org.uk>
References: <47caea363e844bf716867c6a128d374cae4a5772.camel@redhat.com>
         <93aba6cc363e94a6efe433b3c77ec1b6b54f2919.camel@redhat.com>
         <20230515093345.396978-1-dhowells@redhat.com>
         <20230515093345.396978-4-dhowells@redhat.com>
         <1347187.1684403608@warthog.procyon.org.uk>
         <1348733.1684405935@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-05-18 at 11:32 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> > Side node: we need the whole series alltogether, you need to repost
> > even the unmodified patches.
>=20
> Any other things to change before I do that?

I went through the series and don't have other comments.

Cheers,

Paolo

