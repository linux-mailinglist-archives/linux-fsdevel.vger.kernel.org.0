Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CD85BC2D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 08:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiISGan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 02:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiISGal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:30:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C01B1CE
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 23:30:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so62147194eja.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x5E3hYeUBGyR87LRm8eirjWx9vUenYX8S09rh5V5DeE=;
        b=SgbFi65+KWlqhaVNbisBSQTaI0ZkOP3JMuGhF95zdjuSgkkppCZ5fILSeNAG3i2yuN
         TcrJjKbRuZEuabnrOokutAsJJEzIqeoJRH5ZfeIoRdDwdMFctZafeCMzKiEIr0YWzwsG
         z5hPrJkdnRvuDCUq5c5hqm9GsIVb5Zq7FXV2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x5E3hYeUBGyR87LRm8eirjWx9vUenYX8S09rh5V5DeE=;
        b=ANAfCgzMA0+aPS+v6sy4H+REIj98GKPjpOmAd2lgw8ynfsRi1iJRpg/iMLk3wJwmOG
         qgiQOzOgi0Cq3K1hUVEEvH8FB+wF+yg80CWrQOJIIxqKXrpAJPbsGodS4usGJQdJ+pI9
         9pkGt44+SWIPQl+cSvi5V3KRZqCVLWHnT+xAsOY4wMjUS6IBiO0IR2D1QAPPv53RqM4W
         SE3XmrR6Fu8cO89sKHLOLpnoShYb9XGyzZ111dYX+GAJM7ILbURMtZziPseSa6YzYbat
         +O5x5mAEnXKaKZB1EkQ1adqFzCTa3XQ2rEMIJDf5biXpMwd2Z8szrNQteN5z7Z1X2duf
         Bl9g==
X-Gm-Message-State: ACrzQf08RCnJCrXx5cm0sngksEGamkEnqV5IqckaDPFHWfRGKNG8KyC1
        Oee/8liwzXTIldzYMO56b5sokg8uyW/FWCSkHWTMPg==
X-Google-Smtp-Source: AMsMyM52QzKupHhHIHx6aue/wTW6JmWbnq6pIxu0UL038iSxPzhOYtY0ndIvmFyBCDNozavURv/N4nzkp6RJD6juefA=
X-Received: by 2002:a17:907:97d1:b0:780:26c9:1499 with SMTP id
 js17-20020a17090797d100b0078026c91499mr11357251ejc.371.1663569037607; Sun, 18
 Sep 2022 23:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916194416.1657716-1-mszeredi@redhat.com> <20220916194416.1657716-8-mszeredi@redhat.com>
 <66d2c136-547a-3538-d015-c4ee0dcb2419@fastmail.fm>
In-Reply-To: <66d2c136-547a-3538-d015-c4ee0dcb2419@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 19 Sep 2022 08:30:26 +0200
Message-ID: <CAJfpegtk8HPFfQegrs1fsPuC3hwHD2TXvGS7pQor=EoqMmtfng@mail.gmail.com>
Subject: Re: [PATCH 8/8] fuse: implement ->tmpfile()
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 16 Sept 2022 at 23:52, Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 9/16/22 21:44, Miklos Szeredi wrote:
>
>
> > +static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
> > +                     struct file *file, umode_t mode)
> > +{
> > +     struct fuse_conn *fc = get_fuse_conn(dir);
> > +     int err;
> > +
> > +     if (fc->no_tmpfile)
> > +             goto no_tmpfile;
> > +
> > +     err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
> > +     if (err == -ENOSYS) {
> > +             fc->no_tmpfile = 1;
> > +no_tmpfile:
> > +             err = -EOPNOTSUPP;
> > +     }
> > +     return err;
> > +}
>
> A bit confusing part is that the other file systems are calling your new
> finish_tmpfile(), while fuse_create_open() calls finish_open() for
> tmpfiles as well. Seems to be identical but won't this easily miss
> possible changes done in the future to finish_tmpfile()?

There shouldn't be any such changes.  It's really just a shorthand
form of finish_open().

Would calling it finish_open_simple() help?   It really has nothing to
do with tmpfile and .atomic_open instances could call it as well.

Thanks,
Miklos
