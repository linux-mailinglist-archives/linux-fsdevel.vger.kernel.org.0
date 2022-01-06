Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E332486637
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiAFOmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 09:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239677AbiAFOmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641480159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
        b=hzjCB8vgmtRRoJgUfU+7Tqssh59RVeI0eWmS+3a235FiajsGSLfkkjpWwp66nYDVgZKDHu
        0yztWn5AnhP0IX+hXURGGUimEoM8kpTf1fXD44UzYUNcbaFzDdLHqtYvs0e9pQmkpTQptt
        sHvQUJudodyszxvXBV1+OGJoz3TnMns=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-LYIALtk7NVCc3yFPLhGBzg-1; Thu, 06 Jan 2022 09:42:38 -0500
X-MC-Unique: LYIALtk7NVCc3yFPLhGBzg-1
Received: by mail-qv1-f70.google.com with SMTP id ib7-20020a0562141c8700b0040812bc4425so2209431qvb.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 06:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
        b=DyzKbdA9lzeXXqiftQ16mT9+kyzIyhlsfUWSBQrCoeT7hFGYI46xKEEQ9aDjMkr68c
         KpmlWFJkHgHQyOgjoe/+/94dXtLx+K4oDbyBmFDAt18WnQ6cnYEP/BerAA1sumKzrkWy
         Z3/0BjFUWU9MF84CVgCLSL97Wpi8ND9y/4Vf3gt63nlDStHBow8k7VhFD6io/lxW5LOH
         DQOIKwkKfPCEVl1klIOI5Tn3JOC/hGyk/nc12ufFkbiabVEO7vfl2SC34KMGT3uzvrw4
         TNr9b7yB+/jJiOxIpDeX2tbdTO6hSlTtxoob95hp+LVqyg3f+otYdMAG6OwEk4d8oqAO
         CE2A==
X-Gm-Message-State: AOAM533Huh2/66ZNbsDIMQG5GoPtfVYNLxa/oW44synyU9O4NzCXFmUf
        31tODj+axl9aFgofbS+YOTqsq+Fr6O7j3zgMQtuS3U7CEDgzx3lmyY2Se4kLINQzZ/eLfIDM6gp
        xMN3j9RgSqR4E0IOrQQeji1Ex
X-Received: by 2002:a05:620a:bcc:: with SMTP id s12mr40958052qki.440.1641480157666;
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3FRhHacqx3hvXCbD5dR5jpsBPvBE8m7URZnWLXDzc/nf2wfv2oNDbZeyhxFZfEJhygNyDig==
X-Received: by 2002:a05:620a:bcc:: with SMTP id s12mr40958035qki.440.1641480157454;
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id t3sm2038461qtc.7.2022.01.06.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Date:   Thu, 6 Jan 2022 09:42:36 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/4] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <Ydb/3P+8nvjCjYfO@redhat.com>
References: <20211215084508.435401-1-hch@lst.de>
 <20211215084508.435401-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215084508.435401-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15 2021 at  3:45P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
> 
> Add set_dax_nocache() and set_dax_nomc() APIs to control which copy
> routines are used to remove indirect call from the read/write fast path
> as well as a lot of boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Vivek Goyal <vgoyal@redhat.com> [virtiofs]

Late to the game here, but quite a lot of dax DM code removed, thanks!

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

