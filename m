Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF95A3EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Trv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 15:47:51 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:35762 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3Trv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:47:51 -0400
Received: by mail-pf1-f172.google.com with SMTP id 205so2807946pfw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2019 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lfElKMam/T9V6bsHLEtrVU85ksJ2VDYhroR6xFrZWzc=;
        b=S2+GEn1dwls7W9EjbKis0gEXBDsdZQPxoEf3WKnPui0h4AaQOe1DySp16Ru1yOEUR7
         Mm6Q+D3hLV7Y3ti33qQgOpq2rSHyLPakdr2RDl46NbsvRtJ4YLZUZ0V3ZWDGJCD9sZrB
         SQf4HSxDlqVFWh152qgTsEBU0mXYPt3NoxqBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lfElKMam/T9V6bsHLEtrVU85ksJ2VDYhroR6xFrZWzc=;
        b=F7RxpYzMutEyeP8oEym2Np3Kx3ppZ9zLBaMWcKdB6XhjxkTMy1tIM3eRUSrzI5JkOG
         y93SmrlFN+Fr7hqEZSNelLyOnFK5uNjos3v00l83u1z1XFn4Wglc2klpomRwZ+jjCnZO
         tTJXD63RhkEARih0UIBGsFlhjwC9LppxFmKMfTKEk5LLP6NXJihLjLQBejCN8qrMYjej
         f4bCHbvDCTpehQ3VeOlBl9amCv1kbonvp9A15tg6XBpxpoRedLfcno3epjGFUK9dNsPJ
         mzH5NtV2f5F/9UGhFt8pq5MMRkiTPIoJ8t3A58qHlbl3j3xhwRL1cguuwPSizxfXBi2Q
         N+aQ==
X-Gm-Message-State: APjAAAWTAOjAVz/mdfeu03TKmnQ9mlHyxVLlJV57Mftd/qjfouu0seBK
        gICHHgZlLduhKca/h4coNPxzNA==
X-Google-Smtp-Source: APXvYqzQ7f5w2apaQfPAmRolacGQV7qES2OFHKPlOr231SsxxsJG+Tu1jnpgIbKXgFIB/alf1uAmAQ==
X-Received: by 2002:a17:90a:d990:: with SMTP id d16mr219208pjv.55.1567194470301;
        Fri, 30 Aug 2019 12:47:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k36sm5262114pgl.42.2019.08.30.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 12:47:49 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:47:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jason Yan <yanaijie@huawei.com>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org
Subject: Re: CONFIG_HARDENED_USERCOPY
Message-ID: <201908301242.EAC8111@keescook>
References: <6e02a518-fea9-19fe-dca7-0323a576750d@huawei.com>
 <201908290914.F0F929EA@keescook>
 <20190830042958.GC7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830042958.GC7777@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:29:58PM +1000, Dave Chinner wrote:
> On Thu, Aug 29, 2019 at 09:15:36AM -0700, Kees Cook wrote:
> > On Thu, Aug 29, 2019 at 08:42:30PM +0800, Jason Yan wrote:
> > > We found an issue of kernel bug related to HARDENED_USERCOPY.
> > > When copying an IO buffer to userspace, HARDENED_USERCOPY thought it is
> > > illegal to copy this buffer. Actually this is because this IO buffer was
> > > merged from two bio vectors, and the two bio vectors buffer was allocated
> > > with kmalloc() in the filesystem layer.
> > 
> > Ew. I thought the FS layer was always using page_alloc?
> 
> No, they don't. It's perfectly legal to use heap memory for bio
> buffers - we've been doing it since, at least, XFS got merged all
> those years ago.

Okay, so I have some observations/thoughts about this:

- This "cross allocation merging" is going to continue being a problem
  in the future when we have hardware-backed allocation tagging (like
  ARM's MTE). It'll be exactly the same kind of detection: a tagged
  pointer crossed into a separately allocated region and access through
  it will be rejected.

- I don't think using _copy_to_user() unconditionally is correct here
  unless we can be absolutely sure that the size calculation really
  was correct. (i.e. is the merge close enough to the copy that the
  non-merge paths don't lose the validation?)

- If this has gone until now to get noticed (hardened usercopy was
  introduced in v4.8), is this optimization (and, frankly, layering
  violation) actually useful?

- We could just turn off allocation merging in the face of having
  hardened usercopy or allocation tagging enabled...

-- 
Kees Cook
