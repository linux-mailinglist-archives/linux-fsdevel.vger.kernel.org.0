Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5978BF0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjH2HRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjH2HQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:16:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9661A3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 00:16:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a5be3166a2so172452166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1693293405; x=1693898205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cNLUwqPpE3fMhpuPjDxzndJxbXpQeb9TpCT81EH68Fw=;
        b=CbkAsRQsRqfCx2dx+0imI+FcjRWzcLaVcGx2yDDB9RqwcWAk5ZHaeMtPdRghryJFUv
         I0plBTCkVc7n93Ot3RmztYJcryP6RyFie3geg8dttA/J9yn9I2SVWr9Rwojsq5TeOcDn
         YP3snIY191CVoHar6EDMdSoQ12ErBw/oK7fZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693293405; x=1693898205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNLUwqPpE3fMhpuPjDxzndJxbXpQeb9TpCT81EH68Fw=;
        b=L5n+BVVKcB1K63StkAmNUvjLITCa1MP+0PzaqTevBPunyiGX0f2Wt8zPN9alOXuB/0
         ZYRBdgj1ixRcS+KLFgrwhe/lf/SXv32djqJ5cTGEvwZyVOZ6GsOyW7O5YUrV9Gum9kME
         qXWi9Tv7MpB6bYbNVci7IrkgvCUir2x3/Nuh8Rs687e5E8wxUmaQN8nWQLl8TsL/BiUT
         YQTXQ2JCr98Pbcl8Znfy2pkrtBWH3CFSmh4ShnrJm8ruUbzmn1OrFMcHxl0TbuyPX2f3
         xi1r+bQj7AVnn7tiUraPKATQPJlQUTrmCyb+pzYjD7lh6/MOGldhHK8AMbFd4H3YtiNY
         t4IQ==
X-Gm-Message-State: AOJu0Yzdo6Y1AO3FhkdKvLds2fVKAWoYc/tJDQODWyEdEdneM6dv4nOl
        45bMFbznaA0CDeQxZHPenWRYb2umaoz9B+TaobL+jSb3uMW2gf0S
X-Google-Smtp-Source: AGHT+IHec8M3GkrLIzhZnRj/W1rEGDztneFYLd2C0eVRB1JBRxLQUrVQF8TTBSLfU06bTR3XRD9JGpXMCKO4yLkON6U=
X-Received: by 2002:a17:906:2219:b0:9a1:c3ae:b014 with SMTP id
 s25-20020a170906221900b009a1c3aeb014mr14165712ejs.20.1693293405142; Tue, 29
 Aug 2023 00:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230824150533.2788317-1-bschubert@ddn.com> <20230824150533.2788317-5-bschubert@ddn.com>
 <CAJfpegvW=9TCB+-CX0jPBA5KDufSj0hKzU3YfEYojWdHHh57eQ@mail.gmail.com> <1673c0ad-8e1d-fdcd-cffc-33411a7fabd2@fastmail.fm>
In-Reply-To: <1673c0ad-8e1d-fdcd-cffc-33411a7fabd2@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 29 Aug 2023 09:16:33 +0200
Message-ID: <CAJfpegtYsDXp9ppzXq7ysxcKBq+kxqL1Umrjgobmuy1RcLOsmA@mail.gmail.com>
Subject: Re: [PATCH 4/5] [RFC] fuse: Set and use IOCB_DIRECT when
 FOPEN_DIRECT_IO is set
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Aug 2023 at 22:03, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/28/23 13:59, Miklos Szeredi wrote:
> > Also could we make the function names of fuse_direct_IO() and
> > fuse_direct_io() less similar, as this is a very annoying (though
> > minor) issue.
>
> What about _fuse_do_direct_io()? '_' to mark that it is a follow up and
> 'do' that it initiates the transfer? Or maybe just '_fuse_direct_io'? Or
> 'fuse_send_dio'?

I'd prefer a non-underscore variant.  fuse_send_dio() sounds good.

Thanks,
Miklos
