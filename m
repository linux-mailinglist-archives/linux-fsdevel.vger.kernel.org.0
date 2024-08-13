Return-Path: <linux-fsdevel+bounces-25805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D580D950A6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5943B1F26A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9E1A38CB;
	Tue, 13 Aug 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZt4bXWp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BHOcfzaE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382061A0B10;
	Tue, 13 Aug 2024 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567072; cv=fail; b=QRUyUeH+5gj33bg7ynbSksZMGZycLKPBUVDOEeEL7ViPlAAYV/Xy1LbuHhiyXvz6eUoVUFfcUkDBsISxX8tHTmayfk524WTuvijHCB4wCEVxs7gLiJXtNeXU2wewxpL5CA1KNYWvB5x7OgEB7Em0Dx8VdnDOpRanAXzJ784HERk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567072; c=relaxed/simple;
	bh=tvOBFkmA1FSH3Iqg041Q7GR9lW9fWCOBVWJ/k/fN5KY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBvp6pP7tbfWLXOVVT0Z74aMgZ2DwLEkUkDZUb+Hk281ofGQgFdYTfWmqkW0VKgiA04Znk8shxBhdZnuMcWzxYICO+gvfdqxs3BpzhtNhlE3CtNC0xWPca1bQ3EnmfAXJ0WmOUVlBvVnKgTOHxiLFTf3NlUHWhmeAyo+PNRFxrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZt4bXWp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BHOcfzaE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBTvX009742;
	Tue, 13 Aug 2024 16:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=BCdyY/Ypi+YgB3nH62tJoJ8Jwr+RIHWi8YBMqdImZ+4=; b=
	lZt4bXWpV0sSRAYqjkPcXDFlv40p/0YlajaSM8Qe44PhKUnOL8WGd75GHIN3n8Qh
	C9HHa97SvLP7LmQ7Uog5ni1hiZJ0AU/6ONSSFnRl3A5PZyXwh8i9FsZoPCzK99+m
	RTZhY0dcVBaua7TAG18SH8M3qx7yFhGfNzLumgPfO9CE8wDj3Rpma/5eVFmcB72W
	anBP0tjpflrHhLMPiHgtB87fQ8+rj52hJVccHn+Clz1lOOsJH8Ait4nGhSDqJHQ0
	jxRWQvwBW5KyiusuAsWMUQI79quLCf2kfEFTMAb5TZ/fsdTFKEpcdpvsXcfWWOjf
	278rvNqhRaZ84niXN4SHqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wy02xg3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGH99G001485;
	Tue, 13 Aug 2024 16:37:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8qkvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goXWhKKv+iNjheg/a+RwslB2hywPmm4iMD8teYkHszS9LdQ88nptJbrQDylMmknL4fYyDxBkYGplt1u3gtmQnRbwLar4HfKFMca3AoJrXEARoOrlwYu141L2kZFgqeaCN3VAyi/Qi5zAHxYTsjDXSDh7ffZBOuhCJNaue9aeN/WZHn4ya0KA5V+G58obiPElsUo+6o2BE2ihTavwTLolTLmNn8UoVLerPpWRfnBaLxj42UzAtfKE1xqS6lVNvZ+Cjv7ywXUkCk8sDd1Xe9ewQbYLopzzsAwn/sHZ2o8u2QuhUT+BkpnvkcTcWAE0/iAadmJV6Ge+rV0RGHCrgBJyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCdyY/Ypi+YgB3nH62tJoJ8Jwr+RIHWi8YBMqdImZ+4=;
 b=QtOCvpUSHDD7y69pJ4HWJ1tAOH/wWx1QRI7oqFb3DDjhr5SsSi70PZvycWw3VfNHTXbWFbF7kTPDRvtylhQdgszqKqy88Zqh25Il4RfXrsFu5pPrlTvjQBjSfLA6oTFokAj+k4xSkVhHJRwlle478Cjk7ropIe6/IOIpsXf6W4ubhLK7kn93ivV/aMbZdP2EXqJTBaUpuRIGENe8MrrP3igiki5BAlfA8pXrnFg5iAAvw4L5FnGu9CfQz8NbIPs0jQF0OzBGegO/HlzvBCZ63ZATPLVAavni9PJuuNyo61Tm39bZcZBVEDkrHFPTPUdT78hn6EXNmz8+Jc+i3xyqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCdyY/Ypi+YgB3nH62tJoJ8Jwr+RIHWi8YBMqdImZ+4=;
 b=BHOcfzaEJC1C1wAmEHWJags5v9AI6aIJxyft41Qxqp9pvHuQt1A6LlgBu1cB1321lq6OJySdTl42pVXGAi4mmU5YayjYZa2lO6KeCRcxWOcrdDrZpCNNu/zN/cLMNqGS7SErfPPXvop9nE6iM413UH0mG4SN8vS7Tst1zmjjC6Q=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:27 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 11/14] xfs: Only free full extents for forcealign
