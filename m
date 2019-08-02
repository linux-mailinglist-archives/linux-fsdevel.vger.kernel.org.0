Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7283A7F047
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbfHBJTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 05:19:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35612 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfHBJTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:19:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id y4so76425337wrm.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2019 02:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AWW90I58JbC0qNw1B9zfM6Ib/6ksVuYisUHthaEluzs=;
        b=FHcbBWi++zmwQzJ21HrOaEIyvCrjWlJdxt1Fj1FGFHU0a6AXin1+6YB3O77DlPNM/J
         pL5uFFzxgtnxtgmCAgw6KZVuwk/iG3+TaCqWRB7ntiS0bTOn6c/6T0WjTySzPfTnyCqt
         UD6JxvNG6WGMhcf3r4ZyoU5N1oxYXuJ+PxSXQwxe0YywGAukU3Jk3soQcY88Q1nStnQj
         4qM82rguOeJmWreQoHER5kguN7kmcEkuYoqKmgFrbmqMHFcjGtcRCC5DfFUI2gQYyoE/
         WNajEADCcyolG24KZ6naojBchzy7NAoRuBiwdv938IUNBCaO5KHvUqLIoxyCmZnSqpXT
         FS5A==
X-Gm-Message-State: APjAAAUdhywQerWYOmrLzfieXzJUPkL+ZUZPoPjn3/1eOe1tgk34NkQ3
        H3DnZpWajJfQe4O3ZhB5youkdg==
X-Google-Smtp-Source: APXvYqwI+Edf+8WSAIuVXNdwAMHEunwYHZHkK1/ROixc64nej4MDkh74BNSr6DgHzuNsmKROuMiZFg==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr65487799wrt.294.1564737581568;
        Fri, 02 Aug 2019 02:19:41 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id a67sm85805669wmh.40.2019.08.02.02.19.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:19:41 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:19:39 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190802091937.kwutqtwt64q5hzkz@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-5-cmaiolino@redhat.com>
 <20190731231217.GV1561054@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731231217.GV1561054@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick.

> > +		return error;
> > +
> > +	block = ur_block;
> > +	error = bmap(inode, &block);
> > +
> > +	if (error)
> > +		ur_block = 0;
> > +	else
> > +		ur_block = block;
> 
> What happens if ur_block > INT_MAX?  Shouldn't we return zero (i.e.
> error) instead of truncating the value?  Maybe the code does this
> somewhere else?  Here seemed like the obvious place for an overflow
> check as we go from sector_t to int.
> 

The behavior should still be the same. It will get truncated, unfortunately. I
don't think we can actually change this behavior and return zero instead of
truncating it.

> --D
> 
> > +
> > +	error = put_user(ur_block, p);
> > +
> > +	return error;
> >  }
> >  
> >  /**
> > -- 
> > 2.20.1
> > 

-- 
Carlos
