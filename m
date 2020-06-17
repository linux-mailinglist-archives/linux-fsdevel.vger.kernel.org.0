Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D5B1FD361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 19:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFQRZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 13:25:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52214 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:25:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HHHZAb147328;
        Wed, 17 Jun 2020 17:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vaqCbfBg7wUUEyEQckcjkAnwkivK2JLBmbqfA8T87Kc=;
 b=rG8h6sCevPtv2KlllhQDfmP+E3ChsjFwqqsNHJ5qz0D9aHfcL571SW86fjqFRfwIF3zj
 XM8kYmPCoqzhlKsN/DguYZNLNmeYL/290isRUXlQN3gG27fAa06sUquJi3akTjeOmvZR
 8uo0KCskWSaqPP73kaGAGICKH4GaaMIXdo9kIOcsU2VDS9dR/DTpxF0Qew7z8qdz/dj8
 H2ojM2cvbTh+pOabFElR4OVLlBI4UG99iBI8wxni17tzoecQdIemJ7tigXXW2K0nAAut
 GtjMXJPO0OBNtRZ1+RvYabyKxR/vfHLtc5YYqwLhwLKLNrih/vo6/eTsrm9DLZih4dnF Ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31qg352nh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jun 2020 17:25:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HHHebS126726;
        Wed, 17 Jun 2020 17:25:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31q65xxndx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 17:25:07 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05HHOvlB021565;
        Wed, 17 Jun 2020 17:24:58 GMT
Received: from localhost (/10.159.233.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jun 2020 10:24:57 -0700
Date:   Wed, 17 Jun 2020 10:24:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617172456.GP11245@magnolia>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9655 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=1 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170137
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:14:28PM -0500, Eric Sandeen wrote:
> 
> 
> On 6/17/20 10:58 AM, J. Bruce Fields wrote:
> > On Wed, Jun 17, 2020 at 01:03:14AM -0700, Christoph Hellwig wrote:
> >> On Tue, Jun 16, 2020 at 04:21:23PM -0400, Masayoshi Mizuma wrote:
> >>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >>>
> >>> /proc/mounts doesn't show 'i_version' even if iversion
> >>> mount option is set to XFS.
> >>>
> >>> iversion mount option is a VFS option, not ext4 specific option.
> >>> Move the handler to show_sb_opts() so that /proc/mounts can show
> >>> 'i_version' on not only ext4 but also the other filesystem.
> >>
> >> SB_I_VERSION is a kernel internal flag.  XFS doesn't have an i_version
> >> mount option.
> > 
> > It probably *should* be a kernel internal flag, but it seems to work as
> > a mount option too.
> 
> Not on XFS AFAICT:
> 
> [600280.685810] xfs: Unknown parameter 'i_version'

Yeah, because the mount option is 'iversion', not 'i_version'.  Even if
you were going to expose the flag state in /proc/mounts, the text string
should match the mount option.

> so we can't be exporting "mount options" for xfs that aren't actually
> going to be accepted by the filesystem.
> 
> > By coincidence I've just been looking at a bug report showing that
> > i_version support is getting accidentally turned off on XFS whenever
> > userspace does a read-write remount.
> > 
> > Is there someplace in the xfs mount code where it should be throwing out
> > SB_I_VERSION?
> 
> <cc xfs list>
> 
> XFS doesn't manipulate that flag on remount.  We just turn it on by default
> for modern filesystem formats:
> 
>         /* version 5 superblocks support inode version counters. */
>         if (XFS_SB_VERSION_NUM(&mp->m_sb) == XFS_SB_VERSION_5)
>                 sb->s_flags |= SB_I_VERSION;
> 
> Also, this behavior doesn't seem unique to xfs:
> 
> # mount -o loop,i_version fsfile test_iversion
> # grep test_iversion /proc/mounts
> /dev/loop4 /tmp/test_iversion ext4 rw,seclabel,relatime,i_version 0 0
> # mount -o remount test_iversion
> # grep test_iversion /proc/mounts
> /dev/loop4 /tmp/test_iversion ext4 rw,seclabel,relatime 0 0
> # uname -a
> Linux <hostname> 5.7.0-rc4+ #7 SMP Wed Jun 10 14:01:34 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux

Probably because do_mount clears it and I guess xfs don't re-enable
it in any of their remount functions...

--D

> -Eric
> 
> > Ideally there'd be entirely different fields for mount options and
> > internal feature flags.  But I don't know, maybe SB_I_VERSION is the
> > only flag we have like this.
> > 
> > --b.
> > 
