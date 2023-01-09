Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03328662F70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 19:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjAISqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 13:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjAISq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACDAA
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673289941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OBdxaz+hVkdsSEH2VxeqeTgj+6Xw+8m/8DNP4CLwX2k=;
        b=TmUHEMh96/ZCpZctKCE2vxzwxMZhBDbIicN9XxPU0hRCrSB2C0upnECNjXPjb2unNAFX25
        EKHeP6JV3ySEvxTSBXawQCXQvoLsJkxdUDQqMCyx0J+64EqFsULTitcp1HqUWnuLfir62W
        0YkqML0nkbXFvPtoSc6yVoWeOgf1V7k=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-88leQv1XO-mL0ma9sHmcLA-1; Mon, 09 Jan 2023 13:45:40 -0500
X-MC-Unique: 88leQv1XO-mL0ma9sHmcLA-1
Received: by mail-pg1-f197.google.com with SMTP id s76-20020a632c4f000000b0049ceb0f185eso3990620pgs.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 10:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBdxaz+hVkdsSEH2VxeqeTgj+6Xw+8m/8DNP4CLwX2k=;
        b=odaQQ5zuOpVB/jU/7S4v0v6IYAhzHm5NpB4lkyQYEaEO9t7Xzq7PFvq3aChuXRk3Jx
         P+CM04SeGl0wj8kgo1PN0GGWIzAQM/62CV2SdHw6a8vkl2ZcXUkhrElpXKuyzxY2HV3s
         +VLwhNRIj+01ZS8yrqPZihj0Zmz/DqhullsHQ/wpJkgFQ10NwShN2pJ/n7uA4/kN04gh
         jfONNZS7n7acsDuyI7DsN254gKyQl18Z7vRp9dFIJTkh0Fga1keK83jId4DKFF+7sKQK
         dHQT2tLqMkY8FGYdmp0qZTNMNRW6A2gqzk8/TPIqmMsQ6PzME8QdMpr+zhsaWPMRBPQZ
         IThw==
X-Gm-Message-State: AFqh2krPr0tvRBvK0DhWXqLro1eEU5QijEbA919ELiJjZ8NzP7RycgSl
        s/PWjpJLB7z8gI+QwRYLpqaFaReYvyY2yq3wzC8ZqbErqVV3LBHRpppgzKWwnPusCWEjkF3ZK50
        BW+dEAU8NvKZwkIPMiygylWty/BwAZ2r3QTuGTZgBBQ==
X-Received: by 2002:a65:68c7:0:b0:4a2:d7ef:742a with SMTP id k7-20020a6568c7000000b004a2d7ef742amr1949086pgt.536.1673289939457;
        Mon, 09 Jan 2023 10:45:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWzDB61RFPkGZMxNhIFbmnTWsXzRwrl/mBojgRuoVDxrVvPOFKyxdjaDVl5vKiHvxHqafKv7FMRJIzVJSlsoQ=
X-Received: by 2002:a65:68c7:0:b0:4a2:d7ef:742a with SMTP id
 k7-20020a6568c7000000b004a2d7ef742amr1949084pgt.536.1673289939171; Mon, 09
 Jan 2023 10:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20230108194034.1444764-1-agruenba@redhat.com> <20230108194034.1444764-9-agruenba@redhat.com>
 <20230108215911.GP1971568@dread.disaster.area>
In-Reply-To: <20230108215911.GP1971568@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 9 Jan 2023 19:45:27 +0100
Message-ID: <CAHc6FU4z1nC8zdM8NvUyMqU29_J7_oNu1pvBHuOvR+M6gq7F0Q@mail.gmail.com>
Subject: Re: [RFC v6 08/10] iomap/xfs: Eliminate the iomap_valid handler
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
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

On Sun, Jan 8, 2023 at 10:59 PM Dave Chinner <david@fromorbit.com> wrote:
> On Sun, Jan 08, 2023 at 08:40:32PM +0100, Andreas Gruenbacher wrote:
> > Eliminate the ->iomap_valid() handler by switching to a ->get_folio()
> > handler and validating the mapping there.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> I think this is wrong.
>
> The ->iomap_valid() function handles a fundamental architectural
> issue with cached iomaps: the iomap can become stale at any time
> whilst it is in use by the iomap core code.
>
> The current problem it solves in the iomap_write_begin() path has to
> do with writeback and memory reclaim races over unwritten extents,
> but the general case is that we must be able to check the iomap
> at any point in time to assess it's validity.
>
> Indeed, we also have this same "iomap valid check" functionality in the
> writeback code as cached iomaps can become stale due to racing
> writeback, truncated, etc. But you wouldn't know it by looking at the iomap
> writeback code - this is currently hidden by XFS by embedding
> the checks into the iomap writeback ->map_blocks function.
>
> That is, the first thing that xfs_map_blocks() does is check if the
> cached iomap is valid, and if it is valid it returns immediately and
> the iomap writeback code uses it without question.
>
> The reason that this is embedded like this is that the iomap did not
> have a validity cookie field in it, and so the validity information
> was wrapped around the outside of the iomap_writepage_ctx and the
> filesystem has to decode it from that private wrapping structure.
>
> However, the validity information iin the structure wrapper is
> indentical to the iomap validity cookie,

Then could that part of the xfs code be converted to use
iomap->validity_cookie so that struct iomap_writepage_ctx can be
eliminated?

> and so the direction I've
> been working towards is to replace this implicit, hidden cached
> iomap validity check with an explicit ->iomap_valid call and then
> only call ->map_blocks if the validity check fails (or is not
> implemented).
>
> I want to use the same code for all the iomap validity checks in all
> the iomap core code - this is an iomap issue, the conditions where
> we need to check for iomap validity are different for depending on
> the iomap context being run, and the checks are not necessarily
> dependent on first having locked a folio.
>
> Yes, the validity cookie needs to be decoded by the filesystem, but
> that does not dictate where the validity checking needs to be done
> by the iomap core.
>
> Hence I think removing ->iomap_valid is a big step backwards for the
> iomap core code - the iomap core needs to be able to formally verify
> the iomap is valid at any point in time, not just at the point in
> time a folio in the page cache has been locked...

We don't need to validate an iomap "at any time". It's two specific
places in the code in which we need to check, and we're not going to
end up with ten more such places tomorrow. I'd prefer to keep those
filesystem internals in the filesystem specific code instead of
exposing them to the iomap layer. But that's just me ...

If we ignore this particular commit for now, do you have any
objections to the patches in this series? If not, it would be great if
we could add the other patches to iomap-for-next.

By the way, I'm still not sure if gfs2 is affected by this whole iomap
validation drama given that it neither implements unwritten extents
nor delayed allocation. This is a mess.

Thanks,
Andreas

