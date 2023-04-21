Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1A6EAD83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjDUOzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 10:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjDUOzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:55:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FADAAF20;
        Fri, 21 Apr 2023 07:55:46 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LE9Q9s031312;
        Fri, 21 Apr 2023 14:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ytlqZYrH0qoFzwZ2+BYeEx9kCxU/tFANcdaojFrOpM8=;
 b=VxXvr/AXvJmFrMMZAh6S4MCqMKk4MvWG4ILxEw59tkuRXW43NolKWPUwbVV8WPHIo3OX
 QDjRyAR50K4v8UASIa5+//Zf1JqFmfG86iH9zhlW7yNaMgfFAsxpNQJ1FMJodrT5te0o
 iZPhrJZaH/sVEhXpTtp5PaVC3WEphMBnGRbUj7JHkzQnSAgAisA38iG09j8Flgauh8/T
 xVg0cwFKa7IVkaGmWwpyF3KJF94X6SO5IzbFM9RvNqDBYWak/4AsoW2OIpCTC/DYNCzS
 U8czRMskNaLO6pOF9EJPQduzCDHTq9N7/U7V736RE5VjACbTyweEcovidTfBQfDBHGEZ 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3umwkf4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:55:41 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33LEcGgr013987;
        Fri, 21 Apr 2023 14:55:40 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q3umwkf4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:55:40 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33LC6fls003740;
        Fri, 21 Apr 2023 14:55:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pykj8jb8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Apr 2023 14:55:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33LEtcRF32506598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 14:55:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D64658056;
        Fri, 21 Apr 2023 14:55:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FC3C5805A;
        Fri, 21 Apr 2023 14:55:34 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.163.8.185])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 21 Apr 2023 14:55:34 +0000 (GMT)
Message-ID: <ef89b203b67a4a6a8c6aea069c0a2f188a3cfcb0.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Date:   Fri, 21 Apr 2023 10:55:34 -0400
In-Reply-To: <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <90a25725b4b3c96e84faefdb827b261901022606.camel@kernel.org>
         <20230409-genick-pelikan-a1c534c2a3c1@brauner>
         <b2591695afc11a8924a56865c5cd2d59e125413c.camel@kernel.org>
         <20230411-umgewandelt-gastgewerbe-870e4170781c@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jqS1OM330qLgNJZbinJ-NZ1skzQgU5kx
