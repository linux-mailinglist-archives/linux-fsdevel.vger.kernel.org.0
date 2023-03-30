Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D7C6D1256
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjC3WnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjC3WnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:43:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A6D52C;
        Thu, 30 Mar 2023 15:43:02 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o20so18279971ljp.3;
        Thu, 30 Mar 2023 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680216180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwFSRW8EN65u0U8C/dAzq9FdpZBx3E/E14iscLEl3M4=;
        b=hT7cL3NUFjJjieUCAjdMwM7ItXweUqXaFqPt1vfk5yG/y6QUi++t41EtlfLIIWyvLu
         bwuTNy5nVYJ4Yi9JqED4vp60pi/uqxSw96OzSuFdF/kTrw/IojPgg/1f8+sWAaU718zX
         z2kvxvWVqscryrXChdbGVJphDcOYdQzLoPKbE6JTGRsMsIlRjTjf1MH9vGEjs8LebUhP
         dNJn94UUcvimivtP5ddnc20MTADnTNQ/AhdXte8+JGTomGdRt2qteolQWtcC68SxtgRK
         pHHejurkg7LjY55cwiA4bsxl4BMPzFLirNNLXWKRmI7vbSjztHtB8KsKaHcnIrR9kgQm
         bHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwFSRW8EN65u0U8C/dAzq9FdpZBx3E/E14iscLEl3M4=;
        b=Sw6kqrqSrnGY6UP1nIUMeDnYM/hNJ4X0IEEhEABDRXYRWNScfU099b++vNjTMCvJJW
         6gaTvwjwKZZob4LqYKhQ/LxZeFkxyHRYOfCf5oiy3G079/9Zi75e2Ng+DkhvQA/+QzK4
         pPdbur+8b8+yulAvGGgcJyfV4bLjPe2oGv6JIBw0ez0A+3ZeusreZ0sMLXLqhAXo+M0d
         GOFoLGbY+XwqOC/pUjufnUMUXinM3lLrhIiWwX8zxo3sMEQIXL7pjW4OUy6JPjmdfyUw
         2XMmeBlx9L57fBxgAEzfWH/AivAzI1t8y8tMphLDs+rGgSLJopab3oWEfeUNrI4Fv9eg
         0HeA==
X-Gm-Message-State: AAQBX9ePtH9PBTgL7TIJw4929Fxj82IOmgxt3OmPB7cDSk1FZRMZXrqb
        5nTJCNXjfoLcZt2qs/B0+vdp/KziAC5v0BSW+X0=
X-Google-Smtp-Source: AKy350ZBRASV/rxsBIMl1jzB1Yib3BfUL3+4jVtWsGm5qKyhG2NEWoz4nYAftJcA3FIfHfpb3eGgI+D0OLN0/fv3S4U=
X-Received: by 2002:a2e:8746:0:b0:2a5:fe8f:ddec with SMTP id
 q6-20020a2e8746000000b002a5fe8fddecmr4261690ljj.2.1680216180588; Thu, 30 Mar
 2023 15:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202406.15762-1-ddiss@suse.de> <CAH2r5mtEXtRWbtf9OAzwWa2Wm6fUR+fZrU=OmtiP3E0VQpn+2w@mail.gmail.com>
 <20230330231910.1bed68a1@echidna.fritz.box>
In-Reply-To: <20230330231910.1bed68a1@echidna.fritz.box>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 30 Mar 2023 17:42:49 -0500
Message-ID: <CAH2r5msdSfBMBo=yKSLJqjn4Hyn3boSwQ1RywuWiOYfjSgD2Zw@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix DFS traversal oops without CONFIG_CIFS_DFS_UPCALL
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixed description (and updated to include Ronnie's RB)

On Thu, Mar 30, 2023 at 4:17=E2=80=AFPM David Disseldorp <ddiss@suse.de> wr=
ote:
>
> Hi Steve,
>
> On Wed, 29 Mar 2023 18:20:33 -0500, Steve French wrote:
>
> > merged into cifs-2.6.git for-next and added Paulo's Reviewed-by
>
> Thanks, although I'm only aware of Ronnie's review (in this thread).
>
> > On Wed, Mar 29, 2023 at 3:23=E2=80=AFPM David Disseldorp <ddiss@suse.de=
> wrote:
> >
> > > When compiled with CONFIG_CIFS_DFS_UPCALL disabled, cifs_dfs_d_automo=
unt
> > > NULL. cifs.ko logic for mapping CIFS_FATTR_DFS_REFERRAL attributes to
>     ^^
> If you're fixing the reviewed-by, then please also add the missing
> "is" between "cifs_dfs_d_automount NULL".
>
> Cheers, David



--=20
Thanks,

Steve
