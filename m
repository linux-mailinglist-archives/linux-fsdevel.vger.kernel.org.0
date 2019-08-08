Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8806885B69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfHHHR3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 03:17:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfHHHR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:17:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so90574578wrm.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 00:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=sm6fYVDkcPTF7LJfQsGbQg6KjeK+khdgWJ1+4in8e6k=;
        b=IErSXtqHmOwFglOaNA/jMa8qrbHbOLkR8gef3hGkBo29KZrxnHaQLeUsoeaFQwWJBR
         VnjvdtEnZAdl3BoJpSEVm0vz5Oy+36jn5bSc+9enO6lJO6H7VHjrWlrwHeWUrJJA0LuA
         MoLVAbRw21s0mYoLlKjevuxVwz7xVCLAHvFUTF1IUHIFwCwYM6q6srEsYz6/DF9E6Fce
         lB/Kjm9IAmMmjDPxsPhWPsXZuumaDg3voGDiduWQ8A13Bw8aVj9p61ookmGr6XUKEiVZ
         rkmR1ISREsD6x8wdeDKvd9q9MBXvHFeD1l53CDYa/yxbVeKNz/5hx5GvciZwTFGVD/eA
         KXJA==
X-Gm-Message-State: APjAAAVIPjw1J+FFyM/lr9PMYpB7h4Nf7VKUFmyDskBhmeuo5UPYeeTK
        4UUeA1f14ICFFlgW1QxyAZXPEQ==
X-Google-Smtp-Source: APXvYqwZvj/xw6NKXfIzDpGy4jLtjE9fwfHT6KvYlp0xYmEC64p2dIxSu9E7vCfoxWYn3ee/WcZD/w==
X-Received: by 2002:adf:d081:: with SMTP id y1mr15854056wrh.34.1565248646999;
        Thu, 08 Aug 2019 00:17:26 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id j33sm216702369wre.42.2019.08.08.00.17.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 00:17:26 -0700 (PDT)
Date:   Thu, 8 Aug 2019 09:17:24 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190808071723.532hytasnglsuukf@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        adilger@dilger.ca, jaegeuk@kernel.org, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806053840.GH13409@lst.de>
 <20190806120723.eb72ykmukgjejiku@pegasus.maiolino.io>
 <20190806144800.GN7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806144800.GN7138@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:48:00AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 06, 2019 at 02:07:24PM +0200, Carlos Maiolino wrote:
> > On Tue, Aug 06, 2019 at 07:38:40AM +0200, Christoph Hellwig wrote:
> > > On Mon, Aug 05, 2019 at 08:12:58AM -0700, Darrick J. Wong wrote:
> > > > > returned. And IIRC, iomap is the only interface now that cares about issuing a
> > > > > warning.
> > > > >
> > > > > I think the *best* we could do here, is to make the new bmap() to issue the same
> > > > > kind of WARN() iomap does, but we can't really change the end result.
> > > > 
> > > > I'd rather we break legacy code than corrupt filesystems.
> > > 
> > 
> > Yes, I have the same feeling, but this patchset does not have the goal to fix
> > the broken api.
> > 
> > > This particular patch should keep existing behavior as is, as the intent
> > > is to not change functionality.  Throwing in another patch to have saner
> > > error behavior now that we have a saner in-kernel interface that cleary
> > > documents what it is breaking and why on the other hand sounds like a
> > > very good idea.
> > 
> > I totally agree here, and to be honest, I think such change should be in a
> > different patchset rather than a new patch in this series. I can do it for sure,
> > but this discussion IMHO should be done not only here in linux-fsdevel, but also
> > in linux-api, which well, I don't think cc'ing this whole patchset there will do
> > any good other than keep the change discussion more complicated than it should
> > be. I'd rather finish the design and implementation of this patchset, and I'll
> > follow-up it, once it's all set, with a new patch to change the truncation
> > behavior, it will make the discussion way easier than mixing up subjects. What
> > you guys think?
> 
> I probably would've fixed the truncation behavior in the old code and
> based the fiemap-fibmap conversion on that so that anyone who wants to
> backport the behavior change to an old kernel has an easier time of it.
> 

Well, another problem in fixing it in the old code, is that bmap() can't
properly return errors :P
After this patchset, bmap() will be able to return errors, so we can easily fix
it, once we won't need to 'guess' what a zero return mean from bmap()


> But afterwards probably works just as well since I don't feel like tying
> ourselves in more knots over an old interface. ;)
> 
> --D
> 
> > Cheers
> > 
> > 
> > -- 
> > Carlos

-- 
Carlos
