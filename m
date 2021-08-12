Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134E13EA913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhHLRD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbhHLRD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:03:56 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CEC061756;
        Thu, 12 Aug 2021 10:03:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m18so11565394ljo.1;
        Thu, 12 Aug 2021 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TVRfaim7JcFuDwK6qCeMrYCmulGcwWSC8AfnRPfxrg4=;
        b=OrgwjPSTXR7hauGvdb4nrOZJ37karfE+CBe383HHGLrVApcIXU3x7j4C+U50f+0mtf
         4KMEnwEU40Vaqig5GuWGyjLnCZbZgZiyDhANBmgKN4ZE3yxvcbejSwN+LbgU9LiVWKvJ
         7QNbQT0XgisZU59AjkhksT/CmCmBvzxL2CmY+AB4yxlIaKNS2vnXt1oUxhi74ScXp7IL
         Jz+NeyWU8FrfyYZQqkuLkxirNEWsbroD5JEvE7fuW7k51WtEoKNlaKmEoaHC2KK1S0h1
         arNHeVcGZiv0MPntwld4DvTarTUZjEg3SFRN2Q1hzIZbQWkm/L+/x/T1zcKTbQaRLUor
         q7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVRfaim7JcFuDwK6qCeMrYCmulGcwWSC8AfnRPfxrg4=;
        b=KEzQsoteSql5eebJQ35SCYVCIosRz8J6AwmrWBZWcYxRzbs1X+y0m8Nd8n6CZtTYr5
         7Ugo1w014X32yYfIqiJQOzjFShsEqre6TzxQb+WvFgp4SLaOjBxE1hokT2yAowpVnDXG
         Sm9L/RlxiPLnmaOmE6SgEowqHRTB260uLRSbqKuc65jORks3w18K5n2igNFMcMR8mJV3
         YhRYI8w04le4corIzquudmZr5WgqjvxwZs8hWY38kqVCSl3QuWWM+bvEkxgIzYqbw9gu
         T5JIstAp6h8SDv60PFNlaLnd48br6mpWuY2yjzpOv7g5q8/bqI4XPXWz/9oBPWOFj4B9
         mtLg==
X-Gm-Message-State: AOAM532imEriWn1tRcoH9WqzxDAXR2FWlA2IF3tN+FDBajiiFw6OXOws
        q4rGm84on2w5zBz2DlgDEeQ=
X-Google-Smtp-Source: ABdhPJw3+nVBWWUJj9VBiIwgKNFxrn0mNayyfnDEg64wBYh1UwIlrapqHF/myaiY0O21XQjESPgq/w==
X-Received: by 2002:a05:651c:b21:: with SMTP id b33mr3793028ljr.310.1628787809393;
        Thu, 12 Aug 2021 10:03:29 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id s3sm315978lfb.15.2021.08.12.10.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:03:28 -0700 (PDT)
Date:   Thu, 12 Aug 2021 20:03:26 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
Message-ID: <20210812170326.6szm7us5kfdte52u@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729162459.GA3601405@magnolia>
 <YQdlJM6ngxPoeq4U@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQdlJM6ngxPoeq4U@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 01, 2021 at 11:23:16PM -0400, Theodore Ts'o wrote:
> On Thu, Jul 29, 2021 at 09:24:59AM -0700, Darrick J. Wong wrote:
> > 
> > I have the same (still unanswered) questions as last time:
> > 
> > 1. What happens when you run ntfs3 through fstests with '-g all'?  I get
> > that the pass rate isn't going to be as high with ntfs3 as it is with
> > ext4/xfs/btrfs, but fstests can be adapted (see the recent attempts to
> > get exfat under test).
> 
> Indeed, it's not that hard at all.  I've included a patch to
> xfstests-bld[1] so that you can just run "kvm-xfstests -c ntfs3 -g
> auto".
> 
> Konstantin, I would *strongly* encourage you to try running fstests,
> about 60 seconds into a run, we discover that generic/013 will trigger
> locking problems that could lead to deadlocks.

It seems at least at my testing that if acl option is used then
generic/013 will pass. I have tested this with old linux-next commit
5a4cee98ea757e1a2a1354b497afdf8fafc30a20 I have still some of my own
code in it but I will test this tomorrow so I can be sure.

It also seems that acl support is broken. I also suspect ntfs-3g mkfs in
some failure cases. So maybe ntfs-3g mkfs will give different result than
Paragons mkfs. It would be nice to test with Paragons mkfs software or
that Paragon will test with ntfs-3g.

