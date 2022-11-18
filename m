Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDB62FE07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 20:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbiKRTe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 14:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiKRTeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602A538F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668800005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AG1SKrUV7k0X5TWOfCvNitOlF8TPG3jUR8Z8g6cbZlA=;
        b=RCLdgORY8+j40DnRh8lVboASLnhbW7yIWW+LiMWrrEOZsJfTUVQGW4RZxs84yrl8hJw6Ks
        Oo2uRm/wPX5zesYoiSs+tk5HI4od3kt2ZWAEKdeEvbh2tXGgsrsXol/jTTxBmnmc7R4MjW
        /0VKPOCjEKPHvJoIE2RVBF/kVCZA+eI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-ELFayDCBOaaB6ozkuGb1KQ-1; Fri, 18 Nov 2022 14:33:23 -0500
X-MC-Unique: ELFayDCBOaaB6ozkuGb1KQ-1
Received: by mail-qt1-f198.google.com with SMTP id ay12-20020a05622a228c00b003a52bd33749so5778325qtb.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 11:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG1SKrUV7k0X5TWOfCvNitOlF8TPG3jUR8Z8g6cbZlA=;
        b=2De71k2vdhB9P87jVXTlnfP9JssTEgUHsbe3A8gDnmr9SoSyI6Ou1323RG4r5J4sIZ
         8cbeXfaMMEyFcgUCndHs9z0G4sHIDnDrxzmYrULTn5hgrQoIf1TJVD/FuuHVgTT/lLGM
         MagZSSYbmdZEBpWYe359JSMrfnn9Euma7C0pABmv3kIKoxxDLrmLztRhWX2RRy3xEh64
         FkPdX4p5Lb/1JfhwLjDWyY+mfQQtUnLbW8G0DQhsOF5BbAB69c2wAIx8Keum5kfHj5ih
         Db7tqsHxFlvUUarzBVK1Ll0pcKST2H0lhk5ZRjhvDgHjC1/UC3N5Vekmk6KJBmF1Yrbm
         HOxw==
X-Gm-Message-State: ANoB5pl/11mMr4Z+WDHRUD3tgwfA5aoxEWfYJ+sL9ffsaUfwcx7aAXPe
        UNkq+4solJRvPsQd/AL1hqLjmBNxN0Uk++34unC+P5GCS4qqcYDtgA5NIN7OMYx6P7V7vgGcuk/
        IjRm+THIn7DzTI7WA8AUU+THp0Q==
X-Received: by 2002:a0c:f254:0:b0:4af:b70e:1305 with SMTP id z20-20020a0cf254000000b004afb70e1305mr7988786qvl.127.1668800002825;
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
X-Google-Smtp-Source: AA0mqf62x/DXTMrV3cfVNb2/5/8QoAelvIHCdhWqK8AdHzTbIPuGWWkL/VTiCZLNiZKnYFc2xT3sTQ==
X-Received: by 2002:a0c:f254:0:b0:4af:b70e:1305 with SMTP id z20-20020a0cf254000000b004afb70e1305mr7988767qvl.127.1668800002597;
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id a13-20020ac84d8d000000b003a5430ee366sm2391449qtw.60.2022.11.18.11.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:33:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:33:27 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <Y3feB8wHdfx48uCl@bfoster>
References: <20221024173140.30673-1-ivan@cloudflare.com>
 <Y3fYu2VCBgREBBau@bfoster>
 <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:18:36AM -0800, Ivan Babrou wrote:
> On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > > +                     const struct path *path, struct kstat *stat,
> > > +                     u32 request_mask, unsigned int query_flags)
> > > +{
> > > +     struct inode *inode = d_inode(path->dentry);
> > > +     int rv = 0;
> > > +
> > > +     generic_fillattr(&init_user_ns, inode, stat);
> > > +
> >
> > Sorry I missed this on v3, but shouldn't this pass through the
> > mnt_userns parameter?
> 
> The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
> mount aware), and it's not passed anywhere in fs/proc.
> 
> Looking at other uses of generic_fillattr, all of them use "init_user_ns":
> 

Interesting. It looks like this would have used mnt_userns from
vfs_getattr_nosec() before proc_fd_getattr() is wired up, right? I'm not
familiar enough with that change to say whether /proc should use one
value or the other, or perhaps it just doesn't matter.?

Christian?

Brian

> $ rg generic_fillattr fs/proc
> fs/proc/proc_net.c
> 301: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/base.c
> 1970: generic_fillattr(&init_user_ns, inode, stat);
> 3856: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/root.c
> 315: generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
> 
> fs/proc/generic.c
> 150: generic_fillattr(&init_user_ns, inode, stat);
> 
> fs/proc/proc_sysctl.c
> 841: generic_fillattr(&init_user_ns, inode, stat);
> 

