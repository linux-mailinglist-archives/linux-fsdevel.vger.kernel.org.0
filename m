Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6B70BDAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjEVMW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjEVMVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:21:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A292D5A;
        Mon, 22 May 2023 05:19:22 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MAHKSw014026;
        Mon, 22 May 2023 12:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EM4f/HnWMsQA9XlCO7vQgbwM3VoRhIqdzHyjShVOjq0=;
 b=JiIKplnPhYcywJVRwRORFA+9ApBQTtaNyy6k7HfHZk/vf7MlEUd8LOsawF+J5nBOcabq
 1vT2qaW/JkFLzYTvKKKjsOVMgggSQeVlFVbiRnpiVeXSZ7QhN6bN4z4VOcVEy2W+0hXH
 Fw2ocd9QwP8c3T8arIOmsVvomi46+al1Qo1xBzW5hAuJG+2DgOq07D5C9yprKuOa0+yl
 Z4fBD3jA863/Dx1k9I2olggJQJ1fZT6rVI5E7qreCEWDwfyEIH1qtEX0KR1TD1F9HfPM
 t/sBT8XGDeW8YXuOdDyil7uLe91omgwUiq84H/eFbFilIIxf2vpPMHU5cdZ9ol5Qc0wf 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfak4xq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 12:18:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MBpOmB010492;
        Mon, 22 May 2023 12:18:14 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qqfak4xpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 12:18:14 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M9CMA5018866;
        Mon, 22 May 2023 12:18:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3qppdb284e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 12:18:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34MCIBJ864487908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 12:18:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C976858050;
        Mon, 22 May 2023 12:18:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856D258045;
        Mon, 22 May 2023 12:18:10 +0000 (GMT)
Received: from wecm-9-67-38-173.wecm.ibm.com (unknown [9.67.38.173])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 12:18:10 +0000 (GMT)
Message-ID: <9aced306f134628221c55530643535b89874ccc0.camel@linux.ibm.com>
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
Date:   Mon, 22 May 2023 08:18:10 -0400
In-Reply-To: <CAOQ4uxi7PFPPUuW9CZAZB9tvU2GWVpmpdBt=EUYyw60K=WX-Yg@mail.gmail.com>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
         <CAOQ4uxi7PFPPUuW9CZAZB9tvU2GWVpmpdBt=EUYyw60K=WX-Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: opgvgwF5P4zhuFJfXOQ6CRad1NlY8c2l
X-Proofpoint-GUID: 3d-XEyOzlFh7k_HYEoehOs7bmpk7h9i5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_08,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-05-20 at 12:15 +0300, Amir Goldstein wrote:
> On Fri, May 19, 2023 at 10:42 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Fri, 2023-04-07 at 10:31 +0200, Christian Brauner wrote:
> > > So, I think we want both; we want the ovl_copyattr() and the
> > > vfs_getattr_nosec() change:
> > >
> > > (1) overlayfs should copy up the inode version in ovl_copyattr(). That
> > >     is in line what we do with all other inode attributes. IOW, the
> > >     overlayfs inode's i_version counter should aim to mirror the
> > >     relevant layer's i_version counter. I wouldn't know why that
> > >     shouldn't be the case. Asking the other way around there doesn't
> > >     seem to be any use for overlayfs inodes to have an i_version that
> > >     isn't just mirroring the relevant layer's i_version.
> > > (2) Jeff's changes for ima to make it rely on vfs_getattr_nosec().
> > >     Currently, ima assumes that it will get the correct i_version from
> > >     an inode but that just doesn't hold for stacking filesystem.
> > >
> > > While (1) would likely just fix the immediate bug (2) is correct and
> > > _robust_. If we change how attributes are handled vfs_*() helpers will
> > > get updated and ima with it. Poking at raw inodes without using
> > > appropriate helpers is much more likely to get ima into trouble.
> >
> > In addition to properly setting the i_version for IMA, EVM has a
> > similar issue with i_generation and s_uuid. Adding them to
> > ovl_copyattr() seems to resolve it.   Does that make sense?
> >
> > diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> > index 923d66d131c1..cd0aeb828868 100644
> > --- a/fs/overlayfs/util.c
> > +++ b/fs/overlayfs/util.c
> > @@ -1118,5 +1118,8 @@ void ovl_copyattr(struct inode *inode)
> >         inode->i_atime = realinode->i_atime;
> >         inode->i_mtime = realinode->i_mtime;
> >         inode->i_ctime = realinode->i_ctime;
> > +       inode->i_generation = realinode->i_generation;
> > +       if (inode->i_sb)
> > +               uuid_copy(&inode->i_sb->s_uuid, &realinode->i_sb-
> > >s_uuid);
> 
> That is not a possible solution Mimi.
> 
> The i_gneration copy *may* be acceptable in "all layers on same fs"
> setup, but changing overlayfs s_uuid over and over is a non-starter.
> 
> If you explain the problem, I may be able to help you find a better solution.

EVM calculates an HMAC of the file metadata (security xattrs, i_ino,
i_generation, i_uid, i_gid, i_mode, s_uuid)  and stores it as
security.evm.  Notrmally this would be used for mutable files, which
cannot be signed.  The i_generation and s_uuid on the lower layer and
the overlay are not the same, causing the EVM HMAC verification to
fail.

-- 
thanks,

Mimi

