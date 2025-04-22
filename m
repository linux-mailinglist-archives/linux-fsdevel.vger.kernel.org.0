Return-Path: <linux-fsdevel+bounces-46938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE91CA969F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5719A3AC15E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D2B27FD73;
	Tue, 22 Apr 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OmBKxps/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xam5W1zh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEF71AB531;
	Tue, 22 Apr 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324990; cv=fail; b=FdDRU1rPgfp9wxmOE2QdfpyQox+TH59E6UL31qaXmt1w72f1JneJ2hC4sADZBbHjxQeO9RHOtQ4CHszQ6e6sY91jlWmVAA6eleg0VItA/8ALRSqHPdg3T5aOCrVIUWdw1MCyoPVL6y/mcsWcAQkverdNLxMRZgfITu4kmgsIhzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324990; c=relaxed/simple;
	bh=moBFMDnRa7v/eTz0RLb62ulSWo2wPzxkNIbypv0rLEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4J3WTRdjajnYKOU19LNxt3UH+SJkwylz8hA65Hq8utljAwRm9QaPaWP5zJjV7B65dnyMJinRXX0pMO1qbR4klsvfNAeqHiLYdaK7s6BXE0OuxyVSB8FXyZVLChSwHNEbfqbuAjRKi79Xe90aM3PK9gIJZqQdxr+doEN5yUwDYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OmBKxps/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xam5W1zh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3GqA008344;
	Tue, 22 Apr 2025 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=gUdTYbS53G/JglyD7pykL5+aR4OzZqW2GZp0qm82jC0=; b=
	OmBKxps/qJJwkXXaV/4JXmSjjfPeAuPTPDULBb+f4IVEHhKMIL6LV9kfHZM26woC
	t3H4mcbJ07cesbfVHeqOHGvylrdwfUiHHOJKaIaKgqMGXfKmYBpkBhMF73GSRxxH
	QQ8cyG709l1WMqU0aii4rNbfZ1yWr7Rla8O4dJ/0lgFtCjLjXIuRuGvlp5Tg72uV
	ZOoFvgnFSzR3yJS9B1vsIK9gii5+Nq86w3Zj2rFt/qulhNue8rZiOLOe466GJ1N4
	CoyC0U033WTeU3DCClkJK+HiMDwkJpOsAsgdlAZ1qsqown9wyXuDp7KRexNh5sgQ
	wqy00sLIj1UvDuqXi9Imfg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cdea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBOta4033464;
	Tue, 22 Apr 2025 12:28:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013063.outbound.protection.outlook.com [40.93.20.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rtr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZREb7gmbPmODD7tAHya7RbOPxzqEIfWEpT3jPilqXj18oxkZwRwWnobhQdKXd5I7kP7Ka3UkcCY9kFMIw7FPzjdZDw4wDntRlyqQN0bkzDNpn9nqHF0WJugOLVCdscjmtXDfHFPklEbFGhResYf/7rMtemGshWFMN/hZXvDWcbHKlTxwIKzv8hyJm3LkEOOg/CgmNJQdCEWu0ygggULTMkkLWc9i4+hTFWs8GojPU2+Bwot60jNxpIyb7Ou2PzGgUjM6xamvcej6huOBPQUUKgEuRcaCW7oHpwhSwTHoCvLSArYtI/9TCAl7voSATFWxO1LI2Qi3Y2Mb0Lk0DRpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUdTYbS53G/JglyD7pykL5+aR4OzZqW2GZp0qm82jC0=;
 b=CC+SXdI7OeFI3ALv1he21qd6lwmZasjujuG3JqKjaKVLsblct52SaL/+TebM2ayUJL/zurwkqVQkOk6stBK0XWLmzCEr++tCDWEOT3ktxvNo+HKOjDwfLmB2pudVHQxg95B1b9s3ToJvOJp4CKpgyzvUCsh20etie3GsSSXGdBP2vBNDMd/ztdXAoNK1Cv8gxulAtyjXH7Ft7g1lMhXgu9IlgS5f42ulPlqv5my21KVT9zrprhSqs9GJbo9kCUgGven9m+s4+55fZLImbAn0++jYi2d1lDJXh6U9aBLD2NAQLwNPMOPqwBDVNuAvWwmGjV0h8nuW7mCR1Qi/WOzjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUdTYbS53G/JglyD7pykL5+aR4OzZqW2GZp0qm82jC0=;
 b=Xam5W1zhVOTYwVU34j+shD11riGm2KmqE/KSaOQZ1YxPcnMgnhKwdZUd/t96RvUGFcVyDdbgS88aeO0ReCIlwYOR3mVuIkH6hlcy9vo48kLpmbZZredaAZSnHT1mg2xb+C1Kl5S/fMlXFvl92JdiOv7/TgkInLIrcS+IgoE7toc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 10/15] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Tue, 22 Apr 2025 12:27:34 +0000
