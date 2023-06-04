Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3DB721AE0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 00:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjFDWfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jun 2023 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:35:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5AECE
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jun 2023 15:35:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bacf685150cso5514096276.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jun 2023 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685918115; x=1688510115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QoSIs4zNvfb2cx110HHJ+L9wWi7lERHZ03iYA48F3oo=;
        b=UDNZmJQc/76hRRdotOqkkzOaoxboYdAsDiNvjMyvox+9oKw/u3aN5fN241jarlqWNX
         xF47p0U/sN20wwJDGOMkaRixowkqsNDkFzSgH2u5fIOSI30hD0npEM/iu9Khf2+0VwDw
         G1J6Xo/+j7X6CDq6ueSTE0qCaofDvxMzDb/lVPvtzIeYSyP+HKczlAl4U5GcGx91q6uN
         mWk0QAC37xt/KgvyH4VJDar/1M+pZTa3yONCnINonB96u9W+xxBZnoZWx3nAGjK090M8
         S42yol+PkkX0XYaEGaP3t46lDT+NYXLGQSo9NGNIGr1uVVMQdFCiJZVMrlWIorf4SgWg
         CDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685918115; x=1688510115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoSIs4zNvfb2cx110HHJ+L9wWi7lERHZ03iYA48F3oo=;
        b=EQAgiP58h0T8Zopl9DdM+4yd/H4CY3xmFYbpVNPKVgO3wDU16BtF0q+nPwaGfkznwt
         aSO15ZpLB0hFQ8UOofoKyHh0ON+FfJsPNqSEzPx1OfOC7rqug2bWWBqId+Azq6WLuC3V
         TwqNq5A0bWiKT+ECtpi1trURnJs/nX7T2plSi6/vAOzLfRopU058Ov64K/5413QhAQHv
         2k2eoyClnGF9kfrBvVEqeTgdmGgXkti2GF1+qYaQ0X0vzXRBIYucbiFklyUfqXgV9vz9
         muc3oAdiFmEdsX8HkQXrjqtPBCZ4mn/W2cHc6UEAJ/AUk+3gEUGB04ubKOxT225klPPw
         jaRA==
X-Gm-Message-State: AC+VfDw4SNCLlsBtZ539z/Pz3yWAzunE7MYENz3MXDNboLRHoIz3N4i3
        cd3i7/sSeTui58CvMM1jcmbusZEwxeH12K6PZqc=
X-Google-Smtp-Source: ACHHUZ5OX7+k60eAqjAgc+x9c90Bx8PKcXkv7Tm4u0ZxlsRtVRxYIzY3hdpEHbXyiGXXvWo+whaDKw==
X-Received: by 2002:a25:f81d:0:b0:b9d:97af:610 with SMTP id u29-20020a25f81d000000b00b9d97af0610mr12254308ybd.7.1685918115677;
        Sun, 04 Jun 2023 15:35:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001ac7af58b66sm5111780plg.224.2023.06.04.15.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 15:35:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q5wJb-007rRS-24;
        Mon, 05 Jun 2023 08:35:11 +1000
Date:   Mon, 5 Jun 2023 08:35:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <ZH0Rn3hJ7gzW/UHd@dread.disaster.area>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
 <20230602145816.GA1144615@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602145816.GA1144615@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:58:16AM -0400, Theodore Ts'o wrote:
> On Fri, Jun 02, 2023 at 04:34:58PM +1000, Dave Chinner wrote:
> > However, we have a golden image that every client image is cloned
> > from. Say we set a special feature bit in that golden image that
> > means "need UUID regeneration". Then on the first mount of the
> > cloned image after provisioning, the filesystem sees the bit and
> > automatically regenerates the UUID with needing any help from
> > userspace at all.
> 
> > Problem solved, yes? We don't need userspace to change the uuid on
> > first boot of the newly provisioned VM - the filesystem just makes
> > it happen.
> 
> I agree that's a good design --- and ten years now, from all of the
> users using old versions of RHEL have finally migrated off to a
> version of some enterprise linux that supports this new feature, the
> cloud agents which are using "tune2fs -U <uuid>" or "xfs_admin -U
> <uuid>" can stop relying on it and switching to this new scheme.

We're talking about building new infrastructure - regardless
of anything else in this discussion, existing software will always
do what existing software does.

As low level infrastructure designers, we have to think *10 years
ahead* and design for when the feature will be widespread. Designing
infrastructure with "we need a fix right now" in mind almost always
ends with poor results because the focus is "this thing right now"
instead of "how will this work when this gets deployed world-wide by
everyone"....

ext4 developers and the hyperscalers that employ them made a bad
decision due to short-termism. It's only right that the wider
community pushes back against propagating that bad decision into
generic code that everyone will have to live with for the next 20+
years.

We can do better.  We *should* be doing better.

> So for the short-term, we're going to be stuck with userspace mediated
> UUID changes, and if there are going to be userspace or kernel

No, "we" aren't stuck with whacky dynamic runtime ext4 UUID changes.
*ext4 developers* and _hyperscalers that have deployed this on ext4_
are stuck with this awful stuff.

Everyone else gets to learn from the mistakes that have been made,
and "we" will end up with a generic solution that is better and will
work on all filesystems that support UUIDs, including ext4.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
