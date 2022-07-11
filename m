Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547AF56FFD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jul 2022 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiGKLNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 07:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiGKLN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:13:26 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384EABC91
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 03:27:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so8029490eju.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89ZVLsdvHBjAdMd3l23MjrZLayKgPTYS2yIN1wlgK1I=;
        b=vBoOFCJGW48eH5YRpf2uKXY8Nj8EIPdoPVVsy5L9voIpWC2uUUnv67JLL2egeK5sWA
         eVFk/fWZXlgqBKOVE8mgf7rg78xv1r5y/RiUfaDcDiSxPoiwjoUHlKV3ZsqHY1sHOKtD
         2lmOXCuqN2I1mR3F+3ARAPrrbGMrzMl0LxD7AciqDXDwUMOtnrcbwF0EXYCmFD2yiYjR
         K/03iC02eWWYQilL489BcF7q5OkXwc/T0lxeCn88w5XG/zhg5LxB3m9VR6Mgl/32X+hI
         D/IIUv8DfTO1WEpIsWgI3nmUcarY7IPr7j+UVRcIrIVy+baJA+BRRv77VxEzUuCAMd+M
         afPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89ZVLsdvHBjAdMd3l23MjrZLayKgPTYS2yIN1wlgK1I=;
        b=aUtTUCSn+Zzk5198YgW/iuXtByLNPCuPFz9A9ivC8LKr+1iR5luXjuBWjNeEgeUy5v
         V0MTH5iWfkXYETWkT05hlHCX/NZhsDUfv938CE8GDnOPxm2ZexuY8LqyyF6CVoGRhM2G
         rBhc0Yi3rE1LA5iStd+MA8hYdxidpaPqDWaEys3gGc5fD4aztk+uMucbjM/pamZpvJU9
         4xQvnT1aY1TIhDlNrb8h2EzD7wbWdw1ncueGK4eC9e+PylgRa8Wi/rm+P0Qmodepppz2
         CahrzSLR/i9JYmF0oxnHxf/64hnKQB/6aukpGx4mFF44hRaHmGGeKS+WJot13nFF6PVg
         XwzQ==
X-Gm-Message-State: AJIora8iO8ieKzcfB6aLoBrHW7mNx2cDmgrnNWMpDz/YQgtmFEXvWdtg
        kOLf1lfTJGUaa7APyDL2Ck01ztzGdB9H+8hUN01yZhrCn12Z
X-Google-Smtp-Source: AGRyM1uX4j2idmLoWzd8qOU7XPMJiopKVTMyi6s3Vw5A9c/x1GKURWLJNzG2J01fgTu2ukZG9frnZmbe5kPPJeEVAX8=
X-Received: by 2002:a17:906:cc48:b0:72a:ff94:d5df with SMTP id
 mm8-20020a170906cc4800b0072aff94d5dfmr17052556ejb.693.1657535226854; Mon, 11
 Jul 2022 03:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220615055755.197-1-xieyongji@bytedance.com> <CAJfpegu8qB+omP+EKAckLqTKJtRwetFn5xRx8LfXqCeq7a=-kQ@mail.gmail.com>
In-Reply-To: <CAJfpegu8qB+omP+EKAckLqTKJtRwetFn5xRx8LfXqCeq7a=-kQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 11 Jul 2022 18:26:55 +0800
Message-ID: <CACycT3vSNX1-QZji0u-TEsTYP-EusOw_XCqyWcCXyZu=njkKVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Allow skipping abort interface for virtiofs
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 4:05 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 15 Jun 2022 at 07:58, Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > The commit 15c8e72e88e0 ("fuse: allow skipping control
> > interface and forced unmount") tries to remove the control
> > interface for virtio-fs since it does not support aborting
> > requests which are being processed. But it doesn't work now.
> >
> > This series fixes the bug, but only remove the abort interface
> > instead since other interfaces should be useful.
>
> I'd prefer properly wiring up the fc->no_control if there's no
> concrete use case for the rest of knobs.
>

I'm not sure if there are any tools that depend on it. But I didn't
find one. So I can try to remove them if we want.

Thanks,
Yongji