Date: Tue, 13 Aug 2024 16:36:35 +0000
Message-Id: <20240813163638.3751939-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1ba627-714c-4d72-bb2c-08dcbbb637fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+tyW6xUKTQHu5TdZSAIEu3/5deFhLwiOmfjyLs1njC4+Xn6MQb5UTTxyMy/?=
 =?us-ascii?Q?lkF7bhDU0ApVCUthqVaAumwKguo6ZcIhNaq40fxDL6IU9Rj/Z+63WCCQkjRu?=
 =?us-ascii?Q?OQcXZRjnNeORfzfYeBBKJIRm8vbZZ9JbQtqjm3MkChzgFMPrF7M3Yvego5Vh?=
 =?us-ascii?Q?S/ewdZdOhRFzZq81oZ95a5TfGnKmB5UUriQaYdj3Ab2Nu7P52YrmpljQV6aG?=
 =?us-ascii?Q?7YUFz7sFi30QuJZVPmkCNr0Tp/sTCDFbx0cZDAu7qtjqjb95F8SuGiWJtIvm?=
 =?us-ascii?Q?Ru7C3b3sVVKqLGfKT79Y4fcWxZjwuLcBzYjE71su+NBqazwh6qUkHfeZ2Ptp?=
 =?us-ascii?Q?ahtb16RL94uAJmUBaB457O2SQ6kPEbRC4W6SGiv/E36N87ddtjYVDHJ8rQS6?=
 =?us-ascii?Q?V9fOkV8ofNGIf8PFpWDgPcvT89zmMesWbGu5j+Qs0Zcy9bAC3damX9RlyVNS?=
 =?us-ascii?Q?RbK8JiGxkfGqfhIWvIi2zSshVXUYq3EAVHUK5JyG866r3qw7mBZQxTFFPfbE?=
 =?us-ascii?Q?1IFQH/oD4Z7W8gOIaqdwIPBPSbAQY9gM6w3d0NhPf+KjIiN7zKTRDARxMM/8?=
 =?us-ascii?Q?wCjr+WmQp9KELL0RDKGgn1NJfmhqK2+5eQ+9abiwQYu+x4VfDjLYViTliy/y?=
 =?us-ascii?Q?tN1jEzrumcEvfQopV1+gvpFESsquU4P1DRyUZ6I7TbdU54e2N1NfuRVdVP9J?=
 =?us-ascii?Q?MPhmHj5aMc8xPWU+3QSTdqhAebskDLeOEMeoKQ5QgDFX9Ko5asjFReMz+DCP?=
 =?us-ascii?Q?MRLxhqLGUsKnt8J6z3TPuUmvuOsNei5HI7BQJhWkmn0lqq6sm/IKUxtAC4+W?=
 =?us-ascii?Q?ME+QxwFHadboQiY3fxAPOwg31pwgEcF2hbRWOph+vV2/Oe4deNE3Q3M2SjPn?=
 =?us-ascii?Q?rjhpHaXtqwJlnmgn+28SxQ0EjReCG1Hy0Y0AUuiI5gHmMGypvBUFJ+Yb0p57?=
 =?us-ascii?Q?Z8LmSu/7UlNViG4asTcXxmCnr39Kk1dH0DNAd3Z696W4eYQ0yO8xUk/cycs+?=
 =?us-ascii?Q?hluLYeDbvTQHPSnrOiZfAHyBeLsF8Hn5wmTwyVBXjhSMR42lDJiF6e2Gb72p?=
 =?us-ascii?Q?yeTobtAZ75JGLBi1FwCAyqdqlRlihJjU44yawaxohJcsmANO9IPw8n5RBGKn?=
 =?us-ascii?Q?4NoHfrZQk1KMMwakq4PmfUonK5T1i/fYXzLxb7QZ7F91edy7MZg/gAJ1f3QC?=
 =?us-ascii?Q?VBC/6cD8ltwB3IyXxzl6h/SygNcXvA7tgBOIw/s9vsTQ7idfLKPQEbqkiVwd?=
 =?us-ascii?Q?tWUiQ8IohKw0X7KjtUcP5oG3epCIy8thoQWqLdd1WvtXTVgqByI9FAAZEeF/?=
 =?us-ascii?Q?U6JITQp0gULcNzrHAqRYnAIYEdh2vpdmgXzCNN9/TixkLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zW4x8J4s2gcIutNA4jNF+/Pj3vEEL4T0/soKUegja4MB2HwEBlHUq3szwx6q?=
 =?us-ascii?Q?MJa8eK2MmTesBNYU1pQoHhB+gySzFvoCKjeXrGS8dFedMqLVVajH7i36C4//?=
 =?us-ascii?Q?w0jLFZ3lycCNFhbNASmUV45sJU9Ud2LE/Nb8Yw5NTp0a5wOE8CpaODXM6mss?=
 =?us-ascii?Q?tX2omBwdM6pc0OZGo/sYr5xT1i7hnLky3TxZ80RRQz6EO/AVS2YOAoKvpUTa?=
 =?us-ascii?Q?+eqK3Jo5oRIozAJjHwt0BmD/4GhzKAR+Z2jqxWr27iaUnWUAyWQ+J8A7xCRv?=
 =?us-ascii?Q?eK/cO9k08Tgx464AjCx1XjAlFrMhv6k0N6tTi4zFhsjhDzI4BkLQnjbD3AFm?=
 =?us-ascii?Q?K5hVoi+uhb4BvouF6gOadCvftJnq87zVR4Pt0LPeccJVBVloj31SYZpeq8xF?=
 =?us-ascii?Q?HVGsqImcZIev/JR5U3vMzTmH2+wP2jf0cBnO0u/yDfXCH0sMSYn81FT7LjxP?=
 =?us-ascii?Q?BCENAN6RSj4yXw1UK+muF8iOCzm9IpsDfUhEBua/N3aR3AkyE27XlL7KkXio?=
 =?us-ascii?Q?Amvfr8O3QJ9YqVZfhRkcqt8JnUJMdfFsi9F5xJRFWvjcp30C2Y8J1H4tF5Zf?=
 =?us-ascii?Q?GWF+IV5lExevGsA06ZArm925knJDK4mVJUC6Rn3XtHjnmgPm7/KsN9jfUBur?=
 =?us-ascii?Q?zovtKZTvp3WS5xseI8pJJ06zUm7SMquhIMaNVqI7Lfq/AOkoh9r0rkAzkBRF?=
 =?us-ascii?Q?Zl/Xj0ws9pE0j1MXtgmNxAaqX0rjh7eCCg8BxTIzcA3s+NHtOqh6z+YYLXpK?=
 =?us-ascii?Q?D6W9jKp3sAThVcXG9sIE6NDkPQeH5s+p/MStdWTkqNFnLG9LuDmfGrWCSG0g?=
 =?us-ascii?Q?jN/bkNUTq0pze2F38Q9uyS2ZildSfK55dS51pmEntyvlynhbp2EOdsbPwpPg?=
 =?us-ascii?Q?cqZ1AwKg953Ec+w/EVYb+pNw8CGSOHWkUHqE2HTYuicLueHFi4AXZuhrdVD0?=
 =?us-ascii?Q?UfBl0mt5Lz1SJ85hrz2vXA+jmHEpMn42wMv+i/qCfWib4TGGmOtClVOH31G+?=
 =?us-ascii?Q?+Do/bDtL8yz8jI7xvOhvEj+2on9CyUKcuA5DmkApl6wZkTTSGtj9GL/v7rjf?=
 =?us-ascii?Q?QZpsVJ9kAvWJDkmAMYIUi65b+L5NJykLUjL5CvB+MYV2rZvBuSUC2iZVLQEZ?=
 =?us-ascii?Q?dOzPKUMM+His7TR51dV8/ar2N+2OwRQ9TO/wWO1rBeOrzSc0RGXsSm0guyl6?=
 =?us-ascii?Q?dhPWyMsyz9JlAPNc5tHa3FXVcT4zCYqQxPuGCKeABQla4MkVJunT9SseU0sU?=
 =?us-ascii?Q?PdhEL/Ur1ek1FBjZosJnjWq+P5dj6f9Cvurf63YcmOCAZS7IaMaJtm+IMwOv?=
 =?us-ascii?Q?wd3lK3zANZXhXGYt9X5/zVYcCj9xtZKlKkrbpC3dOtgBQv4G7fSONPEeDF5R?=
 =?us-ascii?Q?5fOK+RVf4mzNRzrubOa84wS6+IyjOpvfruI24IowEmTyPrxrhKPXpAVrx87z?=
 =?us-ascii?Q?u6hrwKgdFFDftZ5dp9oLhQSawaxd/har26VKzNO3Eq1iUNxrc035CyLK5OOz?=
 =?us-ascii?Q?4sekwje9StRuDsjckaHiZBJJ551e6FPPkVVtb3xqM9o5i2Gko6Xnf4WvJGrp?=
 =?us-ascii?Q?Fz7RKcMBEFgwhdkSXJEWgA4TwePe9VZThcNyysKZTRCYoffsVpX3rc42Rr7m?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kC4YomEuK/jIvqOIe+YFOruGdcihcJy5weAFbkXNDwMhivvb/jyAzM3YWDK9lBUiwEEN9d/8E47ana9Ykme+jaKZeuIiv5hD0vaf0/wE6Pb0LHCVKpTbzdsbchmOERIaLCJoR2q/BioYDZPx4l++3scUaoQstjLDpUIkwGnyeMkvQs67u+wTNEXvvxuSryeamhE40zk8R4WZMCRn9zX6zbkwknwzLeVVSNjks2uxGLqkj5fh5bfAyZdraXX85wOwV74CFk5lM7iX3N1BIgXRHi+JALSeF1+PjWPg3SeRxJLCguQ6ZRw9tk7L1KAYsrQL0VWrQGx7lYI/gxWcjcM5sNFA2/TY3MLdiP0WqArJt9bcZd4iySJ0QDX1pHYxdHzoDHkrM6VEPkiC473ZyFiy32lYOa2cbcahNmP+qdroy0WMqSr/+XD4FZ5SZzoyeE3+tJlEtEr08y40kX6+JjuXlP1egwdX/xVGdi+Wj+XxKATdk4NnSMHKoWCN1wLRz2By1s7roovHXB0ImkX99HpZwmdUCQJixycsvAa1qwRcAwp4sj/DKwZyA4Xmj7aiENgG43V8id8/RA7tdjn1IalsNsIQprSDpJUYwb4oRtT5fv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1ba627-714c-4d72-bb2c-08dcbbb637fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:27.8823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWvXsJGrOeqJke9UZUXEjObrRxbJ5gsXLATlPhiMA62s/tLuYQVYqAlrOsf9R2L7xxQRovDkdesXJK2k0u56nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130120
