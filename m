Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0BF635D07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 13:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiKWMjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 07:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiKWMio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FA25C5E
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669207071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YBG4FEs/FFeAepPw53/HoJSqPyKF5S2QkCZjLKqE5oY=;
        b=LwAAiO3CKQs+ZxeQaja9lKIc3RWAL8pv78Kip/y3y1nI7v+PfMHR51n5jxQf+yw/nPxB3e
        0FUvJXho2TZQ2YkrtIag/pA2gdEL7utnHDfVjjrwEaGw1a7wWrJYupImAxdWmWj9dy+qw0
        WbqcKFFay2qqk8cZzMrdhwThPvi0YPI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-EsTBnfGSMEizaV5yuPxjsA-1; Wed, 23 Nov 2022 07:37:50 -0500
X-MC-Unique: EsTBnfGSMEizaV5yuPxjsA-1
Received: by mail-qk1-f199.google.com with SMTP id i21-20020a05620a405500b006fb25ba3e00so22238579qko.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:37:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBG4FEs/FFeAepPw53/HoJSqPyKF5S2QkCZjLKqE5oY=;
        b=ZGLtOB4vVrneKKK1WDR2Nc8r/V4nVOHfkVIlWNesAnJB4Li0n8TO9pyJxXtTOJFlPf
         azld+6TAtgkff/oAAtr2Ei5Ft6M0y+uMpRHm9C+rCgMuekELU1oeTmZHApTGHj5Xjrd+
         IJwk/UQ+WbgiCualLZ4csPrwtEBHktPe4H4lHJZqqXwmlMDUL7s7lOB4aASkp06L43ss
         1S6NTjZmoAmzIECwOBFAJNEYDnAKrRhvU+TAdQYWQrxVXGHqevBOZx2ZRvJPwtv/DUAJ
         /KLlFzyUlV6+pO64xx7z8TUMaYRTqQgKAA+3bEbyyJPWNz+W39Zk9AHoJ7iqDH0q8g78
         alsA==
X-Gm-Message-State: ANoB5pmmoI7qBL+V/Z14tev6KLU8a6lE1h9m8XaVNj/2GFn3WXklRBTu
        YbgigZTs64ZTlTPDGsjOQSqabe+OI1VqmXZPndW0JGSK9UB+7ZbnXKSoWSjYzccnhQYHNO8nSSw
        NPHN3teA1b63Ye/gaVtjto9qFng==
X-Received: by 2002:ae9:e009:0:b0:6fb:c25:ddb8 with SMTP id m9-20020ae9e009000000b006fb0c25ddb8mr10786162qkk.377.1669207069756;
        Wed, 23 Nov 2022 04:37:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4U4uICC1jZlLMZk7rGxcGISEnwVgE1TruGHG4MPnRqNFZ0jFgPFSMtWL3rctn9YgpXw+bJAA==
X-Received: by 2002:ae9:e009:0:b0:6fb:c25:ddb8 with SMTP id m9-20020ae9e009000000b006fb0c25ddb8mr10786146qkk.377.1669207069543;
        Wed, 23 Nov 2022 04:37:49 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006cfaee39ccesm12076404qkb.114.2022.11.23.04.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 04:37:49 -0800 (PST)
Date:   Wed, 23 Nov 2022 07:37:55 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] quota: add quota in-memory format support
Message-ID: <Y34UI9MCyq6mcIlw@bfoster>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-2-lczerner@redhat.com>
 <Y3u54l2CVapQmK/w@magnolia>
 <Y3zHn4egPhwMRcDE@infradead.org>
 <20221122142117.epplqsm4ngwx5eyy@fedora>
 <Y33SqRyAGTXVFBIF@infradead.org>
 <20221123083615.sj26ptongwhk6wcl@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123083615.sj26ptongwhk6wcl@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:36:15AM +0100, Lukas Czerner wrote:
> On Tue, Nov 22, 2022 at 11:58:33PM -0800, Christoph Hellwig wrote:
> > On Tue, Nov 22, 2022 at 03:21:17PM +0100, Lukas Czerner wrote:
> > > > That seems like a good idea for memory usage, but I think this might
> > > > also make the code much simpler, as that just requires fairly trivial
> > > > quota_read and quota_write methods in the shmem code instead of new
> > > > support for an in-memory quota file.
> > > 
> > > You mean like the implementation in the v1 ?
> > 
> > Having now found it: yes.
> > 
> 
> Jan,
> 
> do you have any argument for this, since it was your suggestion?
> 
> I also think that the implementation is much simpler with in-memory
> dquots because we will avoid all the hassle with creating and
> maintaining quota file in a proper format. It's not just reads and
> writes it's the entire machinery befind it in quota_v2.c and quota_tree.c.
> 
> But it is true that even with only user modified dquots being
> non-reclaimable until unmount it could theoreticaly represent a
> substantial memory consumption. Although I do wonder if this problem
> is even real. How many user/group ids would you expect extremely heavy
> quota user would have the limits set for? 1k, 10k, million, or even
> more? Do you know?
> 

I don't know this code well enough to have a strong opinion on the v1
vs. v2 approach in general, but FWIW it does seem to me that the benefit
of v1 from a memory savings perspective is perhaps overstated. AFAICT,
tmpfs already pins inodes/denties (notably larger than dquots) in-core
for the lifetime of the inode, so it's not like we'll be saving much
memory from dquots that are actually in-use. I think this dquot memory
should be limited indirectly by the max inode restriction, as well.

That means the potential wastage is measured in dquots that are no
longer referenced, but have previously had a non-default quota limit set
by the admin, right? Even with the v1 approach, I don't think it's wise
to just push such otherwise unused dquots into swap space indefinitely.

Perhaps a reasonable approach to the memory usage issue is to just cap
the number of dquots that are allowed to have custom limits on tmpfs?
E.g., to echo Lukas above.. if there was a cap of something like 512-1k
custom quota limits, would that really be a problem for quota users on
tmpfs? Other users would still be covered by the default mount-time
limits. Of course, you could always make such a cap flexible as a % of
tmpfs size, or configurable via mount option, etc. Just a thought.

Brian

> -Lukas
> 
> 

