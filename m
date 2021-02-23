Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F7A3230BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhBWS2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:28:47 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51858 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233133AbhBWS2r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614104851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=anpaLtEcd3qtkAoA/Wm8hrwTV46F/traBfj2tarUVHU=;
        b=RUKRrfb2QN2wX+X2a9+v6XvEQ4kAw1JEDSVllk/k8/HbqCtktgvuaNNoTrsKaC4FsiE5gi
        A/E45yxA3qqAGV4oGWyj0yjPB3QpfWeyeu607SnwDORutf0bDV3dOaDGwZRM7TgJ7oj7Ev
        2iar3+vqoe5FidlT7UbYhCm4gna+wqU=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-9-U9RgydIDOl6GTeJjcfNK2w-1;
 Tue, 23 Feb 2021 19:27:30 +0100
X-MC-Unique: U9RgydIDOl6GTeJjcfNK2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9XfZHdjDBpfa1TIhdkbXSMBbrvqJputfyHFgMjJnIUXWKYt2/cFAJezkTI2O33y5O0Favv5um4DJG54fTu5PIhRWS7ZhiVaNrMGetGWuz3Watrrh8rlbDGAK1szqaWxvUltbdADoDp2oQTT3EgHs2lo5kDU/EbPgAcEjo+j8H8oKpY/rfWbs+nE0PiIV+Kp2Okcel0ddTD+00EpRynlax21+/Z0//yp7YXy5Xh2cUOo+9VDac99CnuEI8+UQAjKIi6uTF8yckg1cccTaCbsesiOij0/z6fPTv4JLy4QJJnMHmXGBdav7hN/i8x8U7pWj7ZpC6/RatMbwzEuEqDBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJhH+wC6DS/hHrW/UeAnXR7v5GsP377h4BKSIAVDhAU=;
 b=FJmtIASCv97u1T5GPvSvfnJUM9MPy1+XIP7sDh/8Gi2FiwXrFSt8s1JBCWjgPHxvg13F5It9jZ0Msnw14nZUMpAgAHqi1gSx9jXBWVXQSYro9uUFwWo/xELOaTm7O/9Yzreh83hyK5WLgS1GkZYk4k1wkjT/iOTGaxgwwh2r7MjWjNrpJPvQE9Quzu5PGNoFVw4gmbiKDWyC4IgKW9sEJNvciJKWTk5nPF/zL/ULH2JF9y41bogdiyBi5MLET1abkQgerwWhlPVuP/6c01aRAnkFmvol5SqLCZx84Inf7A0qvbhZnK+0G4wl2tp8s0yaZFxDS8kdyM7KVBCJA24P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7277.eurprd04.prod.outlook.com (2603:10a6:800:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 18:27:29 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 18:27:29 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: ignore FL_FLOCK locks in read/write
Date:   Tue, 23 Feb 2021 19:27:26 +0100
Message-ID: <20210223182726.31763-1-aaptel@suse.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:705:9b31:db:7402:52ee:d004]
X-ClientProxiedBy: ZRAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::12) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9b31:db:7402:52ee:d004) by ZRAP278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 23 Feb 2021 18:27:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d39ac5-f496-403d-d92a-08d8d828ad5e
X-MS-TrafficTypeDiagnostic: VE1PR04MB7277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB72777155B3DD57CEF683AB3CA8809@VE1PR04MB7277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qdxyfE8Jh6BMAAnN+t+B//uIGGS3sf19F/8sT1nv8rVcWuZymVWnbunVJ2Bl/KdNSYlJNXEoi98Kx47PEyTnl1x8M2dsWocTs5h+uSheq588GqC3ueWJTT2atT1lDBfjFRMWrGjOVbUVM++/VyWFb7siZf1Y8eIBlZBpanFDCAs94kC9Zmbx0QKxPYZi1j/XJ5m3FpZkkaHnAkx4+SGLa4+kZPKYYqIXPAxztsH7hNtP8zWXxPQ4iGGhzEXDo2MOmin4lUyGlPm4M5DAtEPZtDr/gpmp7evyADVDghlJNJ5g1YVQNaCLwbPXZAoz/YPML6mrt78XNyDHx8C7N7yfnvlWsr4jHvEI3uc50ti2BDFzIhRzLeoVt+JAYwTqNBgzvec/2PBMWzii1N6tj/1YfWIt817+g9FZDWGENKd9OZSzUdiw9dr6phJraxSVTxBhGoAg5Cp2itRutLLEAcO9N9sHU6DsesE4rcq76Nx2z/D4LNB9R68ZcthAY9d9f9N3r9W2/YRd+ZwiwZJVm3EDmBfnvtlvHRJAz1TabjJWNfV/ELuHjABIbvprTx63qPVaL/fho1JEXc6Dw7QmPEZUyyJqsmzQ6hGD/DNnoMTGpXe1Zy97z2I8UD+VRRPNEFE6oDx8EIVw/ax4P5km4gjwV3OvXSaAG6exBMewHmhnthAAY9lCUtbRPqh9A62TZvLdnZsahLuZr5p9wbb9AYLuQCzKFgNW6GqD88f2nibYL+SSOpHjTp5wk6G9AQ9KzIDkLQs7RMWimRxCXtauu7fhs18uNvDwWBR8C7EoRsY2BMs8BiKY1vqfqQFtZ0EEhy3MpBwZ+X8JRp0N72kr0oGXvYU7mjBPepTb80Bn6/qYo/XtjRQKxn0Nlm1Wm/decnp9De5O53JD1XWyeHwf/ecXYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(396003)(39850400004)(366004)(346002)(136003)(376002)(6666004)(66476007)(2906002)(4326008)(8676002)(6486002)(66556008)(186003)(16526019)(478600001)(8936002)(66946007)(6496006)(316002)(5660300002)(107886003)(52116002)(2616005)(1076003)(86362001)(83380400001)(36756003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P6eGyymz+ngnS4L3Rebl2bMRmki2e1shlKOl/yKhLSdLQPNIe5lXBnfvz0SD?=
 =?us-ascii?Q?lLbz09e//btaxzblOUQfrSvV2lQ5JDE0zplKd7g9fTOUmv0wC90FsMxpj90h?=
 =?us-ascii?Q?0KceexsMbLkDmD7T3bZ0K0fPTfe0GVON3L3m1jysqAPO73+lJLmAGpXy3rC7?=
 =?us-ascii?Q?LDei3TVEDA6e0HGe1KknUP9+UFLf3Y6MMqz66ihMmvpEdo+V4mJ9cVb/5zrq?=
 =?us-ascii?Q?g2d5PBZEhHwL71KxAU+Et3ngwtxh5pgcxceG8iQNN2GriO2RnYnXdv9DrYUL?=
 =?us-ascii?Q?54r86yVJm/10suV7KnWJBvgdSlYVeHO7jPu6P+NVi/6ltxMrdHeNjiE+9ps6?=
 =?us-ascii?Q?8yd3FNi8O+V+Y754xdlEZ93XXZDwfyln2j8OyU9+VOmiqEqqkQwtwGnYHWry?=
 =?us-ascii?Q?mmR2JVjIZwdinXD/TF0sxLLSHMHtXJzSU1S00BXT21F9b5YG+MGU1exxS4+2?=
 =?us-ascii?Q?+gApGK08kzI3HOIVDSoCm99dzNnrtRydogJlSwv0c9v2rsq2ZwZcLnin6SP6?=
 =?us-ascii?Q?KlDOWx2fQH4BXcg6tdd9iJhvJ4ERzZTTnP1swD4C/MM+JIUng+wXsyCLROk+?=
 =?us-ascii?Q?6MErEF1jqfsj/6wS9yrIh/Aa8Vrxi1o/1dOscgyIBGFrRqeQKxIloU7+OX1L?=
 =?us-ascii?Q?q10udADnbTariFt6kfzUSBnwR4j6Y6/yPy0r/vnsPD+j8vYQu9oc57+9St7p?=
 =?us-ascii?Q?S4ZEH4ySjj/V3gReHX9NDmJ3F77AU+vfCOeuXeJaBc/7K/XzkRgFxuSJzlBJ?=
 =?us-ascii?Q?IHtS6yDgR5TadZ+ls8q++ncyBsEItXbBpqkFxvnBCQ1bj7ktI1eaaU1IbrFP?=
 =?us-ascii?Q?rTC0qkIAhEjNtCVTC0/TJpq3QlC+1g5qWDpgx1Yc0ydQno6nwLHKsYUkP/bX?=
 =?us-ascii?Q?fTiv0JHeTs3ULuHHSMHauBTRSDwsrGKtEXMPXM0dtk5bOAAoKT1p3t3T8zTP?=
 =?us-ascii?Q?sSqf4R4oUPXkvmgTw/Pr4fasFk04OwMwK0/c4bE18BzlRKS1BPZa91i/bgxI?=
 =?us-ascii?Q?Xypti7md1V5C7S0etNw3xc3+o4QUimf7AEQXek4IeCaJW6rwt04MZAv3oYn/?=
 =?us-ascii?Q?/FgNxD5lJAcNIvnc/Hg1+n83OgO6oi+YRAB4Yz2IfpYH+VONSZewhG9eVk0W?=
 =?us-ascii?Q?Qbs+44IuJCBOIF9ZYTDvtCng0VmABMsFftqTNjXqzDxbMBkeq25e4BZ7Vmcv?=
 =?us-ascii?Q?LPAX/KHZv0LSlwPo57XjZSAdO8Jtpq0GIl8Rm0nTUuqWQD6eoeOEWY1K12Dr?=
 =?us-ascii?Q?ZWEATuYRfyL723j2DS5BdvGiZlLlsKkVdYpuVYYvIjNbKypDhYDjFD85hl4y?=
 =?us-ascii?Q?8U/OnlGIXsOQd+DDtXOmp11gwzTYTa5+f7/cbIW58eoyJJBA+DTWKTWz939i?=
 =?us-ascii?Q?0/VN49SOy5T74eFRsoyfhkghtALS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d39ac5-f496-403d-d92a-08d8d828ad5e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:27:29.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzLyX9nSkVMmAQequ1gasUbTU2LNgkqoEM7mn7qRZCx1Up0vqfot/3DnAz3uaLnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7277
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

