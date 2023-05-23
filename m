Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E470E341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbjEWRgD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjEWRf5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:35:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E648E;
        Tue, 23 May 2023 10:35:31 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NGlLan019858;
        Tue, 23 May 2023 17:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bS1lSm+/4aXi4kR5ZofZllCDbEZqdxjQEnBk9kz/4Y8=;
 b=L1kpo8J1oJryfTKONdjSUl/01H3xe+qHjHDg+4+0sijUvp4l+XH84riPTbGI+RBLxtn1
 EbwvglqSifv8fksksAxqK1hNVz3yOsgxS0J5i/Ctb/odXivazySk/Fl/CW7hXqRcBwzX
 1cWtZfaGwq54EyxUZ6eyxVLVpn+rKtF6ZajgPKKnPngCAyfOk5RmbVNty9aS+Hcvo/pX
 mmR9t6Sgw+aHuH70fyGrx4wvfWyQHNy/++63HnoPERzhlamwWsXwpZQGL1iOfhMBNNRu
 H44I018He2AD3c9fLnBAdfYd6QnjLMId2XMBffmvzz8A3Zy5XLDbUCzKQlNacRBIGRuQ AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs0xs9n9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 17:35:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NHPQmT004788;
        Tue, 23 May 2023 17:35:11 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs0xs9n8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 17:35:10 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NFZhZ5010757;
        Tue, 23 May 2023 17:35:09 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qppds0853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 17:35:09 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34NHZ8sv49086832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 17:35:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CAFF5805F;
        Tue, 23 May 2023 17:35:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83B0658052;
        Tue, 23 May 2023 17:35:06 +0000 (GMT)
Received: from wecm-9-67-154-32.wecm.ibm.com (unknown [9.67.154.32])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 23 May 2023 17:35:06 +0000 (GMT)
Message-ID: <51bc6e173bcea1f017355be5ef44a1d12c70fa7f.camel@linux.ibm.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM
 after writes
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Chinner <david@fromorbit.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Ignaz Forster <iforster@suse.de>, Petr Vorel <pvorel@suse.cz>
Date:   Tue, 23 May 2023 13:35:06 -0400
In-Reply-To: <ZGqgDjJqFSlpIkz/@dread.disaster.area>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
         <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
         <20230520-angenehm-orangen-80fdce6f9012@brauner>
         <ZGqgDjJqFSlpIkz/@dread.disaster.area>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WsqBFjVRsImRVbx6VFrzuxe9GzJZzjki
X-Proofpoint-ORIG-GUID: bIPLyujcVoNFRaFBEPv7amMs7BK0Y0ry
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-05-22 at 08:49 +1000, Dave Chinner wrote:


> > In addition the uuid should be set when the filesystem is mounted.
> > Unless the filesystem implements a dedicated ioctl() - like ext4 - to
> > change the uuid.
> 
> IMO, that ext4 functionality is a landmine waiting to be stepped on.
> 
> We should not be changing the sb->s_uuid of filesysetms dynamically.
> The VFS does not guarantee in any way that it is safe to change the
> sb->s_uuid (i.e. no locking, no change notifications, no udev
> events, etc). Various subsystems - both in the kernel and in
> userspace - use the sb->s_uuid as a canonical and/or persistent
> filesystem/device identifier and are unprepared to have it change
> while the filesystem is mounted and active.
> 
> I commented on this from an XFS perspective here when it was
> proposed to copy this ext4 mis-feature in XFS:
> 
> https://lore.kernel.org/linux-xfs/20230314062847.GQ360264@dread.disaster.area/
> 
> Further to this, I also suspect that changing uuids online will
> cause issues with userspace caching of fs uuids (e.g. libblkid and
> anything that uses it) and information that uses uuids to identify
> the filesystem that are set up at mount time (/dev/disk/by-uuid/
> links, etc) by kernel events sent to userspace helpers...
> 
> IMO, we shouldn't even be considering dynamic sb->s_uuid changes
> without first working through the full system impacts of having
> persistent userspace-visible filesystem identifiers change
> dynamically...

Oh!   FYI, we've started using the ability to change the UUID for IMA
testing.  IMA policy rules can be defined in terms of the UUID without
impacting the existing policy rules.  Changing the UUID can be used to
enable different tests without interferring with existing policy rules.

Mimi

