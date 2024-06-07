Return-Path: <linux-fsdevel+bounces-21218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367E900729
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AB61C22C13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CFC19E7E1;
	Fri,  7 Jun 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TCdlz9KN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W+MKJq5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C07B19CD13;
	Fri,  7 Jun 2024 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771253; cv=fail; b=EOCnKx7woNp4hgJ0ML9oDhLKwMnH5AnTQReYf+QSi+NhOO3ic1qNqyhvfqIDG6c2cUsexmlfTV9JCETsSV5Ag3ANMU/oF02HHioI5K3Xix+sgD0FtiF/yTRBbZ7rVt1v7OwYNEGhWFbg/vVS6IHf4mYPsvI4wDVBcGW172SbQC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771253; c=relaxed/simple;
	bh=lI4IakodFeDyKVGgRiu0t/W+URDX20Vh631xFihAl/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CbEhVW37PMBVmypqWQKQcS0cIA0vIzbvTfTzPwJVjiGpgjVmqnzjTze1tn0bMHts3B+aKBDv5U+m+3QxbM20JQPV5g9dBj8oookuPGq3QEh2wxcdVlSHzGu/7b1zb7X0Qj3vOITXJ/qOnv1YM4B0Mq6TaNBrdafHtUJr43Eii/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TCdlz9KN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W+MKJq5g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cumce021527;
	Fri, 7 Jun 2024 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=;
 b=TCdlz9KN9697MI3ZHb5oxJVbupdqU1eqJVQiu77HTPiY/a/BGYfEFYFipCo5WUTwoih2
 HvOQ+KvW8pVMeP2YgM7EqSVjsiLHUyTH9b8ELzeTacme8+Dxkn1gfVVVASc8kq+JY8+A
 NwRgVqv7O3CfqRyMKtpq31dLLJyWXQfbX3BtThWx6qYSErzgJaQir0iBnYoo3r48z1uy
 c7wEIWCVNz5/e7GSM114diEk4n1atoSfUuvKC0VPVogR4JYh6MMv0mwt8SHzV9vATpLU
 NBgBT0xDOCQRtpNTza/927LP6L4rfUIY+YVfRwnPRfu5bh/VCT5M/4/C+fLVdg+L5MuC tA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhdufp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DKjrA005462;
	Fri, 7 Jun 2024 14:40:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmhy8uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYKRQcoHkAxSqbVWzAWPaARpXWW34Il8juiUcGy8aGIg+b5F40IQfmKtzxk6BxE/dvfEzfSNAcI9FKPLcV4j8u/EDbzAh+iKlUZyI0BP/u4O86FBvA3/ZTEG0KJXEaoG0nQD6ZnUDwRIL1XP9yhIigpG+Ls1CbYL2MH4zZUBYGBE4Mue2IdHUvz5lmoK6BMx6j/zaCPv9VsqvcP76pF1R7L+LsxdiAdajkAaiwaZiriRjvsPJ06SksdPuV+d9lMwwb9kMEyUWG0eO6+BhkqpauJTpQ93V24B8PhXkXlxSKLIWzDF3LEylYWw3ktWMZ/8BJzQlY/pJOlX6XfEfzQVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=;
 b=jtHOZaSHe3dtOIY49fzr0eGFZH9ZZZ5GILIwqm66jw/U/fjCK1YlG8+5BXd2r1T+tc3rgEZhD5hE6xsXj4rOG9tmGaeCNrZlrHV3MMz9czHfMJGUgcqaalHV2p+sPLmZBEDlI3/nYh16SZZKxgEX/pfdQm+zjDxmUEGERSQ3J7lJFDEmhsk5yJTYFORpSTH/nD7q0kdWWFQBn7iL1vng4GXTOijIZ/02Pn6uABkXA/CxQbbui327XUgIR1bgfJTFI0QfNCcIXJVOr7a+6SppcLqFo7XBwL8b0M4zKiyFGdvPKh++AW4qLb/e57USyC7NMWyEkkEKijVHYJq/LMTWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ3p+Ord99NfXwVLwgo3Vy8ye4VJDJivF4HSz5ncL9g=;
 b=W+MKJq5gvfojgB/H52kY/Mpk8QvsOugHVBU81e3Iea3UDx0wYZNFH3aAET+ZTTqSxFm/8eZbFMfTuKXUyVJG+UcQEqKwFQ5YwcR4h8V/hJ5p5ZqK3l9faJaS1Ky/frlhY07+Q7g6ryVttWTkHPXDKgCBaJkL2rYAHdKMIKvkg+Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 11/22] xfs: Do not free EOF blocks for forcealign
