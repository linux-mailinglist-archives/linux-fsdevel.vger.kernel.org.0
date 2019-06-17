Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7BC48CFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2019 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFQSwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 14:52:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50546 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfFQSwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:52:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so528146wmf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2019 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pjVCWmNKxJeMAm6vkG2OfPRISxnV9sN5LGap4EcCEdo=;
        b=B+WUu6CxHD4qe+TlSAj2yNeYIMsbQe/yaBB02OkJTg5NiS3kyUv9Lp9FAJwZmSU0LE
         SVriiYqjv/UGUwQEVeOPpDNqrofNWxjCMOoCDFADZ0X7UpnM0vv0lHlX5LKHj4OpWQ6+
         6eJB84hV6fK4q2g58Ejmrpb0dkKy7EyiwfwhJ3iGxWICFQcYrQP8YweYI2xplosJMicO
         WWLd2d9/99gLwbz58RMjaNJOYeuKmG4BmVDV+jQwakD6hz7/nqVw2aa/fvYHR6rK6JPB
         atGlNfH7HiiMn5g3+kUddiBZKx1QedfnFavgp10cEfTPiGgUVgpuAwxvHIv8LSQoCk46
         Uk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pjVCWmNKxJeMAm6vkG2OfPRISxnV9sN5LGap4EcCEdo=;
        b=VEAKBUDayA/kyPDyok14c6Zku3BPnZZJezyMikm4CtTTyQmRIo4d4Jbs8XKcAbC07p
         jKzLj4YyCtqEhp3tk6jhWkdH9Hal3aPSHuYvA0bGwkudwlVACnbk2vejduhE1UO83mOo
         QXbxohtKU9V/0B6BwAJa6ACd4NklPBwdvbCXL72w5MbM1uNm3wvOnZD1hns55IHPRtR7
         KfoDgixWFZol3J7mZerBWW6HXfYAZ5OCHqXKDqFqiJepcb9F2ZMTwIunpLsHPs3l99iH
         ucyOGQNDYxgRLn9UsXGMrp2kCsPneQdNh9dW3FthpfcWBg3e63UiFD0Uo9fNNmjBuKzP
         wmCw==
X-Gm-Message-State: APjAAAWRT+J0Un4kTNhsyx+lWXKrhanUsiUXkHLKV6NXzV9uh2dcMoH8
        SCito1tGTE2TuDpQr6NNhKi4MA==
X-Google-Smtp-Source: APXvYqxYsUkV6LBwIvTZu2KJAp90AA0hqZy0BsFn4HMpQzgJAaJrC3xWXPFP641RvogUgHDt6YB8TA==
X-Received: by 2002:a1c:c255:: with SMTP id s82mr91486wmf.6.1560797530287;
        Mon, 17 Jun 2019 11:52:10 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id j189sm86126wmb.48.2019.06.17.11.52.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 11:52:09 -0700 (PDT)
Date:   Mon, 17 Jun 2019 20:52:09 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] fs/namespace: fix unprivileged mount propagation
Message-ID: <20190617185208.3qij2fl7acwuewy3@brauner.io>
References: <20190617184711.21364-1-christian@brauner.io>
 <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+OWQ2s-NZC4RzfHtgNfhV9sbtP6dXV4WnsVRQ3A3hnA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:50:13AM -0700, Linus Torvalds wrote:
> On Mon, Jun 17, 2019 at 11:47 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > When propagating mounts across mount namespaces owned by different user
> > namespaces it is not possible anymore to move or umount the mount in the
> > less privileged mount namespace.
> 
> I will wait a short while in the hope of getting Al's ack for this,
> but since it looks about as good as it likely can be, I suspect I'll
> just apply it later today even without such an ack..

Thanks!
Note that I stupidly messed up whitespace by accidently adding an
additional newline. I'll just send a v1 that fixes this nonsense.

Christian
