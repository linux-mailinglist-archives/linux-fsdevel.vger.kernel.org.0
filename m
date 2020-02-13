Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C561515CB35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgBMTfh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:35:37 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45556 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMTfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:35:37 -0500
Received: by mail-pf1-f174.google.com with SMTP id 2so3552221pfg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 11:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/1rogK9INtKuMnTURGkdHnko9JzPDfxF+IkSoYseAhg=;
        b=H1qv6+Z8JEsoAauYyP4KTNAQezz46oq7NIlLDTzjGDDxlMk3z7Ms7K85XzV1Y33Gcz
         5ZgtdQ6LVTKThwDjJz5mQD4j4aiGSd50JGZfr641tWtIobvE24/fWHDUUBuNfZlGTtpT
         krAXX76EC4GJQtwchbQB6pWXzaPScgb/nlRAcyklsY1WskPovFRrkypr3A1Vy4YMkGUk
         f0u6ETQsXNcGW8FDzTsV5VzI7sx7xHzZ9MH7w5Xsx6he2I2sXaSHzft861GXu2heqa11
         l1Xw7mTamtPPv1OAE466NLG7Pdm/v5Bko63MHnlRo3h4Wm5opBSpuAF+vo9WGDE6yUA2
         BY9g==
X-Gm-Message-State: APjAAAVir1ufrV+uvZsmUy7KPiBCkq9JEe8phik43Zs1ZGi4jQWmUIcU
        q/as9uRalK84qDHb22kZVEB88HEQ4Bo=
X-Google-Smtp-Source: APXvYqykPxrGPzCSbZ3ocl4nF1ZQumLcS+V/H3RkcYetVWBTYhmprxTKEnEynHaetazqwP25t3tTUA==
X-Received: by 2002:a63:2302:: with SMTP id j2mr18624067pgj.29.1581622536800;
        Thu, 13 Feb 2020 11:35:36 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id b15sm3989956pft.58.2020.02.13.11.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 11:35:35 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A8C2E40317; Thu, 13 Feb 2020 19:35:34 +0000 (UTC)
Date:   Thu, 13 Feb 2020 19:35:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, Eryu Guan <guaneryu@gmail.com>,
        Jan Kara <jack@suse.cz>, Mel Gorman <mgorman@suse.de>
Subject: [LSF/MM/BPF TOPIC] Increasing automation of filesystem testing with
 kdevops
Message-ID: <20200213193534.GP11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ever since I've taken a dive into filesystems I've been trying to
further automate filesytem setup / testing / collection of results.
I had looked at xfstests-bld [0] but was not happy with it being cloud
specific to Google Compute Engine, and so I have been shopping around
for technology / tooling which would be cloud agnostic / virtualization
agnostic.

At the last LSFMM in Puerto Rico the project oscheck [1] was mentioned a
few times as a mechanism as to how to help get set up fast with fstests,
however *full* automation to include running the tests, processing
results, and updating a baseline was really part of the final plan.
I had not completed the work yet by LSFM Puerto Rico, so could not
talk about the work. The majority of the effort is now complete
and is part of kdevops [2], now a more generic framework to help automated
kernel development testing. I've written a tiny bit about it [3]. Due to
the nature of LSFMM I don't want to present the work, unless folks
really want me to, so would rather have a discussion over technologies
used, pain points to consider, some future ideas, and see what others
are doing. May be worth just as a simple BoF.

So let me start in summary style with some of these on my end.

Technologies used:

  * vagrant / terraform
  * ansible

Pain points:

  * What fstests doesn't cover, or an auto-chinner needed:
    - fsmark regressions, for instance:
      https://lkml.org/lkml/2013/9/10/46
  * vagrant-libvirt is not yet part of upstream vagrant but neeed
    for use with KVM
  * Reliance on only one party (Hashi Corp) for the tooling, even though
    its all open source
  * Vagrant's dependency on ruby and several ruby gems
  * terraform's reliance on tons of go modules
  * "Enterpise Linux" considerations for all the above

Future ideas:

  * Using 9pfs for sharing git trees
  * Does xunit suffice?
  * Evaluating which tests can be folded under kunit
  * Evaluating running one test per container so to fully parallelize testing

[0] https://git.kernel.org/pub/scm/fs/ext2/xfstests-bld.git
[1] https://github.com/mcgrof/oscheck
[2] https://github.com/mcgrof/kdevops
[3] https://people.kernel.org/mcgrof/kdevops-a-devops-framework-for-linux-kernel-development

  Luis
