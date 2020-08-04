Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F4823BB8A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHDN45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHDN4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:56:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3677C06179E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 06:56:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id jp10so15960116ejb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2020 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nir289YmvLvB9cYHD+WrMlDkgzY7IXddotY7RZ5kJuw=;
        b=AEHps8rnJNYWjEsEPmsNrngg9TrZ3KWI5HcB4+HHRs9di0+/ESZLPa6/JKEXxXRDtU
         j0ZA7GgeP7mT12IX5LxV4n0BWV70/alU7ADPeaFlcj67EWL5F74zxF5tjSOVXXhgCu3N
         g/f2upIq2fhT1dR8LKBd75so90/Gkfjyd4Eik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nir289YmvLvB9cYHD+WrMlDkgzY7IXddotY7RZ5kJuw=;
        b=Q2goin5azmZOYBS0T4ZkgtS7Jc9ddCjq2lsH7H8sQkuvB3XUWnR1kWhEgmVxwxxKqh
         sbYjb0IKlXLfzdOAYwWE4c0dUpdKg5/QTkrIEB1zOtoC69DPlYnBDfUJwUb1/IgGXx1+
         X/q7J4mEqWHQAaCpOvLmN0DG5rahuV3Oj1wAL2B2qQaQU2OwxYwzKm+9IggQ79hBdPtn
         l4vWeKiP7YcqJzVAgIzO7dvuw69RoDpUUhL+QFC3PGWbJsymKOFHQkdNuuI3AjLONUaI
         tQrPCcZwMoSljvvjQoJmLpCtOJFr5geednFywoK8a7xdyXcP+dgFtn4mzEhIHLSSFFgn
         z9Iw==
X-Gm-Message-State: AOAM532L/JiMPKDQ1Py4iSla97O4ty5ERvlzUoS/oS2YwGwu52+yVT8G
        gUry8LYpuhsfD8TVggeDQxL53A==
X-Google-Smtp-Source: ABdhPJyvdxPxUWj7x824NLh/G3TC6fG7Nwu5sJ/FqR59hOHVzeefde3nECyeC40mMapaTamORKbAkg==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr20891718ejb.340.1596549404630;
        Tue, 04 Aug 2020 06:56:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 4sm18404381ejn.84.2020.08.04.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 06:56:44 -0700 (PDT)
Date:   Tue, 4 Aug 2020 15:56:41 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
Message-ID: <20200804135641.GE32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
 <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:37:50PM +0100, David Howells wrote:
> Provide support for the handling of an overrun in a watch queue.  In the
> event that an overrun occurs, the watcher needs to be able to find out what
> it was that they missed.  To this end, previous patches added event
> counters to struct mount.

So this is optimizing the buffer overrun case?

Shoun't we just make sure that the likelyhood of overruns is low and if it
happens, just reinitialize everthing from scratch (shouldn't be *that*
expensive).

Trying to find out what was missed seems like just adding complexity for no good
reason.

