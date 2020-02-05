Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC0153965
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 21:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgBEUEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 15:04:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60896 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBEUEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580933074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1jb9TeXcL+mLndWBR1WKFjkYUCNYgUFm6/IdT2uVWM=;
        b=R6msnIu5n+yjocTa1FovjtMTgosS06LZGAYft1H9jxOAQy1wjjq5h6hjOw3vAQrZ8HC8t+
        1cJrNmkdvX8Km07jkMqEEgbSGc82LIFl3ssWgo5cSgd2yk+nZJXthBxIpIljay4+3yWc+z
        Mg23Z1PJafQ2tRV0eQM+EOT9PW4SvgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-IieA2SHXP2Cyliv94B-pXA-1; Wed, 05 Feb 2020 15:04:29 -0500
X-MC-Unique: IieA2SHXP2Cyliv94B-pXA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988C7107B270;
        Wed,  5 Feb 2020 20:04:28 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13E1284DB8;
        Wed,  5 Feb 2020 20:04:26 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A44F22202E9; Wed,  5 Feb 2020 15:04:25 -0500 (EST)
Date:   Wed, 5 Feb 2020 15:04:25 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, dm-devel@redhat.com
Subject: Re: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to
 dcssblk driver
Message-ID: <20200205200425.GF14544@redhat.com>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-3-vgoyal@redhat.com>
 <20200205183205.GB26711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205183205.GB26711@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:32:05AM -0800, Christoph Hellwig wrote:
> > diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> > index 63502ca537eb..f6709200bcd0 100644
> > --- a/drivers/s390/block/dcssblk.c
> > +++ b/drivers/s390/block/dcssblk.c
> > @@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops = {
> >  	.dax_supported = generic_fsdax_supported,
> >  	.copy_from_iter = dcssblk_dax_copy_from_iter,
> >  	.copy_to_iter = dcssblk_dax_copy_to_iter,
> > +	.zero_page_range = dcssblk_dax_zero_page_range,
> >  };
> >  
> >  struct dcssblk_dev_info {
> > @@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> >  	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
> >  }
> >  
> > +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
> > +				       unsigned offset, size_t len)
> > +{
> > +	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
> > +}
> 
> Wouldn't this need a forward declaration?  Then again given that dcssblk
> is the only caller of generic_dax_zero_page_range we might as well merge
> the two.  If you want to keep the generic one it could be wired up to
> dcssblk_dax_ops directly, though.

Given dcssblk is the only user, I am inclined to get rid of genric
version. We can add one later if another user shows up.

Thanks
Vivek