Message-Id: <20250422122739.2230121-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0058.namprd15.prod.outlook.com
 (2603:10b6:208:237::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfba475-b74a-4af9-3779-08dd8199340b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fldRZ80PHz5JgBB8Ow+NE4V/s7gmruf3fyGF1uTSSdD9F3oKZL/TeZC79m9j?=
 =?us-ascii?Q?YUT23w7jCl4yVqwy9csAVtH7f0gKCKoLN1FurtZYKA14nYdmkD833to2eKCc?=
 =?us-ascii?Q?vmr7PVTk5SLz7Qlni3Y11PmxFNtkmjdbILcIJQjUuENQQqBntZrTNvPwF3vg?=
 =?us-ascii?Q?cqzZIjt+dzinK0B/38p9FOAVYoir2zMkMobNFuupwmLD2nkNgxQMj7GoqdAJ?=
 =?us-ascii?Q?+KqDByhIEPTZImmAYJK2Qvgr+VX3fD576ogAWNInksPqZrGDRKRPhlN+85hU?=
 =?us-ascii?Q?f1ZZcB1sMZw7G9+MwHxK9J27TG6fVKVd9IxTL3k/OJcUiruvqSdPgaoeCDF/?=
 =?us-ascii?Q?RwmqBmWExgG8+IveP+YYnHWQl/s6//zzpeW8ftCDqGcGFaOAssprpA1U/5TS?=
 =?us-ascii?Q?VSs18/d+QGp25LaGkEcQVjYiudA7tj1tAWCVDYbsEEHTy/4r5tgQLjwAMk1P?=
 =?us-ascii?Q?06eFJPGrT8Q58U5SKUqdY+KyBIAwRGpfYktdBlhDPOn3PlbGlr2MZYsBM7sA?=
 =?us-ascii?Q?8hFraSv7yNowf/7BH2afHnJVyGNI0ygynkj1jF3r6pUPFL6NxzxUJt/3T4rC?=
 =?us-ascii?Q?Ep+slb/MMOnXiOmRov8YMYJVuBylWzYAWVSGYhJPYtsPngN0DYki7PzwV5Ne?=
 =?us-ascii?Q?oKBV870afIHAAtNmlqM2ipDZ2iF2hXDVHeJub2DTmq0nUdlRcm7rV79FtvTd?=
 =?us-ascii?Q?Fw2jmzgztcFfLcXKZCeXUEMP0dP/4FofphBfuBSKg5Zi+t6w7uNf9bX1EJeI?=
 =?us-ascii?Q?tOd1L4cJfK+L+ETdg1jS6CqXHoZQXfW5wnRFpY8EsQPWRuEUpieBrOrajqu0?=
 =?us-ascii?Q?AFchssHCNfAVeM/TMCBK1U5fkDhuB5zwmuPgd0BEcmHqZLEDEYvQP2uD4pD/?=
 =?us-ascii?Q?UqS6du19iyxLp9djR7qHikOhzUJjwL/MsyvN4xaInhB+B8aENuvoWUw4VzH+?=
 =?us-ascii?Q?bol95XJjIjrrW2cFm4fhHanm240saBhTS9ltcZbfmRGqksDJJFzMDtJGl/gy?=
 =?us-ascii?Q?WdQM07DrMi8gaCJ2z9s4D3F9vvtrqKpEHCAOlEZ+igDvpk3zCM+acUhg5Vdi?=
 =?us-ascii?Q?M1pphelNx1b+ndtD13Ra/DZHzjsHnLktkkFKWHNcsDDxMH7mdbdH1CZom9P1?=
 =?us-ascii?Q?eL1P6H5eRyoAfUrYyiS/djFvSzpHt96nUR3IiKIouXUq32laFLEnf4+mU0O8?=
 =?us-ascii?Q?YvLkwilnVPt9b7espZUyXs1qdPmflGuOsezs83133N8P/pkGU1/FZy9LYKOB?=
 =?us-ascii?Q?hdBsTIUq1y+vl6xlrteEW75pTNJZLd6AkHKEkJ6UgofWMwXlTY9VadeDAQ1F?=
 =?us-ascii?Q?JeZun2/Xm/x9fYKE4MnXhAGMy8dTntDlyF8jsfgP56rZCG2rMutVOTHZSquZ?=
 =?us-ascii?Q?knNtuhRrsADvSIVsf8dERmHXwTWJ1QPjpWtundsnlzUh7Vnem4nsF07Azh88?=
 =?us-ascii?Q?L4vDpZ1VBiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ZYgHrsdudITFRmk7vTQzxlQbyj2zC4tBkhhyMr0xUxGf6iPhmzPlAkWsqCs?=
 =?us-ascii?Q?FYp9dxDkFHIy2RUihwkAQgK2CVA01i1oJunLecea83k//OzNatEJXnBTqzNm?=
 =?us-ascii?Q?hAn+pyOy8qMCLS0/zw8cIDx5mokfBzoQAhpoHel6mydd2zuiaCINHoQJ6Iz9?=
 =?us-ascii?Q?KO8rW1oLL6BVqnjOMZYLn8kguDUs+N3SctUnh5y6yEqcImQxgf5BVGxuZCyV?=
 =?us-ascii?Q?HgemWQx5PeiZPK8BElYs9mvXs8qJLvQJMHTi9d82Lfvzt1Qa93jqkfrJTyvs?=
 =?us-ascii?Q?ieuhhIivkS3vQQCOsQglaoMkBLRTKVyVRK3BMkiPxLcwntyYb+g+FFo9RvI1?=
 =?us-ascii?Q?YxUsR04JLRsUJApq/jr3E5YavvOrY0IxL/jTYUjBlX1cp/VAQIeUCq02velP?=
 =?us-ascii?Q?O9V92GIRQVCNq+wIKvOmipBsGePpV+zErR8WNwdVrbGgaskaInjOm5BzylVv?=
 =?us-ascii?Q?9MAfOkV91XeYYJJUevJmY5mM5k0N80aMudvu2vJ4hDsZG8d8/Ga90U5XF5qD?=
 =?us-ascii?Q?VVrSlYW8Wj3g/QbUV7fnLswRGM2kK0nmUbnwgnjVIMNbvBGUP168HIOejJtg?=
 =?us-ascii?Q?TgR06CchbDCe16awBoBHDPGlWO0wnXi40uSg97dxVh9gOKH2JSea4ZlcqpMw?=
 =?us-ascii?Q?VwneaAfORj5jXZvOGqoTvglGQMCiICpxExVEtu96iU9RpvYM2ksKnvlEm8iI?=
 =?us-ascii?Q?xetFLC5dVVq+4vL6W6BZ9LG+bBd6w72RDDBzPnUo3mH4TojdDhKME+S54Gk3?=
 =?us-ascii?Q?Ho8KwYtx64IAHDpQGUnujLdUHU6TJI7cAXkiVxwOoclAXuMkMA6r/WXZDTV5?=
 =?us-ascii?Q?J/FBBbHmX7NqzXGKZAf3n9v50TQnBre0CQYPtUau2J/pbQP8RlCV+1A13dJw?=
 =?us-ascii?Q?fdDBi5+onQz/lHe3dBixIRftfwEjZyBnMXlXeS3uf6u/9gDfxcd2XwHORH2w?=
 =?us-ascii?Q?rv2jBOBompeQ7vR5b/4k42yi46kyi7SGzlcVEBq0ZL56PX7+92eqMUDuwL5i?=
 =?us-ascii?Q?b111V5hyy/C+0INj79AVInm9mj1y3o+P70ejXPpj/k6l8PBlrmtR4BzdMq3K?=
 =?us-ascii?Q?EaggEypwGeT3zkdEYF28r1/KHPmMXg6DptxUQFy3IMjrTUrfPpiYcr3ILxw8?=
 =?us-ascii?Q?dfmsO+20DRLj1XQqmubi0RzK4s77hOuZdfCvPeff56ZVXV8SQEhqsoVowVr6?=
 =?us-ascii?Q?qYOZKD++rT1VdsPfbuHYhf02lo3x/N3uuWq1hZNNx/sngmuhFU4LqLI3EVMy?=
 =?us-ascii?Q?/N0i5i6GMk1Dr1vD4DvP77/H10PWatBE0TJoDs8n6wtYzTLQPSEkEJ805Z9g?=
 =?us-ascii?Q?7xfjNLgiYmCp2MZh6bV7mPlIkCJ927LxM/DjTBA2BJqh0dTNBoRNvkgfx9MB?=
 =?us-ascii?Q?W0QrMvAygXj1h9lweDlDcimKBIoSEW5CQmnWFO+OkJsXuPa56vTJdyO0Mc2m?=
 =?us-ascii?Q?gerIUCSZgP3tVivkF4RWsDNw32pD+wOWILNaP+q4SP8V0jrTQkrtAswWKhwg?=
 =?us-ascii?Q?nKS27SQev1QRxf4BYG+ji7Hz0+jA1i1I3DD0AwRYpl3DhnHZOsuQhLORl47R?=
 =?us-ascii?Q?3p2X7cH7zWjF+yBWHph9qVISrpEOJzGxufkGYBZ6tx7En9m3gcPzRLiN8ovF?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ysQcagKJJuIn9HFodbXOSbKL3qxEe4UBhpg/zHDAsz6lRdAyQ38zg7PixP6zrDsMsLuiVDW2+vZgLJnqjPyXyA7wbiO99/Hw9hs0/MYeNnxOcQ+wRCXMTvnfPKJJJt78Znds9rIvVAv6Xyhn4+6967JMtRr32koHbJOJEwjHU8mE2xYO+SGZ2RGfN+2ablG8EZ+WBHJWMpjvGzlOW/NBalfiDvmE0bRDeBGWj4wi2dXiDVGonEYpTD6UOMIzE9LBvIoOapbOpU4QtVkLFm3fnokxy4fwDm3tB3b10Ie5StPo8tbYuqOBVNhg01i+QnQyqayz5rcX10KfNeOvyy/az4D76ztuK7DiXABZJ0BinjPp/kgbCa4BYBbIFJD274PxpNOOzdoVzLqX2Ky0ZJnHZU3oQfKtsJLJf7t6SB7R0gNKQdXAW9w6AvtqhHP22nEkh2FBnFKAxfpNdd/vToaCgDKeOU90+eFZ31FGgL7Xw+j0wIMZ5taPv3HGzQ5JaIZDVmJSepI3t8u0VElKyaYM94GTI0BlXQn1FpgjE8AO27eGQOZN40QOK7CWQ+lQUbQGR71pnJc5dIKF7UNTiDWS+AGSjpnCmjJ62Ut5fl23YNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfba475-b74a-4af9-3779-08dd8199340b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:36.0895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHXfNV7M+KJmvjv173JRt15fkM4oPtbi2c8+futLguk5MYG3XcXlWf7jc4wvJYVIdR4Ib9+q1kF9kJgz5H0hjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: BB2MaS1IwRL7WZsX6TKJK9VGdISTZS9f
X-Proofpoint-ORIG-GUID: BB2MaS1IwRL7WZsX6TKJK9VGdISTZS9f

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: don't allow too-small hw atomic writes either]
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 049655ebc3f7..150354e5b436 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,41 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	if (len > xfs_inode_hw_atomicwrite_max(ip))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +847,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +912,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


