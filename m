Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9650246585F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 22:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbhLAVed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 16:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhLAVeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:34:25 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Dec 2021 13:31:02 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l7so50831501lja.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Dec 2021 13:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=g+ZvFO8WeFWQVbr+SI0i5zoF6KOoRrFxnMT4DDgpQb4=;
        b=eoDXRbrsRmAJIVGlLd9Ayy6o3ASNAD60uuZ1HV+FYYj54hcZXcqlGwBVF2oTGCmdMG
         PfA6i9VuSYml2b8sO0RluGjEmhURKz6kXXGwut9n8sJcfwtcoxQ5sQcT0tDmGPGqlMBP
         UTZkpSkCdYmtJC6hJ3dsS5DW+Eu2OLkzoGnqEzJqa+9gklc0IpggdRcvL+TyOCTxmHT5
         GrqG4KJZtuh5+rbS87ev8kVv9V9lAU3NTWGtfbBhLLA1PjRspRMYk1S41Getg/BY1dQn
         VtzU4WsgHEX8jw0xEXFPVTJBOcqNu9guRob6EDvYmNxQD0enz0ZB1ZjHP6CpRBcvp2k8
         p5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g+ZvFO8WeFWQVbr+SI0i5zoF6KOoRrFxnMT4DDgpQb4=;
        b=uXuIuOiWXoKu6wu23M02ojrFJwp7/pAh/jdmBEaF33NEu3sLAyPC4yqxTIQSfWuRZn
         g1btSen+2hbvnyyCVltCiRMyIimmeuevQVJpQvrWMHBjhGs6zBKjTUHLVljconVpklJS
         /5/1RG1pVVmebyiIxytH0EjSeQtJSPOUFan2f4gn9+UIBF+Cy3XZHP9hnvvjJQWnQ5rA
         s/h1J0clUYEbCpKSCrLK4Hb5ygC5pafr5d6uKFI/ybskLZiEL7StzrFRbU03v0WJmY9E
         AB0MK6M+rXOiBv1BO8tBd4PX4IQVmmxVjKKOOB5tNsUc0x9amt7+9UkPXhh+gt9S3LSE
         1tXQ==
X-Gm-Message-State: AOAM531KWPSEjmazjzAeHn+0sp0a7tIfc8RrSxsd9JOsLvav+MNLDXbh
        /1CiJ2ofSnNpvX8wKjHlvebQlr/AKH5nSouK9UpzCzn6N2I=
X-Google-Smtp-Source: ABdhPJwAyVhIrPm8FuyFkhkpRyr3pJ0EKteP7TtQdHiL/cIO/+jXIrOfvUhzvLwFMGFB+CFU8tK4QnPFDcFkLQWeFwQ=
X-Received: by 2002:a2e:a268:: with SMTP id k8mr8126903ljm.451.1638394260520;
 Wed, 01 Dec 2021 13:31:00 -0800 (PST)
MIME-Version: 1.0
From:   Stan Hu <stanhu@gmail.com>
Date:   Wed, 1 Dec 2021 13:30:49 -0800
Message-ID: <CAMBWrQnfGuMjF6pQfoj9U5abKBQpaYtSH11QFo4+jZrL32XUEg@mail.gmail.com>
Subject: overlay2: backporting a copy_file_range bug fix in Linux 5.6 to 5.10?
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A number of users have reported that under certain conditions using
Docker and overlay2, copy_file_range() can unexpectedly create a
0-byte file: In https://github.com/docker/for-linux/issues/1015.

We started seeing mysterious failures in our CI tests as a result of
files not properly being copied.

https://github.com/docker/for-linux/issues/1015#issuecomment-841915668
has a sample reproduction test.

I analyzed the diff between 5.10 and 5.11 and found that if I applied
the following kernel patch, the reproduction test passes:

https://lore.kernel.org/linux-fsdevel/20201207163255.564116-6-mszeredi@redhat.com/#t

This landed in this merge commit and this commit:

1. https://github.com/torvalds/linux/commit/92dbc9dedccb9759c7f9f2f0ae6242396376988f
2. https://github.com/torvalds/linux/commit/82a763e61e2b601309d696d4fa514c77d64ee1be

Could this patch be backported for kernels 5.6 to 5.10?
