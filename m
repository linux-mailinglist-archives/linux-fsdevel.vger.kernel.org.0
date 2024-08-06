Return-Path: <linux-fsdevel+bounces-25060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACB19487B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 04:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E802E284A32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982812B94;
	Tue,  6 Aug 2024 02:56:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ABB15C3;
	Tue,  6 Aug 2024 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913007; cv=none; b=a/W3sNx5Zmudc9RDeXBcmlqDsFxxhcPFnrVACtWNngWRRiVM06De7aYiQmr7JkX1ZqCyfuMtmqaDSKikOPzS6crIe7McAaA2Tj5kuyD14lEzPmpVl0tUAyKnnyipsWXfFyeHOKr5PXsJSN+x9cXUFhohegtBy3BQfFHNKTR1IqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913007; c=relaxed/simple;
	bh=WnzIt4xgMpmIr6XtIYlTesUmiir3EEMcACRHoJFSDUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SExS4A/YDrjjU73XF3ZFjJ/C6ZJ6ny1BYDxY0X+EDH0q/zMUw8TlmL0zONywqqctGSQIEep6eop8sQyNVHwk4X0Igy3k9FCWFMhLFQ/2koTjk+wCcbU2XL8O/qvpCY3KUSXgFX0t8eqK+6+4689YFrQYbLArCjz9/sQkTJrGN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4762gJEs017586;
	Mon, 5 Aug 2024 19:56:13 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40sm2h226c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 05 Aug 2024 19:56:13 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 5 Aug 2024 19:56:12 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 5 Aug 2024 19:56:10 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V7] squashfs: Add symlink size check in squash_read_inode
Date: Tue, 6 Aug 2024 10:56:09 +0800
Message-ID: <20240806025609.1193466-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805014037.GF5334@ZenIV>
References: <20240805014037.GF5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bT_MhT4XJzJqjZM-RPTquVgxi8Y4jMMo
X-Proofpoint-GUID: bT_MhT4XJzJqjZM-RPTquVgxi8Y4jMMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=674
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408060020

On Mon, 5 Aug 2024 02:40:37 +0100, Al Viro wrote:
> > It is int overflow, not others.
> 
> Excuse me, what?
> 
> > Please see my V7 patch,
> > Link: https://lore.kernel.org/all/20240803074349.3599957-1-lizhi.xu@windriver.com/
> 
> I have seen your patch.  Integer overflow has nothing to do with
> the problem here.
No, the fix to this issue is due to the length overflow of int type caused
by the i_size of loff_t type (in the function squashfs_symlink_read_folio).
> 
> Please, show me an unsigned int value N such that
> 
> _Bool mismatch(unsigned int N)
> {
> 	u32 v32 = N;
> 	loff_t v64 = N;
> 
> 	return (v32 > PAGE_SIZE) != (v64 > PAGE_SIZE);
> }
This always return 0, why are you asking this?
> 
> would yield true if passed that value as an argument.
> 
> Note that assignment of le32_to_cpu() result to inode->i_size
> does conversion from unsigned 32bit integer type to a signed 64bit
> integer type.  Since the range of the former fits into the range of the
> latter, conversion preserves value.  In other words, possible values
> of inode->i_size after such assignment are from 0 to (loff_t)0xfffffff
> and (inode->i_size > PAGE_SIZE) is true in exactly the same cases when
> (symlink_size > PAGE_SIZE) is true with your patch.
> 
> Again, on all architectures inode->i_size is capable of representing
> all values in range 0..4G-1 (for rather obvious reasons - we want the
> kernel to be able to work with files larger than 4Gb).  There is
> no wraparound of any kind on that assignment.
The type of loff_t is long long, so its values range is not 0..4G-1.

--
Lizhi

