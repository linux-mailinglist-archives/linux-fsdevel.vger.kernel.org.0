Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8518081D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgCJTb6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 15:31:58 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34769 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgCJTb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:31:57 -0400
Received: by mail-il1-f193.google.com with SMTP id c8so12733948ilm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=Auk/J/am7PnSkti7DnDeBTBkoI7EdkOeiXxOafA83iFtNlXEfJCh8HA0llJSykN0lU
         F3K3PX0+eGlrLpw9xVldfbGWlBeibwiL4+JP4oW3J6fT8IYoEUYX6QU+hSAzqc2x9YAS
         wcqf5w4LictNkY4z6rP056PjahcGRfLxvhsqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QsMHMToALTgigyVVitR0QGzkqjZRHN3wRK9R0WkFcg=;
        b=b+UuTyaYCulzScydlwnGOZUoJ52sz2YjuUCqKu+692d87w+YwHrppRrcJBqX+W93fU
         gAgiffcHNnAhWmGPZQPCy1MN3go0ZxEfvr3s1z5/Iwdy2txFFCnwBGULpR6HuBvlhb8m
         Sw601cIg69ZTDsYIF+0p3uJ9e7eThkgDjwl37wt9Qcew5gPGJNXadONHRC+ZTWDpIK09
         xq6QKK8AnXDjoQb6uci+wId37AulfboO096eAFxF7tHohCFmZowYP2Rhda8L/ZA1U/pB
         yWM9rpy7zu8fBsdiUdHxEFuoUEXwAGgKRG/ILhkVxRszGLz8qmmUZ/cNHcbAKL6759bm
         36Gg==
X-Gm-Message-State: ANhLgQ2XztQJCEpacQHzFuULjiD8caVsqLS/O+0XUrBfWWKygmhi6kC2
        g2V/GsKs0U9iCUDNlCworMn6YMwhqA+nbUD00h1UIg==
X-Google-Smtp-Source: ADFU+vsFfd6CjN4MRb2Z8XflZdOXGt54+OVcpgTdjMhSBiJTAUfuWfnL1e0wV+iTRlceDUTwZKIzKC3VAbxB+0sXKGs=
X-Received: by 2002:a05:6e02:f43:: with SMTP id y3mr21752506ilj.174.1583868715742;
 Tue, 10 Mar 2020 12:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-12-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-12-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:31:44 +0100
Message-ID: <CAJfpegu5HMg2BnBsfSEWOv7K_0KjchntZ9q4oOvxzYLjOEBF3g@mail.gmail.com>
Subject: Re: [PATCH 11/20] fuse: implement FUSE_INIT map_alignment field
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> The device communicates FUSE_SETUPMAPPING/FUSE_REMOVMAPPING alignment
> constraints via the FUST_INIT map_alignment field.  Parse this field and
> ensure our DAX mappings meet the alignment constraints.
>
> We don't actually align anything differently since our mappings are
> already 2MB aligned.  Just check the value when the connection is
> established.  If it becomes necessary to honor arbitrary alignments in
> the future we'll have to adjust how mappings are sized.
>
> The upshot of this commit is that we can be confident that mappings will
> work even when emulating x86 on Power and similar combinations where the
> host page sizes are different.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