Date: Fri,  7 Jun 2024 14:39:08 +0000
Message-Id: <20240607143919.2622319-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: ee39a410-1092-4856-c43e-08dc86ffc1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QHFV2YRlK4CwhS9/+DlcHCLTptOdOPnYUJQ9qgXze+feF53z6lNxcpvpVxbA?=
 =?us-ascii?Q?lBiZ465uDjTqzDPlXDLW7MPmzeuHGxlcpL3ckeTbMbEn2C+pbdn9CGMkVs1Z?=
 =?us-ascii?Q?wP95ock+weo0Y2L8zLG6tjLQttqhAmT0w7LUzyA+pq5tFOgsKfQVTUaKY8nV?=
 =?us-ascii?Q?VksHTH2ukvbxJgikN5WLM/ltB5qvjxqNOIH9YgukAXFWCTqAECPAEDzL18EQ?=
 =?us-ascii?Q?vXGJsxIz3YW2xi29pTrr7k7fZFThUNKjv1wg/qRRZT1qvUfTKm5+j0b7PWdh?=
 =?us-ascii?Q?T3cUqsOnh+Z8+Tgp8KxW5ayJuP53QvgASugEUK0R816ILIBRh0SGTBbBIURY?=
 =?us-ascii?Q?KZlCQRlTrkuQDdUPscF2BcfZ+JWBbRgM0AbrxDBtVPpH2xbaxm1KuuU8SzX1?=
 =?us-ascii?Q?jhwiGpQo0af+RXtf3jsF0qReBPlac/NvRp5FmHiiqUNleaP8YIq8IZXEwtWU?=
 =?us-ascii?Q?+qWZDySNtstqbnK7a3dk9RfHxwtLXSQO14kg8/1mfcATOwliGnef90X/IcK/?=
 =?us-ascii?Q?dIKkhld+FoHAeR5ZcWrSupnhvCHszpuXKjziINZftvc9+VxTq19VTjEBo05W?=
 =?us-ascii?Q?5ro6smx8aIZZrpLGqWVvfd3XA4WlQUSCoA7J4JIOHocs+tDzu2/Si+edEojv?=
 =?us-ascii?Q?Hh7w/BhelPZybFCqzh5M7DGvu9RRUVL1GlNfEq+x4RSgwDilEN7QZyRmU+AL?=
 =?us-ascii?Q?PiHrJczaDX213rtRDxh64lOVYTQloSDU2BbSsSx4oN7o7ay8LlGrFXuSBdK4?=
 =?us-ascii?Q?DRLbLUd5kmETKzaTkvud2X77pHEz4ZqswqM2m0jotPKkJSjoynpa4Hq8a4+A?=
 =?us-ascii?Q?SEXdRGPfPZ8DwJ4voDzyt0GTGuSSh5l4ucwkSEYOkRRWp6nvAcYTUCVxxDh1?=
 =?us-ascii?Q?lZ/0dSPkkfYLBKIC5rK+FhJo0WJ7s8yacAQlNMJgrVq7K+e3jRZZVgfzZDHj?=
 =?us-ascii?Q?Qp0KWMUd5I4rTMNe6HT/feb6bZhiUFuOIv8fftw8tsBCYHz/ZWNca0O0t89a?=
 =?us-ascii?Q?FUEcoJlkqjDVeMrP3/uiEBrckF65jdpH5W69louRmMqbNaRYLNuna3w1oWtZ?=
 =?us-ascii?Q?mPoLkQeIR3XAM3etRTrK45q8sA3dmuEtO08zTRzOj6U3UC38ZOMmuXWOJj+B?=
 =?us-ascii?Q?Be3imgHOJuA4byhe6rymE6PSeqP8yjZRhmELbzQxD7sZ5eZYP6YE+Cv/jKSY?=
 =?us-ascii?Q?paELX4FuLQN6NK/4/XAnQSxD01WIZ7NstMVqesOi8QLcf9QSr1FxWR7npeuc?=
 =?us-ascii?Q?l2wYC6ra7vc9bUEAYMVCsLs4B6SxnL4ZoYZiJL1FMDhoXtfTLr1e/zY18QCj?=
 =?us-ascii?Q?8lEka1SaSBige1iNHZd5JPx+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OMq45TF+kxSVUCO6JJK7YluL8uQzFg4BqQylrcXO8tMmavvxJs4PSJY/pGDB?=
 =?us-ascii?Q?4bUnJxbzBDpy1ohtw/8ogDZp5nWnB5//QnyoDY0XhVLAaGcCb/CTVTvsGO3U?=
 =?us-ascii?Q?igDbu2qGYvsQ7rggi+scJaTpVXb3LqGazvwBiXyhztHK6+fVOfCEEXN5NM1o?=
 =?us-ascii?Q?zBqLzahLNQKKJ4eahLqqwBlU1za1Gsehuqs3mQ3d9YZ7urK8vp8EtSD1/SSj?=
 =?us-ascii?Q?xzIbxNNJJ2jed8NGw19ZRWwmV/HXYEfo3vhWt2yDumiWAgfpNbua462yHOiy?=
 =?us-ascii?Q?+gtwMR+85E+1Ru2+A6sK5rYPf/xjl5PYJyenaJQnQ+W9f4Pu2T0ImdYzZFdj?=
 =?us-ascii?Q?PvPtE19bTsdeh/qvoi86kichEXl4Hzdt344p2LGJRjVkNwsRbDbNXwd3uNkb?=
 =?us-ascii?Q?L3ZunX+N3eUCxNAZ/vXtI3Ah3+tacb8LXycnswtOf3WnW9Ybsipryw/MDIay?=
 =?us-ascii?Q?j7KeEIBVLAPiFafFptXDpMk1ell5q1hNZEQRP51DI4nDK+IAX5YDWR4L3Ifg?=
 =?us-ascii?Q?YhAcrwl04+Ta2b3Y5odoKrMpV8OXjHwp8+h0d+4aUzmlu3Vtgd8mYHCnophP?=
 =?us-ascii?Q?XgrHIhgwZ2lmqZqle+W6oLEq/BxPpPWuyCmALXoNv6i2J7XXyw9bpTpR5czx?=
 =?us-ascii?Q?a5fKlt3srtjDz8+VRGwAoRprgjR6svdne9hFkHjrkiey+TEvJGqqu+C1JHU5?=
 =?us-ascii?Q?P/GIVxX3e6/q64aLrxplyA2d+7B12eZrGIKrSWqp7DAcVZMxo9ACgcfyl4sA?=
 =?us-ascii?Q?U60AWlZP6g4UhYMSp3VTRuEVBte/olDGHOhLGEzfU3i+sPErwRQDfJlg1joN?=
 =?us-ascii?Q?ae7B1FUdAJHShJUQjzpUi5BqVIc9IbQK/dann54amvOQKbEL8oakjyQmO/zA?=
 =?us-ascii?Q?fz+qTEDASMTA6KHdzvjUltDRQi9wa75W1vr62ajDKgOp+ies8Urx9jvY7KVV?=
 =?us-ascii?Q?mshj8fQ8hux0iTZA7P4RCt2Ada+9l9IOsyvCdQZzsJslFN5by7VAtXQWtvl7?=
 =?us-ascii?Q?NUqOCMguao7z5ZFRaqE1kY8ungLi8DQq0NQqTGLZcrGqUJnqPluHB0VnbqrH?=
 =?us-ascii?Q?X1a+BrYQQ3hw5b7HwhxeXtfQ86jjR6WwxQ7RtcPer5h+daB1KYWB0WBKEQbI?=
 =?us-ascii?Q?wv+1G4bJgPLU3uYlZE9zUTGWZD/20IPAvuvC5dBz2ezQnepBFfWhV3Coea56?=
 =?us-ascii?Q?DVDKY9+BU4Wb3bdLwXQ3n38IcO3TAXsQHgNgvCC194uDPmWURX8pECPSHefJ?=
 =?us-ascii?Q?Fon+EEMTyLRVuJxPEl9DY2ghadgHqiKAGgfV4Cf6LwFg2Ut+XPMeFDLDBM+Z?=
 =?us-ascii?Q?MwjQaY6lqGS7QsgYOv7/MsWDDbG3Cvy5qKAdUF+OHrb7h1fIAMqbZjaP35E7?=
 =?us-ascii?Q?EJqrp96mVBhDlFBh4+c6rWeM9VuZKcn+fBWZ26Ivv11A/5xco4kTHjUdEaXW?=
 =?us-ascii?Q?xt5s9SgPm7gjB3AO9pocHu4xlt/ojlCrZ3UM+YlsyTg8dwViXdHVpFxmrpin?=
 =?us-ascii?Q?2flGh6Ro9YCt0+PPyHsmog8qBIvrcNNAuaE322qnHSWFlaEtFX+zhPqSx8PT?=
 =?us-ascii?Q?ICaBEF8uDkiRpzx6dSgx939qxgPsC//8JTkClxkgAgdO2qs08myJcsPrg+HR?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NvZQZMBwMUrwtvJ3atdoarw7SZZhW0+Ye8ux9yEMDJd9AxYjYL9bpXZ6ThJxd4wb8dFhQNxfg2Bpb4hewTFQmAf4eZy4WSkanoddFvBsB5Aiu4P/DS5fRYRxGozJ1OmayXoDO/XafiNyfVTYV4ojHT7q/ESTDRR8eCYW949J1YAhT6vDKuFdy+zf6dKXyC1eZneMiQsSjRofKmCSXFas+YaGKIWGMQ/v522tK0d4s/zs6JW2RSIeflJNx+UKpe+BRYUMw59TyrmJ2e3BqhE3C/aYaF6NX/zzB/EBhS8I5ASUNe5f0JDWyluGXmTAl+pBmMO7344pW5yMvrS4T4wDmgvyN3sSDTg4WnOzqSWsogLcUYOdhcartd50pXJaIkegYJq9GtfYxO6ZJUjtoMgJEFswbV7cOtPtNLXkJCykqbsZsrLH2MsM5xjVUKQSatCOszdtli3JO0QOGRvKK4+BdN4NgD/GvOczXvQl/z6W/X8fIa7YbJh1Etfg68Q/RcTBsRzDjMLgPQVsc/avlpLtvb1bu6Zu7ukCA6u4vwjvWY1uwkqFLWRs4DXCNjjZ7ozGiob1n1TEoYBVn4v+kVgcbPXJYkfY6LMRSCitP9+CWto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39a410-1092-4856-c43e-08dc86ffc1d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:20.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3iPd/vzUE0jA9i5oPZveNHHZzTGj3Z50Z4cpQZh42ozvIiDx68JZzQdNy5SrWpCVgy0V1FlDNHDaE12r3eieQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-GUID: S9hC3M6yPnCJjonet6R7BsEgjhoUBiir
X-Proofpoint-ORIG-GUID: S9hC3M6yPnCJjonet6R7BsEgjhoUBiir

For when forcealign is enabled, we want the EOF to be aligned as well, so
do not free EOF blocks.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index e5d893f93522..56b80a7c0992 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -539,8 +539,13 @@ xfs_can_free_eofblocks(
 	 * forever.
 	 */
 	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
-	if (xfs_inode_has_bigrtalloc(ip))
+
+	/* Do not free blocks when forcing extent sizes */
+	if (xfs_inode_has_forcealign(ip))
+		end_fsb = roundup_64(end_fsb, ip->i_extsize);
+	else if (xfs_inode_has_bigrtalloc(ip))
 		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
+
 	last_fsb = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
 	if (last_fsb <= end_fsb)
 		return false;
-- 
2.31.1


