Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CCC117B96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 00:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfLIXmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 18:42:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLIXmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:42:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so17741491ljr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 15:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aThrcSk9eJO9ZEYp7MG17rWkIvsNKHgQ2G/tGY7+yOE=;
        b=14tLFFKpoHTBuxLubV+jJ4G64SOJMnFCScFUUU9UaiDMXiZdeG2vUaK4lyOGq7NC4w
         UTPyCCusyaPb50dHMWMotz1iv4mj3c0zWp3o3fLvU6hZXdgmhaTMsNKdnJ724em4bz/Q
         6WjkZbMLqbozo9qRqcnX/KkrmyT6IGc1TAQOfLh0K9pXRyX+VNZEfmtbScNsTz4lkpYG
         9qiUIem6CMOGSvATGX8ScnZshVcCrEochW3UtZeJb7xoQjpZhygzCrK0y8g4n+1fkGt/
         z7TocrnA5IKUW4EQVLertAQlotckPKaUdm06UdNXJVyH7WgO3bvJ7dF546k1404uL3oC
         2sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aThrcSk9eJO9ZEYp7MG17rWkIvsNKHgQ2G/tGY7+yOE=;
        b=rPZfhAveCGafpprNndFZNISDvT2K6bx/nEf3HknC8DE+FNLsuO1PYms0FQBoQ9F0zP
         WZVjngWGsRa2j7uJ8bwPISaI8+kGGgPBm+k5EFBFBaDHYYv5dfgGLOojk3zAzOfqnS7A
         /+nwLR3E+s/LgiNnDNI2BI7uGHrPKHZqUCPbO1KFpLL9FcUQ3qQtlnzm8uoP8uh78yml
         EUN7waLlz+e+DpVGxdyI3QJ775CnrBlxTRI/kqoJuhtp16kKuJg7c99MXnhc+RNmisdT
         a1So3somN6zpVrC2Z2RxSS+aSCanO3uHM00+Pf/HaOeCnm8BC/9FK2Rc+P8trITnf6pq
         ZHVQ==
X-Gm-Message-State: APjAAAVtpAMt7E2XZHJbVGC7+lwwA0gKq0NiooDVdxftcfip2oEjd7f/
        UzrSiI/PJVLshTMuYNXc46ruV2nY0FyVuQn9f4iQ
X-Google-Smtp-Source: APXvYqwX6hbYsmadx0Ho/OJIPmZFzixXDc4j7x2P5It41no5mCwMWMtRc+w57pdQz3Ao2AxtB/uIFzSwPoizTOSw1+4=
X-Received: by 2002:a2e:b045:: with SMTP id d5mr5848186ljl.184.1575934936802;
 Mon, 09 Dec 2019 15:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20191122172245.7875-1-sds@tycho.nsa.gov>
In-Reply-To: <20191122172245.7875-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:42:05 -0500
Message-ID: <CAHC9VhRWx-1sUDLgKwkiL6PC9vXh-rUaWg4rOq3_U6=w1MOO8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: revert "stop passing MAY_NOT_BLOCK to the
 AVC upon follow_link"
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, will@kernel.org, viro@zeniv.linux.org.uk,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:23 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> This reverts commit e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK
> to the AVC upon follow_link"). The correct fix is to instead fall
> back to ref-walk if audit is required irrespective of the specific
> audit data type.  This is done in the next commit.
>
> Fixes: e46e01eebbbc ("selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link")
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/avc.c         | 24 ++++++++++++++++++++++--
>  security/selinux/hooks.c       |  5 +++--
>  security/selinux/include/avc.h |  5 +++++
>  3 files changed, 30 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
