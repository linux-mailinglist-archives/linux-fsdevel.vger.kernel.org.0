Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BA63ECAB9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Aug 2021 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhHOTuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhHOTud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 15:50:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00CC061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 12:50:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id bl13so8244519qvb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Aug 2021 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-stonybrook-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=ocoSTScZfDAhY8MwUiGktXzPmGF5YW6e35P+/QZF/gU=;
        b=vdSXTqBFbAg/Cj7Lu1y0HKeVftWylary8q40nRGwqcDAgkOsRYtuZBWyRLWKKCPdDW
         36Bq3KE8pH36CEU55I3FMWvcCU+TYLlwuuEb8xWy4Q66JxZX8pBYdjXorwRHQG4VQnhf
         urwadt7jsyszWm9Z3xQg3xBLiiZ8grGocJLkZYzpnArLDH/f1zX7egFNrvb4U7SSQMCc
         sHyTAEC0KziSECYoTHTrzfyJgaiHtxKBrFs8LkXxmYuuAqKZI52gGdjTrb2VAie81lQM
         fJtZELLHduWq/pUW2BoyHdeAw50gkQlI37Kt6npJHagU2JiWVQv1q0VnEwqje2TGOe/o
         5KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=ocoSTScZfDAhY8MwUiGktXzPmGF5YW6e35P+/QZF/gU=;
        b=lGuuijPsBXK/ujWm03gTwf/W8PSY5nc1Kh1++jxS3EEY0PwQtr4FiX/YnZ1gA+UhFS
         o0WdKgaP0Jrl3iNgDbTv4n2xar8E2C/+PYsehtAf5gfjuigu/yqsxk5QIbePGbh/Nx29
         swhXs4EO03kmvC8GDfu1naIIpgOk6iDBxUvwfQKuIkdw3KCfQ+W8OUh+bTZOlSSlwE67
         /Znbc7YdJ1B5ju2ZMFC+NTZWDc+UJI96b4MHjcn5WU1KJB5kQHXh+6nCeHX4xQw5uwnW
         UQ/F9yPem3mpjzaxEqL60zlFCLs3wOgUakd5+Jebd+nSu67q3onSsw644wnT7zP/tHqi
         3SYg==
X-Gm-Message-State: AOAM533ALGVN8/tROOiJqaVqskEpIhyasLt8RdBP0kGMrycvplHFqKBG
        Ly8rONsWqzztwYEONOg6LSAstzIOxZ5PpA==
X-Google-Smtp-Source: ABdhPJyQVfHqC5yyQ+E+fOc6b0gAsUlZcXa/9YxokuQEYzKWEUx/Y8oGcOxCKa7yV1Mx7ESrcP8LwQ==
X-Received: by 2002:a0c:be8e:: with SMTP id n14mr12803207qvi.16.1629057001949;
        Sun, 15 Aug 2021 12:50:01 -0700 (PDT)
Received: from smtpclient.apple (ool-4573eead.dyn.optonline.net. [69.115.238.173])
        by smtp.gmail.com with ESMTPSA id d8sm2201518qtr.0.2021.08.15.12.50.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 12:50:01 -0700 (PDT)
From:   Yifei Liu <yifeliu@cs.stonybrook.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Save and restore full file system states via ioctl
Message-Id: <881E5EA5-BE75-4EEA-BC2D-F4574A56D3DC@cs.stonybrook.edu>
Date:   Sun, 15 Aug 2021 15:50:01 -0400
To:     linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am a graduate student researcher at Stony Brook University.  Our team =
is working on applying model checking to detect file system bugs in the =
Linux kernel.  The problem now is that we need to restore a file =
system's previous state, including on-disk (persistent) and in-memory =
(in-kernel) states.  However, the in-memory states (e.g., page cache, =
kernel memory) are not easily saved and restored.  We investigated =
virtual-machine snapshotting, but VM snapshot is slow.  Then we plan to =
implement our own customized checkpoint/restore API for kernel file =
systems via unlocked_ioctl.  Checkpoint API copies important filesystem =
data structures in VFS (e.g., super_block, inode, dentry, file), while =
restore API replaces the current data structures with the copied =
version. =20

I want to ask if this objective is feasible.  Basically, we hope to =
implement a file system snapshot to save and restore all the file system =
states using ioctl.  The concern is that structures like inode and =
dentry are interconnected with other kernel components, which might =
cause inconsistent kernel states after restoration.  Any ideas or =
thoughts?  Thank you!

Best Regards,
Yifei

