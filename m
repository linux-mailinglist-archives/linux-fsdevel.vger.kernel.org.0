Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F36EAE28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjDUPiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjDUPiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:38:02 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A451125AE;
        Fri, 21 Apr 2023 08:38:00 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LEgShG006511;
        Fri, 21 Apr 2023 14:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2Ju8pqGa2m0Pa7C+ibK08Mb+2OAt+YEF09z+pzB+moc=;
 b=N26po9zJepipAXftwZ9Ksf2SAFtmayQlXTl4fN4SKUX8PCEzpZJ8nOU26gJ9UdfAOREV
 pGfQpxXppJGcNAEVT//KcDRVXW5e8GuFIf5HDKmtTb11TzYqtW5aeZva67LS/S3CVZhJ
 RMwHhbQFsB+3ZI6CIkc32HEo89tIhB4XPrYeu1JvAG50ngkjRjgz4deL958l9Q/xj0ps
 9DEwoj3R/y3+6qCE60Dwwkr2CyARU3i/b/FNUfl1hKwxUD32WuJIeyQeR8uHE9eaEsVX
 JR1vzIkNq2o/pIz9/eWGIKiPNQB4InEQQ/MlO8IF9goqNIQIWmACzozTgDtZ4lALjnsv sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3v2v94t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:44:11 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33LEh5EA009609;
        Fri, 21 Apr 2023 14:44:03 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3v2v93x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:44:03 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCikYB027070;
        Fri, 21 Apr 2023 14:43:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pykj79wwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:43:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33LEhn109110270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 14:43:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C7705805C;
        Fri, 21 Apr 2023 14:43:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D66835805F;
        Fri, 21 Apr 2023 14:43:47 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.8.185])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Apr 2023 14:43:47 +0000 (GMT)
Message-ID: <cbffa3dee65ecc0884dd16eb3af95c09a28f4297.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Fri, 21 Apr 2023 10:43:46 -0400
In-Reply-To: <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CFy9FUIyV3xuItYoC68paE8NPsJ-Yhek
X-Proofpoint-ORIG-GUID: RgiN1v2180XPGj715m7iNirTDfUGKBQ0
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-04-07 at 09:29 -0400, Jeff Layton wrote:
> > > > > 
> > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > 
> > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > 
> > We should cool it with the quick hacks to fix things. :)
> > 
> 
> Yeah. It might fix this specific testcase, but I think the way it uses
> the i_version is "gameable" in other situations. Then again, I don't
> know a lot about IMA in this regard.
> 
> When is it expected to remeasure? If it's only expected to remeasure on
> a close(), then that's one thing. That would be a weird design though.

Historical background:

Prior to IMA being upstreamed there was a lot of discussion about how
much/how frequently to measure files.  Re-measuring files after each
write would impact performance.  Instead of re-measuring files after
each write, if a file already opened for write was opened for read
(open writers) or a file already opened for read was opened for write
(Time of Measure/Time of Use) the IMA meausrement list was invalidated
by including a violation record in the measurement list.

Only the BPRM hook prevents a file from being opened for write.

> 
> > > > > 
> > > > > 
> > > > 
> > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > overlayfs inode.
> > > > 
> > > > I suspect that the real problem here is that IMA is just doing a bare
> > > > inode_query_iversion. Really, we ought to make IMA call
> > > > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > > > the upper layer. Then overlayfs could just propagate the results from
> > > > the upper layer in its response.
> > > > 
> > > > That sort of design may also eventually help IMA work properly with more
> > > > exotic filesystems, like NFS or Ceph.
> > > > 
> > > > 
> > > > 
> > > 
> > > Maybe something like this? It builds for me but I haven't tested it. It
> > > looks like overlayfs already should report the upper layer's i_version
> > > in getattr, though I haven't tested that either:
> > > 
> > > -----------------------8<---------------------------
> > > 
> > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > 
> > > IMA currently accesses the i_version out of the inode directly when it
> > > does a measurement. This is fine for most simple filesystems, but can be
> > > problematic with more complex setups (e.g. overlayfs).
> > > 
> > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > the filesystem to determine whether and how to report the i_version, and
> > > should allow IMA to work properly with a broader class of filesystems in
> > > the future.
> > > 
> > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > So, I think we want both; we want the ovl_copyattr() and the
> > vfs_getattr_nosec() change:
> > 
> > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> >     is in line what we do with all other inode attributes. IOW, the
> >     overlayfs inode's i_version counter should aim to mirror the
> >     relevant layer's i_version counter. I wouldn't know why that
> >     shouldn't be the case. Asking the other way around there doesn't
> >     seem to be any use for overlayfs inodes to have an i_version that
> >     isn't just mirroring the relevant layer's i_version.
> 
> It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> inode.
> 
> You can't just copy up the value from the upper. You'll need to call
> inode_query_iversion(upper_inode), which will flag the upper inode for a
> logged i_version update on the next write. IOW, this could create some
> (probably minor) metadata write amplification in the upper layer inode
> with IS_I_VERSION inodes.
> 
> 
> > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> >     Currently, ima assumes that it will get the correct i_version from
> >     an inode but that just doesn't hold for stacking filesystem.
> > 
> > While (1) would likely just fix the immediate bug (2) is correct and
> > _robust_. If we change how attributes are handled vfs_*() helpers will
> > get updated and ima with it. Poking at raw inodes without using
> > appropriate helpers is much more likely to get ima into trouble.
> 
> This will fix it the right way, I think (assuming it actually works),
> and should open the door for IMA to work properly with networked
> filesystems that support i_version as well.

On a local filesystem, there are guarantees that the calculated file
hash is that of the file being used.  Reminder IMA reads a file, page
size chunk at a time into a single buffer, calculating the file hash. 
Once the file hash is calculated, the memory is freed.

There are no guarantees on a fuse filesystem, for example, that the
original file read and verified is the same as the one being executed. 
I'm not sure that the integrity guarantees of a file on a remote
filesystem will be the same as those on a local file system.

> 
> Note that there Stephen is correct that calling getattr is probably
> going to be less efficient here since we're going to end up calling
> generic_fillattr unnecessarily, but I still think it's the right thing
> to do.
> 
> If it turns out to cause measurable performance regressions though,
> maybe we can look at adding a something that still calls ->getattr if it
> exists but only returns the change_cookie value.

Sure.  For now,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

