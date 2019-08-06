Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378418312D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 14:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfHFMHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 08:07:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38589 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:07:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so54867863wmj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2019 05:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ada15BeFOUWX2EQ0DfRuw+y8XK/lBggnHBApatYPxzU=;
        b=CijFh/RdNCYViaoruRKCE5pVdQTcr4Andjcdz8+XwunV9eVQocSa8OUMqwKakKGFD7
         tCnAD8FjDId6u+jDjB+jQFmqWPTiQsDiZgggPsMDdDIon3qwhybj0X01FomB9k7RQ/gn
         b77H3zcGJV6ZbfMRC2nrDssPb8Elm7jMvOErZZkvp29GcqAuwquLzY95gRhjyT+x+3VF
         ltuVVd0niEHQloALvlwI5uLu4icaqGMm3imdcZb9taFR/gJWT0Y8leALP5NyUIvOCI06
         H4Qug6svlSIIh29BN3rPcS26ah2Mq9a/mjR5UdwVjg9Gv1grcnL5qSZaXrQVQDgCjqOx
         veeQ==
X-Gm-Message-State: APjAAAWxGnbs+DhrW1XYDeLL2o6IgyDvsDgK/1xTuenWz2zBzOqlqhTJ
        s6KkCAiurquDCvgiACL/rpkdwQ==
X-Google-Smtp-Source: APXvYqyWcQACerC6HMZZz1xnG3rbsfHRIUgj/7NcbJmo3UsBozeEVY2sQdv11WeHaAXTO/LoWeTIjA==
X-Received: by 2002:a05:600c:2199:: with SMTP id e25mr4433962wme.72.1565093247510;
        Tue, 06 Aug 2019 05:07:27 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id j16sm42653334wrp.62.2019.08.06.05.07.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 05:07:26 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:07:24 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190806120723.eb72ykmukgjejiku@pegasus.maiolino.io>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
 <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
 <20190805151258.GD7129@magnolia>
 <20190806053840.GH13409@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806053840.GH13409@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:38:40AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 05, 2019 at 08:12:58AM -0700, Darrick J. Wong wrote:
> > > returned. And IIRC, iomap is the only interface now that cares about issuing a
> > > warning.
> > >
> > > I think the *best* we could do here, is to make the new bmap() to issue the same
> > > kind of WARN() iomap does, but we can't really change the end result.
> > 
> > I'd rather we break legacy code than corrupt filesystems.
> 

Yes, I have the same feeling, but this patchset does not have the goal to fix
the broken api.

> This particular patch should keep existing behavior as is, as the intent
> is to not change functionality.  Throwing in another patch to have saner
> error behavior now that we have a saner in-kernel interface that cleary
> documents what it is breaking and why on the other hand sounds like a
> very good idea.

I totally agree here, and to be honest, I think such change should be in a
different patchset rather than a new patch in this series. I can do it for sure,
but this discussion IMHO should be done not only here in linux-fsdevel, but also
in linux-api, which well, I don't think cc'ing this whole patchset there will do
any good other than keep the change discussion more complicated than it should
be. I'd rather finish the design and implementation of this patchset, and I'll
follow-up it, once it's all set, with a new patch to change the truncation
behavior, it will make the discussion way easier than mixing up subjects. What
you guys think?

Cheers


-- 
Carlos
