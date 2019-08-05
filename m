Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1519781702
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfHEK1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 06:27:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33680 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHEK1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:27:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so6348472wme.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 03:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DgcovKuK5WhPn6hVzFZNbyXAianIZnw5XWtwj+mlfWk=;
        b=gss8EeR5X12LfVi2+J9AAWMozTzQdPLVsdW5p/aclrhoDSVTsMsXOPQ0M4lGz5E+nv
         mlbVOfy9+3M77JhoAEODqIF7TFy9kmgQRTq7NTAafXv2VtTuyzmjCViP4gzbcREhjUZD
         nVzlIKuNG2rM5W1/kJZ/okUNxYTZs2v1twOGjbtZvOVgq/wrQCYwN9EvblIcHtaC7zma
         cJ+kPHlzxuE/w5KRRkge6ohdJGfz1ap4rpeigx4NemYUu7l72e3lUCqKmXnL5AGmaLXW
         eL/n7zRpyk5lUtCOFsozR9HEFXZOPjCrKXR0XkJkTiKZLDq2+DcfYCZO088/D5F6iTya
         aHKQ==
X-Gm-Message-State: APjAAAUwsvm3LPZ04HSKXKey/zT4ATfyBe8a/KWqTrd2yLENyWG1EWi+
        3TXp514L//BCDm2pSYGNs7bVzQ==
X-Google-Smtp-Source: APXvYqzfF6AQaF4c4hasKzPBhxJz92+5NrrN/wf7wERzHvxkWGAMbXPySxFIwOZ5TpnC1TmHgNzNzg==
X-Received: by 2002:a7b:cb94:: with SMTP id m20mr17390752wmi.144.1565000852931;
        Mon, 05 Aug 2019 03:27:32 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id n14sm160342770wra.75.2019.08.05.03.27.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 03:27:32 -0700 (PDT)
Date:   Mon, 5 Aug 2019 12:27:30 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190805102729.ooda6sg65j65ojd4@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
 <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
 <20190802151400.GG7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151400.GG7138@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:14:00AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 02, 2019 at 11:19:39AM +0200, Carlos Maiolino wrote:
> > Hi Darrick.
> > 
> > > > +		return error;
> > > > +
> > > > +	block = ur_block;
> > > > +	error = bmap(inode, &block);
> > > > +
> > > > +	if (error)
> > > > +		ur_block = 0;
> > > > +	else
> > > > +		ur_block = block;
> > > 
> > > What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> > > error) instead of truncating the value?  Maybe the code does this
> > > somewhere else?  Here seemed like the obvious place for an overflow
> > > check as we go from sector_t to int.
> > > 
> > 
> > The behavior should still be the same. It will get truncated, unfortunately. I
> > don't think we can actually change this behavior and return zero instead of
> > truncating it.
> 
> But that's even worse, because the programs that rely on FIBMAP will now
> receive *incorrect* results that may point at a different file and
> definitely do not point at the correct file block.

How is this worse? This is exactly what happens today, on the original FIBMAP
implementation.

Maybe I am not seeing something or having a different thinking you have, but
this is the behavior we have now, without my patches. And we can't really change
it; the user view of this implementation.
That's why I didn't try to change the result, so the truncation still happens.
> 
> Note also that the iomap (and therefore xfs) implementation WARNs on
> integer overflow and returns 0 (error) to prevent an incorrect access.

It does not really prevent anything. It just issue a warning saying the result
will be truncated, in an attempt to notify the FIBMAP interface user that he/she
can't trust the result, but it does not prevent a truncated result to be
returned. And IIRC, iomap is the only interface now that cares about issuing a
warning.

I think the *best* we could do here, is to make the new bmap() to issue the same
kind of WARN() iomap does, but we can't really change the end result.


> 
> --D
> 
> > > --D
> > > 
> > > > +
> > > > +	error = put_user(ur_block, p);
> > > > +
> > > > +	return error;
> > > >  }
> > > >  
> > > >  /**
> > > > -- 
> > > > 2.20.1
> > > > 
> > 
> > -- 
> > Carlos

-- 
Carlos
