Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7726180888
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 20:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCJTuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 15:50:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35704 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:50:01 -0400
Received: by mail-io1-f66.google.com with SMTP id h8so14088064iob.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3QS0e8RcKFN7/huSeBCCDwuVM9JqD+PwQz/25LYZ7s=;
        b=OhbAghdNUJbciPVHuH7moOlqqCFrFRE9cU5y6G8bZaazds/cVCLgdwVJGN8cktdJeV
         PcCU4iK+sDFS7sQ0uFJKeBvYtAZY/fdaWTYPriu+UWlAjLMThNuq340tP6KkBerdfuKh
         y3T0QJitw2eIkqR+syI0QC6SM1+A3omTiS8nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3QS0e8RcKFN7/huSeBCCDwuVM9JqD+PwQz/25LYZ7s=;
        b=eH4e5v7T2SHYRlv5Vk/ThIhdO7rjzWBGvLtDYkOKUgwLSYPmCMKAg3kA3lcdE8EY5G
         RE6eDf/n6TFTlOzYx+XjnBjGFBHaIx/X9r1JKZ9Gxr44lIWLUlz8f6+8Ltjlk4nHYc9t
         40kc+QLtcRO+Zqwuq22c4fy6VA2grG8gSR+anJqScfUQiHvV7T9clB8ud3M7keYia9VW
         LaIAwl+9uBRMv5l1jM/uWIVSCGaXn+AECpxhsWvHEGx2Mei4BLjuetZbMS7m86ax8NNv
         kLbM8COwLnqG/0mSlORdKUInKPulB/I68gRdK1WIewiq+vERAuMphzLzCpjhWQG1xHRx
         6cCg==
X-Gm-Message-State: ANhLgQ1XQZxKV7HcFazPJ1dr/7COaie3ss6Jd0LC2cBsKEWRNnTuv2I1
        s78NLvIPfiK6CVkW8h/rpxmr+la7YGYUGAmGc8N02A==
X-Google-Smtp-Source: ADFU+vst15KzgX+tYyB+mxwdb3zdIiBvf9oRWln6x3JODjSTwfwW2FTFg8mFRjfOJtT7xvjklxE++Xz8fUEBp6Pgo14=
X-Received: by 2002:a02:a813:: with SMTP id f19mr19907887jaj.35.1583869800367;
 Tue, 10 Mar 2020 12:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-13-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-13-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 20:49:49 +0100
Message-ID: <CAJfpeguY8gDYVp_q3-W6JNA24zCry+SfWmEW2zuHLQLhmyUB3Q@mail.gmail.com>
Subject: Re: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Introduce two new fuse commands to setup/remove memory mappings. This
> will be used to setup/tear down file mapping in dax window.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> ---
>  include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 5b85819e045f..62633555d547 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
>         uint64_t        flags;
>  };
>
> +#define FUSE_SETUPMAPPING_ENTRIES 8
> +#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
> +struct fuse_setupmapping_in {
> +       /* An already open handle */
> +       uint64_t        fh;
> +       /* Offset into the file to start the mapping */
> +       uint64_t        foffset;
> +       /* Length of mapping required */
> +       uint64_t        len;
> +       /* Flags, FUSE_SETUPMAPPING_FLAG_* */
> +       uint64_t        flags;
> +       /* Offset in Memory Window */
> +       uint64_t        moffset;
> +};
> +
> +struct fuse_setupmapping_out {
> +       /* Offsets into the cache of mappings */
> +       uint64_t        coffset[FUSE_SETUPMAPPING_ENTRIES];
> +        /* Lengths of each mapping */
> +        uint64_t       len[FUSE_SETUPMAPPING_ENTRIES];
> +};

fuse_setupmapping_out together with FUSE_SETUPMAPPING_ENTRIES seem to be unused.

Thanks,
Miklos
