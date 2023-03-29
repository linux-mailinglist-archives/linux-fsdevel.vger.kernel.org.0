Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7A86CF35D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 21:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC2TmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjC2Tly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0385BAE
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680118865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=np8vWIlQ+v2ijN50x+Ku8EC8uzXFlwApSDs6+DUB4YQ=;
        b=CTHj+5ulom0yej5fV4YO9JqbNsAlBhnM2EUIdOx7Kv796juvQ+n8OoNQU+2Iz3ZoQ1IewL
        ts5kvV4yUHBoOtF+3bubi+HEEVkBqb4MRs6F6wYwkOoGY9SXaO0EhuGWCJ/5k0YN9gSKTp
        r8uajItW2UJcEDiLVI85NfH0w0rHf58=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-cRe2dfEUPlGP4g0fWUiVBw-1; Wed, 29 Mar 2023 15:41:04 -0400
X-MC-Unique: cRe2dfEUPlGP4g0fWUiVBw-1
Received: by mail-qt1-f198.google.com with SMTP id w13-20020ac857cd000000b003e37d3e6de2so10960587qta.16
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118863; x=1682710863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=np8vWIlQ+v2ijN50x+Ku8EC8uzXFlwApSDs6+DUB4YQ=;
        b=J2rKcePQC8JmJgT4BpV+Kdw1y2PkTZntzGzcusnoJgwf3Walhky4kYQbDY7Ifxfjnn
         M619UJPzyxh4ahfpCITCcTTJYgjpMI+Flkv3/Ejkm9tWcEK0KPzkKVJS1RRuExZVnW70
         uQmCIIUQEY1N7IihOIIEbQo2cDq/tLwiZOrOmEaB+BiLRjc3B5b0kYwuaIGmTwvu2gSO
         wG2LFrkvwLJNVkRUbBxFDVt8hK4h7dh9yCHHBDQEBTAH/0E94K9Hfth3bJkUWvef9CeY
         iY6eRImddGeQ0HP17ixuVt5SJGwgaqjwUEW5KqWnwmO4fnBOr5QcMiq+EdOZNUSXoxlT
         9Fng==
X-Gm-Message-State: AAQBX9d2TAtdMh1e3q49k5mgtfVPvfZTUQL6EUiISA/shl0AYFsLkMS1
        oLE9DZXTPHf1n2a+v6lj8BJyDD6cozPj5++jb9eg1hcqC8Uiya/KduBpT4mdDZJ9/N3rPEQgQU9
        BZyM1VpXUmWhjgfTxAjoeJ7XXoQ==
X-Received: by 2002:a05:6214:409:b0:56c:222d:427a with SMTP id z9-20020a056214040900b0056c222d427amr32374993qvx.1.1680118863439;
        Wed, 29 Mar 2023 12:41:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350beCRIu7VzJno1QTnNsCw1pZmRV6igDjjS/pY6b+5FxGAYv86IgYq9XMU67rDUGaXNwUgQxCw==
X-Received: by 2002:a05:6214:409:b0:56c:222d:427a with SMTP id z9-20020a056214040900b0056c222d427amr32374970qvx.1.1680118863150;
        Wed, 29 Mar 2023 12:41:03 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id 123-20020a370581000000b007456df35859sm14434041qkf.74.2023.03.29.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:02 -0700 (PDT)
Date:   Wed, 29 Mar 2023 15:41:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: don't fail on unrecognized features
Message-ID: <ZCSUTSbAcwBINiNk@x1n>
References: <20220722201513.1624158-1-axelrasmussen@google.com>
 <ZCIEGblnsWHKF8RD@x1n>
 <CAJHvVcj5ysY-xqKLL8f48-vFhpAB+qf4cN0AesQEd7Kvsi9r_A@mail.gmail.com>
 <ZCNDxhANoQmgcufM@x1n>
 <CAJHvVcjU8QRLqFmk5GXbmOJgKp+XyVHMCS0hABtWmHTDuCusLA@mail.gmail.com>
 <ZCNPFDK0vmzyGIHb@x1n>
 <CAJHvVciwT0xw3Nu2Fpi-7H9iR92xK7VB31dYLfmJF5K3vQxvFQ@mail.gmail.com>
 <ZCNrWRKl4nCJX3pg@x1n>
 <CAJHvVch52KG3V6eQY47t2hbJfEczdLgxcg65VWZdzML6bVFXeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVch52KG3V6eQY47t2hbJfEczdLgxcg65VWZdzML6bVFXeg@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:53:38AM -0700, Axel Rasmussen wrote:
