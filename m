Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C41466655
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 16:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347566AbhLBPYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 10:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51000 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233556AbhLBPYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638458440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpHGsXakpJlVBZeLLA5f4UndWEwg3fD3Vmc+Si6d6Ds=;
        b=T+KMgep2BA9/jsG3Uvpi7WrE1UqJHQBFKl80Iv712l1Rb0A0d0fq8EPJF7rWeN+PxDLb4F
        jA+K+WXSSkGX2v2oPWvfKYNsoVHAB62o1E6MOKH0r+yM96s6VMPqyLaM1+4+RoOJntP/sC
        unxw/nzJZ/w2K4JxB56HU3Qh+G80z7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-xN-dqma8PymgPha3qORidw-1; Thu, 02 Dec 2021 10:20:35 -0500
X-MC-Unique: xN-dqma8PymgPha3qORidw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E662583DD31;
        Thu,  2 Dec 2021 15:20:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A945DF21;
        Thu,  2 Dec 2021 15:20:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 57E70225F43; Thu,  2 Dec 2021 10:20:33 -0500 (EST)
Date:   Thu, 2 Dec 2021 10:20:33 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ronyjin <ronyjin@tencent.com>,
        charliecgxu <charliecgxu@tencent.com>
Subject: Re: ovl_flush() behavior
Message-ID: <YajkQUpxWQI1N64l@redhat.com>
References: <17d719b79f9.d89bf95117881.5882353172682156775@mykernel.net>
 <CAOQ4uxidK-yDMZoZtoRwTZLgSTr1o2Mu2L55vJRNJDLV0-Sb1w@mail.gmail.com>
 <17d73da701b.e571c37220081.6904057835107693340@mykernel.net>
 <17d74b08dcd.c0e94e6320632.9167792887632811518@mykernel.net>
 <CAOQ4uxiCYFeeH8oUUNG+rDCru_1XcwB6fR2keS1C6=d_yD9XzA@mail.gmail.com>
 <20211201134610.GA1815@quack2.suse.cz>
 <17d76cf59ee.12f4517f122167.2687299278423224602@mykernel.net>
 <CAOQ4uxiEjGms-sKhrVDtDHSEk97Wku5oPxnmy4vVB=6yRE_Hdg@mail.gmail.com>
 <CAOQ4uxg6FATciQhzRifOft4gMZj15G=UA6MUiPX2n9-NR5+1Pg@mail.gmail.com>
 <17d78e95c35.ceeffaaf22655.2727336036618811041@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d78e95c35.ceeffaaf22655.2727336036618811041@mykernel.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:11:39AM +0800, Chengguang Xu wrote:
> 
>  ---- 在 星期四, 2021-12-02 07:23:17 Amir Goldstein <amir73il@gmail.com> 撰写 ----
>  > > >
>  > > > To be honest I even don't fully understand what's the ->flush() logic in overlayfs.
>  > > > Why should we open new underlying file when calling ->flush()?
>  > > > Is it still correct in the case of opening lower layer first then copy-uped case?
>  > > >
>  > >
>  > > The semantics of flush() are far from being uniform across filesystems.
>  > > most local filesystems do nothing on close.
>  > > most network fs only flush dirty data when a writer closes a file
>  > > but not when a reader closes a file.
>  > > It is hard to imagine that applications rely on flush-on-close of
>  > > rdonly fd behavior and I agree that flushing only if original fd was upper
>  > > makes more sense, so I am not sure if it is really essential for
>  > > overlayfs to open an upper rdonly fd just to do whatever the upper fs
>  > > would have done on close of rdonly fd, but maybe there is no good
>  > > reason to change this behavior either.
>  > >
>  > 
>  > On second thought, I think there may be a good reason to change
>  > ovl_flush() otherwise I wouldn't have submitted commit
>  > a390ccb316be ("fuse: add FOPEN_NOFLUSH") - I did observe
>  > applications that frequently open short lived rdonly fds and suffered
>  > undesired latencies on close().
>  > 
>  > As for "changing existing behavior", I think that most fs used as
>  > upper do not implement flush at all.
>  > Using fuse/virtiofs as overlayfs upper is quite new, so maybe that
>  > is not a problem and maybe the new behavior would be preferred
>  > for those users?
>  > 
> 
> So is that mean simply redirect the ->flush request to original underlying realfile?

If the file has been copied up since open(), then flush should go on upper
file, right?

I think Amir is talking about that can we optimize flush in overlay and
not call ->flush at all if file was opened read-only, IIUC.

In case of fuse he left it to server. If that's the case, then in case
of overlayfs, it should be left to underlyng filesystem as well?
Otherwise, it might happen underlying filesystem (like virtiofs) might
be expecting ->flush() and overlayfs decided not to call it because
file was read only.

So I will lean towards continue to call ->flush in overlay and try to
optimize virtiofsd to set FOPEN_NOFLUSH when not required.

Thanks
Vivek

