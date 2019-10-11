Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F06D3671
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfJKAlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:41:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46493 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfJKAlM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:41:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id d1so7998916ljl.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 17:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wNy6JFK5djKAuZbuRMlDS+XyW8tF2WH1HB98CJhwX4=;
        b=Ebgr6hpepFByF0DkP5utDnq8dgpXwryts91lmQkxebHKHDitPBleV83coxn3yI9W2o
         4bjKmKWCPPjMPhL8Nq/Rdml5kvyzOdaMmxDE1iIeADKjQ4B3ePZan8TAafgqsmoQqDBo
         DPSQq0Dom4ILIzKaOPRAGB6iBjZKCOwLqRUsFj6Doy+Ihf3ofxWf6aVnflJ+uXxgpKYc
         bbkJw50tNvEfHUPIhBMY1Zh/pD7QtrHNUoMxcmVpT5dFWXFUE49Oh+2y3HcTvrkmCGKi
         d1cVCQqj7IfTxrHF88A0gj3Twf8bqPV2nRUrW6tYaMCpO+AnG3VtKUhbnJoR6lVbp5wI
         hqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wNy6JFK5djKAuZbuRMlDS+XyW8tF2WH1HB98CJhwX4=;
        b=Waklk8hEovjA6Fh4x6vwXXEJ42sgwGgmMawHQT7lNNhaDHP9o6jHis0cPo2BM3SzD5
         j5+Ie+mf0vZJ7O5t/2M3st9hi8xXUtgh6qFzMqYj8uN4ud0cdmC9I28mwp6JWY4zCqC9
         KyCr3IJtR73h6ibUrUM5f0z2uudbORuzmNAGrDZTpw0vY+4+FgZOqjuLgCjz85v5phlB
         UQ95DeKRYU/WZbQHHzw4aWrM6sOO1cKX4kKT7fDbn/f7UaFBYo2ccmK/6hziJerE2/tJ
         SYaR1G4w0s5XYoq6brYNHSgLcDornpmyXKI12yRrYdjWKQO3MkfjJGa07KQ3zj+gT05o
         AoeQ==
X-Gm-Message-State: APjAAAVoLZ8Z7N3nWQ5cQTr8lZKEOEmKOIsiWek+kZveFwZaTpzTCvMF
        +lQdV1sPc1EAo0c8TJH/06G7xmXXZVpfvt2V8CXX
X-Google-Smtp-Source: APXvYqyMEnp+g0nirg0RbsN817lbDmHEIQg2bqDza4Lalp8B5gyrzCzWjpLPJS7tANwgfZue3U1+820n9L5ACEXWqxU=
X-Received: by 2002:a2e:b17b:: with SMTP id a27mr7770213ljm.243.1570754469730;
 Thu, 10 Oct 2019 17:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <a6b00624ac746bc0df9dd0044311b8364374b25b.1568834525.git.rgb@redhat.com>
In-Reply-To: <a6b00624ac746bc0df9dd0044311b8364374b25b.1568834525.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:40:58 -0400
Message-ID: <CAHC9VhT3QNHxXCc_QsC5K5HadAv7AqwNw-Fk+yLECquE_dKmfQ@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 18/21] audit: track container nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:27 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Track the parent container of a container to be able to filter and
> report nesting.
>
> Now that we have a way to track and check the parent container of a
> container, fixup other patches, or squash all nesting fixes together.
>
> fixup! audit: add container id
> fixup! audit: log drop of contid on exit of last task
> fixup! audit: log container info of syscalls
> fixup! audit: add containerid filtering
> fixup! audit: NETFILTER_PKT: record each container ID associated with a netNS
> fixup! audit: convert to contid list to check for orch/engine ownership softirq (for netfilter) audit: protect contid list lock from softirq
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h |  1 +
>  kernel/audit.c        | 67 ++++++++++++++++++++++++++++++++++++++++++---------
>  kernel/audit.h        |  3 +++
>  kernel/auditfilter.c  | 20 ++++++++++++++-
>  kernel/auditsc.c      |  2 +-
>  5 files changed, 79 insertions(+), 14 deletions(-)

This is my last comment of the patchset because this is where it
starts to get a little weird.  I know we've talked about fixup!
patches some in the past, but perhaps I didn't do a very good job
communicating my poin; let me try again.

Submitting a fixup patch is okay if you've already posted a (lengthy)
patchset and there was a small nit that someone uncovered that needed
to be fixed prior to merging, assuming everyone (this includes the
reviewer, the patch author, and the maintainer) is okay with the
author posting the fix as fixup! patch then go for it.  Done this way,
fixup patches can save a lot of development, testing, and review time.
However, in my opinion it is wrong to submit a patchset that has fixup
patches as part of the original posting.  In this case fixup patches
have the opposite effect: the patchset becomes more complicated,
reviews take longer, and the likelihood of missing important details
increases.

When in doubt, don't submit separate fixup patches, fold them into the
original patches instead.

--
paul moore
www.paul-moore.com
