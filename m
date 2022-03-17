Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F24DC9A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCQPO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbiCQPO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:14:28 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB9C8931C
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:13:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v75so5907088oie.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vsXPFM05s5AQNEixsjvTdclhiFilv/38nHKYUquOD8=;
        b=jNKg/6F8ntzJx914Od4UtzAwjF7yIJxzxe3d8/e1I0dacpaJ2NJnic0QLX0vNidQUx
         kThdtc2c60Yizg2mM9cdRtmYlUuXLVlwg9EL7A74RuGX8y7BwukMCFxTMG8smnCKMrub
         y3r6CG6zvOOfo5r/y4a39cDQq5bM8+OsXDn0XbMykjUEo7Otqj53ufRK8HbKJoUuuzTx
         6ih3Dfa/B6eDIes9VFWnJdRUUMxZe0DkYUVPzaI9MXXCFG9Bm9ORwLbzKXmxc8pTM3kS
         WH7vxW5EJoGOv9feOz1qN5SelL95eCn4h96/5WIqrL6o1vR/K2DAMgjQXhDf7J9YAsnU
         utBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vsXPFM05s5AQNEixsjvTdclhiFilv/38nHKYUquOD8=;
        b=hAJ6/DISjgvQB1BRk6W8wEbT7bfrrzL6LYMuhCsGgT9CI7+zZL6Xa/Q0i1A5+imPZy
         +QX8ISKLkKIkJlrViEzlJcmlNU7C9NXtvzLRI/xAANtC6xrt6rhr8ud2SK05jZBSLS7V
         oCrsOElAf3Bv7ILlLjU8zzYIbFU4bD2/7Q2r2vQySBk/0OBwXusmBzZ6La31tbeEZPAQ
         aci3DJW1kYmmTtkuBEifjsyYhQP4PETeGrcufsDBxcVFaSHN+/BBRkmmzcX2TyGIyIxU
         hZyJxxeq3yBD7nDWnpFIcHwWT3dfR+GJQ3MnynZzXFQhcsZPMlcljQuv5VKRJdmPY+I7
         SwCQ==
X-Gm-Message-State: AOAM533sly+KJfhIBy4J/TbV/7erLU64q96RfR+YHDB5dzUXQKkkBGIX
        VMbWGEinBLLVoJ89hMVE/wobvBQSSefMekah8oo=
X-Google-Smtp-Source: ABdhPJyq9BEMo1noKrhzDzbijKP2p6g35H/NKWQzxjqYgRSv+UzQNH33cEMMYibGnxL+df93xrUapx2DGeP48+jLCIg=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr5870867oib.203.1647529991118; Thu, 17
 Mar 2022 08:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-2-amir73il@gmail.com>
 <20220317142541.shlwdtb4ujusce4u@quack3.lan>
In-Reply-To: <20220317142541.shlwdtb4ujusce4u@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Mar 2022 17:12:59 +0200
Message-ID: <CAOQ4uxhpRiPKuqvNhKGfyj69-D8Lrbpfxm4Xxuf6f4GkTTqinQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fsnotify: move inotify control flags to mark flags
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:25 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-03-22 17:57:37, Amir Goldstein wrote:
> > The inotify control flags in the mark mask (e.g. FS_IN_ONE_SHOT) are not
> > relevant to object interest mask, so move them to the mark flags.
> >
> > This frees up some bits in the object interest mask.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Looks good. I'm just wondering: Can we treat FS_DN_MULTISHOT in a similar way?

Probably, but it is less straightforward. Need to add dn_flags to
struct  dnotify_struct.

Thanks,
Amir.
