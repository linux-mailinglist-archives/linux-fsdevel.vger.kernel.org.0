Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23ED662899
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbjAIOcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 09:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjAIOb7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:31:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB861C41A
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 06:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673274663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/5CxOh6JMVjx4DWpk0WTYPdAcLVAF5Kf4Udq+XxJnU=;
        b=Qv91eR63Tk1JM8qGM9BRbV2TBLeGgwmxHQ/K8M619BjpgOm3Ccum/fvsNFJiebgcvg5jTM
        gmh1PrLxaFjZcLB7zg+IJQycvscxgwEY5SAvXVFC91z//lbzzny6kRYTwBVkJJF4+a/r5k
        GL6RlPyx9Gw0E1MOxylaYdaefQE3w+U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-_l-7Hb-DO-umc2QdJmVIYQ-1; Mon, 09 Jan 2023 09:31:02 -0500
X-MC-Unique: _l-7Hb-DO-umc2QdJmVIYQ-1
Received: by mail-qk1-f197.google.com with SMTP id bp6-20020a05620a458600b006ffd3762e78so6582491qkb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 06:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/5CxOh6JMVjx4DWpk0WTYPdAcLVAF5Kf4Udq+XxJnU=;
        b=KzkIyBOr+NZQMEs9coUPAUTByvZ7E53ts7an00eQXoFXzoOW4pqYn+IRcIFtRkCQHm
         sXekPTZgY4/Z1ErgZf6oFtfp4D4KqvkzAOm0L/LyMnc2R+evIFy63fXXXx44pVeniR1T
         DLfW5333KxBcxpo5gcVWUwWGNagTFhGtRaP+MAtjiMbYbPJfJPBlhDRmDIUHtQN2Snv7
         /kSLkxQge/rF4C4wZHvA7kOPRlWTYkPRKK7U+wjC/V9LjMAp5rNbQEeRh86JW98i6pHa
         vWB3hlOGyAJMvWF8UX+G1l5cbUtux1cenbUFn3ECzndNJdejxsO5RpQlvruT5HGZmOSp
         Qlzg==
X-Gm-Message-State: AFqh2kpxQEvRG22lypO+e0kVv1hpzwhZNtFmxKOgd18YN0y93/o3zukY
        BKH02RDtUmcbjqs1M5cNfQGQyu3SkiyWLmCtuGQlWpF4brg8QADuTB6T4Oqle0sdXbn35il0GSg
        t67UiShHbzb1TkWT4vhgcBMCbwg==
X-Received: by 2002:a05:622a:258c:b0:3ab:9ef8:f7e8 with SMTP id cj12-20020a05622a258c00b003ab9ef8f7e8mr61154357qtb.42.1673274661757;
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs2PjV6Le5BW95OcfwC5I0zXYI7ZeewrhxYZzbihODOMKdAREvC1S3JTRjDCftXyp1XLCxvtA==
X-Received: by 2002:a05:622a:258c:b0:3ab:9ef8:f7e8 with SMTP id cj12-20020a05622a258c00b003ab9ef8f7e8mr61154334qtb.42.1673274661522;
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id x23-20020ac87ed7000000b0039467aadeb8sm4588461qtj.13.2023.01.09.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 06:31:01 -0800 (PST)
Message-ID: <05df91ed071cfefa272bb8d2fb415222867bae32.camel@redhat.com>
Subject: Re: [PATCH 02/11] filemap: Remove filemap_check_and_keep_errors()
From:   Jeff Layton <jlayton@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date:   Mon, 09 Jan 2023 09:31:00 -0500
In-Reply-To: <Y7weinAVLt0uPRa8@casper.infradead.org>
References: <20230109051823.480289-1-willy@infradead.org>
         <20230109051823.480289-3-willy@infradead.org>
         <36311b962209353333be4c8ceaf0e0823ef9f228.camel@redhat.com>
         <Y7weinAVLt0uPRa8@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-01-09 at 14:02 +0000, Matthew Wilcox wrote:
> On Mon, Jan 09, 2023 at 08:48:49AM -0500, Jeff Layton wrote:
> > On Mon, 2023-01-09 at 05:18 +0000, Matthew Wilcox (Oracle) wrote:
> > > Convert both callers to use the "new" errseq infrastructure.
> >=20
> > I looked at making this sort of change across the board alongside the
> > original wb_err patches, but I backed off at the time.
> >=20
> > With the above patch, this function will no longer report a writeback
> > error that occurs before the sample. Given that writeback can happen at
> > any time, that seemed like it might be an undesirable change, and I
> > didn't follow through.
> >=20
> > It is true that the existing flag-based code may miss errors too, if
> > multiple tasks are test_and_clear'ing the bits, but I think the above i=
s
> > even more likely to happen, esp. under memory pressure.
> >=20
> > To do this right, we probably need to look at these callers and have
> > them track a long-term errseq_t "since" value before they ever dirty th=
e
> > pages, and then continually check-and-advance vs. that.
> >=20
> > For instance, the main caller of the above function is jbd2. Would it b=
e
> > reasonable to add in a new errseq_t value to the jnode for tracking
> > errors?
>=20
> Doesn't b4678df184b3 address this problem?  If nobody has seen the
> error, we return 0 instead of the current value of wb_err, ensuring
> that somebody always sees the error.
>=20

I was originally thinking no, but now I think you're correct.

We do initialize the "since" value to 0 if an error has never been seen,
so that (sort of) emulates the behavior of the existing AS_EIO/AS_ENOSPC
flags.

It's still not quite as reliable as plumbing a "since" value through all
of the callers (particularly in the case where there are multiple
waiters), but maybe it's good enough here.

I'll look over the rest of the set.

Thanks,
--
Jeff Layton <jlayton@redhat.com>

