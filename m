Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96E1C51A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfENIi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 04:38:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35283 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfENIi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 04:38:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so8263602pgs.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=igN9DgvcsdnnQcED87MufBXYemaWzI/btuCv4zC86yk=;
        b=GyRIMQHWrRSVtwP9IB5pyhtzqC4lPgeL0Y6beT6Qu4IZvr3gGiC9moimim+D9LkzvQ
         MEEZopp3jLTd3NW9rr2av+zcSv5sG6yxATJxZch96iyR7Vt5O8iVVR9KeDDdv3u44RDl
         UaYKlPaw3B25/ilDWdybyms52YrdOWkcCimnCd0rzMk7lbnW3wG7xJD+7Y1cPxm3eo8x
         /IcHai8RyaPGpuO10KNBGL34tDo7TgLJzFqFXMzrzaYkd6OZrO9RZjsPnFXRWFxr8t0z
         83455vvpULAaytz3l+5A0IgFjdYbPuwM+AftAn4nKNFSHLn0MwKll6hrPVQk06gNdVTQ
         mAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=igN9DgvcsdnnQcED87MufBXYemaWzI/btuCv4zC86yk=;
        b=MlBkUkC0XHE4AYiRwZNthVzgXhq3Jb0IoAbXRejLMehMPxTud0O2/7IjowskxnWOuF
         ON+cWABWqwzy2GR4WDvvd61EmAFgwegyqWgA3KbMLx8IICqZnZdp/pszjubwh8xLlfNZ
         VCipQ8xbWGtdwcnvEoT0fqqNIRDON/QcUmWcFHSGrsOwhGt6f3w+2x15ZnvndtOrK5er
         cEv3subC/HhJwsmt1Mw/ewWUW4ZPIja+QAdPRGFOSrE0ACXvWG1ogaDDtBeARkgiuHD0
         zne8IN4L+dSK61T7XQNBgX5qXS/zQCR6tVKrSmXFUODtyjWKsX+CoC8Vb2xycAHwDda9
         fC4Q==
X-Gm-Message-State: APjAAAV0UkHkhN68AcLwb1KdqpSdXWtp4bmkvYB0g2HYiMmwq7RQc6Ae
        rnXXfikg+oTjsvgKjsA2EycfTA==
X-Google-Smtp-Source: APXvYqyqn2NOwOEZgtTbGy9WkrWx9lpJrCvlzVQwgRZJjBLJCvhNFSg43dsH15YYKmWUEQTHx4ScMw==
X-Received: by 2002:a65:578a:: with SMTP id b10mr20396367pgr.161.1557823106177;
        Tue, 14 May 2019 01:38:26 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id j184sm18479757pge.83.2019.05.14.01.38.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 01:38:25 -0700 (PDT)
Date:   Tue, 14 May 2019 01:38:19 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514083819.GC230665@google.com>
References: <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
 <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 03:13:40PM -0700, Frank Rowand wrote:
> On 5/10/19 9:17 AM, Logan Gunthorpe wrote:
> > 
> > 
> > On 2019-05-09 11:18 p.m., Frank Rowand wrote:
> > 
> >> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> > 
> > Cool. From my cursory look, in my opinion, these would be greatly
> > improved by converting them to the framework Brendan is proposing for Kunit.
> > 
> >>> If they do exists, it seems like it would make sense to
> >>> convert those to kunit and have Kunit tests run-able in a VM or
> >>> baremetal instance.
> >>
> >> They already run in a VM.
> >>
> >> They already run on bare metal.
> >>
> >> They already run in UML.
> > 
> > Simply being able to run in UML is not the only thing here. Kunit
> > provides the infrastructure to quickly build, run and report results for
> > all the tests from userspace without needing to worry about the details
> > of building and running a UML kernel, then parsing dmesg to figure out
> > what tests were run or not.
> 
> Yes.  But that is not the only environment that KUnit must support to be
> of use to me for devicetree unittests (this is not new, Brendan is quite
> aware of my needs and is not ignoring them).
> 
> 
> >> This is not to say that KUnit does not make sense.  But I'm still trying
> >> to get a better description of the KUnit features (and there are
> >> some).
> > 
> > So read the patches, or the documentation[1] or the LWN article[2]. It's
> > pretty well described in a lot of places -- that's one of the big
> > advantages of it. In contrast, few people seems to have any concept of
> > what kselftests are or where they are or how to run them (I was
> > surprised to find the in-kernel tests in the lib tree).
> > 
> > Logan
> > 
> > [1] https://google.github.io/kunit-docs/third_party/kernel/docs/
> > [2] https://lwn.net/Articles/780985/
> 
> I have been following the RFC versions.  I have installed the RFC patches
> and run them to the extent that they worked (devicetree unittests were
> a guinea pig for test conversion in the RFC series, but the converted
> tests did not work).  I read portions of the code while trying to
> understand the unittests conversion.  I made review comments based on
> the portion of the code that I did read.  I have read the documentation
> (very nice btw, as I have said before, but should be expanded).
> 
> My comment is that the description to submit the patch series should
> be fuller -- KUnit potentially has a lot of nice attributes, and I
> still think I have only scratched the surface.  The average reviewer
> may have even less in-depth knowledge than I do.  And as I have
> commented before, I keep diving into areas that I had no previous
> experience with (such as kselftest) to be able to properly judge this
> patch series.

Thanks for the praise! That means a lot coming from you!

I really cannot disagree that I could use more documentation. You can
pretty much always use more documentation. Nevertheless, is there a
particular part of the documentation that you think it lacking?

It sounds like there was a pretty long discussion here about, a number
of different things.

Do you want a better description of what unit testing is and how KUnit
helps make it possible?

Do you want more of an explanation distinguishing KUnit from kselftest?
How so?

Do you just want better documentation on how to test the kernel? What
tools we have at our disposal and when to use what tools?

Thanks!
