Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD41776A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 14:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgCCNEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 08:04:23 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45668 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgCCNEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:04:23 -0500
Received: by mail-qt1-f172.google.com with SMTP id a4so2650019qto.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jV9MOqj3WfpAvtB6pN8ntyBJlB6ixy+o1z9uv0T/wJ8=;
        b=e1czJgeczWvVajGwOP+z+FkY1TGYcksRitzO/boEV+27Up3xOd+ML1WMd36/dvfmtX
         FSHAl7TeJT7R2g+9BGewO7uEFH3wcoTDWPy/AJP/4dkarpzlvPjbnzepEQLzP0Qv10uk
         jJKJIS+e53attz6FAuvIfhQRiIX4guOAblBMFsskoFxJTYfKU3bdLh0lGG7az7iETbjw
         ePF+dYPzFd+NQ5zBwaZb2pBDL9KnYdc1DmkqM9exgDQ+7VCTmYo2lfWs503C9M2SSYe5
         eZMHz86oOZZWfvLy5uHqJg0TY7xRY6EK3iK9cTm/duhnAugML/wJNbIF65Tlp2ULES3h
         9Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jV9MOqj3WfpAvtB6pN8ntyBJlB6ixy+o1z9uv0T/wJ8=;
        b=GPOgGEv+lUbfQ1DI/3gA0SsyQY9rute6UEtzqTYXKu45BYDC6kZXXmZUdpJ7eTwofE
         nIITcT+OLruwEo/Y4hRfc08Xml0vcqHkOgNeUkMVc/vOwysAoRr5qJMsINwgRxy/Ltg9
         vrXttUzc4yBplEg56CfE617U/ZKx0lXiQDUBW+ldU9XjXsWYNnf5uJQSNZz4VgWrLgPi
         +BY8a9s1K8PlTEjAMI30aIlWAZQcOIr42O2fROhlEMZrT1SNNqQC9CJoCcyHpc0I5YW4
         9Kxh0REFyxynnwbmakGGNnVFAgO0p+t0wr1/5BwF7J9Ed9yN9+9CkanuTHpVUZqo+StG
         4DSg==
X-Gm-Message-State: ANhLgQ2kBsgKDHi0UL+IX4AyRc0Q92wdrNk1ikcQvq2g5fuOoe66JO5O
        8gXkGCsaJTIBVw5ORQBphsM=
X-Google-Smtp-Source: ADFU+vstoC3xFL6LK08SXwDvPUGTjYp3QYPGY5MkFBS7kLk9J+plna+Y2j509AStPcVDIZFAVjEGPA==
X-Received: by 2002:ac8:5283:: with SMTP id s3mr4236292qtn.47.1583240662300;
        Tue, 03 Mar 2020 05:04:22 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::7f70])
        by smtp.gmail.com with ESMTPSA id t13sm11860006qkm.60.2020.03.03.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:04:21 -0800 (PST)
Date:   Tue, 3 Mar 2020 08:04:21 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Michael Stapelberg <michael+lkml@stapelberg.ch>,
        Jack Smith <smith.jack.sidman@gmail.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [fuse-devel] Writing to FUSE via mmap extremely slow (sometimes)
 on some machines?
Message-ID: <20200303130421.GA5186@mtj.thefacebook.com>
References: <CANnVG6kZzN1Ja0EmxG3pVTdMx8Kf8fezGWBtCYUzk888VaFThg@mail.gmail.com>
 <CACQJH27s4HKzPgUkVT+FXWLGqJAAMYEkeKe7cidcesaYdE2Vog@mail.gmail.com>
 <CANnVG6=Ghu5r44mTkr0uXx_ZrrWo2N5C_UEfM59110Zx+HApzw@mail.gmail.com>
 <CAJfpegvzhfO7hg1sb_ttQF=dmBeg80WVkV8srF3VVYHw9ybV0w@mail.gmail.com>
 <CANnVG6kSJJw-+jtjh-ate7CC3CsB2=ugnQpA9ACGFdMex8sftg@mail.gmail.com>
 <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtkEU9=3cvy8VNr4SnojErYFOTaCzUZLYvMuQMi050bPQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Sorry about the delay.

On Wed, Feb 26, 2020 at 08:59:55PM +0100, Miklos Szeredi wrote:
> - apparently memcpy is copying downwards (from largest address to
> smallest address).  Not sure why, when I run the reproducer, it copies
> upwards.
> - there's a slow batch of reads of the first ~4MB of data, then a
> quick writeback
> - there's a quick read of the rest (~95MB) of data, then a quick
> writeback of the same
> 
> Plots of the whole and closeups of slow and quick segments attached.
> X axis is time, Y axis is offset.
> 
> Tejun, could this behavior be attributed to dirty throttling?  What
> would be the best way to trace this?

Yeah, seems likely. Can you please try offcputime (or just sample
/proc/PID/stack) and see whether it's in balance dirty pages?

  https://github.com/iovisor/bcc/blob/master/tools/offcputime.py

If it's dirty throttling, the next step would be watching the bdp
tracepoints to find out what kind of numbers it's getting.

Thanks.

-- 
tejun
