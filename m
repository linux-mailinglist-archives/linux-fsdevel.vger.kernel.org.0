Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218677A5912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjISE44 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjISE4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:56:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63709F2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 21:56:49 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-564b6276941so4377873a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 21:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695099409; x=1695704209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=12kF/HL+Cjs4gwXfgdrPEGdm6VElmUpKnIMvK3/u7mU=;
        b=XELaK3OX9L97fKmA6bUTG68DOXABHvzDR3eoBOYiRHai+Yfw7Ovq3N9d5fE1arGm5d
         iZ62N7gC1prMtK7K98HZs5wcCsBld3+5J6eWUlYMLnh7inqSycF8cDzGDeRRTOVD7Rcm
         2Scw9eGMiZmjTtn45zWJBDq6LZelctn6CzK4fSYaORderL+bQK5+9QMWA2g9csJ2RLgn
         Av5UUX8SfsjWYTEmXa4c8Ih7j+HKMOWFVexrvtDrMm4RL9oXNjixZPzKvDN1Y7KQ6xDD
         cYr1qBVDBqsIaxE4SFqEl9MhMRx0ULS0A9/av01lCFsIW2vxNn/lZ5YudesiL7tddUOL
         GDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695099409; x=1695704209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12kF/HL+Cjs4gwXfgdrPEGdm6VElmUpKnIMvK3/u7mU=;
        b=SL2gq/IZW7IC1+5GHeXe+jC9hgD7dcH3RaPndhYs1M2DFLRzFYiXZca2HRhSTSRKr3
         HEmbqt+TIoySSGoHU4HBJEOrgdCA9ftCsOiMj/RpoejnNeT9gnBRM8CUjdh/l652CmLi
         NiymkHNREc/AWf2up19VCVXv5etU+fAMh/b43pKLcBNMLclxM5QGVjwSePyPjj6PmxOp
         DgJeDPyM2ubxY5CO6FiVd/t+gE5+ZvYF/jTXHcDpnfhDjQNMFNk7GLJlKuppMv9VAZ3x
         wD36Ri+oluEMeihMZuXhgpVdjAglTFjPt3WpeZMH5SOsHjahQvlJ2ZG8rDbEBwIzkA9Y
         wGJw==
X-Gm-Message-State: AOJu0Yzp7Ie6toT47uw7iD8b3dnP0V3wmTTsDDxF9caIjiYnaG6dNGJK
        eSuDppuAB9trMrxsGsLHQRHIYcdHK3Y+eazxwKs=
X-Google-Smtp-Source: AGHT+IH5x45YDY6dLanOwd5ogK7EZTSgjNDuDysGAo7UwF8NC08wzRuA8id7lSkPzjxzdIfKrUfioQ==
X-Received: by 2002:a05:6a20:1444:b0:12e:5f07:7ede with SMTP id a4-20020a056a20144400b0012e5f077edemr14817960pzi.41.1695099408683;
        Mon, 18 Sep 2023 21:56:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id r11-20020a62e40b000000b006879493aca0sm7810780pfh.26.2023.09.18.21.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 21:56:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qiSmz-002eLV-0g;
        Tue, 19 Sep 2023 14:56:45 +1000
Date:   Tue, 19 Sep 2023 14:56:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        NeilBrown <neilb@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZQkqDZF9GPbrHDax@dread.disaster.area>
References: <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
 <169491481677.8274.17867378561711132366@noble.neil.brown.name>
 <CAHk-=wg_p7g=nonWOqgHGVXd+ZwZs8im-G=pNHP6hW60c8=UHw@mail.gmail.com>
 <20230917185742.GA19642@mit.edu>
 <CAHk-=wjHarh2VHgM57D1Z+yPFxGwGm7ubfLN7aQCRH5Ke3_=Tg@mail.gmail.com>
 <20230918111402.7mx3wiecqt5axvs5@quack3>
 <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whB5mjPnsvBZ4vMn7A4pkXT9a5pk4vjasPOsSvU-UNdQg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:26:24AM -0700, Linus Torvalds wrote:
> On Mon, 18 Sept 2023 at 04:14, Jan Kara <jack@suse.cz> wrote:
> >
> > I agree. On the other hand each filesystem we carry imposes some
> > maintenance burden (due to tree wide changes that are happening) and the
> > question I have for some of them is: Do these filesystems actually bring
> > any value?
> 
> I wouldn't be shocked if we could probably remove half of the
> filesystems I listed, and nobody would even notice.

That's the best argument for removing all these old filesystems from
the kernel that anyone has made so far.

As it is, I'm really failing to see how it can be argued
successfully that we can remove ia64 support because it has no users
and is a maintenance burden on kernel developers, but that same
argument doesn't appear to hold any weight when applied to a
filesystem.

What makes filesystems so special we can't end-of-life them like
other kernel code?

[....]

> And that's kind of the other side of the picture: usage matters.
> Something like affs or minixfs might still have a couple of users, but
> those uses would basically be people who likely use Linux to interact
> with some legacy machine they maintain..  So the usage they see would
> mainly be very simple operations.

Having a "couple of occasional users" really does not justify the
ongoing overhead of maintaining those filesystems in working order
as everything else around them in the kernel changes. Removing the
code from the kernel does not deny users access to their data; they
just have to use a different method to access it (e.g. an old
kernel/distro in a vm).

> And that matters for two reasons:
> 
>  (a) we probably don't have to worry about bugs - security or
> otherwise - as much. These are not generally "general-purpose"
> filesystems. They are used for data transfer etc.

By the same argument they could use an old kernel in a VM and not
worry about the security implications of all the unfixed bugs that
might be in that old kernel/distro.

>  (b) if they ever turn painful, we might be able to limit the pain further.

The context that started this whole discussion is that maintenance
of old filesystems is becoming painful after years of largely
being able to ignore them.

.....

> Anyway, based on the *current* situation, I don't actually see the
> buffer cache even _remotely_ painful enough that we'd do even that
> thing. It's not a small undertaking to get rid of the whole
> b_this_page stuff and the complexity that comes from the page being
> reachable through the VM layer (ie writepages etc). So it would be a
> *lot* more work to rip that code out than it is to just support it.

As I keep saying, the issues are not purely constrained to the
buffer cache. It's all the VFS interfaces and structures. It's all
the ops methods that need to be changed. It's all the block layer
interfaces filesystem use. It's all the page and folio interfaces,
and how the filesystems (ab)use them. And so on - it all adds up.

If we're not going to be allowed to remove old filesystems, then how
do we go about avoiding the effort required to keep those old
filesystems up to date with the infrastructure modifications we need
to make for the benefit of millions of users that use modern
filesystems and modern hardware?

Do we just fork all the code and how two versions of things like
bufferheads until all the maintained filesystems have been migrated
away from them? Or something else? 

These are the same type of questions Christoph posed in his OP, yet
this discussion is still not at the point where people have
recognised that these are the problems we need to discuss and
solve....

Dave.
-- 
Dave Chinner
david@fromorbit.com
