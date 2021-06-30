Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1BD3B80F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhF3KwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 06:52:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13006 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhF3KwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 06:52:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UAfXfd015075;
        Wed, 30 Jun 2021 10:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=FxOE4NuQ35+xxqSaXweYOLfnzgA3aF0LuzxJYhCNSso=;
 b=HLh2ag2vzSmPWspgoK3yO/X9DaG6syFmljjB68+EcK1q/o0dd0pdEcsxHpSGyIHPadB0
 5MgXX3WzwUThrFK/ZX9vd9gyYyKanySv4zpkhlKS+R4RsP5PsfucSvJjafyPvrbesa15
 q0Z/N0Y79hhOlOOBb69mMfq+M+Rp6jVMuWLL74GuEHfEYKo191NYZtR8XdV/7/na62wr
 ZdRd5I81yCPh8o62qSnh6YjBpSW6e3cu7QUz1kwr1MgTDOHQ522DQ8STcMnhKM/XwtgF
 nbOGKYfv6sHfG/t5TGw1OxuK/0wxWJE9g0GGSkUuZnGUiBC55MVxLYBW8FlcmZwZKMAN /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gha48pvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 10:49:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15UAju0p089676;
        Wed, 30 Jun 2021 10:49:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv27q99u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 10:49:18 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15UAnHPk098035;
        Wed, 30 Jun 2021 10:49:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 39dv27q998-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 10:49:17 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15UAnFf1016531;
        Wed, 30 Jun 2021 10:49:15 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jun 2021 10:49:14 +0000
Date:   Wed, 30 Jun 2021 13:49:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in
 struct fsnotify_event_info
Message-ID: <20210630104904.GS2040@kadam>
References: <20210629191035.681913-8-krisman@collabora.com>
 <202106300707.Xg0LaEwy-lkp@intel.com>
 <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
 <20210630084555.GH1983@kadam>
 <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiCYBL2-FVMbn2RWcQnueueVoAd5sBtte+twLoU9eyFgA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: zTbxK_I6Xemz85vnsMQm6VSaTEbL8JMY
X-Proofpoint-GUID: zTbxK_I6Xemz85vnsMQm6VSaTEbL8JMY
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I think my bug report was not clear...  :/  The code looks like this:

	sb = inode->i_sb;

	if (inode) ...

The NULL check cannot be false because if "inode" is NULL we would have
already crashed when we dereference it on the line before.

In this case, based on last years discussion, the "inode" pointer can't
be NULL.  The debate is only whether the unnecessary NULL checks help
readability or hurt readability.

> Why does it presume that event_info->dir is non-NULL?

That was my commentary, just from reading the code.  Smatch says that
"event->dir" is unknown.

> Did smach check all the callers to fsnotify() or something?

The kbuild-bot doesn't build the cross function database but if you did
use the cross function database then, yes, it does track all the
callers.  There are two pointers that we care about, the "inode" and
the parent inode (dir).  Smatch can figure out when "inode" is NULL vs
non-NULL but where it gets stuck is on the some of the parent inodes
like this call from fsnotify_dirent():

	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
                                 ^^^^^^^^^^^^^^^

Smatch doesn't know that d_inode() is always non-NULL at this point.

regards,
dan carpenter