X-Proofpoint-GUID: UGQDCkHBaLQftarH04UVEhh15LM50We8
X-Proofpoint-ORIG-GUID: UGQDCkHBaLQftarH04UVEhh15LM50We8

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> #earlier version
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |  8 +++-----
 fs/xfs/xfs_inode.c     | 12 ++++++++++++
 fs/xfs/xfs_inode.h     |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 7a51859eaf84..317ce8947e8d 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -851,11 +851,9 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (xfs_inode_has_bigrtalloc(ip)) {
-		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
-		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
-	}
+	/* Free only complete extents. */
+	startoffset_fsb = xfs_inode_roundup_alloc_unit(ip, startoffset_fsb);
+	endoffset_fsb = xfs_inode_rounddown_alloc_unit(ip, endoffset_fsb);
 
 	/*
 	 * Need to zero the stuff we're not freeing, on disk.
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 94ab3f4d6cef..73562c6f9a1d 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3141,6 +3141,18 @@ xfs_inode_roundup_alloc_unit(
 	return roundup_64(offset, rounding);
 }
 
+xfs_fileoff_t
+xfs_inode_rounddown_alloc_unit(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		offset)
+{
+	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
+
+	if (rounding == 1)
+		return offset;
+	return rounddown_64(offset, rounding);
+}
+
 /* Should we always be using copy on write for file writes? */
 bool
 xfs_is_always_cow_inode(
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 71acddb8061d..336124105c47 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -645,6 +645,8 @@ unsigned int xfs_inode_alloc_fsbsize(struct xfs_inode *ip);
 unsigned int xfs_inode_alloc_unitsize(struct xfs_inode *ip);
 xfs_fileoff_t xfs_inode_roundup_alloc_unit(struct xfs_inode *ip,
 		xfs_fileoff_t offset);
+xfs_fileoff_t xfs_inode_rounddown_alloc_unit(struct xfs_inode *ip,
+		xfs_fileoff_t offset);
 
 int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 		struct xfs_dquot **udqpp, struct xfs_dquot **gdqpp,
-- 
2.31.1


