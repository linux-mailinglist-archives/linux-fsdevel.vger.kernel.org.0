Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C180B64D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfIRNkk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 09:40:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42811 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfIRNkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:40:40 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so16170266iod.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATuX8EIOxlpSwdyBiZYQlv1azss4zE5wSKwxCtolCdI=;
        b=Ztvd/SqnlNDBgL+KDRGV+FRvBx5glU46mX94XgrT3UH+kjAMAeFCUQUB31kfRa+cDF
         haZ0otJGgvTf/K9cJmHvRlS+hKi9MSIRMPn4RuAEfdepH4HYFKUXbZ3FRKqObTH9Uw3/
         QDH0ivFlviTUhy2mu+Crd92Eot2PvGscRg7Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATuX8EIOxlpSwdyBiZYQlv1azss4zE5wSKwxCtolCdI=;
        b=UsT3AteoqJyAuNZC1XKJIYeK6fzhxqbgSBoP68synPpAKFlmDHLMsWqVPbFTjShT38
         bgF0v18oBvb9LmZuSJlA6P0Y5mAZ/cpAttzIjrAcJ3NfxSxbLO8fA0tR+CGFbJd7VJGm
         DiM9FWa5yHTNouCSuHGRxodcBAeByHOqwoENk9F3MRo1MQHRjiDeMeQ5QUzcRViXXP8n
         t6gTANlwupQpCLxKk5RhvIGdBCSRTc8k+RV79hAlnS3QNatFy8M5pv192qFG+Qas0VOq
         DwXVx4h31iTB+h+hWlLR0wd+0sQ3S4L7I1006bnLr7LX9O1xbJVOQ+/Rml2SEm2lJVCi
         3OTw==
X-Gm-Message-State: APjAAAXBj601826MRFQt1CDJjPS/A4aozlIA8ng4RdilJN7ec2wsw8qe
        rBrUv05lHwjd46qWZhM38yRywk9320hjD97KSb5gnQ==
X-Google-Smtp-Source: APXvYqwkARifyRHf1YCC3t6qp1ghAXswoFF1Gj2kUefz8lsvcOfTKUMbWbx3+tGYozwtOMEnjHdeTY5LtlPZlydkDdE=
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr5056239ioa.212.1568814039180;
 Wed, 18 Sep 2019 06:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190912141931.30819-1-mszeredi@redhat.com> <20190918084651-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190918084651-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Sep 2019 15:40:27 +0200
Message-ID: <CAJfpegsUEOyUsiNPMaoXCqpoF236mu=DqOvZgqqOE4x1WDLTXw@mail.gmail.com>
Subject: Re: [PATCH v6] virtio-fs: add virtiofs filesystem
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 2:57 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> Overall this looks ok to me. Handling full vq by a timer is really gross
> but it's correct - just terribly inefficient.

Yes.  The reason this didn't get too much attention is that it's
relatively difficult to make the queues actually fill up (which is a
good thing).

But this should definitely be one of the first things to be cleaned up...

>  I think you should add a
> MAINTAINERS entry though, we want
> virtualization@lists.linux-foundation.org Cc'd on patches.

Already done in the documentation patch (which I didn't resend, but
you should find the v5 version in your mailbox).

> With that corrected:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Who's going to merge this? Miklos do you want to merge it yourself?

I'll merge this since it depends on the rest of the fuse queue.

> > +     /**
> > +      * Cleanup up when fuse_iqueue is destroyed
>
> Cleanup up -> Clean up

Fixed.

> > + * virtio-fs: Virtio Filesystem
> > + * Copyright (C) 2018 Red Hat, Inc.
>
>
> 2019 at this point?

I'd consider the creation year okay for this.  These copyright notices
don't seem to be kept up to date, and don't need to, since the SOB
procedure allows for fine-grained tracking of authorship.

> > +     /* After holding mutex, make sure virtiofs device is still there.
> > +      * Though we are holding a refernce to it, drive ->remove might
>
> refernce -> reference

Fixed.

Changes, with your ack pushed to:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Thanks,
Miklos
