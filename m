Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F0FDD3C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbfJRWTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 18:19:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393698AbfJRWTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:19:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so4672561pfb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2019 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qUpFp9KbBdWTA0E3gLC1f/xv0BL9BCPRfBmIyXLMH9o=;
        b=IaOC59DYv7KJEbVcYWcyRLrXU1oRgzuR1RM9lexH6K0zqcIc3Z6m34DHWN+ZsJ2wBe
         LY7mrWxUdAZpPNvKpo8mDvELAYqphBX13rSdoZXNoBmNoA+/ePoP5cofLtUN0o0xmJET
         Sg2obSCTgbmkdxCSuhDU7T682WIPRAj8hlnrKt3r1pnYeKCbK/GudaH54rAabHouqmiR
         G6As+0f4zpg4bzcpH63EjDEEtSJzvIQ0Pwi0UArtJJK3EX3NMd6PPAOkVzyh891ib8Yb
         vjzcDtg4wYqxTAszqHaBdsu1eDPNs8v0MPsL1fHSePiPCRHFxDf5XbrWI+FqYJUpkQ2E
         X0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qUpFp9KbBdWTA0E3gLC1f/xv0BL9BCPRfBmIyXLMH9o=;
        b=a+KFtKuCax3gf5Vp2d6rg+OHvTydSVdbdjMMmIzW75C6eU1foJw2dij9p8m3ZkQi/8
         Anyy1eLQg09V6JqwrP6FcLkLae3UmfC7wr3sp35PLUPBVITjnM0SAsitkeV7mazio/H5
         jwP+uyC3MAjoOoMlaDjAgA/aPmnQOm0ryZCwG2yo8bsLCOFGKc9VCVbiaDC+YzczOscE
         oUuDljmk00JnKgKLa5h9Sxr6DIw5UnPv6yRoCjQRFTKTOCu/fqjueG6yeLKmLJlyQs8Y
         1mseLXl7vxvE40ruBfAHB8aZg6blw7rL/6gb+Gt1gLyRsV5DQaAtgFJhcl4xpg0tJH/S
         ordw==
X-Gm-Message-State: APjAAAU+OmSE4KitVvUYVv487ClDxdNX3+43Y7fkhnLiL8qeiQ66steS
        Ti87r82o8D+8NLfdA/oOKu57/vPvC9w=
X-Google-Smtp-Source: APXvYqyxzxBugxiQhWjrcdKq/fapHz7ohmS/zaFmnasZqb/cpP6OqZNVRoAvo3fcsrgg1N6/7uR0JQ==
X-Received: by 2002:a65:564b:: with SMTP id m11mr8264583pgs.133.1571437186710;
        Fri, 18 Oct 2019 15:19:46 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:cf85])
        by smtp.gmail.com with ESMTPSA id o185sm11976062pfg.136.2019.10.18.15.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:19:46 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:19:45 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] btrfs: generalize btrfs_lookup_bio_sums_dio()
Message-ID: <20191018221945.GB59713@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <01fdb646d7572f7d0d123937835db5c605e25a5e.1571164762.git.osandov@fb.com>
 <aa49f032-f6be-8594-7c80-7101a0c6bcd0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa49f032-f6be-8594-7c80-7101a0c6bcd0@suse.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 12:22:33PM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.10.19 г. 21:42 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This isn't actually dio-specific; it just looks up the csums starting at
> > the given offset instead of using the page index. Rename it to
> > btrfs_lookup_bio_sums_at_offset() and add the dst parameter. We might
> > even want to expose __btrfs_lookup_bio_sums() as the public API instead
> > of having two trivial wrappers, but I'll leave that for another day.
> 
> IMO exposing btrfs_lookup_bio_sums and adding proper kernel doc for its
> parameters is the correct way forward. Consider doing this if the
> general direction of this patchset is accepted and before sending the
> final revision.

Ok, if I'm not the only one that thinks it's a good idea, I'll go ahead
with that.
