Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664EB48CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfFQSuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 14:50:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35231 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfFQSue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:50:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so781128ljh.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJNgLRxBBn3ldusAk8vZnHSv/cw7OZUcPpU87Ds7axA=;
        b=Bou8DRGEQCecEBNSUfFtTPeseoLHD0XaAFEIBsWSO0ipikvw3uK03pajREfMRg9xGJ
         RHjbeoD4wiwvH1jw+HHfdArE6k8zcfMKGxTOigVfiqDD3yQNYZV/bHc7sTIEHfVYs6/a
         BFygJ9Og1NqRb3jOobPB1z9rLh9rBzkbN9K0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJNgLRxBBn3ldusAk8vZnHSv/cw7OZUcPpU87Ds7axA=;
        b=LiRxSXLEWXnny9RkwDCYLWdqxQv0ARwSvhAXZKpCyogwvi0XvnJ9EDNep0j57l5gJ5
         0IlwR3uMEvITGOdnuQuxL837AVha8IMeOZTA9Svn5DlIxVM+NgcCGmDnOfHImSHrPIuJ
         NKcjSLsdm9/f8XDL5a8lO2n8L+Ot2rJT/p1QMEb0vvo8PIOr/ote32V5LdHMd/kc+/9b
         znNFbCOKtHApUCuOOp7YLXrAKsP8HN/kv9ODd5TAqlBiHUXtO+J9WMk3nYkVS/NjgSf3
         ctOqWsOllXogerMFDUQGhbPTr60rboqEdsVkrsOFbFbq14uGxwiaghT0VgBqWDURYKPu
         O/Lg==
X-Gm-Message-State: APjAAAUL+Grf+qenerYuQ4RNWHuRcIB/39p01+8gEVnioOu28pOOblfa
        TGLUsuecZps+BujeI6ToNsvesuklBlc=
X-Google-Smtp-Source: APXvYqzr7ychqVYmzZ2FxJurRNpIF7NwQ3IVRemc70lRIkrPeqmpxJmhWvdcflkuuiXM1R50sXhF8Q==
X-Received: by 2002:a2e:6c14:: with SMTP id h20mr3033244ljc.38.1560797430850;
        Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id x1sm2209275ljx.61.2019.06.17.11.50.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 131so10391653ljf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 11:50:30 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr14840250ljj.165.1560797429770;
 Mon, 17 Jun 2019 11:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617184711.21364-1-christian@brauner.io>
In-Reply-To: <20190617184711.21364-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 11:50:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
Message-ID: <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
Subject: Re: [PATCH] fs/namespace: fix unprivileged mount propagation
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:47 AM Christian Brauner <christian@brauner.io> wrote:
>
> When propagating mounts across mount namespaces owned by different user
> namespaces it is not possible anymore to move or umount the mount in the
> less privileged mount namespace.

I will wait a short while in the hope of getting Al's ack for this,
but since it looks about as good as it likely can be, I suspect I'll
just apply it later today even without such an ack..

                    Linus
