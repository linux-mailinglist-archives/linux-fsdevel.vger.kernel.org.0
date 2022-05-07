Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F351E5BE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiEGI4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344435AbiEGI4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 04:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BBCD3F325
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 01:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651913538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ciSZ83kEJsDE3Sa5MWACbwccq8QNxUBeEt2oeFsfks=;
        b=TsuL37sFmSB/FaYw2HCPmnNu1/Ucjzqi5rd+stjfslEYlMcCCD1uq79UDayq5GdImf7mJh
        PHhFBmkcnIumNtaULzWdQnXT12jiNlW3P1qcbsCtIVcFCt3spBKycLq46yrnoipJCtibjs
        uB/YHneb55G/o5kNicTp1EostNqJFyU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-vDe4UjHUNYSsLbEv35D9xQ-1; Sat, 07 May 2022 04:52:17 -0400
X-MC-Unique: vDe4UjHUNYSsLbEv35D9xQ-1
Received: by mail-qk1-f198.google.com with SMTP id o13-20020a05620a0d4d00b0069f47054e58so6532381qkl.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 01:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0ciSZ83kEJsDE3Sa5MWACbwccq8QNxUBeEt2oeFsfks=;
        b=ZOHMcKu0F95NxbrrxcnwLdAhlEL7X23Q6WN1aYbRUpOL1GnZ1+3YEPaE8CwMCbdqqz
         jGyzJ7RVi04FyOcdU2cJC+fLTpNasN0HnLqQDwc2P8m8od8HA8ebFzM3sS0nQZYmkWpk
         aYUlaUaA1jAOnD8AbU3qxwlVbETQ3GifQ39XuFxezDWeCck20AP9rT+V8o3ZVCxXj4fo
         gbA6oO2xCr7JhKdjEfDAAzAXkKh7k7dPNh06CTUXHxJRdRZqI/VqhxYzpWaZvkAUXXpB
         WNkclhebi3BEzBb/EFM4hYegK4oCiIEn6PpklXnxvN7lz95phepL8s81AbM9YjcOjGlD
         eFhQ==
X-Gm-Message-State: AOAM531IfIGD4isWXi3ri9MRFXmo7CQ2lqpn/TkRqqB2Mmg696dVyMzT
        ZjuZ6+GsLwBj7i0jPkMklkOb+HhRrAJ+y6jNgtcucOmX5sjfLK8hnY1waj3LQTHyD5QXXQiETt8
        jMVwuWsv7/BsmF9br9yB3Wee/yA==
X-Received: by 2002:ad4:5f05:0:b0:45a:b123:c790 with SMTP id fo5-20020ad45f05000000b0045ab123c790mr5717721qvb.105.1651913536594;
        Sat, 07 May 2022 01:52:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIBzHQ9MAQUy0qbjalqPMAKavi34yRXzOZQ7RrVrBdVX+bNk5poqDGDCGKjpoueT6Mn6ly6Q==
X-Received: by 2002:ad4:5f05:0:b0:45a:b123:c790 with SMTP id fo5-20020ad45f05000000b0045ab123c790mr5717712qvb.105.1651913536379;
        Sat, 07 May 2022 01:52:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p184-20020a378dc1000000b0069fc13ce1e1sm3747116qkd.18.2022.05.07.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 01:52:15 -0700 (PDT)
Date:   Sat, 7 May 2022 16:52:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] idmapped-mounts: Reset errno to zero after detect
 fs_allow_idmap
Message-ID: <20220507085209.ortk2ybj3t2nemkc@zlang-mailbox>
Mail-Followup-To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6275DAB9.5030700@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6275DAB9.5030700@fujitsu.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 07, 2022 at 01:33:33AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Zorro
> 
> Since  Christian doesn't send  a new patchset(for rename idmap-mount)
> based on lastest xfstests, should I send a v4 patch for the following
> patches today?
> "idmapped-mounts: Reset errno to zero after detect fs_allow_idmap"
> " idmapped-mounts: Add mknodat operation in setgid test"
> "idmapped-mounts: Add open with O_TMPFILE operation in setgid test"
> 
> So you can merge these three patches if you plan to announce a new
> xfstests version in this weekend.
> 
> What do you think about it?

Sure, you can send V4 of patch 1/5 ～ 3/5 (base on latest for-next branch
please), as they have been reviewed and tested. Christian's patch (about
refactor idmapped testing) might need more review, he just sent it out to
get some review points I think (cc Christian).

If you'd like to catch up the release of this weekend, please send your
v4 patch ASAP. Due to I need time to do regression test before pushing.
It'll wait for next week if too late.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu
> > If we run case on old kernel that doesn't support mount_setattr and
> > then fail on our own function before call is_setgid/is_setuid function
> > to reset errno, run_test will print "Function not implement" error.
> > 
> > Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> > ---
> >   src/idmapped-mounts/idmapped-mounts.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> > index 4cf6c3bb..8e6405c5 100644
> > --- a/src/idmapped-mounts/idmapped-mounts.c
> > +++ b/src/idmapped-mounts/idmapped-mounts.c
> > @@ -14070,6 +14070,8 @@ int main(int argc, char *argv[])
> >   		die("failed to open %s", t_mountpoint_scratch);
> > 
> >   	t_fs_allow_idmap = fs_allow_idmap();
> > +	/* don't copy ENOSYS errno to child process on older kernel */
> > +	errno = 0;
> >   	if (supported) {
> >   		/*
> >   		 * Caller just wants to know whether the filesystem we're on

