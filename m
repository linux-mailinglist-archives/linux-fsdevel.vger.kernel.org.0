Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C0308B45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 18:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhA2RQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 12:16:01 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:58008 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232433AbhA2ROd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 12:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611940404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=q0WslrzyvNbD/LC/THzDFyY2adL+VV62HuHSO0mWonk=;
        b=GyZnRUDKIf23ve0X+njiFFSdAzlmP+IjecH61/qB8fWysEkP3UoQpmMYomWtWGc9vpnC/1
        Ujrp75A03yD85Q53NF+C8yLTdXrijTA17FV9GJYJoLSHhfnO+5LgWPyEkGIx7KcqnlqCRF
        j27EHAk+wlrh96ekKO6G+/GLQca+0ow=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-20-alTweLuINiG6uL7ZduCfAQ-1; Fri, 29 Jan 2021 18:13:22 +0100
X-MC-Unique: alTweLuINiG6uL7ZduCfAQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJgRQfDiAS3leRBg9nR/VbPdRnTMYaw+fGGYWUeUQsV2gsYbxmKBB00aC/Ow8gHUtRG3Ee/ON7SvoXvZXviztIjO4GRN61g5iENk4XQEpBBl9TRQcajmywShDGXiPEHAFzVwbzheynZr6vM+eGfo4IYdRSu5qCvxdZwci81C/AbcjkPHRX3RlLgH9V4wO6wSUUXmWiuHqGhqCCJVMaeOJFZXJJ9Gi0fGDG922xiYWIwOR5o/uOaktYT0ypf6FIS7dgZRIBh+254XpQvy9DQvcsvw/wcfmJ2EELnyTmA+pbo7Xrb9Jxt3pmui8rEc15rTgYLPEsKLcimk7CB8mtFZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9luHzFU775/t+txmVLD1zwMZS+Q/+7ffZyMA7RQsYc=;
 b=mariTrUDLyIFbrbiWfMDI3Pi5jLf07GC/CUe7r7OObw7tFfuQ/r8FocTuq3nBRK4v163DD1coPB3n7qzg1lo1La467VySrPpMyQK+8owytAadEG1mNkLQewshnKGykpZuKvr7mEJ2b97TfTFa4Kab8O6HvXHoZJvVztWYDAhNMkynAGg0sTgdozDSUMsGppP7Zod/VGAIWCwUmYo0PLPDvVeE5JAHcl9hpo4CeZCr8b5gWd2Uk7lBwv0LHuD7BogZe3HXRxt0tr2rZEOU4qwKiBd4o2Eo44QA/eppNR0M89eUs+jVDSsFv6YKbSBtbWeAZDDHPRbdsAOPwSqiDovbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB5213.eurprd04.prod.outlook.com (2603:10a6:803:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 17:13:20 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.016; Fri, 29 Jan 2021
 17:13:20 +0000
From:   =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>,
        Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH v1] cifs: make nested cifs mount point dentries always valid to deal with signaled 'df'
