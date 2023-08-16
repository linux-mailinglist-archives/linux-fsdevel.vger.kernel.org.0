Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422D77DA1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbjHPGFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 02:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbjHPGFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92F81FE6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 23:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692165854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2SN3FtMPWOYoJEWsWtLTr+p00cJScPn6dytSX+zKSw=;
        b=P2iH2zl0J2PmOHXjVr7RhJWBR+J5pHWTeuDKG5bsRcasqDopXV1RODdyzPDsNs6XZ9sjyf
        rVnJbVJ8//hLUJyfseY4mBg2q8sRK8njkufR30b9Xg/rGh3Stc5Gar3V+QnFNqtmSEV16f
        k+UasajsmdTiGqJPiN0Y5gOTxkcHdhw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-uzYp2BjzNEWYfh5mAHcztg-1; Wed, 16 Aug 2023 02:04:12 -0400
X-MC-Unique: uzYp2BjzNEWYfh5mAHcztg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bbebf511abso73964685ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 23:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692165852; x=1692770652;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2SN3FtMPWOYoJEWsWtLTr+p00cJScPn6dytSX+zKSw=;
        b=KOedVybCAM2o2ClCGco3rsA4xxDf4bcPyFelWea9Onq87Yds0USy0qILRo/pFUZz5+
         zksWg6A2UNz27dV9ccOTOCX/QITGwaZH9LjudlndyhW8fhEPwBURDa+6QBkoL658IHOb
         k7PCWjLVWNKuoi7gIALG99LBe0soI6MJ1sdUDmoxv0j7J7alEAAIF0AogET4NiipEf6a
         1h+1YmLn3/O8hAmefer19vI6n+msMMIEZhUbVhpYcxne8vzqjj8oxTjR3dKNf3butSO7
         jQxcTMMAHn5/jrzyoDT1M/R2QontTyHtZLPVJbzEnTz9cgmXNvt1Vot4sgCnm5+fpuQo
         y1JA==
X-Gm-Message-State: AOJu0YytuwwvlYun01QX2V8WlgsFtJhBlRhk5RTKVukc3DjVdRnjBmw9
        GTpgSffXtXGvJ5+/zbsxA2D+w0AMX67wfj90ygpzIcul5CjeiBMc4nsmJWRYzCpbCMLWOkHYc1F
        E3xoCTxjp8wdmapqjiIUPJEQHXA==
X-Received: by 2002:a17:903:2796:b0:1bd:f1a7:8293 with SMTP id jw22-20020a170903279600b001bdf1a78293mr807064plb.69.1692165851857;
        Tue, 15 Aug 2023 23:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS3SdxCOU/alsfStDzwCuPlhoClV2uZlYDjYjqcKgGb+s5pwSHzVGQpdAqkgVd/4Z3H89y+A==
X-Received: by 2002:a17:903:2796:b0:1bd:f1a7:8293 with SMTP id jw22-20020a170903279600b001bdf1a78293mr807042plb.69.1692165851494;
        Tue, 15 Aug 2023 23:04:11 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903230b00b001b8af7f632asm12136464plh.176.2023.08.15.23.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 23:04:10 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:04:05 +0800
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
Message-ID: <20230816060405.u26tvypmh4tcovef@zlang-mailbox>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816001108.GA1348949@frogsfrogsfrogs>
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

On Tue, Aug 15, 2023 at 05:11:08PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 15, 2023 at 04:54:55PM -0700, Luis Chamberlain wrote:
> > On Sat, Aug 12, 2023 at 12:05:33PM +0300, Amir Goldstein wrote:
> > > On Sat, Aug 12, 2023 at 3:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> > > > > On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > > > > > +Roles
> > > > > > +-----
> > > > > > +There are seven key roles in the XFS project.
> > > > > > +- **Testing Lead**: This person is responsible for setting the test
> > > > > > +  coverage goals of the project, negotiating with developers to decide
> > > > > > +  on new tests for new features, and making sure that developers and
> > > > > > +  release managers execute on the testing.
> > > > > > +
> > > > > > +  The testing lead should identify themselves with an ``M:`` entry in
> > > > > > +  the XFS section of the fstests MAINTAINERS file.
> 
>                                     ^^^^^^^^^^^^^^^^^^^
> > > > >
> > > > > I think breaking responsibility down is very sensible, and should hopefully
> > > > > allow you to not burn out. Given I realize how difficult it is to do all
> > > > > the tasks, and since I'm already doing quite a bit of testing of XFS
> > > > > on linux-next I can volunteer to help with this task of testing lead
> > > > > if folks also think it may be useful to the community.
> > > > >
> > > > > The only thing is I'd like to also ask if Amir would join me on the
> > > > > role to avoid conflicts of interest when and if it comes down to testing
> > > > > features I'm involved in somehow.
> > > >
> > > > Good question.  Amir?
> > > >
> > > 
> > > I am more than happy to help, but I don't believe that I currently perform
> > > or that I will have time to perform the official duties of **Testing
> > > Lead** role.
> > > 
> > > I fully support the nomination of Luis and I think the **Release Manager**
> > > should be able to resolve any conflict of interests of the **Testing Lead**
> > > as feature developer should any such conflicts arise :)
> > 
> > Fair enough.
> > 
> > Darrick, I suppose just one thing then, using M for Testing Lead seems
> > likely to implicate the 'Testing Lead' getting Cc'd on every single new

Do you hope to get CC address/list ...

> > patch. As much as I could help review, I don't think I can commit to
> > that, and I think that's the point of the current split. To let us split
> > roles to help scale stuff.
> 
> Note that we're talking about "M:" entries in the *fstests* MAINTAINERS
> file, not the kernel...

... from fstests project, for a patch on a linux-$FSTYP project?

That's weird to me. 

> 
> > So how about a separate new prefix, TL: ? Adding Linus in case he has
> > a stronger preference to only keep us at one character fist index on
> > MAINTAINERS.
> 
> ...so I'm cc'ing Zorro since he's the owner of the relevant git repo.
> Hey Zorro, do you have any opinions about how to record who's
> responsible for each filesystem adding tests for new code and whatnot?

I think a specific fs test lead is a contributer for that fs project more,
not for fstests. The test lead need to report test results to that fs
project, not necessary to report to fstests.

And a test lead might do more testing besides fstests. So I can't imagine
that I need to check another project to learn about who's in charge of the
current project I'm changing.

(If I understood anything wrong, please correct me:)

Thanks,
Zorro

> 
> --D
> 
> > 
> >   Luis
> 

