Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B292FB991
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 15:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405588AbhASOdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 09:33:25 -0500
Received: from support.corp-email.com ([222.73.234.235]:19229 "EHLO
        support.corp-email.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405349AbhASLOh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:14:37 -0500
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 06:14:34 EST
Received: from ([183.47.25.45])
        by support.corp-email.com ((LNX1044)) with ASMTP (SSL) id NEB00015;
        Tue, 19 Jan 2021 19:07:15 +0800
Received: from GCY-EXS-15.TCL.com (10.74.128.165) by GCY-EXS-06.TCL.com
 (10.74.128.156) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 19:07:16 +0800
Received: from localhost.localdomain (172.16.34.38) by GCY-EXS-15.TCL.com
 (10.74.128.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 19:07:14 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <balsini@android.com>
CC:     <akailash@google.com>, <amir73il@gmail.com>, <axboe@kernel.dk>,
        <bergwolf@gmail.com>, <duostefano93@gmail.com>,
        <dvander@google.com>, <fuse-devel@lists.sourceforge.net>,
        <gscrivan@redhat.com>, <jannh@google.com>,
        <kernel-team@android.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maco@android.com>,
        <miklos@szeredi.hu>, <palmer@dabbelt.com>,
        <paullawrence@google.com>, <trapexit@spawn.link>, <wu-yan@tcl.com>,
        <zezeozue@google.com>
Subject: Re: [PATCH RESEND V11 0/7] fuse: Add support for passthrough read/write
Date:   Tue, 19 Jan 2021 19:06:54 +0800
Message-ID: <20210119110654.11817-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.34.38]
X-ClientProxiedBy: GCY-EXS-01.TCL.com (10.74.128.151) To GCY-EXS-15.TCL.com
 (10.74.128.165)
tUid:   2021119190715f9f4f0275f6c87c21aaa38b5cbe9b56e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

on Mon, Jan 18, 2021 at 5:27 PM Alessio Balsini <balsini@android.com> wrote:
>
> This is the 11th version of the series, rebased on top of v5.11-rc4.
> Please find the changelog at the bottom of this cover letter.
> 
> Add support for file system passthrough read/write of files when enabled
> in userspace through the option FUSE_PASSTHROUGH.
[...]


Hi Allesio,

Could you please add support for passthrough mmap too ?
If the fuse file opened with passthrough actived, and then map (shared) to (another) process
address space using mmap interface. As access the file with mmap will pass the vfs cache of fuse,
but access the file with read/write will bypass the vfs cache of fuse, this may cause inconsistency.
eg. the reader read the fuse file with mmap() and the writer modify the file with write(), the reader
may not see the modification immediately since the writer bypass the vfs cache of fuse.
Actually we have already meet an issue caused by the inconsistency after applying fuse passthrough
scheme to our product.

Thanks,
yanwu.

