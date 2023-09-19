Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788847A5774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 04:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjISCoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 22:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjISCoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:44:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACED103
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:44:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c44a25bd0bso20209415ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695091445; x=1695696245; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DaQ7S4Czgw55gMOMG3g0mH+EVG0KMgeQe9X7+ZUKWE4=;
        b=NImYVtVgKmzalA4t9RlC5NW7DfjG8aSoEPrc7G6fKix1OPUr1QMKdtHypxXwZOx2aM
         HLstKETkciGeneLUxymtqlQRCE3eEKB07QEsxcDfUBP3nAwF26YE5nn4vI+H3LxcgKq8
         dF6T8zQl1fZdQcoPsiRPbwgooqJQa3U88wmF5yZ1X729dOn8AVdrvI+jzGPG0r1B41j0
         7CSh8CI7jxI33wz4ApO0pFd+GzcmtCxz1+Fo2NgLzgUHvglt7Pb1+i0I+IY7bOfYf5cU
         t8c7nR4jBcUVdvJyVe35QhoefvcEKgW1xHBPkmhlatm4pZtgttclOICed4iqKbcdtBmu
         COHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695091445; x=1695696245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaQ7S4Czgw55gMOMG3g0mH+EVG0KMgeQe9X7+ZUKWE4=;
        b=rIffPV4j041CKsHRFuKSZEs6Ff7HLjfKCZ76tiI4mGd/Nn3yRq7t0pWIK9pFkkIm+Z
         CMenQA4ggCAjW2t3OvfMUTxJgdUbgOIvLszOaEgGA+yn25dwSR0Y4gTEm1kaXmaCe8Wa
         U2rUD/GSEkP9Gin+0uBRXybbvzpMGVG2ka/mmos83EpCEU65NVQV7oNJPG/GvmWRq96R
         go1UUvayrBniZx4mAZOFSO0Sp1VxUtnS9LiYwcG8ZbRf8s/qiApi0BmAuOohruw2yvCq
         sz7aUgAwxXNEwFzsj1pfNcRdtaOIysf/PK4vN9OleNVyECs/ImY2sLKySDPPefuEFpO9
         NTyQ==
X-Gm-Message-State: AOJu0YwCLllfAZddvdQ3Zx7McNcen0YLUzNvIQnS701BSjpN6RFlABQR
        L2efVR+xX5d7U+NhtGSzce88EA==
X-Google-Smtp-Source: AGHT+IFaUPTzW+AZNYUCbNAzz4Yh4s2XQ3AtuwCW41UnfrtAgOKAvPJ+/XtCTVFO1ZCTe5HaxkDXVg==
X-Received: by 2002:a17:902:c109:b0:1c3:e4b8:701f with SMTP id 9-20020a170902c10900b001c3e4b8701fmr1445729pli.19.1695091445193;
        Mon, 18 Sep 2023 19:44:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902b41800b001bbdf32f011sm8879326plr.269.2023.09.18.19.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 19:44:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qiQiY-002bkQ-0x;
        Tue, 19 Sep 2023 12:44:02 +1000
Date:   Tue, 19 Sep 2023 12:44:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZQkK8kTPhFw8BpVA@dread.disaster.area>
References: <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 16, 2023 at 05:50:50PM -0400, James Bottomley wrote:
> On Sat, 2023-09-16 at 08:48 +1000, Dave Chinner wrote:
> > On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> [...]
> > >  - "they use the buffer cache".
> > > 
> > > Waah, waah, waah.
> > 
> > .... you dismiss those concerns in the same way a 6 year old school
> > yard bully taunts his suffering victims.
> > 
> > Regardless of the merits of the observation you've made, the tone
> > and content of this response is *completely unacceptable*.  Please
> > keep to technical arguments, Linus, because this sort of response
> > has no merit what-so-ever. All it does is shut down the technical
> > discussion because no-one wants to be the target of this sort of
> > ugly abuse just for participating in a technical discussion.
> > 
> > Given the number of top level maintainers that signed off on the CoC
> > that are present in this forum, I had an expectation that this is a
> > forum where bad behaviour is not tolerated at all.  So I've waited a
> > couple of days to see if anyone in a project leadership position is
> > going to say something about this comment.....
> > 
> > <silence>
> > 
> > The deafening silence of tacit acceptance is far more damning than
> > the high pitched squeal of Linus's childish taunts.
> 
> Well, let's face it: it's a pretty low level taunt and it wasn't aimed
> at you (or indeed anyone on the thread that I could find) and it was
> backed by technical argument in the next sentence.  We all have a
> tendency to let off steam about stuff in general not at people in
> particular as you did here:
> 
> https://lore.kernel.org/ksummit/ZP+vcgAOyfqWPcXT@dread.disaster.area/

There's a massive difference between someone saying no to a wild
proposal with the backing of solid ethical arguments against
experimentation on non-consenting human subjects vs someone calling
anyone who might disagree with them a bunch of cry-babies.

You do yourself a real disservice by claiming these two comments are
in any way equivalent.

> But I didn't take it as anything more than a rant about AI in general
> and syzbot in particular and certainly I didn't assume it was aimed at
> me or anyone else.

I wasn't ranting about AI at all. If you think that was what I was
talking about then you have, once again, completely missed the
point.

I was talking about the *ethics of our current situation* and how
that should dictate the behaviour of community members and bots that
they run for the benefit of the community. If a bot is causing harm
to the community, then ethics dictates that there is only one
reasonable course of action that can be taken...

This has *nothing to do with AI* and everything to do with how the
community polices hostile actors in the community. If 3rd party
run infrastructure is causing direct harm to developers and they
aren't allowed to opt out, then what do we do about it?

> If everyone reached for the code of conduct when someone had a non-
> specific rant using colourful phraseology, we'd be knee deep in
> complaints, which is why we tend to be more circumspect when it
> happens.

I disagree entirely, and I think this a really bad precedent to try
to set. Maybe you see it as "Fred has a colourful way with words",
but that doesn't change the fact the person receiving that comment
might see the same comment very, very differently.

I don't think anyone can dispute the fact that top level kernel
maintainers are repeat offenders when it comes to being nasty,
obnoxious and/or abusive. Just because kernel maintainers have
normalised this behaviour between themselves, it does not make it OK
to treat anyone else this way.

Maintainers need to be held to a higher standard than the rest of
the community - the project leaders need to set the example of how
everyone else should behave, work and act - and right now I am _very
disappointed_ by where this thread has ended up.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