X-Proofpoint-GUID: boew0fgaxtLpb0GeLYZZDJckZkynqIgn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210127
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-04-11 at 10:38 +0200, Christian Brauner wrote:
> On Sun, Apr 09, 2023 at 06:12:09PM -0400, Jeff Layton wrote:
> > On Sun, 2023-04-09 at 17:22 +0200, Christian Brauner wrote:
> > > On Fri, Apr 07, 2023 at 09:29:29AM -0400, Jeff Layton wrote:
> > > > > > > > 
> > > > > > > > I would ditch the original proposal in favor of this 2-line patch shown here:
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/linux-integrity/a95f62ed-8b8a-38e5-e468-ecbde3b221af@linux.ibm.com/T/#m3bd047c6e5c8200df1d273c0ad551c645dd43232
> > > > > 
> > > > > We should cool it with the quick hacks to fix things. :)
> > > > > 
> > > > 
> > > > Yeah. It might fix this specific testcase, but I think the way it uses
> > > > the i_version is "gameable" in other situations. Then again, I don't
> > > > know a lot about IMA in this regard.
> > > > 
> > > > When is it expected to remeasure? If it's only expected to remeasure on
> > > > a close(), then that's one thing. That would be a weird design though.
> > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > 
> > > > > > > Ok, I think I get it. IMA is trying to use the i_version from the
> > > > > > > overlayfs inode.
> > > > > > > 
> > > > > > > I suspect that the real problem here is that IMA is just doing a bare
> > > > > > > inode_query_iversion. Really, we ought to make IMA call
> > > > > > > vfs_getattr_nosec (or something like it) to query the getattr routine in
> > > > > > > the upper layer. Then overlayfs could just propagate the results from
> > > > > > > the upper layer in its response.
> > > > > > > 
> > > > > > > That sort of design may also eventually help IMA work properly with more
> > > > > > > exotic filesystems, like NFS or Ceph.
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > Maybe something like this? It builds for me but I haven't tested it. It
> > > > > > looks like overlayfs already should report the upper layer's i_version
> > > > > > in getattr, though I haven't tested that either:
> > > > > > 
> > > > > > -----------------------8<---------------------------
> > > > > > 
> > > > > > [PATCH] IMA: use vfs_getattr_nosec to get the i_version
> > > > > > 
> > > > > > IMA currently accesses the i_version out of the inode directly when it
> > > > > > does a measurement. This is fine for most simple filesystems, but can be
> > > > > > problematic with more complex setups (e.g. overlayfs).
> > > > > > 
> > > > > > Make IMA instead call vfs_getattr_nosec to get this info. This allows
> > > > > > the filesystem to determine whether and how to report the i_version, and
> > > > > > should allow IMA to work properly with a broader class of filesystems in
> > > > > > the future.
> > > > > > 
> > > > > > Reported-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > 
> > > > > So, I think we want both; we want the ovl_copyattr() and the
> > > > > vfs_getattr_nosec() change:
> > > > > 
> > > > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > > > >     is in line what we do with all other inode attributes. IOW, the
> > > > >     overlayfs inode's i_version counter should aim to mirror the
> > > > >     relevant layer's i_version counter. I wouldn't know why that
> > > > >     shouldn't be the case. Asking the other way around there doesn't
> > > > >     seem to be any use for overlayfs inodes to have an i_version that
> > > > >     isn't just mirroring the relevant layer's i_version.
> > > > 
> > > > It's less than ideal to do this IMO, particularly with an IS_I_VERSION
> > > > inode.
> > > > 
> > > > You can't just copy up the value from the upper. You'll need to call
> > > > inode_query_iversion(upper_inode), which will flag the upper inode for a
> > > > logged i_version update on the next write. IOW, this could create some
> > > > (probably minor) metadata write amplification in the upper layer inode
> > > > with IS_I_VERSION inodes.
> > > 
> > > I'm likely just missing context and am curious about this so bear with me. Why
> > > do we need to flag the upper inode for a logged i_version update? Any required
> > > i_version interactions should've already happened when overlayfs called into
> > > the upper layer. So all that's left to do is for overlayfs' to mirror the
> > > i_version value after the upper operation has returned.
> > 
> > > ovl_copyattr() - which copies the inode attributes - is always called after the
> > > operation on the upper inode has finished. So the additional query seems odd at
> > > first glance. But there might well be a good reason for it. In my naive
> > > approach I would've thought that sm along the lines of:
> > >
> > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > index 923d66d131c1..8b089035b9b3 100644
> > > --- a/fs/overlayfs/util.c
> > > +++ b/fs/overlayfs/util.c
> > > @@ -1119,4 +1119,5 @@ void ovl_copyattr(struct inode *inode)
> > >         inode->i_mtime = realinode->i_mtime;
> > >         inode->i_ctime = realinode->i_ctime;
> > >         i_size_write(inode, i_size_read(realinode));
> > > +       inode_set_iversion_raw(inode, inode_peek_iversion_raw(realinode));
> > >  }
> > > 
> > > would've been sufficient.
> > > 
> > 
> > Nope, because then you wouldn't get any updates to i_version after that
> > point.
> > 
> > Note that with an IS_I_VERSION inode we only update the i_version when
> > there has been a query since the last update. What you're doing above is
> > circumventing that mechanism. You'll get the i_version at the time of of
> > the ovl_copyattr, but there won't be any updates of it after that point
> > because the QUERIED bit won't end up being set on realinode.
> 
> I get all that.
> But my understanding had been that the i_version value at the time of
> ovl_copyattr() would be correct. Because when ovl_copyattr() is called
> the expected i_version change will have been done in the relevant layer
> includig raising the QUERIED bit. Since the layers are not allowed to be
> changed outside of the overlayfs mount any change to them can only
> originate from overlayfs which would necessarily call ovl_copyattr()
> again. IOW, overlayfs would by virtue of its implementation keep the
> i_version value in sync.
> 
> Overlayfs wouldn't even raise SB_I_VERSION. It would indeed just be a
> cache of i_version of the relevant layer.
> 
> > 
> > 
> > > Since overlayfs' does explicitly disallow changes to the upper and lower trees
> > > while overlayfs is mounted it seems intuitive that it should just mirror the
> > > relevant layer's i_version.
> > >
> > >
> > > If we don't do this, then we should probably document that i_version doesn't
> > > have a meaning yet for the inodes of stacking filesystems.
> > > 
> > 
> > Trying to cache the i_version is counterproductive, IMO, at least with
> > an IS_I_VERSION inode.
> > 
> > The problem is that a query against the i_version has a side-effect. It
> > has to (atomically) mark the inode for an update on the next change.
> > 
> > If you try to cache that value, you'll likely end up doing more queries
> > than you really need to (because you'll need to keep the cache up to
> > date) and you'll have an i_version that will necessarily lag the one in
> > the upper layer inode.
> > 
> > The whole point of the change attribute is to get the value as it is at
> > this very moment so we can check whether there have been changes. A
> > laggy value is not terribly useful.
> > 
> > Overlayfs should just always call the upper layer's ->getattr to get the
> > version. I wouldn't even bother copying it up in the first place. Doing
> > so is just encouraging someone to try use the value in the overlayfs
> > inode, when they really need to go through ->getattr and get the one
> > from the upper layer.
> 
> That seems reasonable to me. I read this as an agreeing with my earlier
> suggestion to document that i_version doesn't have a meaning for the
> inodes of stacking filesystems and that we should spell out that
> vfs_getattr()/->getattr() needs to be used to interact with i_version.
> 
> We need to explain to subsystems such as IMA somwhere what the correct
> way to query i_version agnostically is; independent of filesystem
> implementation details.
> 
> Looking at IMA, it queries the i_version directly without checking
> whether it's an IS_I_VERSION() inode first. This might make a
> difference.h
> 
> Afaict, filesystems that persist i_version to disk automatically raise
> SB_I_VERSION. I would guess that it be considered a bug if a filesystem
> would persist i_version to disk and not raise SB_I_VERSION. If so IMA
> should probably be made to check for IS_I_VERSION() and it will probably
> get that by switching to vfs_getattr_nosec().

When the filesystem isn't mounted with I_VERSION, i_version should be
set to 0.

Originally when the filesytem wasn't mounted with I_VERSION support,
the file would only be measured once.  With commit ac0bf025d2c0 ("ima:
Use i_version only when filesystem supports it"), this changed.   The
"iint" flags are reset, causing the file to be re-
{measure/appraised/audited} on next access.

-- 
thanks,

Mimi

