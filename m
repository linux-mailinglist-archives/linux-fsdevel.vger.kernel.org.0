Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D56781744
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjHSDx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 23:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjHSDxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E822421D
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 20:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692417147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cy3Z7SW+rCdzzNQYguFXCQzqr1tVMIrLJOSnaM0sZUk=;
        b=U9S5LFhTTh28fGnowvX1+KztPgmcMoGddf5J9p4OcX/SpyJ+dVtHvkVto8QWCPGy04pSmv
        Jtj0TWlTSLWlvdiI18UXllO7hniFEOR9lMOb2HdniHq0ee0m2znOKUQwmrt92i7bISrpFb
        7U2BOjl3aM29Kyfx9yrUCttgf18IyIc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rnWX7cUIPoqouk55qI6AfA-1; Fri, 18 Aug 2023 23:52:25 -0400
X-MC-Unique: rnWX7cUIPoqouk55qI6AfA-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a5a7e981ddso2132798b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 20:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692417145; x=1693021945;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy3Z7SW+rCdzzNQYguFXCQzqr1tVMIrLJOSnaM0sZUk=;
        b=RSy5I8BYmoJYRexx/cAFHyxllnEzE7gme0ZNlPmvjcPCPi2C+zKNHTEr76bqko0SvP
         grb+noN0NY2XnNNHKN8NqClnW5tz7M9PW779WWO8uNs2xqhItio8ZTihcvJrBM+UhpC+
         Hyx/6IF6dCZwetmyhJ4EbhF0c7l2tce398mKKmojiHAWM0zYyVA5ShjnO2faYosXHRGq
         4R5il7S8WgsdFK+Nnicwkmwo6Evr777hKgeJwGvlsErIp4pUCKfTwhPcKWIBAfZERCMH
         +aQBq+ykdfo2Yly6QAltYA1BOFv7xdS+hGx4Yfam0sMogWJbCm9nXndterQqvRntVvGI
         6Wew==
X-Gm-Message-State: AOJu0YxUooZnKWe7LsRHQfsFGlkjDAMywFHuZCFaSkCU9xtxAoYciEY2
        risf7SypfPp28f2i2LiLCuzfg+iv3MelN0OUkVOoTvif22sYqTo2Alovg0iVELneJnMYFF/8Zyl
        fRbFQsY4OktpfiF7e9pmoa5FT/w==
X-Received: by 2002:a05:6808:5c5:b0:3a7:46c3:c5c3 with SMTP id d5-20020a05680805c500b003a746c3c5c3mr1148598oij.50.1692417144808;
        Fri, 18 Aug 2023 20:52:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESaLnr41gmdVixaAgFE9CzdYmktFVjsKz5nqdOZeXa3aYpnijK0jBcmBHQ38eTIILLOjtCoA==
X-Received: by 2002:a05:6808:5c5:b0:3a7:46c3:c5c3 with SMTP id d5-20020a05680805c500b003a746c3c5c3mr1148580oij.50.1692417144511;
        Fri, 18 Aug 2023 20:52:24 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x13-20020aa784cd000000b00666e883757fsm2246962pfn.123.2023.08.18.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:52:24 -0700 (PDT)
Date:   Sat, 19 Aug 2023 11:52:18 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <20230819035218.yajnnxjy4zwhhogr@zlang-mailbox>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
 <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
 <20230817003345.GV11377@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230817003345.GV11377@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:33:45PM -0700, Darrick J. Wong wrote:
