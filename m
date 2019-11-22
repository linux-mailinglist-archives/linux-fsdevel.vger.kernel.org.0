Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5A1073CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfKVODG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 09:03:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727105AbfKVODG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574431384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8uYfWtOgbthXXxrVkXg50WbOf5RfOQ7RoysNC37DKcE=;
        b=Ss2Q9zhwWjDxwlE7dqw1j2i7hQyvGX3YSLapmtuP/irbBqGizPuASwzzlKimWH/BdkX6vF
        qDizEUode0H5qCyXYsVk80mWBLdRPknF59prWVW+rnnEh6T5yxKzpB4UPZtiPlZSfdWa1Z
        y6e4ciXXdXgCNDAY7ORCuz67YUrri8M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-oBeqNYwcM2KBpiKnFSCyXg-1; Fri, 22 Nov 2019 09:03:01 -0500
Received: by mail-wr1-f69.google.com with SMTP id 92so3929278wro.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2019 06:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S9AoClto/DOzG0HVtJvN5KM/68JGEBgcxcs5IkQTM3c=;
        b=NrermdTMmFHVCaLtlSFfT7VNsqJPCoi7E1syyC0q465wdoDtlqQq9m4MsQJvCwr4nI
         E461+XS4eMiqOKvL71/Ox2s8n62WN2i6ON77NtaHMm2t+MgIE8z+tJ6Nx0Q0fxCu/TCO
         6w8MHJIgCUCUle7e3Z9ifS/mMCJumjibc9WPYa/Mh4Cd+4apCYKwA7WTdx4ZozMwsoKS
         3ltuPMncIbS0Vh4pjS/LJzgbmTrhyP7zgV10YYvXOJ029TpCtLUlkvA38MTxWVHPW9Mk
         l17InpthRpACETTm1UDMybeivWCkmvS+3KW+/XX+ZttnmCtHR8FZgn+BB9H5SZWSh2DY
         YeqQ==
X-Gm-Message-State: APjAAAUz9aYVDjit/ZEowbGpzG1Mhxc7grm5qGacgwi51KWpY/RXMokN
        9Qy7TC4ZDHsqPUc3C86zMKdqPExVqzqbCX/odeaymz1qa9ILmC6h+XHKBby3aqxRFdJk/jKppbx
        UWSCLeq8EcoqtsiKh+Y3yxSRfUw==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr16215265wmj.20.1574431380196;
        Fri, 22 Nov 2019 06:03:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPjMID2asLRVMZHXkMdrlL5MzzGlxpWUWr4BTBKWTYluA4U1736x+LYFDffw9RVw5aYsA3HQ==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr16215248wmj.20.1574431380033;
        Fri, 22 Nov 2019 06:03:00 -0800 (PST)
Received: from orion (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id a26sm3519294wmm.14.2019.11.22.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 06:02:59 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:02:57 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        sandeen@sandeen.net
Subject: Re: [PATCH 1/5] fs: Enable bmap() function to properly return errors
Message-ID: <20191122140257.vd2lytosz7y2xqr4@orion>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
 <20191122085320.124560-2-cmaiolino@redhat.com>
 <20191122133701.GA25822@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191122133701.GA25822@lst.de>
X-MC-Unique: oBeqNYwcM2KBpiKnFSCyXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 02:37:01PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 22, 2019 at 09:53:16AM +0100, Carlos Maiolino wrote:
> > By now, bmap() will either return the physical block number related to
> > the requested file offset or 0 in case of error or the requested offset
> > maps into a hole.
> > This patch makes the needed changes to enable bmap() to proper return
> > errors, using the return value as an error return, and now, a pointer
> > must be passed to bmap() to be filled with the mapped physical block.
> >=20
> > It will change the behavior of bmap() on return:
> >=20
> > - negative value in case of error
> > - zero on success or map fell into a hole
> >=20
> > In case of a hole, the *block will be zero too
> >=20
> > Since this is a prep patch, by now, the only error return is -EINVAL if
> > ->bmap doesn't exist.
> >=20
> > Changelog:
> >=20
> > =09V6:
> > =09=09- Fix bmap() doc function
> > =09=09=09Reported-by: kbuild test robot <lkp@intel.com>
> > =09V5:
> > =09=09- Rebasing against 5.3 required changes to the f2fs
> > =09=09  check_swap_activate() function
> >=20
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > ---
>=20
> The changelog goes under the --- if you really want a per-patch
> changelog.  I personally find the per-patch changelog horribly
> distracting and much prefer just one in the cover letter, though.
>=20
> Otherwise this looks good, although we really need to kill these
> users rather sooner than later..
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>=20

Yeah, I forgot to move the changelogs under --- while formatting the patche=
s, I
didn't mean to send them on the commit log.

This signed-off-by was meant to be a reviewed-by? I'm not sure if I got wha=
t you
meant with the sign-off here.


--=20
Carlos

