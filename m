Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B170B1AD81F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgDQIAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 04:00:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36664 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgDQIAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:00:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id u13so1963694wrp.3;
        Fri, 17 Apr 2020 01:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D9Cm8tiUrg/W1Q7McZQji69rvG+FU5ciQYbgQ4VtKtk=;
        b=SGtUVIxXIHi69ASccsLEdEE/+qnOOfvpEvweULjjGP5mAYpVs1YHHJ54wg6S0YQHrM
         jAisqQXMIjcYaQ1mWOhIMHkrD/CYaYmYlwYSDX16qHz9InCt32YzXDXLM4uoG5N1vDDi
         VCp+9oSPfqs/Qm1ewiVxPjnruVAF3O5h/W6ahUa9AWyT2qMAh0zob/tbAAmqJwPWXg3e
         L5fMLluS8bPYreRQ49d57lT6J7Bi98GTuvNKtH/RC60Va3wvNUAUV0bVjwgvRWfl7/6S
         YPAtgnmxf9YgfVmQK27QqyYnUdUgxn/xOLh74H+Q7ipdjLg11s8gZ9frJsO3DsMqijiR
         5CjQ==
X-Gm-Message-State: AGi0Puagm0BpAITm1xSzKsQHaXgYfeSH+k+uutDoquuoW+16fpLmT8cY
        JVnYxP+udB/5mdY2h5Q/899+AuYX
X-Google-Smtp-Source: APiQypK6QkzwwzEqDKqri8AOStqnCVoQcUWo9VpjG6PFJPc06p38N+Xz35zVVtoaK0x1nCOpRAEbSg==
X-Received: by 2002:adf:c109:: with SMTP id r9mr2483924wre.265.1587110405815;
        Fri, 17 Apr 2020 01:00:05 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id n6sm6585346wmc.28.2020.04.17.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:00:05 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:00:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: implicit AOP_FLAG_NOFS for grab_cache_page_write_begin
Message-ID: <20200417080003.GH26707@dhcp22.suse.cz>
References: <20200415070228.GW4629@dhcp22.suse.cz>
 <20200417072931.GA20822@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417072931.GA20822@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-04-20 00:29:31, Christoph Hellwig wrote:
> On Wed, Apr 15, 2020 at 09:02:28AM +0200, Michal Hocko wrote:
> > Hi,
> > I have just received a bug report about memcg OOM [1]. The underlying
> > issue is memcg specific but the stack trace made me look at the write(2)
> > patch and I have noticed that iomap_write_begin enforces AOP_FLAG_NOFS
> > which means that all the page cache that has to be allocated is
> > GFP_NOFS. What is the reason for this? Do all filesystems really need
> > the reclaim protection? I was hoping that those filesystems which really
> > need NOFS context would be using the scope API
> > (memalloc_nofs_{save,restore}.
> 
> This comes from the historic XFS code, and this commit from Dave
> in particular:
> 
> commit aea1b9532143218f8599ecedbbd6bfbf812385e1
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Tue Jul 20 17:54:12 2010 +1000
> 
>     xfs: use GFP_NOFS for page cache allocation
> 
>     Avoid a lockdep warning by preventing page cache allocation from
>     recursing back into the filesystem during memory reclaim.

Thanks for digging this up! The changelog is not really clear whether
NOFS is to avoid false possitive lockup warnings or real ones. If the
former then we have grown __GFP_NOLOCKDEP flag to workaround the problem
if the later then can we use memalloc_nofs_{save,restore} in the xfs
specific code please?
-- 
Michal Hocko
SUSE Labs