Date:   Fri, 29 Jan 2021 18:13:16 +0100
Message-ID: <20210129171316.13160-1-aaptel@suse.com>
X-Mailer: git-send-email 2.29.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [2003:fa:705:9f78:7b0f:e618:4073:cda]
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f78:7b0f:e618:4073:cda) by ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.18 via Frontend Transport; Fri, 29 Jan 2021 17:13:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246a3c87-fb4a-4acf-2890-08d8c4792d33
X-MS-TrafficTypeDiagnostic: VI1PR04MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5213F2602932B4A00FC6845BA8B99@VI1PR04MB5213.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+F52aQ2A1QB7KDvVYMXerGcJsBFwBAF56iDc/pooiZ8dpibSlWxa9XTB459edHKEIqDIBaMxsRpD6Kx1bkypYBqT6dsT899nmNzH+zT5D4bPf3pbaw0u4z5ZArB4xH1is596pyPnyl+5sDCjmOyQel2g6PLkLyB7P0uXhp5wcg/hpf/SgtJFeGFBop1xe3mt5vNQgyI0xqYHod/uFU5hFzJZyNivipx2zqNaP5yv+/ZyP4xo855t6N+9UXU1Qs/H0mmRPfFA9L+ya4/RSDEzkT5KsXhJI9wSHzd15s5csbGsxFKwsjactJDp/pAuAMlGXn4LFcMayZR/vfWcuyvS/racGip+R5aW/2vl8ReS3+5K3WH4nn2dFXe7lfCZF23qR0OGEJbe4ODBWNcNz104kkBbCGWAB0NwhIXxgq9NHA+9rl0Awi1BHmBu10em4be5H5Rw/B3F3HTTPhjle4w3g4+KtVdSUP+tyqmb9nnCRzYsB45iBThJxXZKJOok8848Y7Jg7kUmUaUe1dpU1hEM+IBzVoLJ2HZESDrwc6nNqXPzlB+ZY/eqrl8LSu+UGJnE5jxPXoyjitJZ8vdiPufa3xwwuLtPOu4lZ0z10IPx5fAv6DNe6VOMYkDrzPT8eoU6wrlMU4+ldzNJJ1jsEDEZztgb1E6sH495uM0Z8N41yxO+2qR/fRQeqOLS+06lfNFkkyRBRE91ULHpzft6uXgiOhMc28gCrTOw2sU3ePqJar86jS2IdDdPIETJHWBksncqI1GUA3buCjMJrlYzL0BsDH+2O3w1UVSFHSH3Ei6FmAMPH+ihjSwVWTf5A5Cuv15yJ+dCi8bQqcj9JMAnBPQbkSj/c8ilRo1FoHWIoU0i3OiSl7Fii/qp0NDotNlSNrHkdKg/KCy338SUpgBfB5ncg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(66946007)(1076003)(66556008)(6666004)(16526019)(186003)(8676002)(6486002)(66476007)(478600001)(316002)(86362001)(8936002)(5660300002)(2616005)(2906002)(52116002)(4326008)(36756003)(54906003)(83380400001)(6496006)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PQQB14zvBwHIGNF0jseKEXP7Gxa0bqHB2O/bPYSm3LwIosD1McgjIyD3Dc5e?=
 =?us-ascii?Q?k2WzHwthI51WkumgnBq8iA9qXktqQSuXM8qkjmUhIM9jPL34+hy0SSP8sjuo?=
 =?us-ascii?Q?U6Xu5Rvhta4pS/1WOjX1iIPT1zMO51sw7R2Ne89ad929PG0qk07HZozdtiig?=
 =?us-ascii?Q?gnwr2ucRZ9t6u2uXwRxmFmph1s9AmD/HY9LdFkEkRo8rU186J1xSm80NEBnv?=
 =?us-ascii?Q?0cMT7mLxzIgaNB8bmzRI5bVwbxNKQpm/tJpwlecofJDmw2h4gkz0cUrRXqSK?=
 =?us-ascii?Q?VkQokznBYQI4Mmq+9fRwFZKluA9hylM8mK2rv+xwqqBu9T3rcbZBrOcFtLaU?=
 =?us-ascii?Q?sO1jN0Odjp+maup8gIMfjARd0oyOFPbklup60HBgYAE9Q0jJAtq324f4e+4u?=
 =?us-ascii?Q?awK6ud2etLClWll9PjKg/UOZCGqShARvAx9yZzV6RofjF+KQDhn8QKY3+zOz?=
 =?us-ascii?Q?2nYZVO7c2sN12MKuW0w5VG0fAyW7V/64hA79DeiF1UfzmkZe7MJ/ORpHR0Df?=
 =?us-ascii?Q?6GDMFtQjqGmwAW/UasAsbd4+sVuaU8+ANsNQl9K8rXhegcvOPci4vXmSaJrD?=
 =?us-ascii?Q?pkEOtdw88oKrSaBoGXPQFU7hvt4/yGgMZt/v6Io02Kwmi/1BdLcSvAtSC+Xg?=
 =?us-ascii?Q?oMSZ+JmvfLbh3g7V7FoGEdEVDWGFwXUjlPBD4ArtFdvXyqjtc+w4wFi4MbEG?=
 =?us-ascii?Q?2syIQnAb22fb0RYuk697AaHNGnnYnzPVqXCCQmlP5HgYE0Dc4H9jNLWvtivO?=
 =?us-ascii?Q?lAZY7z+KpkuxBflzwIIPhe/W/15qPLn2ZhBcXtdpy/FM8VgU3bm/eFAVQ9SY?=
 =?us-ascii?Q?8x2bxx8Z02Tka61kihcZXQBMjOr3kbdOMcIHck2MpUEYwFf9c5Lm1xsFo5xT?=
 =?us-ascii?Q?F7vE3tlaBv6Gv81RPbRpydzo/JRkpAAU2wxmxo/yLIuCF/WEy0R07oK+/Tpl?=
 =?us-ascii?Q?NAluEWXtzg8CTWbzX4p3Jjfnc6olgeY5djn2CjnbZxLDSeY011dEZy2K/3Vs?=
 =?us-ascii?Q?GjWs8XLuPzKn0UJhhj5xudKA3kn/xb6gbOX0RDy6DV1zDnnz3ikTeczKQwdB?=
 =?us-ascii?Q?ovBKzh+QRDrflg5NEU6If1u/GBdpvh/6HuEa+FfpQytATh9iXVhX1aRSKgmK?=
 =?us-ascii?Q?ixYEwAMCwjWI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a3c87-fb4a-4acf-2890-08d8c4792d33
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 17:13:20.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrMX32EEpwsBxFiI4RBAV+KRIZiblbT2gnAvX6ez88hxT4US1rtFuGn4Pwqqq5Ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5213
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Aurelien Aptel <aaptel@suse.com>

