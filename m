Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21332114AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 03:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfLFCQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 21:16:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46447 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfLFCQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:16:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so5828203ljk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 18:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xvIAU4ajlJMH6F3Cdm6kVXiilcE6i5hIxPHQ49SNC2U=;
        b=RpK75t0vxIowsQzVUL/QqdLluqPD/186ouUbUukZlke5uhvKiir/Ohtr9zCNWpLqZ9
         bHuJNNmVMv9KRBa9PyXiVuDclb0hpU6lle/7KZrI9xwBqgwknoB1s7usTIUGXDrqZAPS
         dMHer8SJhn6AbpkREiXkFM8GfFrbYt1FG6oQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xvIAU4ajlJMH6F3Cdm6kVXiilcE6i5hIxPHQ49SNC2U=;
        b=kEhuD9L6TwRDBE3P2aLUULxSFCqB1H26PWQwojnBiloA4zEA4nbNLBiQxWvHqLZLXh
         CBvuhM1UEzj5RHMR75q6D/Ij8JRrDRYgMZp/RbNjB9sHxc1zvcK2OJC3VU3b5JeD7Jwz
         5gHCUwWweVvFtv8d6vnzR0VLuImHNNWHESLd4B2DPzvwaSzKPCuHX87vfCCtsy6X3mpC
         /JLQtHo0AiiePBoRBtH91QKiyLJN8q9XEVCCeKUQZsufAFOYdCq2fB8UvKJ+eoJPlS+8
         ab/ALfHqps/MLP6vSYl+7+c4I8v44WWNYhOP53HqFEYrgo8SnIRv2MZZ1tE3YNjY6ulu
         64og==
X-Gm-Message-State: APjAAAVd12lr/JcLZZcbRoVUMJdjjrPxej0WRwKy1oy7vCVc6v5gDzD8
        TqUuoy/sQblnsBGY4pqQTdcQqHVJTL0=
X-Google-Smtp-Source: APXvYqyjIxpmUIXMZkbOTdhNrBh2h6dp9B83Y+ARAVBOR0WJ3JyI9jCPxxUloOtDbzLXGzOsW/l4fQ==
X-Received: by 2002:a2e:580c:: with SMTP id m12mr7386203ljb.252.1575598572245;
        Thu, 05 Dec 2019 18:16:12 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id e8sm6741436ljb.45.2019.12.05.18.16.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 18:16:11 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id d20so5844309ljc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2019 18:16:11 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4910107ljn.48.1575598570830;
 Thu, 05 Dec 2019 18:16:10 -0800 (PST)
MIME-Version: 1.0
References: <20191206013819.GL4203@ZenIV.linux.org.uk>
In-Reply-To: <20191206013819.GL4203@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Dec 2019 18:15:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
Message-ID: <CAHk-=wgPd1dYZjywZqPYZP-7dD2ihwviYfYLY3i+K=OLk2ZozQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git d_inode/d_flags barriers
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 5, 2019 at 5:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

I'm not pulling this.

Commit 6c2d4798a8d1 ("new helper: lookup_positive_unlocked()") results
in a new - and valid - compiler warning:

  fs/quota/dquot.c: In function =E2=80=98dquot_quota_on_mount=E2=80=99:
  fs/quota/dquot.c:2499:1: warning: label =E2=80=98out=E2=80=99 defined but=
 not used
[-Wunused-label]
   2499 | out:
        | ^~~

and I don't want to see new warnings in my tree.

I wish linux-next would complain about warnings (assuming this had
been there), because they aren't ok.

                 Linus
