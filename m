Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AAD64C709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 11:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbiLNKZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Dec 2022 05:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiLNKY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B2E0CC
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 02:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671013450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9yG5JV06r9TcNN4oFhlXP0Fq7y0VXR4zsj82aFUNl6c=;
        b=G1qtEDOMlNvyBL6R57MlkQ43auALJvTFOm4h+wTyQjx0B9BDfiD6JFjRVtR9Vm0zqHjCKs
        BoDrmQDzVg7PmeJoNgFmYtG3QQWrWlkPcqg2YBPZSgN+VEdU5uvnGrTC4x+0ohgdIhBpL0
        ROMi+9vr9DHF9qrGPzZQv+gWkZBkMt4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-Edb0zZboNMSW8VFjpeuKCQ-1; Wed, 14 Dec 2022 05:24:07 -0500
X-MC-Unique: Edb0zZboNMSW8VFjpeuKCQ-1
Received: by mail-yb1-f198.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so19892276yba.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Dec 2022 02:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9yG5JV06r9TcNN4oFhlXP0Fq7y0VXR4zsj82aFUNl6c=;
        b=nV4hIQ+Y+RPFypahNm00rfAgPZHYldccmzJOXltUoSFzopp9kbqyaNwJqsmeCZoozO
         Cg7cjeZAa4CDT8qRcpNjSCmoFPj51aeqN0Bj1VN3RBnV152kbYCOZCabP++tFHtl35BN
         WHKa0Z8pmStYaCXkQzrxqoC28CZBMPXD4qaX2YcgmcxFRmva1vSLgZF04qcevgCueLPy
         mZm/TCoZcNm+QZ981NJWNHfhB4YN3YQ79I/+JyaQCk15eoAWX0YvaRytpm5ayAkSLPCO
         mCy/eglsvNp1TCVePYBkZs5O/fYpg7bVtTs2sQjL3lD/fhJuksbv/iHNcatoZ4gTL4We
         bmUA==
X-Gm-Message-State: ANoB5plGYSb8BcAhk92GfAlLmV4bNSoeajVQoZF08X6f+IgmSr9MPi2s
        YIBBb+pF47ZadvGUketpfWRO7bjJPqagw6oLfsyd/YynUaxiKhbityjZLess1jUAwREkKpennz9
        RrP6cfXWGPCUsOgGa550GIfyweuvjj1p+IEX8fO58TA==
X-Received: by 2002:a25:909:0:b0:6f6:e111:a9ec with SMTP id 9-20020a250909000000b006f6e111a9ecmr48384783ybj.259.1671013446803;
        Wed, 14 Dec 2022 02:24:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf61cW0VEZXZNysLUpNNresP+dckKKxSg1BOV8+R05IGkzjNCFGZ/0C6A9iUp0+CkXmSutXnr6PHEpDQw0QN8Ys=
X-Received: by 2002:a25:909:0:b0:6f6:e111:a9ec with SMTP id
 9-20020a250909000000b006f6e111a9ecmr48384777ybj.259.1671013446592; Wed, 14
 Dec 2022 02:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20221213194833.1636649-1-agruenba@redhat.com> <Y5janUs2/29XZRbc@magnolia>
 <Y5l9zhhyOE+RNVgO@infradead.org>
In-Reply-To: <Y5l9zhhyOE+RNVgO@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 14 Dec 2022 11:23:55 +0100
Message-ID: <CAHc6FU6_RduhNAmA3SgDN74Zux9OZtyRg-bUU4c3YGgO8tm9+Q@mail.gmail.com>
Subject: Re: [PATCH] iomap: Move page_done callback under the folio lock
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 10:07 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Dec 13, 2022 at 12:03:41PM -0800, Darrick J. Wong wrote:
> > On Tue, Dec 13, 2022 at 08:48:33PM +0100, Andreas Gruenbacher wrote:
> > > Hi Darrick,
> > >
> > > I'd like to get the following iomap change into this merge window.  This
> > > only affects gfs2, so I can push it as part of the gfs2 updates if you
> > > don't mind, provided that I'll get your Reviewed-by confirmation.
> > > Otherwise, if you'd prefer to pass this through the xfs tree, could you
> > > please take it?
> >
> > I don't mind you pushing changes to ->page_done through the gfs2 tree,
> > but don't you need to move the other callsite at the bottom of
> > iomap_write_begin?
>
> Yes.

I assume you mean yes to the former, because the ->page_done() call in
iomap_write_begin() really doesn't need to be moved.

> And if we touch this anyway it really should switch to passing
> a folio, which also nicely breaks any in progress code (if there is any)
> and makes them notice the change.

Okay.

> That being said, do you mean 6.2 with "this window"?  Unless the gfs2
> changes are a critical bug fix, I don't think Linux will take them if
> applied after 6.1 was released.

Yes, I really mean the merge window that is currently open.

Thanks,
Andreas

