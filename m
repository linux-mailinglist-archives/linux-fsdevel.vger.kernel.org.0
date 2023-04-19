Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A186E814A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDSScS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjDSScR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:32:17 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18336271E;
        Wed, 19 Apr 2023 11:32:16 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id v18so435947uak.8;
        Wed, 19 Apr 2023 11:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681929135; x=1684521135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+eiDUqQ4ATdWBBA4KAHSoTZLEcs4ydIuwuJ2VGKhcE=;
        b=eGXa/dvNSs5V1EdWbsohe1VuRV9tYm3i6dzHmbDV6OikfVgUe1TtRonG3bvikweY1X
         QZrMpPgkx3HNVeoRJ8b3LdvW+efpB064IwhX0/Uf3Td7nko4gHT6Efn79WV6/qgEw47P
         ezA5qF5TmsUNC0HusTO+x+vFbKY9uHr4mWidLz4gZUtnGJ4Rhs+RZ7cQd08eDsq6O/2Q
         6bkMFGl/rOjQvOHw+YOzad+sP9EMLbLrG1KD9RAQxLPamRz1QiF28bPfO1ykGqZlbgvC
         plydQay/ACU1RzxscaYFY4Guwd4BfH5/bRGVqwz/hJ880hzn0JKNDXCWGAFRb0/WIFR6
         DgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681929135; x=1684521135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+eiDUqQ4ATdWBBA4KAHSoTZLEcs4ydIuwuJ2VGKhcE=;
        b=PWkvcWA2WuCP46tOMxkK3P06TZgTxI+8ue/nzFuUHs0atXFZVzV530y++IEcQgRXh/
         4e4DxaKQi2tFsDV2fcmh2Br7SaZ8ttRBDXj2wPU+c5vzXc2m7OwI6y+rSPLg3Fdy3v4L
         bZKLImg9p++LcraRIOoGxjN9jKhLmROn/77F1eaRHhQYQgPRLMg60Yx6mpYTwAIz1C2k
         5IWQKtPUwTx8ltM4xpy/gxPszzOUAhTX+wL92pKoXjIMC4D8Hw4oc1FBBpQakypbPOpI
         JA1pjaEiUc3XY5h9sMN7AJ8jhXX0ncMaxRqNiHZPL4lmn/AcXZVMl6+gNCFS5NFT0ZqJ
         nAwg==
X-Gm-Message-State: AAQBX9cyv1E5bVdIH4FE2cRJDcPb4NZ7M+9b6Or0d1c7rf/K5gCP5OAd
        rReyx3Fy6OH3QdjrOa9tjDJlIv/3EhOKNhHNNnTUbMRn
X-Google-Smtp-Source: AKy350besVBLBJG/sKIygEX0YjXkAbx2mPHk4Ok17jeOeyymZQxKRkNtz7ACCZcLOEPn2WtCS6BnXTIzr7hq1sJ6HxE=
X-Received: by 2002:ab0:5b8d:0:b0:771:f5ee:f4e with SMTP id
 y13-20020ab05b8d000000b00771f5ee0f4emr280734uae.1.1681929135067; Wed, 19 Apr
 2023 11:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230414182903.1852019-1-amir73il@gmail.com> <20230414182903.1852019-2-amir73il@gmail.com>
 <20230419131441.rox6m2k5354j22ss@quack3>
In-Reply-To: <20230419131441.rox6m2k5354j22ss@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Apr 2023 21:32:04 +0300
Message-ID: <CAOQ4uxhFU4XbANZCdmM2OH4=rxESSygXkKTBn6BMynSXkCpMgQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] fanotify: add support for FAN_UNMOUNT event
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
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

On Wed, Apr 19, 2023 at 4:14=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 14-04-23 21:29:02, Amir Goldstein wrote:
> > inotify generates unsolicited IN_UNMOUNT events for every inode
> > mark before the filesystem containing the inode is shutdown.
> >
> > Unlike IN_UNMOUNT, FAN_UNMOUNT is an opt-in event that can only be
> > set on a mount mark and is generated when the mount is unmounted.
> >
> > FAN_UNMOUNT requires FAN_REPORT_FID and reports an fid info record
> > with fsid of the filesystem and an empty file handle.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Seeing the discussion further in this thread regarding FAN_IGNORED won't
> it be more consistent (extensible) to implement the above functionality a=
s
> FAN_IGNORED delivered to mount mark when it is getting destroyed?
>
> I.e., define FAN_IGNORED as an event that gets delivered when a mark is
> getting destroyed (with the records identifying the mark). For now start
> supporting it on mount marks, later we can add support to other mark type=
s
> if there's demand. Thoughts?

Sounds like a good idea.

I will look into it.

Thanks,
Amir.
