Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4A3E5929
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 13:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhHJLeO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 07:34:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbhHJLeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:34:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 83AB92009E;
        Tue, 10 Aug 2021 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628595229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGHQoxFgLxzrAyVEvKxaCUt+s4AACK8ClH0C6z1y2uQ=;
        b=pH0mWjcf96HRpsrC0a3PRfKNZs7kdyxtskfolLcI6rf9pr+zfzBfIz9plCDNYwGkcYnswp
        ks9Tft/MSU7VIQTSAFn27rgeZtGYll2jna2JfyFUdXTKtE0ejTfkdYnL/2skVPYErK0+Ev
        wyoarCd5/DZqId/b2VdC5s/X4NoCij8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628595229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGHQoxFgLxzrAyVEvKxaCUt+s4AACK8ClH0C6z1y2uQ=;
        b=8OTIdUaUUGFf7+DABViXEEcLQx9Q1vS7HVep007te9+/iNfhrMPajU+ElZb4MN9mH6ZfG8
        Mi3WcL/hc4FeUMAA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 5192FA3BAF;
        Tue, 10 Aug 2021 11:33:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F19F41F2AC2; Tue, 10 Aug 2021 13:33:48 +0200 (CEST)
Date:   Tue, 10 Aug 2021 13:33:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add pidfd support to the fanotify API
Message-ID: <20210810113348.GE18722@quack2.suse.cz>
References: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628398044.git.repnop@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Matthew!

On Sun 08-08-21 15:23:59, Matthew Bobrowski wrote:
> This is V5 of the FAN_REPORT_PIDFD patch series. It contains the minor
> comment/commit description fixes that were picked up by Amir in the
> last series review [0, 1].
> 
> LTP tests for this API change can be found here [2]. Man page updates
> for this change can be found here [3].
> 
> [0] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhnCk+FXK_e_GA=jC_0HWO+3ZdwHSi=zCa2Kpb0NDxBSg@mail.gmail.com/
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgO3oViTSFZ0zs6brrHrmw362r1C9SQ7g6=XgRwyrzMuw@mail.gmail.com/
> [2] https://github.com/matthewbobrowski/ltp/tree/fanotify_pidfd_v2
> [3] https://github.com/matthewbobrowski/man-pages/tree/fanotify_pidfd_v1
> 
> Matthew Bobrowski (5):
>   kernel/pid.c: remove static qualifier from pidfd_create()
>   kernel/pid.c: implement additional checks upon pidfd_create()
>     parameters
>   fanotify: minor cosmetic adjustments to fid labels
>   fanotify: introduce a generic info record copying helper
>   fanotify: add pidfd support to the fanotify API

Thanks! I've pulled the series into my tree. Note that your fanotify21 LTP
testcase is broken with the current kernel because 'ino' entry got added to
fdinfo. I think having to understand all possible keys that can occur in
fdinfo is too fragile. I understand why you want to do that but I guess the
test would be too faulty to be practical. So I'd just ignore unknown keys
in fdinfo for that test.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
