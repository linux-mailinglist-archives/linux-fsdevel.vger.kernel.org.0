Return-Path: <linux-fsdevel+bounces-24843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C70945607
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDFB1C2310E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA5175AE;
	Fri,  2 Aug 2024 01:39:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF079134AB;
	Fri,  2 Aug 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562786; cv=none; b=Xaeh2rsF24cStm+74mvy318/9y8Q49mtJEveUSKpE5rqYrhCP+WN+RmZvL6QnXoukph380Gfu4PXHX7vOjQk9zDtVD5oh+gKCpNI7DoyDZgr5VTxOuLD+YnspdA1VMOLLSlhnpfwr724meYh5bvs967Kuw8za5liBsPiS2ruzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562786; c=relaxed/simple;
	bh=qLxp/e4geSzSXoWLwJ22yq+h1HK+xkGEd4vJuM3xOzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUgXw14l7iMdx/Q+YeQ1hzDMX2vZD3Fn4DQGeAnuiXMOTu6edokPxL7KiOkGWJYr6y9t1NQCspZYynnQcuJPwcL3I5O41ale2UlBJLZvr7zPV7OyndIFHb2PPaZkRQI6xrcNLZsYYdfIHzGE5tFu3lnCqDP+pY/+OZ4Bi4mcZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4721bcDM002962;
	Fri, 2 Aug 2024 01:39:23 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf2r4v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 01:39:23 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 1 Aug 2024 18:39:21 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 1 Aug 2024 18:39:19 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <jack@suse.cz>
CC: <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V2] squashfs: Add length check in squashfs_symlink_read_folio
Date: Fri, 2 Aug 2024 09:39:18 +0800
Message-ID: <20240802013918.811227-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801153042.prhbovbuys4zmprv@quack3>
References: <20240801153042.prhbovbuys4zmprv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wS2A7I-Rojq4P1Qa_KSDPeYUIBwkHId1
X-Proofpoint-GUID: wS2A7I-Rojq4P1Qa_KSDPeYUIBwkHId1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_23,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2408020010

On Thu, 1 Aug 2024 17:30:42 +0200, Jan Kara wrote:
> > syzbot report KMSAN: uninit-value in pick_link, the root cause is that
> > squashfs_symlink_read_folio did not check the length, resulting in folio
> > not being initialized and did not return the corresponding error code.
> > 
> > The incorrect value of length is due to the incorrect value of inode->i_size.
> > 
> > Reported-and-tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > ---
> >  fs/squashfs/symlink.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
> > index 6ef735bd841a..d5fa5165ddd6 100644
> > --- a/fs/squashfs/symlink.c
> > +++ b/fs/squashfs/symlink.c
> > @@ -61,6 +61,12 @@ static int squashfs_symlink_read_folio(struct file *file, struct folio *folio)
> >  		}
> >  	}
> >  
> > +	if (length < 0) {
> 
> OK, so this would mean that (int)inode->i_size is a negative number.
> Possible. Perhaps we should rather better validate i_size of symlinks in
> squashfs_read_inode()? Otherwise it would be a whack-a-mole game of
> catching places that get confused by bogus i_size...
This move is tough enough, start from where i_size is initialized.
I will send a v3 patch for it.

--
Lizhi

