Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDD663C43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 10:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjAJJIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 04:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbjAJJHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:07:41 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750419C25;
        Tue, 10 Jan 2023 01:07:40 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id jr10so3106432qtb.7;
        Tue, 10 Jan 2023 01:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gXHkdvWBXNLyizQqN+zkUZ//tPu5q4K0Ow4ZbjvaKhg=;
        b=LeSg2FkhIhu9tMHW5R4n9vrheCJBYn824F/gOjqNBUOgydaQ/eiaUxZG/wQyoZbTHT
         QBn7BYZr/zCCaT5RJ0keGxHcFRmZvWzv+AOF+80jy2PvB9p9erNBDxTkIBmlcU44ayk3
         5LGUQAytZyMu7VeARuyBifwCPsQrcuWKCAPL3i+6LtuNUpXC9zTDWYPmr/CeeW5TtDxO
         UTCCP0h3BB+ExMIDZG5F69XD3vN+LM5GxutZyMMfGah9eNnIRjzbjUiwQzRgYXTTdyZ1
         7Hq8GXMEGhHC0z2krtnm7+gQd4dtKGRnJQcPdEN75WtGfp9FplamJ042YDnxa26P2WhT
         mB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXHkdvWBXNLyizQqN+zkUZ//tPu5q4K0Ow4ZbjvaKhg=;
        b=diVndK3t53zlfWBJr/GD4P1z8fp0/L/WVkW8vXRBcEx2j4Vid9Euci8ulRo1VRlvfT
         mT+uPuAdarPe+u3pZf5wQfK3MyilFWI8TvrCtNjbvquhRHaWlR4c5DtuOeMTe1PSZOzw
         /XkWB+D43rYkAU4GGayVHeiR1MW5vH2JuwR42nWBQGvg6BtrvQqs12e5ytcEAl9EAZbv
         WXv7MLw6TUagpiDzHA72CCYvO5NB9nWxXost2NX3KuuPwwRiroiq00VHwG3r1IheVA1I
         jCT/R699093H4R+3jHfxzEGVhpIhw3ww6yJ4SKyIBJsZFW+U1qyBHy/S53bR+Ab1oxN4
         8Rpg==
X-Gm-Message-State: AFqh2kp52osMP6i6mq22eXlOtAhZmR/0Cl841mz+0szXsj+NbvKPtLRB
        dPR3+Aiv5PnhnuxSt7objuwBZVBKSwCB5aQm3tYkg+K8lC4=
X-Google-Smtp-Source: AMrXdXs6uhQyxln3cf7HEIycxq2EFSA7Nn+yk7nOOwlXGh0hcw7vP/9kuIOgPi/gxFvAWtY489aIJuA9oy3Nx0jH16g=
X-Received: by 2002:ac8:5544:0:b0:3a9:6c70:3992 with SMTP id
 o4-20020ac85544000000b003a96c703992mr3080249qtr.585.1673341659942; Tue, 10
 Jan 2023 01:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20230108213305.GO1971568@dread.disaster.area> <20230108194034.1444764-1-agruenba@redhat.com>
 <20230108194034.1444764-5-agruenba@redhat.com> <20230109124642.1663842-1-agruenba@redhat.com>
 <Y70l9ZZXpERjPqFT@infradead.org>
In-Reply-To: <Y70l9ZZXpERjPqFT@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 10 Jan 2023 10:07:28 +0100
Message-ID: <CAHpGcML+3tHmvKzzpun52BfZy94ekqGe+sXWZBDe04D_+0N=Ug@mail.gmail.com>
Subject: Re: [RFC v6 04/10] iomap: Add iomap_get_folio helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 10. Jan. 2023 um 09:52 Uhr schrieb Christoph Hellwig
<hch@infradead.org>:
> On Mon, Jan 09, 2023 at 01:46:42PM +0100, Andreas Gruenbacher wrote:
> > We can handle that by adding a new IOMAP_NOCREATE iterator flag and
> > checking for that in iomap_get_folio().  Your patch then turns into
> > the below.
>
> Exactly.  And as I already pointed out in reply to Dave's original
> patch what we really should be doing is returning an ERR_PTR from
> __filemap_get_folio instead of reverse-engineering the expected
> error code.
>
> The only big question is if we should apply Dave's patch first as a bug
> fix before this series, and I suspect we should do that.

Sounds fine. I assume Dave is going to send an update.

Thanks,
Andreas
