Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BB1730BC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbjFNXxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 19:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjFNXxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:53:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5D1BC
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 16:53:31 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b16cbe4fb6so5368062a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686786810; x=1689378810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENFUOuLYPNAjTu0vIC85o5SRD9Y6MEisvLZRTUVQ4X4=;
        b=krB9LlKvuoI99I9rLN/GU8lZu0M84MbbSwVeO3b6GPgZEJPUB8yFMuelhT4OIMjPVL
         wOecS3Sx5gLa4a9sn1ElLBj9RsjdSIRhsPk+a1/Qca3N2x6iSwotAhS90gml+pXu7aIV
         Vyr5befPjtPEeRNrBEyVg15W1lQyqzFKTAZ1zKcJdF3h5YZzt6gZzik9HGPVpFdoo9UE
         HDBH2Pp2p2ypWOMpXuXaecPrN+8y9MlnapuXxvfUAfpc2m5l57tnO4ZnTrcfhsQmk3Ko
         IXbwIttFokx/yrlm+clhsODgj/hjldgSSDxK/kIy3+DjTq1Txz8qsb8NkT083+C9i15I
         HvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686786810; x=1689378810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENFUOuLYPNAjTu0vIC85o5SRD9Y6MEisvLZRTUVQ4X4=;
        b=XPOfRWVJN0lCO1lxuzqY32j4eVr7Bj4erFqP7FHWPm5g/d7u7J7jWAKKG3omMyD/E0
         sb7NYC26OPxTCTVSjLRLYkQPjJmzA0hzBS4MPel00+TofG4sSoqzioe2lXDfYYhoNE3B
         o6+QK69itk0qxcvuL7iaRvaEct/uKfrkJXJHeow3zSQw+5RmxBI8kMMzsKTFclSwwiu/
         YmjVi1fZP0K7cl01fb8WfidA0vt1UfeWqzyT2xRREDQNkUMTjXni2qCGJWz/isNXjAxz
         Ysmhaios9A3fNvNdw+LdQpuTrnWnpveVMy2FKk89YXQUoIg9+m+F2SuSTqjaBjV73+1x
         fbeQ==
X-Gm-Message-State: AC+VfDy6RvL5pyUj6h8nl26L+GFqz4xoB8Y8xJsj9cXdekd3sC5h3dcl
        tleHps9h2b8QYpDq5HoMbJZTrw==
X-Google-Smtp-Source: ACHHUZ4V7Q9iu3VBGMS+d4zJLgoAyeoudoFgZN36LF5rNfzZLCfqU4uefe/K3YACwcCUj4opqXu/qw==
X-Received: by 2002:a05:6358:9db1:b0:125:83a6:caa5 with SMTP id d49-20020a0563589db100b0012583a6caa5mr11405713rwo.3.1686786810129;
        Wed, 14 Jun 2023 16:53:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id d2-20020a631d02000000b0054fd46531a1sm1861351pgd.5.2023.06.14.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 16:53:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9aIo-00BrXy-0p;
        Thu, 15 Jun 2023 09:53:26 +1000
Date:   Thu, 15 Jun 2023 09:53:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZIpS9u4P43PgJwuj@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:06:14PM +0200, Hannes Reinecke wrote:
> On 6/14/23 15:53, Matthew Wilcox wrote:
> > On Wed, Jun 14, 2023 at 03:17:25PM +0200, Hannes Reinecke wrote:
> > > Turns out that was quite easy to fix (just remove the check in
> > > set_blocksize()), but now I get this:
> > > 
> > > SGI XFS with ACLs, security attributes, quota, no debug enabled
> > > XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) or
> > > less will currently work.
> > 
> > What happens if you just remove this hunk:
> > 
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
> >                  goto out_free_sb;
> >          }
> > 
> > -       /*
> > -        * Until this is fixed only page-sized or smaller data blocks work.
> > -        */
> > -       if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > -               xfs_warn(mp,
> > -               "File system with blocksize %d bytes. "
> > -               "Only pagesize (%ld) or less will currently work.",
> > -                               mp->m_sb.sb_blocksize, PAGE_SIZE);
> > -               error = -ENOSYS;
> > -               goto out_free_sb;
> > -       }
> > -
> >          /* Ensure this filesystem fits in the page cache limits */
> >          if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
> >              xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {
> 
> Whee! That works!
> 
> Rebased things with your memcpy_{to,from}_folio() patches, disabled that
> chunk, and:
> 
> # mount /dev/ram0 /mnt
> XFS (ram0): Mounting V5 Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
> XFS (ram0): Ending clean mount
> xfs filesystem being mounted at /mnt supports timestamps until 2038-01-19
> (0x7fffffff)
> # umount /mnt
> XFS (ram0): Unmounting Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551

Mounting the filesystem doesn't mean it works. XFS metadata has
laways worked with bs > ps, and mounting the filesystem only does
metadata IO.

It's not until you start reading/writing user data that the
filesystem will start exercising the page cache....

> Great work, Matthew!
> 
> (Now I just need to check why copying data from NFS crashes ...)

.... and then we see it doesn't actually work. :)

Likely you also need the large folio support in the iomap write path
patches from Willy, plus whatever corner cases in iomap that still
have implicit dependencies on PAGE_SIZE need to be fixed (truncate,
invalidate, sub-block zeroing, etc may not be doing exactly the
right thing).

All you need to do now is run the BS > PS filesytems through a full
fstests pass (reflink + rmap enabled, auto group), and then we can
start on the real data integrity validation work. It'll need tens of
billions of fsx ops run on it, days of recoveryloop testing, days of
fstress based exercise, etc before we can actually enable it in
XFS....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