flock(2)-type locks are advisory, they are not supposed to prevent IO
if mode would otherwise allow it. From man page:

   flock()  places  advisory  locks  only; given suitable permissions on a
   file, a process is free to ignore the use of flock() and perform I/O on
   the file.

Simple reproducer:

	#include <stdlib.h>
	#include <stdio.h>
	#include <errno.h>
	#include <sys/file.h>
	#include <sys/types.h>
	#include <sys/wait.h>
	#include <unistd.h>

	int main(int argc, char** argv)
	{
		const char* fn =3D argv[1] ? argv[1] : "aaa";
		int fd, status, rc;
		pid_t pid;

		fd =3D open(fn, O_RDWR|O_CREAT, S_IRWXU);
		pid =3D fork();

		if (pid =3D=3D 0) {
			flock(fd, LOCK_SH);
			exit(0);
		}

		waitpid(pid, &status, 0);
		rc =3D write(fd, "xxx\n", 4);
		if (rc < 0) {
			perror("write");
			return 1;
		}

		puts("ok");
		return 0;
	}

If the locks are advisory the write() call is supposed to work
otherwise we are trying to write with only a read lock (aka shared
lock) so it fails.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6d001905c8e5..3e351a534720 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3242,6 +3242,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from=
)
 	struct inode *inode =3D file->f_mapping->host;
 	struct cifsInodeInfo *cinode =3D CIFS_I(inode);
 	struct TCP_Server_Info *server =3D tlink_tcon(cfile->tlink)->ses->server;
+	struct cifsLockInfo *lock;
 	ssize_t rc;
=20
 	inode_lock(inode);
@@ -3257,7 +3258,7 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from=
)
=20
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(from),
 				     server->vals->exclusive_lock_type, 0,
-				     NULL, CIFS_WRITE_OP))
+				     &lock, CIFS_WRITE_OP) || (lock->flags & FL_FLOCK))
 		rc =3D __generic_file_write_iter(iocb, from);
 	else
 		rc =3D -EACCES;
@@ -3975,6 +3976,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter=
 *to)
 	struct cifsFileInfo *cfile =3D (struct cifsFileInfo *)
 						iocb->ki_filp->private_data;
 	struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
+	struct cifsLockInfo *lock;
 	int rc =3D -EACCES;
=20
 	/*
@@ -4000,7 +4002,7 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter=
 *to)
 	down_read(&cinode->lock_sem);
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
 				     tcon->ses->server->vals->shared_lock_type,
-				     0, NULL, CIFS_READ_OP))
+				     0, &lock, CIFS_READ_OP) || (lock->flags & FL_FLOCK))
 		rc =3D generic_file_read_iter(iocb, to);
 	up_read(&cinode->lock_sem);
 	return rc;
--=20
2.30.0

