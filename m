Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A9079C17E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjILBOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjILBO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:14:28 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED8E19C347
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 18:02:56 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-76ef80a503fso313208385a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 18:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694480417; x=1695085217; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pPRxdQYWFbbSl+jHzMVmAydNP48vWrPe/8h3KIcG/lw=;
        b=2bgMzYkB5XZKBPZN3R2HxRPiAxUSLns9rJtDG5kR4Hb8AMQxRnVxM/QhC9jPDasAl6
         gDQi+TEWW2p5iBi/w2HNFCAgVhir6wqaa641EGaibnu98P3DXdKHs63mqnJXY/huF+Ql
         jylbIUAvxVI6Mc288cWDfoAHslx7Sogu+2asZvcZHlcln/q78cHeK3ryA4NB86/flvAg
         M1GHn15J93bnFKHFlmLJAtcohYrS0/g/sWz4CdDQPifQARo2ZPMdtwcbxL67jVaHrkjH
         IRiXYldCJl25O8bVkBfBpxWmZhsfcv+J3Z2SQh+67fn74jF/TuKn4J4jLcDasM+7Owc3
         MDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480417; x=1695085217;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPRxdQYWFbbSl+jHzMVmAydNP48vWrPe/8h3KIcG/lw=;
        b=cKGrTHg8xjiHRbYe32dkTgILLLatuK8wL6S48iUPNQ2l5RBpA0qwRk1mhsovTT5RYp
         uGtXZLn4J3kDdYAMz+kx1gkQf/l+fY5UQ4NJlacSMcCVrhWtrKOfIPp8W7rOCMq3IaIT
         qhr3bTv67+Nr22EYrYDdRcEPFfD1ewvlUee0EOe6R9aymkMmY2A1/A10qbTR6OnxOcX9
         22sjNHeY0MG7lD8gTcBYbaJ2tyVjHDEPu/cggM1HhZRrcSFLkmIfgK0hzv9PiA2tSTEm
         qVOqb4Q0T83bhZeaIqSg9L0AeeSDePEbg1uWART5c4KXTaNsup2tD9O9IItOJpBRO8dz
         2UDA==
X-Gm-Message-State: AOJu0YwGUA/s5+pBzYXgD1PPpp7EN7/xD7eBkUtwLm+oXGe9snM2NAIc
        gtj2L+A+EhMrANkb20ta+coxAZAzgiMKo9CSQg0=
X-Google-Smtp-Source: AGHT+IFS5zLSL4VBgsFycphCfiFTrK4YLKRPjGCRN2XD6/1iVP8JzkDx3BIypwW0HdBlNiptjkSbug==
X-Received: by 2002:a17:903:486:b0:1c0:c7ae:a8a2 with SMTP id jj6-20020a170903048600b001c0c7aea8a2mr8212750plb.35.1694478196991;
        Mon, 11 Sep 2023 17:23:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id jd19-20020a170903261300b001bb0eebd90asm7106688plb.245.2023.09.11.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 17:23:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qfrBS-00E01A-0C;
        Tue, 12 Sep 2023 10:23:14 +1000
Date:   Tue, 12 Sep 2023 10:23:14 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZP+vcgAOyfqWPcXT@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <ZPe0bSW10Gj7rvAW@dread.disaster.area>
 <ZPe4aqbEuQ7xxJnj@casper.infradead.org>
 <8dd2f626f16b0fc863d6a71561196950da7e893f.camel@HansenPartnership.com>
 <ZPyS4J55gV8DBn8x@casper.infradead.org>
 <a21038464ad0afd5dfb88355e1c244152db9b8da.camel@HansenPartnership.com>
 <20230911031015.GF701295@mit.edu>
 <5dd21470139df5de7f02608f453469023f50d704.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dd21470139df5de7f02608f453469023f50d704.camel@HansenPartnership.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:03:45PM -0400, James Bottomley wrote:
> On Sun, 2023-09-10 at 23:10 -0400, Theodore Ts'o wrote:
> > On Sun, Sep 10, 2023 at 03:51:42PM -0400, James Bottomley wrote:
> [...]
> > > Perhaps we should also go back to seeing if we can prize some
> > > resources out of the major moneymakers in the cloud space.  After
> > > all, a bug that could cause a cloud exploit might not be even
> > > exploitable on a personal laptop that has no untrusted users.
> > 
> > Actually, I'd say this is backwards.  Many of these issues, and I'd
> > argue all that involve an maliciously corrupted file system, are not
> > actually an issue in the cloud space, because we *already* assume
> > that the attacker may have root.  After all, anyone can pay their $5
> > CPU/hour, and get an Amazon or Google or Azure VM, and then run
> > arbitrary workloads as root.
> 
> Well, that was just one example.  Another way cloud companies could
> potentially help is their various AI projects: I seem to get daily
> requests from AI people for me to tell them just how AI could help
> Linux.  When I suggest bug report triage and classification would be my
> number one thing, they all back off faster than a mouse crashing a cat
> convention with claims like "That's too hard a problem" and also that
> in spite of ChatGPT getting its facts wrong and spewing rubbish for
> student essays, it wouldn't survive the embarrassment of being
> ridiculed by kernel developers for misclassifying bug reports.

No fucking way.

Just because you can do something it doesn't make it right or
ethical.  It is not ethical to experiment on human subjects without
their consent.  When someone asks the maintainer of a bot to stop
doing something because it is causing harm to people, then ethics
dictate that the bot should be *stopped immediately* regardless of
whatever other benefits it might have.

This is one of the major problems with syzbot: we can't get it
turned off even though it is clearly doing harm to people.  We
didn't consent to being subject to the constant flood of issues that
it throws our way, and despite repeated requests for it to be
changed or stopped to reduce the harm it is doing the owners of the
bot refuse to change anything. If anything, they double down and
make things worse for the people they send bug reports to (e.g. by
adding explicit writes to the block device under mounted mounted
filesystems).

In this context, the bot and it's owners need to be considered rogue
actors. The owners of the bot just don't seem to care about the harm
it is doing and largely refuse to do anything to reduce that harm.

Suggesting that the solution to the harm a rogue testing bot is
causing people in the community is that we should to subject those
same people to *additional AI-based bug reporting experiments
without their consent* is beyond my comprehension.

> I'm not sure peer pressure works on the AI community, but surely if
> enough of us asked, they might one day overcome their fear of trying it
> ...

Fear isn't an issue here. Anyone with even a moderate concern about
ethics understands that you do not experiment on people without
their explicit consent  (*cough* UoM and hypocrite commits *cough*).
Subjecting mailing lists to experimental AI generated bug reports
without explicit opt-in consent from the people who receive those
bug reports is really a total non-starter.

Testing bots aren't going away any time soon, but new bots -
especially experimental ones - really need to be opt-in. We most
certainly do not need a repeat of the uncooperative, hostile "we've
turned it on and you can't opt out" model that syzbot uses...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
