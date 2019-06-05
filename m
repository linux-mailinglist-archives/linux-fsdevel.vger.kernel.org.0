Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 930F135A6A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfFEK0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 06:26:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEK0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 06:26:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so12139697pgm.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M1ULtVTBaRjJ1PHd8skCpbTVO6zbbI/pi1e0gXp7yc0=;
        b=jAQ7fFrGO0TepAjaeIU8cFqLQxHx3KjiTOlpJHN1i0lpGgHHU5xkuYBwY5v31GkgKL
         pJPivwXOu550agdJIYhlPftZMBzP0X7kfNUgAK1FayYvt8LHGpXhis876t6/AELoj4Ix
         LteoO3odnsLY/gznyLnkIIRH4x4bn6QYccT5RQmKC05p9Jje9UPyLlgJehd5351xQC5m
         EK+mjbCGXLppVyRoCHYSC6lUQ61Z63AqXSjp/BCcL7MK3CCKVljkD2p+chMO+3wCNhU/
         eX7Dv99osaWfMFdlpwiGXyGvPW8KPEZ7RaaNjMwyuc8wLKK+LFyoZXxOZqBqvfiQV3jw
         U0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M1ULtVTBaRjJ1PHd8skCpbTVO6zbbI/pi1e0gXp7yc0=;
        b=isZ17yHjSY1UnsuYiX+08wli2m91uGuJP/My2q9b6rCrchFuYK324z8SeqkImv+J3W
         7jlcV+NY8NrtUAQl4dBcpuzA3bJrys6NVqZCwA2FwEPsQjRRIaA8HhWCXLgmfIsM1cQU
         71lc30OuJ/rfwivuAqbpCyVLSbyhaysc9AdBKadqeka+UOJvB030gnT2gSt2hvkQa4sH
         r7FiAQN0PRCuDCyQQ5rQgge/qCfEcZw5ZzwzFWByG0xHBoJh39vnzP6ncZ0i/5+gMKFm
         bh+PZCiGS981pn+g1n0mGVxDNvznFOQrXf0tOMVNY7/AWjzCbZLz2CEsd6DqJCkEUTFy
         HyFg==
X-Gm-Message-State: APjAAAUKWr1yz6M4k8pitumPVrRlRJQzfEdKOaDT4UY3cVvbfUVvDZvZ
        TV2IDOnrm95AOum5fdKUrjHn
X-Google-Smtp-Source: APXvYqySxD+fahxqn6P/0cG5QKLSgMNAfXkPXSCVU91zFyZzNMLl1HP/nOL6ml0Er8r9V2f2cemjRA==
X-Received: by 2002:a63:4e07:: with SMTP id c7mr3389206pgb.350.1559730380269;
        Wed, 05 Jun 2019 03:26:20 -0700 (PDT)
Received: from poseidon.Home ([114.78.0.167])
        by smtp.gmail.com with ESMTPSA id i5sm14705123pfk.49.2019.06.05.03.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 03:26:19 -0700 (PDT)
Date:   Wed, 5 Jun 2019 20:26:13 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190605102611.GA4546@poseidon.Home>
References: <20190522163150.16849-1-christian@brauner.io>
 <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 01:25:08PM +0300, Amir Goldstein wrote:

...

> > > > Interesting. When do you think the gate can be removed?
> > >
> > > Nobody is working on this AFAIK.
> > > What I posted was a simple POC, but I have no use case for this.
> > > In the patchwork link above, Jan has listed the prerequisites for
> > > removing the gate.
> > >
> > > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > > When events gets reported with fid instead of fd, unprivileged user
> > > (hopefully) cannot use fid for privilege escalation.
> > >
> > > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > > non-initial userns it's a no-no
> > > > since we support nested workloads.
> > >
> > > One of Jan's questions was what is the benefit of using inotify-compatible
> > > fanotify vs. using inotify.
> > > So what was the reason you were looking into switching from inotify to fanotify?
> > > Is it because of mount/filesystem watch? Because making those available for
> >
> > Yeah. Well, I would need to look but you could probably do it safely for
> > filesystems mountable in user namespaces (which are few).
> > Can you do a bind-mount and then place a watch on the bind-mount or is
> > this superblock based?
> >
> 
> Either.
> FAN_MARK_MOUNT was there from day 1 of fanotify.
> FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.
> 
> But directory modification events that are supported since v5.1 are
> not available
> with FAN_MARK_MOUNT, see:
> https://github.com/amir73il/man-pages/blob/fanotify_fid/man2/fanotify_init.2#L97
> 
> Matthew,
> 
> Perhaps this fact is worth a mention in the linked entry for FAN_REPORT_FID
> in fanotify_init.2 in addition to the comment on the entry for FAN_MARK_MOUNT
> in fanotify_mark.2.

Sorry, a little late to the party...

The fact being that directory modification events that are supported since v5.1
are not available when used in conjunction with FAN_MARK_MOUNT?

-- 
Matthew Bobrowski
