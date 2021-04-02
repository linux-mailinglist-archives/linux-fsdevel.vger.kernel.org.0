Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A268D35284E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBJMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 05:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhDBJMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:12:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94CC0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 02:12:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w11so2274997ply.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eClyzo54kpf4B5tpfP3fEyzY7D8nTckaJP0ovBRgLBw=;
        b=IPvwChbu4YwpZ1QrwmUTpgYzS1JQK0WpJTxlZZ+4T+k0qLP+vDXh7JvCd/4V/RAgCA
         HKC56rDALIS8NaFoVyCTGSvaDWKYaKsVLcIkYcbaD6F43HbcfkNJ7a/OLMsPRdspl2Rn
         uL5sntwbyFheg77a5e9GRqVtw0MLP+i940Ij0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eClyzo54kpf4B5tpfP3fEyzY7D8nTckaJP0ovBRgLBw=;
        b=KTUEC1AC4+2/XS4K0YUM+tGxbLEry7qwXwYSRGyrQ9GF37Scq0WmWfTYQYBoXm4qJB
         F6t+I+An6UFgu6w5oCUoxoTTgpESRCjaHO7bJvgIdUnk0bYqqkDaHY4Sjicz0ge5bV0O
         Pr+IeEEWecWc7RBurGO+w9Dvs0q15XOua8hl+rZf7ZWN1WQ+/Ak7fBFHZRFSW/SqQWYj
         kooJ5PcT/mP1yzThGu/5nvr7rmbDbkEpVxwLc5CAYWO6S5/tN0F+IQCPxQA34Fc1LWdz
         RN1vAvcBoV6z0v3xx39gwHqW2sj5yR+oG/eugkD7ZCzWHeyvaMuaX1rd2/CP7W38u+Zd
         b4Dw==
X-Gm-Message-State: AOAM531TyjiJMlkzo85L4AvtdwMB15o+PieJ1YktXh0WpQ1ftyTAkqXX
        7pn1MQ38nIBqDCTrGft/z7ikeg==
X-Google-Smtp-Source: ABdhPJyrFWgP+qAN88fhumPhJVUdxksoE1hFMcsLBFucOW8x+oYH99yEY0RHDBRzYKlUtpf4x+b9qA==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr13009816pjq.9.1617354772739;
        Fri, 02 Apr 2021 02:12:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gz12sm7673412pjb.33.2021.04.02.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:12:52 -0700 (PDT)
Date:   Fri, 2 Apr 2021 02:12:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Yongji Xie <xieyongji@bytedance.com>, devel@driverdev.osuosl.org,
        tkjos@android.com, maco@android.com,
        Jason Wang <jasowang@redhat.com>, joel@joelfernandes.org,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>, arve@android.com,
        viro@zeniv.linux.org.uk, Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] binder: Use receive_fd() to receive file
 from another process
Message-ID: <202104020210.9A945E5@keescook>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <CACycT3ux9NVu_L=Vse7v-xbwE-K0-HT-e-Ei=yHOQmF66nGjeQ@mail.gmail.com>
 <YGWjh7qCJ8HJpFxv@kroah.com>
 <CACycT3uEGRiDuOj2XBwF2PmnGXsQgrLDemJDFRytsJiJMyRWDw@mail.gmail.com>
 <YGWvbAXQO2Vsiupo@kroah.com>
 <CACycT3vNaDg5twEpKtnZTjbyD=0FhZKJLzH+uBNQuyCmxFaeww@mail.gmail.com>
 <YGXUNfsExs6tZD0c@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGXUNfsExs6tZD0c@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 04:09:57PM +0200, Greg KH wrote:
> On Thu, Apr 01, 2021 at 08:28:02PM +0800, Yongji Xie wrote:
> > On Thu, Apr 1, 2021 at 7:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Apr 01, 2021 at 07:29:45PM +0800, Yongji Xie wrote:
> > > > On Thu, Apr 1, 2021 at 6:42 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Apr 01, 2021 at 06:12:51PM +0800, Yongji Xie wrote:
> > > > > > On Thu, Apr 1, 2021 at 5:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > > > > > > > Use receive_fd() to receive file from another process instead of
> > > > > > > > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > > > > > > > the logic and also makes sure we don't miss any security stuff.
> > > > > > >
> > > > > > > But no logic is simplified here, and nothing is "missed", so I do not
> > > > > > > understand this change at all.
> > > > > > >
> > > > > >
> > > > > > I noticed that we have security_binder_transfer_file() when we
> > > > > > transfer some fds. I'm not sure whether we need something like
> > > > > > security_file_receive() here?
> > > > >
> > > > > Why would you?  And where is "here"?
> > > > >
> > > > > still confused,
> > > > >
> > > >
> > > > I mean do we need to go through the file_receive seccomp notifier when
> > > > we receive fd (use get_unused_fd_flags() + fd_install now) from
> > > > another process in binder_apply_fd_fixups().
> > >
> > > Why?  this is internal things, why does seccomp come into play here?
> > >
> > 
> > We already have security_binder_transfer_file() to control the sender
> > process. So for the receiver process, do we need the seccomp too? Or
> > do I miss something here?
> 
> I do not know, is this something that is a requirement that seccomp
> handle all filesystem handles sent to a process?  I do not know the
> seccomp "guarantee" that well, sorry.

This is an extremely confused thread. seccomp _uses_ the receive_fd()
API. receive_fd() calls the security_file_receive() LSM hook. The
security_binder_*() LSM hooks are different yet.

Please, let's wait for Christian to clarify his idea first.

-- 
Kees Cook
