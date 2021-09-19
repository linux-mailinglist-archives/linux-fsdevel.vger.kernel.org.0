Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B826410AF8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhISJsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 05:48:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:54353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237283AbhISJsS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632044807;
        bh=Ki59M46OZYfdH3PG+RwhEZzRP9x7phcKZLkGNFtq4ec=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=dN3TZKxCLkA0jLf1a0J6LoYieDEiY6AmARsLyG53mhfZ21RrqqjOkgsOlw1+1SHq9
         ypxnHTkWqrsjTVsKNKUrGwIyNaDMXIEhegpIhFrJBCTxjGs+xRKA47DOBV8v8h410y
         ajyYUOYRghUx7ijzhvMk9335cOUpdUTHsuce/wHk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M42jK-1mRtPL1Iqe-0001F1; Sun, 19 Sep 2021 11:46:47 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] writeback: prefer struct_size over open coded arithmetic
Date:   Sun, 19 Sep 2021 11:46:30 +0200
Message-Id: <20210919094630.30668-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nFDjU21+R7K0PsI52/aSQu0ZuRfj4cWvpqOJWuFGauNy6aaJLJC
 8/uv55GHL56FjDjPr/teo+68hSV17rSG4e5bAxjPDpo+2ZcDv5PZ5eW0eniT3tGvjhlu2hh
 ODg0DpIQ2Fh9XSqclzbHSJxXkCUQzxuKq8wzkOz/YYZqMis2d4yENUi4TvTUChvtPUVSx3Y
 CiEq36fkQu7qp1DrPr2bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YTQAfcQfpGM=:ox9N0ncaldIoqV0MjohknG
 q7XfWnGrEJ3fk4K9OxJZPLpUSnIinCvAuowBsxAlVK5tQaiFNlx+vUPrP6AqvD7ngl4xDNmYn
 epiHkMuXllc6I1yunVqIDMjNuYYUhMLhbbYPIjcfH6nWb70JdxDKn/wjkfAXJyWcCwCk7PklN
 GG7iBR/4VTM1VE8rv0TTCrobML4cFmtD9gNF9guUxeqiIuAK1rPDkqVwb8tH5K61K5cVvH2hN
 ZvTqU/Dcna1U3685zgLuS8MJhoP1I5JVgoFO5/xRnWIXvZi1rtJY2G7KvUKtmlXxuYNhjDDJ8
 ymkIvm46FfBZeBS3bDRPmC4G4oB0fg7X83pXloNOjWNIzXaftauNf6jKFKBZ8N1Lz/yHnhaXT
 8KKmtiO9IACVwxLjhh9HZKSmw0awstDB0jtcz0nL/b0P89Mu89oD7NpPEi0SFAaGJZ4qMVbgY
 MydoiiIUAGgSXSh5fBUBDbL4Ng8A0D+GEWAvrm82Udboh9hp3Ll42/8CzvPT5tJJesWY24jo4
 4KsDQsQpIMVoy5rzOZYPHmWrmJPMq6SsbZD6LMh6mBuii9reCoEnFrFwbNcYqxOsNJcV3hr23
 lP+AnavK7Ove/AO+B1PLZGUyUYISiyHanctqZCR60KnwSc89t45PDk/e5GuZ9AVF0x93yQtYs
 xCMPzwKRrA2+0lt8SHbQN6rQ6Z/g5h3D3tPLkl7RYZ+2gDtVoJu8yVDHJdM3Uo1ISCZ05+ZKe
 H2I61O6P7FY7mi1Cb8qObXp3ukDTo0tMef7OL36mnWi4rxYDphbAW3CexNY33FRy3YGq1rW0/
 +tKwTgLm1OaNOZKP1LIhxzSbEP8fKTMMVGCVS1XCSIGrB8mUky7bYSjbLILvSozA6lvBjTcyu
 VQvf6gr02ltlQd3spsXL5WgUlYdhTGxd0EEd+rUJeC4mFsIpbjfbMvwE9f7AGIUBPQ7mGJnD9
 vq5ztT7VZov8C2H9sSNlFL6a4t5OF9UPgLokcSC4nvo25+RtqH1xUrvnhkFIwZcBiV1EDvoiJ
 IspqacAfxvhotoBrO8sl8uNxJmEjF5VAoRUk2LwIpNS9cHdnTWOAbD3OVy2C5WJR3/vy+m2Xm
 H9yrt2qY/Hn+7k=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

In this case this is not actually dynamic size: all the operands
involved in the calculation are constant values. However it is best to
refactor this anyway, just to keep the open-coded math idiom out of
code.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + count * size" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 fs/fs-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 81ec192ce067..f7abff31e026 100644
=2D-- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -624,8 +624,8 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	int nr;
 	bool restart =3D false;

-	isw =3D kzalloc(sizeof(*isw) + WB_MAX_INODES_PER_ISW *
-		      sizeof(struct inode *), GFP_KERNEL);
+	isw =3D kzalloc(struct_size(isw, inodes, WB_MAX_INODES_PER_ISW),
+		      GFP_KERNEL);
 	if (!isw)
 		return restart;

=2D-
2.25.1

