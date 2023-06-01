Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790F719BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFAMOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjFAMOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:14:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDC4E61
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 05:14:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fa4a6a79bso99703466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685621596; x=1688213596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xyPeoWutKyPiILXgLviwGF1RLzkupo3yExspEf61QSc=;
        b=gXuksHS2G+jIJhUGBbUNjw/Kp8UgLvtwfvk2K1C4T1pZpYHIBEAQLW51xyX43VGcjk
         GNykJTKyqGdrNQOYpogcCBk8YczFIaj96DUaruH/VajUWK9C6MiCbxctzTu/3GXcpEcs
         72wEtWANLjdiGmP9AJbhKtikgTGG2YM35ujVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685621596; x=1688213596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyPeoWutKyPiILXgLviwGF1RLzkupo3yExspEf61QSc=;
        b=fZXYvwfoe21bXSiI+vd265i5B977kTECLv8HvJEIsY00HrgCsRKbmkZkI6amEVtWP4
         fgN1NqypMH3fpIJNqwAq7J3hOOLiApuQ7yzn81DF349kZV4BBu6/SEFM7WiKPd4CvIn/
         isIfMAKu4/5ysqI4x8oWFQcM5/7KDb+PO5mUw9OwQ+AJw0jQgvW3c0KuxLVPwSZ0YIyy
         XmNs74WJga6cVVGR35PcSu5a3eIoRBw6ZmzgXLQLzKQyxYYfaPnAddiMOeoGp/yGXSqH
         weABAZl/lxfEiqV/frCBKMgpCPymEUAWzOH+nvQjAkm3YCGD2J9OsRSva5N0YL9//UI7
         U4+g==
X-Gm-Message-State: AC+VfDz6r5AHzN5+L3e3Gd8tQ2J9VEF35vBx32VfYba9DB/WvjGQ1nfN
        hdZQzmuXxynUNRlxJYA6bn2LLoCX+844hd5lc6hLM2ekn/Lly0l/
X-Google-Smtp-Source: ACHHUZ4JszazVsNMBMXQ0p4wl7QThlCjhod2KN4/0fDqzedboIm9DGJkd6n8g5yFti5UauXZWQH88TQS+53u92NRWYY=
X-Received: by 2002:a17:907:3ea0:b0:96f:9608:da7c with SMTP id
 hs32-20020a1709073ea000b0096f9608da7cmr8501573ejc.36.1685621596227; Thu, 01
 Jun 2023 05:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531092643.45607-1-quic_pragalla@quicinc.com>
 <CAJfpegtr4dZkLzWD_ezAbFgTnbYaGDRq4TR1DUzz4AfFLSLJEA@mail.gmail.com> <27f39698-8b70-52df-3371-338f2de27108@quicinc.com>
In-Reply-To: <27f39698-8b70-52df-3371-338f2de27108@quicinc.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Jun 2023 14:13:04 +0200
Message-ID: <CAJfpegtHicLw7-KjQem60UPaUyco7h1tZ+4EmOdC-=9=C8Tg8Q@mail.gmail.com>
Subject: Re: [PATCH V1] fuse: Abort the requests under processing queue with a spin_lock
To:     Pradeep Pragallapati <quic_pragalla@quicinc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Jun 2023 at 12:02, Pradeep Pragallapati
<quic_pragalla@quicinc.com> wrote:
>
>
> On 5/31/2023 5:22 PM, Miklos Szeredi wrote:
> > On Wed, 31 May 2023 at 11:26, Pradeep P V K <quic_pragalla@quicinc.com> wrote:
> >> There is a potential race/timing issue while aborting the
> >> requests on processing list between fuse_dev_release() and
> >> fuse_abort_conn(). This is resulting into below warnings
> >> and can even result into UAF issues.
> > Okay, but...
> >
> >> [22809.190255][T31644] refcount_t: underflow; use-after-free.
> >> [22809.190266][T31644] WARNING: CPU: 2 PID: 31644 at lib/refcount.c:28
> >> refcount_warn_saturate+0x110/0x158
> >> ...
> >> [22809.190567][T31644] Call trace:
> >> [22809.190567][T31644]  refcount_warn_saturate+0x110/0x158
> >> [22809.190569][T31644]  fuse_file_put+0xfc/0x104
> > ...how can this cause the file refcount to underflow?  That would
> > imply that fuse_request_end() will be called for the same request
> > twice.  I can't see how that can happen with or without the locking
> > change.
> Please ignore this patch. i overlooked it as list_splice in
> fuse_dev_release() and made the change.
> > Do you have a reproducer?
>
> don't have exact/specific steps but i will try to recreate. This is
> observed during stability testing (involves io, reboot, monkey, e.t.c.)
> for 24hrs. So, far this is seen on both 5.15 and 6.1 kernels. Do you
> have any points or speculations to share ?

Do you have KASAN enabled in the kernel?  That might help UAF issues easier.

Thanks,
Miklos
