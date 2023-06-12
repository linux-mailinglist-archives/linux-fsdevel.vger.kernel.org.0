Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B13972B644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 06:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjFLEAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjFLD76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:59:58 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE3318B;
        Sun, 11 Jun 2023 20:59:57 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-78cd0c63ae2so94294241.1;
        Sun, 11 Jun 2023 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686542396; x=1689134396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5eFbd9HFD/KRz0+XmRiub04jDxZ5/25uC97kTShMpE=;
        b=EHyikn5gRvV78mN0YYf4xUPtAFpwRdYAhXIgBhQsen9zlXyZa6YQlQUu4I0VWvmJh+
         dhWeExCKRXcTldPlqkBujT4S8hYN9S3Jbd0cMP3UHAxhFpCvnWUtHmMlhjd82cWzsGvU
         Qb7ARehRdVdQqDwwsuvnhXh3B4toJX9+XvVg9hyMHUdMnCY5RWns/MKwcvTSzaHC+A5z
         LGWo7zNB0SZBqKipj0F/4Pdmq3YHlJiRJAryzsQ/uZsCXKixJBKSxVNWgBYySL2p8hyI
         XG2M96nT6JkeIkwNK/tgbq9u68or6XC76h7ZdsAV4l8TrLv8iVPvQyw7+G8nKpB+6EsB
         ZRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686542396; x=1689134396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5eFbd9HFD/KRz0+XmRiub04jDxZ5/25uC97kTShMpE=;
        b=O29izzM6VWi3MIrt9LuOqD2CTZj8NvvtlC6b/4dkY1fO8JY53wJ3Lm91+oDx9A1muw
         fdTxacKpCx7giw5aNhJfUVVef68mb9+0EiiW8VIBW//e+DyMPZw8o730gQlAWPUV0BhG
         sWjXLX2OasTjkUtTAMuTG4hLJ9tiwha0yW35z5AuQTZ7331fe2CUIPXdAMQa3isZgRUs
         c3MitrJ7FoiFgFQW1CdpwAygMEBB+RDK8Nt/4jX0I/MskH9as4bgcSpt8FauuHViY8jD
         NjqeBbNeSPOY68zTqQD4HaiyF1e++8P4Qgqg41osxRtTtu6GDTu9R6didb2UsQAV2c10
         sOQQ==
X-Gm-Message-State: AC+VfDysFHCOwwuhuOPxZjBQccTrVLIs1TWsMpqlyt7p6K6NIInipxnI
        3yLZTQj+Qnnq3f6w2Cz20ESqFjArNyr+MW0SN+Y=
X-Google-Smtp-Source: ACHHUZ6USzvroyFg92cZrS7qO9IxCrPShW1dFdqmI83KF4j0hqeLShP/3gCnfuLWhWbnhcZB+F5Mz/kUXDkjrqKPDPY=
X-Received: by 2002:a67:f906:0:b0:43b:2630:477 with SMTP id
 t6-20020a67f906000000b0043b26300477mr2660495vsq.5.1686542395803; Sun, 11 Jun
 2023 20:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000da4f6b05eb9bf593@google.com> <000000000000c0951105fde12435@google.com>
 <20230612033023.GA16241@lst.de>
In-Reply-To: <20230612033023.GA16241@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 12 Jun 2023 12:59:39 +0900
Message-ID: <CAKFNMomCUnaB3_3chQm4P8devx2NwAp2hMpYfbyaHKyO2WLEkw@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_clear_dirty_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot <syzbot+53369d11851d8f26735c@syzkaller.appspotmail.com>,
        axboe@kernel.dk, dsterba@suse.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wqu@suse.com
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

On Mon, Jun 12, 2023 at 12:30=E2=80=AFPM Christoph Hellwig wrote:
>
> On Sun, Jun 11, 2023 at 02:18:29PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 4a445b7b6178d88956192c0202463063f52e8667
> > Author: Qu Wenruo <wqu@suse.com>
> > Date:   Sat Aug 13 08:06:53 2022 +0000
> >
> >     btrfs: don't merge pages into bio if their page offset is not conti=
guous
>
> I can't see how that btrfs commit would affect nilfs2..

Yeah, I think this bisection result is wrong.
I have already posted a bug-fix patch titled "nilfs2: prevent general
protection fault in nilfs_clear_dirty_page()"
for this issue.

Thanks,
Ryusuke Konishi
