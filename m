Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684C70E5C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 21:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbjEWTjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 15:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238390AbjEWTjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 15:39:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C6E4F;
        Tue, 23 May 2023 12:39:13 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NJHPbK027740;
        Tue, 23 May 2023 19:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vgex8UsbtCktiKteHQwNp7o1/Ls7Gbddnp8I3giQeKQ=;
 b=ql+IgI8Q6eDCb9hrhKJ1Bq10PXgnvyKau54mTxPo9qJB0wLVgygl8e+6lDb/inIaWr3J
 r0iGE4DLy7NfPje0bxYTi6cWnywgNN48/tYZwqU+bXEcG1HMBDIjoAXmvasWHAkVNq3u
 PBbiRoreOJW5qMjifpv6L8W1uZQYYMKRMLpXa9/yeRa5RKbgjG5UN/DmPO0bAXk/CjYn
 WDuK1eNFq7b1pU57mincQMPnLuervcmlFTHp3HcN7SwFcKuDPhsNIcgTU6PPR9O6Y/Ag
 UVNF1hKCV8E2Mx+GhjCPGRcFtHRIJI7iiXfsVclFxaCbk7H9CuzjXoMgn31Nse/7vmFB OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs29pjk90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 19:38:56 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NIeHaC028885;
        Tue, 23 May 2023 19:38:56 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs29pjk83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 19:38:56 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFUXRU009193;
        Tue, 23 May 2023 19:38:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3qppc5gmq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 19:38:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34NJcslr3146358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 19:38:54 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 055CE58056;
        Tue, 23 May 2023 19:38:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C58858052;
        Tue, 23 May 2023 19:38:53 +0000 (GMT)
Received: from wecm-9-67-154-32.wecm.ibm.com (unknown [9.67.154.32])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 23 May 2023 19:38:53 +0000 (GMT)
Message-ID: <85070b837c134341bb10a2647dbe62e2b5806565.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
Date:   Tue, 23 May 2023 15:38:52 -0400
In-Reply-To: <CAOQ4uxjjLLGQM5BUgDrFdghYsFgShNA6tDpvC8vNg_jOh9WGAQ@mail.gmail.com>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
         <CAOQ4uxi7PFPPUuW9CZAZB9tvU2GWVpmpdBt=EUYyw60K=WX-Yg@mail.gmail.com>
         <9aced306f134628221c55530643535b89874ccc0.camel@linux.ibm.com>
         <CAOQ4uxjjLLGQM5BUgDrFdghYsFgShNA6tDpvC8vNg_jOh9WGAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LycEsRAw8JRrBB-8NMf98hXLdZNeEj3b
X-Proofpoint-ORIG-GUID: nFeOZ42C0MsrKmUcQk_gPLhlgBP0djeB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_12,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230158
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 17:00 +0300, Amir Goldstein wrote:
> On Mon, May 22, 2023 at 3:18 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Sat, 2023-05-20 at 12:15 +0300, Amir Goldstein wrote:
> > > On Fri, May 19, 2023 at 10:42 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
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
> > > > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > > > >     Currently, ima assumes that it will get the correct i_version from
> > > > >     an inode but that just doesn't hold for stacking filesystem.
> > > > >
> > > > > While (1) would likely just fix the immediate bug (2) is correct and
> > > > > _robust_. If we change how attributes are handled vfs_*() helpers will
> > > > > get updated and ima with it. Poking at raw inodes without using
> > > > > appropriate helpers is much more likely to get ima into trouble.
> > > >
> > > > In addition to properly setting the i_version for IMA, EVM has a
> > > > similar issue with i_generation and s_uuid. Adding them to
> > > > ovl_copyattr() seems to resolve it.   Does that make sense?
> > > >
> > > > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > > > index 923d66d131c1..cd0aeb828868 100644
> > > > --- a/fs/overlayfs/util.c
> > > > +++ b/fs/overlayfs/util.c
> > > > @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
> > > >         inode->i_atime = realinode->i_atime;
> > > >         inode->i_mtime = realinode->i_mtime;
> > > >         inode->i_ctime = realinode->i_ctime;
> > > > +       inode->i_generation = realinode->i_generation;
> > > > +       if (inode->i_sb)
> > > > +               uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> > > > >s_uuid);
> > >
> > > That is not a possible solution Mimi.
> > >
> > > The i_gneration copy *may* be acceptable in "all layers on same fs"
> > > setup, but changing overlayfs s_uuid over and over is a non-starter.
> > >
> > > If you explain the problem, I may be able to help you find a better solution.
> >
> > EVM calculates an HMAC of the file metadata (security xattrs, i_ino,
> > i_generation, i_uid, i_gid, i_mode, s_uuid)  and stores it as
> > security.evm.  Notrmally this would be used for mutable files, which
> > cannot be signed.  The i_generation and s_uuid on the lower layer and
> > the overlay are not the same, causing the EVM HMAC verification to
> > fail.
> >
> 
> OK, so EVM expects i_ino, i_generation, i_uid, i_gid, i_mode, s_uuid
> and security xattr to remain stable and persistent (survive umount/mount).
> Correct?