Assuming
- //HOST/a is mounted on /mnt
- //HOST/b is mounted on /mnt/b

On a slow connection, running 'df' and killing it while it's
processing /mnt/b can make cifs_get_inode_info() returns -ERESTARTSYS.

This triggers the following chain of events:
=3D> the dentry revalidation fail
=3D> dentry is put and released
=3D> superblock associated with the dentry is put
=3D> /mnt/b is unmounted

This quick fix makes cifs_d_revalidate() always succeed (mark as
valid) on cifs dentries which are also mount points.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---

I have managed to reproduce this bug with the following script.  It
uses tc with netem discipline (CONFIG_NET_SCH_NETEM=3Dy) to simulate
network delays.

#!/bin/bash

#
# reproducing bsc#1177440
#
# nested mount point gets unmounted when process is signaled
#
set -e

share1=3D//192.168.2.110/scratch
share2=3D//192.168.2.110/test
opts=3D"username=3Dadministrator,password=3Daaptel-42,vers=3D1.0,actimeo=3D=
0"

cleanup() {
    # reset delay
    tc qdisc del dev eth0 root
    mount|grep -q /mnt/nest/a && umount /mnt/nest/a
    mount|grep -q /mnt/nest && umount /mnt/nest

    echo 'module cifs -p' > /sys/kernel/debug/dynamic_debug/control
    echo 'file fs/cifs/* -p' > /sys/kernel/debug/dynamic_debug/control
    echo 0 > /proc/fs/cifs/cifsFYI
    echo 0 > /sys/module/dns_resolver/parameters/debug
    echo 1 > /proc/sys/kernel/printk_ratelimit
   =20
}

trap cleanup EXIT

nbcifs() {
    mount|grep cifs|wc -l
}

reset() {
    echo "unmounting and reloading cifs.ko"
    mount|grep -q /mnt/nest/a && umount /mnt/nest/a
    mount|grep -q /mnt/nest && umount /mnt/nest
    sleep 1
    lsmod|grep -q cifs && ( modprobe -r cifs &> /dev/null || true )
    lsmod|grep -q cifs || ( modprobe cifs &> /dev/null  || true )
}

mnt() {
    dmesg --clear
    echo 'module cifs +p' > /sys/kernel/debug/dynamic_debug/control
    echo 'file fs/cifs/* +p' > /sys/kernel/debug/dynamic_debug/control
    echo 1 > /proc/fs/cifs/cifsFYI
    echo 1 > /sys/module/dns_resolver/parameters/debug
    echo 0 > /proc/sys/kernel/printk_ratelimit

    echo "mounting"
    mkdir -p /mnt/nest
    mount.cifs $share1 /mnt/nest -o "$opts"
    mkdir -p /mnt/nest/a
    mount.cifs $share2 /mnt/nest/a -o "$opts"
}

# add fake delay
tc qdisc add dev eth0 root netem delay 300ms

while :; do
    reset
    mnt
    n=3D$(nbcifs)   =20
    echo "starting df with $n mounts"
    df &=20
    pid=3D$!
    sleep 1.5
    kill $pid || true
    x=3D$(nbcifs)
    echo "stopping with $x mounts"
    if [ $x -lt $n ]; then
        echo "lost mounts"
        dmesg > kernel.log
        exit 1
    fi
done



fs/cifs/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 68900f1629bff..876ef01628538 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -741,6 +741,10 @@ cifs_d_revalidate(struct dentry *direntry, unsigned in=
t flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
=20
+	/* nested cifs mount point are always valid */
+	if (d_mountpoint(direntry))
+		return 1;
+
 	if (d_really_is_positive(direntry)) {
 		inode =3D d_inode(direntry);
 		if ((flags & LOOKUP_REVAL) && !CIFS_CACHE_READ(CIFS_I(inode)))
--=20
2.29.2