> On Wed, Aug 16, 2023 at 02:04:05PM +0800, Zorro Lang wrote:
> > On Tue, Aug 15, 2023 at 05:11:08PM -0700, Darrick J. Wong wrote:
> > > On Tue, Aug 15, 2023 at 04:54:55PM -0700, Luis Chamberlain wrote:
> > > > On Sat, Aug 12, 2023 at 12:05:33PM +0300, Amir Goldstein wrote:
> > > > > On Sat, Aug 12, 2023 at 3:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > >
> > > > > > On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > > > > > > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > > > > > > +Roles
> > > > > > > > +-----
> > > > > > > > +There are seven key roles in the XFS project.
> > > > > > > > +- **Testing Lead**: This person is responsible for setting the test
> > > > > > > > +  coverage goals of the project, negotiating with developers to decide
> > > > > > > > +  on new tests for new features, and making sure that developers and
> > > > > > > > +  release managers execute on the testing.
> > > > > > > > +
> > > > > > > > +  The testing lead should identify themselves with an ``M:`` entry in
> > > > > > > > +  the XFS section of the fstests MAINTAINERS file.
> > > 
> > >                                     ^^^^^^^^^^^^^^^^^^^
> > > > > > >
> > > > > > > I think breaking responsibility down is very sensible, and should hopefully
> > > > > > > allow you to not burn out. Given I realize how difficult it is to do all
> > > > > > > the tasks, and since I'm already doing quite a bit of testing of XFS
> > > > > > > on linux-next I can volunteer to help with this task of testing lead
> > > > > > > if folks also think it may be useful to the community.
> > > > > > >
> > > > > > > The only thing is I'd like to also ask if Amir would join me on the
> > > > > > > role to avoid conflicts of interest when and if it comes down to testing
> > > > > > > features I'm involved in somehow.
> > > > > >
> > > > > > Good question.  Amir?
> > > > > >
> > > > > 
> > > > > I am more than happy to help, but I don't believe that I currently perform
> > > > > or that I will have time to perform the official duties of **Testing
> > > > > Lead** role.
> > > > > 
> > > > > I fully support the nomination of Luis and I think the **Release Manager**
> > > > > should be able to resolve any conflict of interests of the **Testing Lead**
> > > > > as feature developer should any such conflicts arise :)
> > > > 
> > > > Fair enough.
> > > > 
> > > > Darrick, I suppose just one thing then, using M for Testing Lead seems
> > > > likely to implicate the 'Testing Lead' getting Cc'd on every single new
> > 
> > Do you hope to get CC address/list ...
> > 
> > > > patch. As much as I could help review, I don't think I can commit to
> > > > that, and I think that's the point of the current split. To let us split
> > > > roles to help scale stuff.
> > > 
> > > Note that we're talking about "M:" entries in the *fstests* MAINTAINERS
> > > file, not the kernel...
> > 
> > ... from fstests project, for a patch on a linux-$FSTYP project?
> > 
> > That's weird to me. 
> 
> Not for the kernel, no.  Just the contributions to fstests.
> 
> For example, if I were sending a patch deluge, the online fsck testing
> patches would be cc'd to you; to whomever's listed as M: under XFS in
> fstests MAINTAINERS; and fstests@ and linux-xfs@.
> 
> The kernel patches would be cc'd to linux-xfs, and to whomever steps up
> to review the code (who are we kidding, dchinner).
> 
> xfsprogs patches for online fsck would be cc'd to linux-xfs and Carlos.
> 
> > 
> > > 
> > > > So how about a separate new prefix, TL: ? Adding Linus in case he has
> > > > a stronger preference to only keep us at one character fist index on
> > > > MAINTAINERS.
> > > 
> > > ...so I'm cc'ing Zorro since he's the owner of the relevant git repo.
> > > Hey Zorro, do you have any opinions about how to record who's
> > > responsible for each filesystem adding tests for new code and whatnot?
> > 
> > I think a specific fs test lead is a contributer for that fs project more,
> > not for fstests. The test lead need to report test results to that fs
> > project, not necessary to report to fstests.
> 
> I disagree -- yes, /developers/ (and the release manager) should be
> running tests and reporting those results to that fs project.
> 
> However, I defined the testing lead (quoting from above):
> 
> "**Testing Lead**: This person is responsible for setting the test
> coverage goals of the project, negotiating with developers to decide
> on new tests for new features, and making sure that developers and
> release managers execute on the testing."
> 
> In my mind, that means the testing lead should be reviewing changes
> proposed for tests/xfs/* in fstests by XFS developers to make sure that
> new features are adequately covered; and checking that drive-by
> contributions from others fit well with what's already there.
> 
> (That's what I thought you wanted out from the people mentioned in the
> fstests MAINTAINERS file...)

OK, you or (the one you nominate to be the XFS testing lead) might want to send
a patch to fstests@, to add a "M: xxx" under "XFS" (xfstests/MAINTAINERS.),
and add this new definition of "Testing lead" part to "M:" flag in
xfstests/MAINTAINERS. We can talk about more details under that patch.

Thanks,
Zorro

> 
> > And a test lead might do more testing besides fstests. So I can't imagine
> > that I need to check another project to learn about who's in charge of the
> > current project I'm changing.
> 
> ...so the testing lead would be the person who you'd talk to directly
> about changes that you want to make.
> 
> (Wait, who is "I" here?  You, Zorro?  Or were you paraphrasing a
> developer?)
> 
> --D
> 
> > (If I understood anything wrong, please correct me:)
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > 
> > > >   Luis
> > > 
> > 
> 

