Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D733734953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 01:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFRXfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 19:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:35:07 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CFFE44
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 16:35:06 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b58351327eso175024a34.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 16:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687131305; x=1689723305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fh/QD67RXkBHOuMqDMBgCmptKVZnGnbT6cHL+zbUSS8=;
        b=lZgAzHZa/Je9B8XgN45KtCbueBGf7YzmwSs7VouPjN2kkneg9+92jCQRLQtFFkv65u
         VjJx3YV5WCio4L+1wtbUH1vxW1cRQIgiN3fRjiOEEN0zOKuq7sZ/x+2dWGzWeUnqpyHw
         JUUSl5Zc4EvHIqcI2bIjMvY9u+4oPXZx46C/4KywGVQ2fDuxo2jBmV5xrbXAi0X3aVz9
         Uy9zryMjHykSGXL2zfd2fuE1+RUmsDBW9x+HkV1S6TLkMVysh1lHKN+UnANV7mZfEuWa
         UHVFw3fYKystbr++THU2CT2e+wuz1XXcL4PSbERQjn4QO0WjWGcrbVrJxg/CeskwUzOS
         pRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687131305; x=1689723305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh/QD67RXkBHOuMqDMBgCmptKVZnGnbT6cHL+zbUSS8=;
        b=dAM4MdCEeZIqc83IvTblaGzYYfkDzJPuBQci0oQMGICZOdvLMLYuog2wSqcV+spE0B
         IGORiMuieu6RCn26+k/EoynoS17+37Ok0bscYY2FSOR63y6GALaBdPPGP2WHcT/5fyEJ
         Mzq+ewpU9hmNHq4PZbfIkjBn0UaVUWqXC5BarYXqYiCd5noa/MfOPAo+pDWveAb5qu4x
         +bVziPg8AYZPxXYxyWTdGTrxLm+q05dEDDP0LuzEhIlZI7lRDhp/srPvFAmiqCKxRnLB
         ka3qbeQT0IUqrrbhOxVnnCOdzxHf2Ns0EJvD4h52SVHwXVPLKs/Az7PhqXh6f6PzOMC9
         pnog==
X-Gm-Message-State: AC+VfDzGJzmaQp/WbTn/7ydR+M3f1IHVpdtHsb9n4Uyp0sbx3oPc89EQ
        Fnabc/0xBN+fFWf9AtKaxmenFA==
X-Google-Smtp-Source: ACHHUZ4XLGw6/vMFfxHGld2JCcJ2RIFDx573ZwSIVpvb522QQtnV+YmQECUW5hvMxcuNhEbFaRSVnA==
X-Received: by 2002:a9d:6c50:0:b0:6b5:6b95:5876 with SMTP id g16-20020a9d6c50000000b006b56b955876mr728803otq.25.1687131305552;
        Sun, 18 Jun 2023 16:35:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id v9-20020aa78089000000b006475f831838sm10110992pff.30.2023.06.18.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 16:35:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qB1vB-00DRS8-0J;
        Mon, 19 Jun 2023 09:35:01 +1000
Date:   Mon, 19 Jun 2023 09:35:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZI+UpU2OQC+XyeJy@dread.disaster.area>
References: <20230612161614.10302-1-jack@suse.cz>
 <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
 <20230614020412.GB11423@frogsfrogsfrogs>
 <CACT4Y+YTfim0VhX6mTKyxMDVvY94zh7OiOLjv-Fs0kgj=vi=Qg@mail.gmail.com>
 <ZIpPgC57bhb1cMNL@dread.disaster.area>
 <CACT4Y+aqL_woqyGuxVGc-F2TEbk7i4OguiudDrA1cWpOi-n50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aqL_woqyGuxVGc-F2TEbk7i4OguiudDrA1cWpOi-n50Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:14:53AM +0200, Dmitry Vyukov wrote:
> On Thu, 15 Jun 2023 at 01:38, Dave Chinner <david@fromorbit.com> wrote:
> > Hence the claim that "because syzbot doesn't run we don't have
> > visibility of code bugs" is naive, conceited, incredibly
> > narcissistic and demonstratable false. It also indicates a very
> > poor understanding of where syzbot actually fits into the overall
> > engineering processes.
> 
> Hi Dave, Ted,
> 
> We are currently looking into options of how to satisfy all parties.
> 
> I am not saying that all of these bugs need to be fixed, nor that they
> are more important than bugs in supported parts. And we are very much
> interested in testing supported parts as well as we can do.
> 
> By CONFIG_INSECURE I just meant something similar to kernel taint
> bits.

How is that any better?  Who gets to decide what sets
this taint? Subsystem maintainers?

> A user is free to continue after any bad thing has happened/they
> did, but some warranties are void. And if a kernel developer receives
> a bug report on a tainted kernel, they will take it with a grain of
> salt. So it's important to note the fact and inform about it.
> Something similar here: bugs in deprecated parts do not need to be
> fixed, and distros are still free to enable them, but this fact is
> acknowledged by distros and made visible to users.

"Deprecated" does not mean *unmaintained*. They are two completely
different things, and conflating the two does not help anyone.

You are talking about marking unmaintained code with a taint, not
deprecated code. reiserfs is unmaintained code. ntfs3 is
unmaintained code. hfs is unmaintained code. There are several other
unmaintained filesystems that don't have active maintainers.  Bug
reports never, ever get looked at, etc. Sure, there's an argument to
taint them.

But whilst XFS v4 is deprecated, it is still very much maintained.
We encourage people to move off V4, we focus less on it, but if bug
reports from users come in, we still fix them. So even if you
introduce some "unmaintained" taint for the kernel, you aren't going
to see it get set for the XFS V4 format.

> But we are looking into other options that won't require even CONFIG_INSECURE.

Who is this nebulous "we"?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
