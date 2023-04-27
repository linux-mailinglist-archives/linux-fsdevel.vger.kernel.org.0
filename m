Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DA6F0043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 06:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbjD0E5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 00:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD0E5m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:57:42 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496753AB0;
        Wed, 26 Apr 2023 21:57:39 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-77106047c7dso2744880241.1;
        Wed, 26 Apr 2023 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682571458; x=1685163458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLmWIFpnn20j0lccvqVtw0L56xvxxqFU548NhO28Qec=;
        b=Cbknn0Oex4GnYVwe9GEWBYrrMj1F9BhPRxqYrOTzI2A+w6OJhSK2a/v+CXOV/foGiG
         6Y4qgtWxWJNcpIeM+DnyI2tNhYoaHEPVYR716+hJpoGHaMMNY8GoMq/rHJa/8ECmsZjE
         Ahw6EiS57bmx/acs0YNLduKRDAduk1rQbwLlyDd9d0WI6FWAaT3Gddhpg/ws/UNffqQc
         BhTEWLInc1ZVlV8pRK669xCqYopaN0OOp4uH9cKXbxAxl5iIpw4zoh+BBSEnO9xrKlIK
         OvAefcIS55/I72oHPjktHpe7o4f07umosVQNJtCHu82suBabrn8H6zxSAI5NC+s1NTUW
         a+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682571458; x=1685163458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLmWIFpnn20j0lccvqVtw0L56xvxxqFU548NhO28Qec=;
        b=IWn6H0VxNKYlrNZkPq+F249Wx7fXSgC8ZLctb1KAaRY658LNmfm8lC8LAbchvTv9Ug
         CrITXMUenxVnzP+BvSa6+JQXb4l6DsgikJ0jNY3yW7RMsEFXEqC15ZwCgJpf40sDGA6J
         A3YI8TqfxkYhVEzLj9bYOK+N4V/9HcDQ2DWRT2pkTSvRDGvVZMMbM7+82l4wyNPo54Au
         fWCQ8a6duKVEQTYX9sdGO24w7C6+jRwvEquSoA8QAXyFKb1kvjikyNyaEfwyQoiLnZLZ
         BBlF0u6f4tU8CMIaDqfFXZN5BPKsp08m/CR1R8WNTKEbRbrTkzpEtwty5mAO/JZQ0z49
         bZwg==
X-Gm-Message-State: AC+VfDwiiPZ2E08pF19EfbKVArNzre5yw7QguLBb/Z4+6EKWdE9RZa7I
        FaATfJv7LuUsgu3J9jbu9cgicgbP8M6bBK1Mq40HcTnCa7g=
X-Google-Smtp-Source: ACHHUZ6FxsA/v05Ew0AoOkka/784qMVNZ58NlcOrY65lOQIFTNGfnXrlaDZm/QEj1HN1H5dd2sqAZigvANvAusP6djg=
X-Received: by 2002:a67:f8d2:0:b0:42c:7e09:f41f with SMTP id
 c18-20020a67f8d2000000b0042c7e09f41fmr189090vsp.16.1682571458302; Wed, 26 Apr
 2023 21:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <ZEkrfVEQ8EkmUcxK@manet.1015granger.net>
In-Reply-To: <ZEkrfVEQ8EkmUcxK@manet.1015granger.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 07:57:27 +0300
Message-ID: <CAOQ4uxgjZD3RtYLV+LVLf8Yf6kazQSKBbSh6NUrds=tE6s9Aog@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
To:     Chuck Lever <cel@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-nfs@vger.kernel.org,
        jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 4:47=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Tue, Apr 25, 2023 at 04:01:01PM +0300, Amir Goldstein wrote:
> > Jan,
> >
> > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at =
an
> > alternative proposal to seamlessly support more filesystems.
> >
> > While fanotify relaxes the requirements for filesystems to support
> > reporting fid to require only the ->encode_fh() operation, there are
> > currently no new filesystems that meet the relaxed requirements.
> >
> > I will shortly post patches that allow overlayfs to meet the new
> > requirements with default overlay configurations.
> >
> > The overlay and vfs/fanotify patch sets are completely independent.
> > The are both available on my github branch [2] and there is a simple
> > LTP test variant that tests reporting fid from overlayfs [3], which
> > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > requesting a non-decodeable file handle by userspace.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vt=
ft@quack3/
> > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> >
> > Amir Goldstein (4):
> >   exportfs: change connectable argument to bit flags
> >   exportfs: add explicit flag to request non-decodeable file handles
> >   exportfs: allow exporting non-decodeable file handles to userspace
> >   fanotify: support reporting non-decodeable file handles
> >
> >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> >  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
> >  fs/fhandle.c                                | 20 ++++++++------
> >  fs/nfsd/nfsfh.c                             |  5 ++--
> >  fs/notify/fanotify/fanotify.c               |  4 +--
> >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> >  fs/notify/fdinfo.c                          |  2 +-
> >  include/linux/exportfs.h                    | 18 ++++++++++---
> >  include/uapi/linux/fcntl.h                  |  5 ++++
> >  9 files changed, 67 insertions(+), 26 deletions(-)
>
> Hello Amir-
>
> Note that the maintainers of exportfs are Jeff and myself. Please
> copy us on future versions of this patch series. Thanks!

Sorry. Will do.
Thanks for the review!

Amir.
