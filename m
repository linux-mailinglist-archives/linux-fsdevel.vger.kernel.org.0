Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE423203C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgG2OSj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 10:18:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgG2OSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596032318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v3yRCdNgmRAYY03SE3GU+4EvBfKgO2Uc6QsVoa6VhTk=;
        b=NTI7vWwiFcjj/uC2k6UO3TJaV/SqdxVmq3YEF7/MD1G+UYH8xdNgS/virdO5Gxm34Vrzcu
        jjT/IJb55j/MQAY+YHdaSwKOBOZb7UyNKx/SZhTDmZNyJ7PEA7hYwZX+FeY7QEq+nWHJnB
        xBUfmNe5LAWBFc5y8xSAQEVk7YjldSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-fwG21gukN_ux2eMFmujtww-1; Wed, 29 Jul 2020 10:18:36 -0400
X-MC-Unique: fwG21gukN_ux2eMFmujtww-1
Received: by mail-wm1-f72.google.com with SMTP id q15so1064078wmj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2020 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3yRCdNgmRAYY03SE3GU+4EvBfKgO2Uc6QsVoa6VhTk=;
        b=PsqxN5t/1Xt5T8qneWZjqWckwySAz4owVjVsA4rsnfMuXQrEk0cAPKrstspa81uGPx
         iKC6vCLXZaBdZXdHFTRZSVhFgfbb2+vxKpUVb32y5Scj7P2L8VgY4MmZxdd6ZbXkrLSU
         wt0LSAlwHXvY2zlhihKVUhn3AkTmlpzs3a0/ZCmgrTTHlaopQhUYGrt8dkjO5f8FmRy5
         nJ2+peSzvku5c1GJGCjXYlLvsI42QERD1RQILVivCIViCOFwGL8/gVPXzd647qbx/U2Q
         Y7oFswzgrH7XdkWOr+CrlrWXI2shvxgR5tTtefYfPa5O2LLLvuS3fuBvIkWhd5tvDqN3
         s/ww==
X-Gm-Message-State: AOAM5309L8sm8kW2uZI35q+nvcwIyy3KT9wa5D56hkQ69+T/lW8WRmQQ
        8zGaV6y6PgPOhq/uaglhdkCS6vRTyail2O5WOYLfgNgJHctQzwTPnBIOqEQ54JkrQAGP2oqBqfl
        8qyM7iBEpMHfRohOvaBG4aDFx+g==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8508126wmj.57.1596032314736;
        Wed, 29 Jul 2020 07:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmmwjulBzKNnKWk+ryRFt1ck/MUmSlh4QEF+dyEOk3V/1QmT4D6lnSPhVTqHYJjenQPDZGtQ==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr8508106wmj.57.1596032314505;
        Wed, 29 Jul 2020 07:18:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id q7sm5949774wra.56.2020.07.29.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 07:18:33 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:18:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
Message-ID: <20200729101807-mutt-send-email-mst@kernel.org>
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <20200729082053.6c2fb654@canb.auug.org.au>
 <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728153143.c94d5af061b20db609511bf3@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 03:31:43PM -0700, Andrew Morton wrote:
> On Wed, 29 Jul 2020 08:20:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Andrew,
> > 
> > On Tue, 28 Jul 2020 14:55:53 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > config CONTIG_ALLOC
> > >         def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
> > > 
> > > says this is an improper combination.  And `make oldconfig' fixes it up.
> > > 
> > > What's happening here?
> > 
> > CONFIG_VIRTIO_MEM selects CONFIG_CONTIG_ALLOC ...
> 
> Argh, select strikes again.
> 
> So I guess VIRTIO_MEM should also select COMPACTION?

+Cc the maintainer.

-- 
MST

