Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6476E365FB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 20:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhDTSrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 14:47:39 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:36585 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhDTSri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:47:38 -0400
Received: by mail-pj1-f47.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so22872474pjh.1;
        Tue, 20 Apr 2021 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ofvhAkyt127k1jB+SJJBXxN2vdKK7h9N4Sgbm7nGyY=;
        b=rxuYRPGdut/goUOyBBzB7QynctlD7j9eI5ZCEd8g+vmvBI19Y4PAC7mfku5ewlZ/bP
         iFVn40B5+Hj16iVy2R2uUtZ+ruSXMgsjq0haxtK8DHn26ICXsza4Ef1A9oD/u93HcE7v
         ARVeEkwfRj128ZuvRTPvE5jPhc35+dfy9uqKznVu9qSIBo7t5IcLzJCjF8mgyPC4JOIv
         PYXJAuCuxTgCL6VGybIsxxvPgXPC10R0/eANAV4Hw8nX997eZisvtzgb5GCNxm2/a4CU
         TH11bwf7RKimThsal7Y8DtoAxNvMJ0xIK4RKpyJgfiFqSUw5Wl/DDHKmloeSuNaospNV
         nOGQ==
X-Gm-Message-State: AOAM5318zrA/hiBM4ImEkypMoh2Oqi8v5za2XC5vQ2PKZxXr1ALptZLl
        xnv2Hvj4ua1MOf1uDUeLGZI=
X-Google-Smtp-Source: ABdhPJzopyA6ryc66gxjtVVJJBnHGNqi9GrY3KLn4SONcQ4NA/qPJ315G+UIezYPSjVB1kjhhp9kKw==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr6208420pjb.63.1618944425220;
        Tue, 20 Apr 2021 11:47:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y1sm6025769pgl.88.2021.04.20.11.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:47:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6F288403DC; Tue, 20 Apr 2021 18:47:03 +0000 (UTC)
Date:   Tue, 20 Apr 2021 18:47:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com, mchehab@kernel.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        kernel@tuxforce.de, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 6/6] fs: add automatic kernel fs freeze / thaw and
 remove kthread freezing
Message-ID: <20210420184703.GN4332@42.do-not-panic.com>
References: <20210417001026.23858-1-mcgrof@kernel.org>
 <20210417001026.23858-7-mcgrof@kernel.org>
 <20210420125903.GC3604224@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420125903.GC3604224@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 01:59:03PM +0100, Christoph Hellwig wrote:
> > This also removes all the superflous freezer calls on all filesystems
> > as they are no longer needed as the VFS now performs filesystem
> > freezing/thaw if the filesystem has support for it. The filesystem
> > therefore is in charge of properly dealing with quiescing of the
> > filesystem through its callbacks.
> 
> Can you split that out from the main logic change?  Maybe even into one
> patch per file system?

The issue with this is that once you do the changes in pm to
freeze/suspend, if you leave the other changes in for the filesystems
freeze / resume will stall, so all this needs to be an atomic operation
if we want bisectable kernels.

  Luis
