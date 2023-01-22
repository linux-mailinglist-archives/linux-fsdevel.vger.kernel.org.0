Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF61676BAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAVItl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 03:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVItl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C21E1CD
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674377333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SDKIuBosw0Y6gCecomo8g6nVj0vlJmnHgW0J/JWrps=;
        b=abpU4or6ZYq44UOZARUY/SVL2Buabb2bxS0OBzvNDaqhOk43BlGOllIB8Ptmi+XyennVRj
        OSGOtuMJEftrZ/FJOGFIrcyKh61t6BB8WpbT3vjbZrLUzA5scFm7svCvTlPvMZFDXLmGPV
        NNh89uraMr5bhAhq/xja0d9AaX+OfXI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-8q7EmNALPU2wAMj287nJIQ-1; Sun, 22 Jan 2023 03:48:52 -0500
X-MC-Unique: 8q7EmNALPU2wAMj287nJIQ-1
Received: by mail-pj1-f72.google.com with SMTP id pm1-20020a17090b3c4100b002292b6258a0so3759201pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 00:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SDKIuBosw0Y6gCecomo8g6nVj0vlJmnHgW0J/JWrps=;
        b=NUn5HNngAt1kEEoWlTKUZqF7Y3wEa5TB3UazyuJAOVbxSe5Dy3evXLIXiknExuq4Fw
         CEz1Y0/PgS6HyRUBZi9wukGPyDnnZkmidd3Ty0XOssosAiarorFVxWHfG2QDJKEtx/41
         ruIJKrIWV/yRlud7UuW9aeTUEn4BvajiNp8EJFFk8yGAjpjsAWAGfWVIdc6eWaTKyMBY
         dNiwF9Lk6DbXvisIyiilXv1QatrxYkmH4qaiidNJ2+h7nWQceS18SQAP8JWW/116juKA
         7NRiiTY4237Q9BkZYauCGg2xRaMTTLuyyy/KQ/JPm0tgXFDATdX5cXwQB9neAuLo4yUH
         IfkQ==
X-Gm-Message-State: AFqh2krWTFg8ue/UhXFKj6b2JArKtCf2apqCQN6D2uDeRU2JdCjAMAYg
        BOGd31/ZUax6qNz3ZDc2gZy2K/MTgdQT7ZhQlAA4owKoWuyXtGaHcVM6+dcKOcQi/BHrYaH4Oa2
        xsAh+0ceQgMtGyRNgLisynrTp5MX+3rq+eWCvdHWJYw==
X-Received: by 2002:a62:be13:0:b0:58d:b201:84b1 with SMTP id l19-20020a62be13000000b0058db20184b1mr2282361pff.41.1674377331215;
        Sun, 22 Jan 2023 00:48:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuwAWLrw38cQ1Ha9xZx3SZuQe/jt+10b3RQAqmklXd4+tytynF8ViRBHXKCC9L1qZVXzs046Wi44O+irVm6SaQ=
X-Received: by 2002:a62:be13:0:b0:58d:b201:84b1 with SMTP id
 l19-20020a62be13000000b0058db20184b1mr2282357pff.41.1674377330917; Sun, 22
 Jan 2023 00:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20230120141150.1278819-1-agruenba@redhat.com> <20230121142927.GB6786@lst.de>
In-Reply-To: <20230121142927.GB6786@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 22 Jan 2023 09:48:38 +0100
Message-ID: <CAHc6FU5udwDCBaH8Cm1EMDh8P1_7WwRVU2SXgF-SZmh5pE2-8Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "gfs2: stop using generic_writepages in gfs2_ail1_start_one"
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 21, 2023 at 3:29 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +     struct address_space *mapping = data;
> > +     int ret = mapping->a_ops->writepage(page, wbc);
> > +     mapping_set_error(mapping, ret);
> > +     return ret;
>
> I guess beggars can't be choosers, but is there a chance to directly
> call the relevant gfs2 writepage methods here instead of the
> ->writepage call?

Yes, we could wrap struct address_space_operations and move the
writepage method into its wrapper structure relatively easily, but
that would still leave things in a messy state. So I'd really like to
reassess the validity of commit 5ac048bb7ea6 ("GFS2: Use
filemap_fdatawrite() to write back the AIL") before deciding to go
that way.

Also, we're really trying to iterate the list of inodes that are part
of the transaction here, not the list of blocks, and if we stick with
that, an actual list of inodes would help. That would be the
complement of our list of ordered inodes in a sense.

Until then, I'd like to stick with the simplest possible solution
though, which seems to be this.

> Otherwise this looks good:
>
> Acked-by: Christoph Hellwig <hch@lst.de>

Thanks a lot,
Andreas