> On Tue, Mar 28, 2023 at 3:34 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Mar 28, 2023 at 02:52:35PM -0700, Axel Rasmussen wrote:
> > > I don't see being very strict here as useful. Another example might be
> > > madvise() - for example trying to MADV_PAGEOUT on a kernel that
> > > doesn't support it. There is no way the kernel can proceed here, since
> > > it simply doesn't know how to do what you're asking for. In this case
> > > an error makes sense.
> >
> > IMHO, PAGEOUT is not a great example.  I wished we can have a way to probe
> > what madvise() the system supports, and I know many people wanted that too.
> > I even had a feeling that we'll have it some day.
> >
> > So now I'm going back to look at this patch assuming I'm reviewing it, I'm
> > still not convinced the old API needs changing.
> >
> > Userfaultfd allows probing with features=0 with/without this patch, so I
> > see this patch as something that doesn't bring a direct functional benefit,
> 
> The benefit is we combine probing for features and creating a
> userfaultfd into a single step, so userspace doesn't have to open +
> manipulate a userfaultfd twice. In my mind, both approaches achieve
> the same thing, it's just that one requires extra steps to get there.
> 
> To me, it's still unclear why there is any harm in supporting the
> simpler way? And, I also don't see any way in which the more complex
> way is better?

Because that's what the man page says? :)

> 
> > but some kind of api change due to subjective preferences which I cannot
> > say right or wrong.  Now the patch is already merged.  If we need to change
> > either this patch or the man page to make them match again, again I'd
> > prefer we simply revert it to keep everything like before and copy stable.
> 
> I think we need to change documentation either way. But, I think the
> changes needed are actually bigger if we want to revert.

IIUC the man page doesn't need to update if we revert this patch.

The man page described clearly on what will happen if we pass in feature
bits that are not supported:

       To enable userfaultfd features the application should set a bit
       corresponding to each feature it wants to enable in the features
       field.  If the kernel supports all the requested features it will
       enable them.  Otherwise it will zero out the returned uffdio_api
       structure and return EINVAL.

> With the simpler behavior, the selftest and the example program in the
> man page are ~correct as-is; otherwise we would need to modify those
> to use the two-step probing method.
> 
> (By the way, I am excited about the selftest refactoring you talked
> about! Thanks for doing that work. It definitely needs it, the
> complexity there has gotten significantly worse as we've added more
> things onto it [wp, minor faults].)

I'll definitely copy you when I post it.  It growed a bit larger than I
thought, it'll be great if you can help have a look.

In the test cases I added an UFFDIO_API test to be the 1st one and that's
why I found this issue.  To let all tests pass currently I'll need to
revert this patch.  If you want we can move the discussion there when I
post it, I think that may need to be the 1st patch for the test suite
change and to let current test suite pass.

> I think the man page description of how to use the API is incomplete
> in either case. Right now it sort of alludes to the fact that you can
> probe with features==0, but it doesn't explicitly say "you need to
> probe first, then close that userfaultfd and open the real one you
> want to use, with a subset of the features reported in the first
> step". If we want to keep the old behavior, it should be more explicit
> about the steps needed to get a userfaultfd.

To tell the truth, if I'm going to change the API anyway, I'll simply add a
UFFDIO_FEATURES ioctl() returning the supported features, that'll be much,
much easier than either the old one or the one this patch proposed, IMHO.
Then we keep all the rest untouched.  That should work perfectly and
that'll not require open()/close() duplications either.

But as I mentioned before, I don't think UFFDIO_FEATURES justifies itself
either much on being worthwhile because it introduces a new ioctl without
any major benefit.  At least we'll need to keep the old behavior still
working.

> 
> You are right that it also doesn't describe "you can just ask for what
> you want, and the kernel tells you what subset it can give you; you
> need to check that the reported features are acceptable" - the new
> behavior. That should be updated.

-- 
Peter Xu

