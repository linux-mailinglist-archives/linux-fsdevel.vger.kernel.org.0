Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1951BFF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378253AbiEEM5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378257AbiEEM5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 08:57:45 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C003562EA
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651755245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ALHOS/AhHZTnqkgAgjy6knXJ+TYy7w9Te//L0PuVbc=;
        b=FjvTu8RglBpB0JjQOKrF5b4ur6XMXUmhS91xiNOwWIa5whubccGZKrdurSv61K7rxP0zCg
        8fd8OhEU4QwUBhSdHtnJSrAECQZ0fBrRUIpNSJs5oAm9GIVa4mu1CaQfVMV7g1qhION7rF
        3x3Oo0iSmduqJwfSFeJgUsxOL03oyqI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-9INGEXHyM9CVrc7QbKjBww-1; Thu, 05 May 2022 08:54:02 -0400
X-MC-Unique: 9INGEXHyM9CVrc7QbKjBww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99F913C02B7C;
        Thu,  5 May 2022 12:54:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.32.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A5F6552AB1;
        Thu,  5 May 2022 12:54:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4D000220463; Thu,  5 May 2022 08:54:01 -0400 (EDT)
Date:   Thu, 5 May 2022 08:54:01 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
Message-ID: <YnPI6f2fRZUXbCFP@redhat.com>
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com>
 <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 11:42:51AM +0530, Dharmendra Hans wrote:
> On Thu, May 5, 2022 at 12:48 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, May 02, 2022 at 03:55:18PM +0530, Dharmendra Singh wrote:
> > > In FUSE, as of now, uncached lookups are expensive over the wire.
> > > E.g additional latencies and stressing (meta data) servers from
> > > thousands of clients. These lookup calls possibly can be avoided
> > > in some cases. Incoming three patches address this issue.
> >
> > BTW, these patches are designed to improve performance by cutting down
> > on number of fuse commands sent. Are there any performance numbers
> > which demonstrate what kind of improvement you are seeing.
> >
> > Say, If I do kernel build, is the performance improvement observable?
> 
> Here are the numbers I took last time. These were taken on tmpfs to
> actually see the effect of reduced calls. On local file systems it
> might not be that much visible. But we have observed that on systems
> where we have thousands of clients hammering the metadata servers, it
> helps a lot (We did not take numbers yet as  we are required to change
> a lot of our client code but would be doing it later on).
> 
> Note that for a change in performance number due to the new version of
> these patches, we have just refactored the code and functionality has
> remained the same since then.
> 
> here is the link to the performance numbers
> https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/

There is a lot going in that table. Trying to understand it. 

- Why care about No-Flush. I mean that's independent of these changes,
  right?  I am assuming this means that upon file close do not send
  a flush to fuse server. Not sure how bringing No-Flush into the
  mix is helpful here.

- What is "Patched Libfuse"? I am assuming that these are changes
  needed in libfuse to support atomic create + atomic open. Similarly
  assuming "Patched FuseK" means patched kernel with your changes.

  If this is correct, I would probably only be interested in 
  looking at "Patched Libfuse + Patched FuseK" numbers to figure out
  what's the effect of your changes w.r.t vanilla kernel + libfuse.
  Am I understanding it right?

- I am wondering why do we measure "Sequential" and "Random" patterns. 
  These optimizations are primarily for file creation + file opening
  and I/O pattern should not matter. 

- Also wondering why performance of Read/s improves. Assuming once
  file has been opened, I think your optimizations get out of the
  way (no create, no open) and we are just going through data path of
  reading file data and no lookups happening. If that's the case, why
  do Read/s numbers show an improvement.

- Why do we measure "Patched Libfuse". It shows performance regression
  of 4-5% in table 0B, Sequential workoad. That sounds bad. So without
  any optimization kicking in, it has a performance cost.

Thanks
Vivek