Yes

> 
> You cannot expect that the same EVM xattr will correctly describe both
> the overlayfs inode and the underlying real fs inode, because they may
> vary in some of the metadata, so need to decide if you only want to attest
> overlayfs inodes, real underlying inodes or both.

Understood.  Accessing a file on the overlay filesystem then needs to
be verified based on the backing file metadata.  Currently that isn't
being done.  So either all the backing file metadata needs to be copied
up or some other change(s) need to be made.

> If both, then the same EVM xattr cannot be used, but as it is, overlayfs
> inode has no "private" xattr version, it stores its xattr on the underlying
> real inode.
> 
> i_uid, i_gid, i_mode:
> Should be stable and persistent for overlayfs inode and survive copy up.
> Should be identical to the underlying inode.
> 
> security xattr:
> Overlayfs tries to copy up all security.* xattr and also calls the LSM
> hook security_inode_copy_up_xattr() to approve each copied xattr.
> Should be identical to the underlying inode.

> s_uuid:
> So far, overlayfs sb has a null uuid.
> With this patch, overlayfs will gain a persistent s_uuid, just like any
> other disk fs with the opt-in feature index=on:
> https://lore.kernel.org/linux-unionfs/20230425132223.2608226-4-amir73il@gmail.com/
> Should be different from the underlying fs uuid when there is more
> than one underlying fs.
> We can consider inheriting s_uuid from underlying fs when all layers
> are on the same fs.
> 
> i_ino:
> As documented in:
> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/overlayfs.rst#inode-properties
> It should be persistent and survive copy up with the
> xino=auto feature (module param or mount option) or
> CONFIG_OVERLAY_FS_XINO_AUTO=y
> which is not the kernel default, but already set by some distros.
> Will be identical to the underlying inode only in some special cases
> such as pure upper (not copied up) inodes.
> Will be different from the underlying lower file inode many in other cases.
> 
> i_generation:
> For xino=auto, we could follow the same rules as i_ino and get similar
> qualities -
> i_generation will become persistent and survive copy up, but it will not be
> identical to the real underlying inode i_generation in many cases.
> 
> Bottom line:
> If you only want to attest overlayfs inodes - shouldn't be too hard
> If you want to attest both overlayfs inodes AND their backing "real" inodes -
> much more challenging.
> 
> Hope that this writeup helps more than it confuses.

Thanks, Amir.   It definitely helps.

To summarize what I'm seeing (IMA hash and EVM HMAC):

- Directly accessing overlay files, "lower" backed file, fails to
verify without copying all the file metadata up.

- Writing directly to the "upper" backing file properly updates the
file metadata.

- Writing directly to the overlay file does not write security.ima
either to the overlayfs  or the "upper" backing file.

policy rules:
appraise func=FILE_CHECK fsuuid=....
measure func=FILE_CHECK fsuuid=....
appraise func=FILE_CHECK fsname=overlay 
measure func=FILE_CHECK fsname=overlay

Mimi

