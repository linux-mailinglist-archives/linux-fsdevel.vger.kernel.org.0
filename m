Return-Path: <linux-fsdevel+bounces-47383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D303A9CE8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BEC7B96A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC921B424F;
	Fri, 25 Apr 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="muVyE9Tx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L6N1Otql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEC1B0402;
	Fri, 25 Apr 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599571; cv=fail; b=th8c0I6ppABPXf+ZiuUNJNle9QlJ32vFRzu4KX7SsPHOFJ2NBVAirAK/8/clTzo4CQlhDIBQfEamfGE7fZYNiQDNmOToWuLqNdQ2xQe6SqaaJ8bIvf3xzXL1qN4VKjm7j10buIKiE4Qul1WnkOnms9OnjWtx/krWiu6ppO/LNGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599571; c=relaxed/simple;
	bh=hbZ5A+/rJ1GllY/adoMMmzki3qhaCgjRFHa3AkqQhFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Og2jmLfL6Da7RHmeS0Hihx4+se7GUi34jJe9KtckXS+OzUvZ1gSZG+CfEu7BPYgMDvNulRAMjFzn+ipIBooJ8GH73CoNPA8vApMGr7RUdwz6C1rLtkO7FwTMY+T7b5vj/DsqR1mSK+12vNJwmmHNe3ttIm25+7jr0scjgLT7nfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=muVyE9Tx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L6N1Otql; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGWFH6005071;
	Fri, 25 Apr 2025 16:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oc/n1Rkb/avUefnyF/hQx8rJgvQ2Vb643pZmNamfzIk=; b=
	muVyE9TxxHLI39E0e4C+x+GxkDw3QnsptLxqxy8Q3wFdNSRfh3rbnkHZVYdq/qwJ
	swa6CKzcX99cIquPq2ipCDpDpyd/T2jvgTL+q286G7VdkzZ+DNQyHTkBNomnI2Uu
	rac2I7q0d7SDaaweiwRibN8o1B92XACqMTMNN/VH+C3beq5wlI7A2nYXCxut0Pam
	yVF+hlQ2jE2rk+zGQIp3pvoN0wxbaKvIl6fNZKWpAVAbL+s3LFa9XrQQ1NKAR0jW
	erIejO9KNxtUh3BUJOtv0S3e8+t2TNA9LRZ5VzbtSpfNCnLJU85IijokBKS3zDcf
	bQWUH5oHdLiHc1z288uXSQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468e0b01sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFgv4C031703;
	Fri, 25 Apr 2025 16:45:54 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsyt11-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IX09rpVTsDUHXJGA9PVpvZXPk9kDIlXR0NWpSbWsCad9DpfO18WUPXz22/c7OJojCQvR8eHokvXVb2ltrdTNsBNsebYbUuYCWj6fosoZHcvpjV7ERv2wXYUtnhC4iOvyBoC6v3Nr9bGS/PmUZ/+2l6H+ka17cRZzOy/m4rz9cvlRu2lVKKYP/f4Dn4HQQ0u0PJTiq7+4sJRVT6b+u/f1Eub4gUUuGRD98rRsWNgE9pDLP7avCRdYV5gyH0s2R+w4lY7FwxKQTcASrIN0XOtJ+8xw0JQFcd9S3B7teSNxhFTVbxjJIgabMEJPRSRR5xwaudF+KylhBrTdm4+bwkg5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc/n1Rkb/avUefnyF/hQx8rJgvQ2Vb643pZmNamfzIk=;
 b=q4WiPiWfKQInOegZqMv4CRvmimQUwya3mJ76REo4dtZ+AsGg3nMqWTqB/otvtkHFC9tmpAxjbkd56GxUVke7Mme9geAE9n6+PwV8AqbGGt1MxX8DAq1QgrzH/Pv1+TGaRpFfa3iGvYtX9hSVm9shH5XyV+dyisuQdfANVfQQfQUKxDO5vgqut0Z/IUIZO8OAo9SdpRrrlR0PUkdqywExJroAT0jBL4N8FpNRZqPngqb1NZpYL8jeNf2gLWH5bMfWLIF0mhMvCSZ9fHOu91ZsBlEugyPoQloMP/wi3BTEuq2pewvAALlavsokR196rnh1Q7MK0PdDFSGLoSzMR0ADPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc/n1Rkb/avUefnyF/hQx8rJgvQ2Vb643pZmNamfzIk=;
 b=L6N1OtqlQqygxmEqwkeCveMUxUu7H8wrGCn1UDyHVgqaFQfnagqvjTocVbmfAEEcJ/RNUj+hsJj4YCL2YyUTMCXuR0jW/cqeSFwjR+Mvz3QJilToV0TVmvH5nLq+ZYr6TP87+QPMlpx7cwx3rSbysessX6A/s2MsXx4AU1zDRuE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 11/15] xfs: commit CoW-based atomic writes atomically
Date: Fri, 25 Apr 2025 16:45:00 +0000
Message-Id: <20250425164504.3263637-12-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: acdca6c4-adb0-4fc4-1e80-08dd8418a3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3BLdwWqFAmu8piq3uUtCbxQd4437aXF2kzau6eqKHsLVN8xGKa67wVnYZA9?=
 =?us-ascii?Q?RcCMZKugDFAu9b7NL9pMZ5+CF+WCC3dZRKJYZHHo/SWCgfPrwmUAoNcJU1SJ?=
 =?us-ascii?Q?EZOgdVctW4zJqxYFNB+0Wf433FPkhHcWKYR+voH8RrK3z7xIVQenyx6KM+OI?=
 =?us-ascii?Q?+WxAZqS0pobQHEhxXMGeHA1MuNkJh20GSJWk7ejt3Vpq/gnV5QQEBm1sm0Aj?=
 =?us-ascii?Q?3Jo/vst6vQeBbvqXWvbMCG9lUfop2eekF4zIzICMvQaOXYCQ4G9nEcVn7y7v?=
 =?us-ascii?Q?wT2Lgm/O4Sdw6H5orgsSE8wBSD9j0P/2LF+FPjQyyb5PUCuMGAuxgltFOoay?=
 =?us-ascii?Q?8TfXoKno6bw7jreqhppuBeBcLCIxO2IoouHRa0Wn1RCNRZ6UrtPG04nj86go?=
 =?us-ascii?Q?oKSY6VqfxKWQcotN5XtKq0cxwbXaNMtFpIQy2ejzCO8NzGgg1Fpqt8qFRiCp?=
 =?us-ascii?Q?x20Kt7QNsAzHbshdEIlf8aK7QbUrMe9tYSa6fPsnNb8KWywCryFFYcN3+YrD?=
 =?us-ascii?Q?vfSAFsUaiF882pU6Pj0cUrpVC9I7Mc5Tub0/IDIlFuAs7AtbzXxqC6YLSKz+?=
 =?us-ascii?Q?XxpZnO1kPCEx7hfzVx7MhsGri1bNkNu56Q+o1rmt3mCe/JH3oJ+lYyz2BSUK?=
 =?us-ascii?Q?B7K6U+mMYXJrntILS4upUziAio4mBrXg5nYqE017s4pm1oWWzQWgRuCSMHuM?=
 =?us-ascii?Q?uVXjcoFAaXP4xXSdSPgiW1KvRq993s6t/CbzVHp+vCi89a0VsRsYdsdJAld4?=
 =?us-ascii?Q?KbZkx4+i3uigMKheSAE/3EVp2tk69NtNluP9MUUFz3HJygxeIImUHugxx8Lc?=
 =?us-ascii?Q?pBypK5QujQwnB7O1FyCFtT4wh7MXFqx1QHa5vSmkbhKFRcAduq606q/RucxP?=
 =?us-ascii?Q?QrhIX5699jVXDp0zTEIw7bdAgnHH5MIhoZD1E4MP1bEJNq3kuWmTOm9RNh1n?=
 =?us-ascii?Q?cQTAv0m9jwzz0mkRZ+IvGdwdE3m1WOqNl6cTx7pjYAbqo0CCey6bTpVxmzok?=
 =?us-ascii?Q?pS2WygSIpH+bk2vYVLlz65uoR9yRnoc5OytGGxsjxe5t8YqvPvri1YbLVEX1?=
 =?us-ascii?Q?Fl5lCy8LrfLg/A0cj/4e3Urp4JO9xynQjHZlg6O/sakrBo6JONmOg6hxXhej?=
 =?us-ascii?Q?m0G/MHAHqIRp6pcOucMp+hPwJ1G54Fbn6dcpyid+cFNxrz/wTQOSYut40+8O?=
 =?us-ascii?Q?N93BfLEG6Y+w0ROBHz0oMByqCadZls3+06OrLZkMbwD/vVz97SCfOMW0dX/J?=
 =?us-ascii?Q?gd2MaBdNEHWQ8T1N7phN4Fw5VDxE/W9kQfe011+IawYUdPaiSt+QvdMx22OH?=
 =?us-ascii?Q?egitcLT8YLHs4ZmiZ+oVeng020xK7d3B18Iyv1tp26tMx2p/4y4stTVSIDLB?=
 =?us-ascii?Q?a+tMqJ0RkCIBSvfUWe0YSjvwXBnXwaMZmQySVNYbm4UE8iQb+W9V4qQlKu1P?=
 =?us-ascii?Q?HRKLhjyh0Hw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TDHzC3CvSzr3eVR0+c7k8+PC8jW2SZEQ+JWs3xxcjiMfqk7s7tVuWqRdLaxO?=
 =?us-ascii?Q?V4h/0voCkIxgC+xJC/1qXDVnL+dZy/3lTihd3BFY7ATUMLaTGh/9gpo08NYv?=
 =?us-ascii?Q?tgGASNuxGDWG16yHkJAllUQUl/JatdRTMa84/eTuRJDnvSc/HWEXstFZNeqf?=
 =?us-ascii?Q?qnCLDTHpYw39rnAbKQA9ef7vCcxQZ+UnhIPvRhcMqk6Re2RosKFwwAEI9fF7?=
 =?us-ascii?Q?FN0691M8G4aRl9tXPqGjvXtaY0S/rnB3GsoWxDHnF/MQ2gbDZyicpMBQkmkV?=
 =?us-ascii?Q?MCg1sTWT9vJRaj9HmpCjm/zCWza3yFB5lcJdkTDvfDWMuEtKQk66IXQ8tdci?=
 =?us-ascii?Q?++KVvsK9np1RadJaKDjFqoVh8LDUUxkQYesdhfmXH4RQEQHkxTCD6mombauN?=
 =?us-ascii?Q?5mwaRuLThVQ9uZnyzVZYC2/i8gQTJLDxLd+03P53j6CCJY7VcGfBjqSwrAoQ?=
 =?us-ascii?Q?UKbWpOTEYNL4ZvQx+VEvkwxbsahlUGBmrwIkfz1wYtQQm8nHkMkQ9hiSaz0p?=
 =?us-ascii?Q?QGS063baccoV7uJh7oxxFrbKPNn5BlNoaCiAjjRgYHSCrK4HvuQhnOSdA+HN?=
 =?us-ascii?Q?Y4flrqsopZNkXxo/vCW6wz4ICFomODSml8YT43POpaFrrDQc/jlcRWdg7dJE?=
 =?us-ascii?Q?0t1sojjbI40/WbhDrX5F1aim/P0Sr8hNjWE5WZ3t5gB7RvtTr6++YpVd2OWO?=
 =?us-ascii?Q?GpeCjupU1Ec7K6XTQwa3gldRl/8AJM9hk+dyzeBZAc1UI2ZvjtZTE6WFsmpN?=
 =?us-ascii?Q?75p/OTo1NuTXpin/g/TeUeLs2skdlYkR3GSm579tBU0Sqe3dnPnKU7v63qro?=
 =?us-ascii?Q?BRlw0rgC6yKFv4yXwrkhY1Va+4d22/FefBUilfsHTSiVq4rpPRaXWB0d7OzI?=
 =?us-ascii?Q?2Ob1wjK9ONrqFSpH6laxkWaeXOfy31tAxcqJoYZG89NT50Zl3HAvJXg/Jwel?=
 =?us-ascii?Q?KgC/HAiDI6mdIH/awqh9P9o87MPKF8yxLDl2XOW+0OLj2d05P+GfHa62g9JF?=
 =?us-ascii?Q?GeAgNSSsgjidNO7vVTE734iHoya97D7qyE+3Hhbecvd3h+uLh21Xe7xMHrKn?=
 =?us-ascii?Q?EQeKoj55xu5OJEgYKQLU/fhJ1mMw8gYZNnvt7gRAF22WlKZrwzPiQfIb15D7?=
 =?us-ascii?Q?PbRSOXOvTd1wzUaBDzS8eLLJxMKc5Vq6cqRIK0OG4f4m1aY6+gxSuwr4sTUe?=
 =?us-ascii?Q?DPS1UggwB6sy3BlNhbtAoTlLlY6Pi4u+Ma4pVvl/6AH5H2Chp7Btafmt1kc+?=
 =?us-ascii?Q?/kEJfCCBf3mBug9xLMA1zh64E/Y/lERWgG/5ytyOgqjgKXBDqrR8n2n1OW6z?=
 =?us-ascii?Q?nuKoh4ibVraqYHeL7raLwv2/RlDPu7cIAkKTBF5CULtQgbonli4x14TbVjyi?=
 =?us-ascii?Q?zHBL8tacxkqS88VWfKIk/38m473thsZ/MQxekVKc8r7MystfAMfgxWRqlccu?=
 =?us-ascii?Q?fhHol9TlFmY1yFpKts1oHg0RheSdWPJtaWuj5TNWJavfFxfxJJ+ckPdyUs7L?=
 =?us-ascii?Q?TSJ1Ah4i5GR6qmcZYG+gZ60UKVun+SPe2oKB/BpeLK6IoeC0LyxYEC1uFNp9?=
 =?us-ascii?Q?tyciS2q4VFKA0FuiuRMB3iOunffTqdJAosXjCS0hAvh15gNuwp72aSoKi8uy?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZptGy/guls7oclUI1v52GOldGbhpmQmhH55hGsDjvjV2Q8y+j8utWjKuipk4wpmz9vbJpF7R39abZVoCccg+074/BWE7l+1gqGNuvmysbAAoFqeYHuFDPnB+rR28ngsUg9LdxiXWh5OzjddYenznGq2S3lFChomfoF84nXftRKSuU/3Ye33XhlQdklFYy0i8YmnZX9P41G9ej5mkWHDsFQlnH5yjFkpkdnkWO6DH6kF3/ltkXSxaYQNHPbysJrGrsWEB/GSX4Ki0YqVaFTKDxdRUbO6/07aKCHUrgLj53rjyDkES6vbSwuzaCNREYdZQrX0FzsxhJRM+kpU9d4/57rh1EPZxuSckEt5ioiIswoaMtL8Ekux7PoSU0GJFCI5/lZU9uEpB2Z3Xjx7d4cR0anilOYma9OL+Do0zy9r3k5e1uvqk1ArTElSzPuHPbXJ/3HCiJp/ibZ6gsuqPAEis79HpGbygiQJG1I6KynlQLVaOyrOnPlj7TH3S7Q00C5HBycfUcwRka5k2vr+00fQbHjzh/nOFYovJdG6klXYH2KF7Ssh7gZmTMzNKeAlmPWC3BIo6B4YgLPaElyc2R6bV9ooE3JlcIioEIebI2aIpsl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdca6c4-adb0-4fc4-1e80-08dd8418a3ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:52.3720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLuabQFVnUeXKxrSHGrnaSfFOboZ7oRsEoPFzo/MNl86mn0BFEK701xBEgre4eid95pJCay7OZIi/zCpF4a8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250118
X-Proofpoint-ORIG-GUID: GOFcgxEP9P58M-px8dr7xhKJAWDIWPqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfX/CglAlakySnA +qv0fQuQPhofEuI4Uuheb2aS+bigue4fXYCoqVc0iGFuVvil6h8lozw4dCN47xCyE/Uo5nvgq4a 1rDXdQYsEB6+G03VbttqY3+mRqit+NuZnQA1ANaIe83gKTMAdFfSyWBpACPPp3/EO+dy4PlEfQv
 kNJjlj95CExtMArhVYGKaPRF3OhgactSLwOqct5u6mrmrv2LD6fSlsm8RJagD3A2xeKCDKWU4pY 0Ya/FZTyZIxXRH188l+iPuXI1aw5W7w0tNQGZNPhfUy2/kegwhfNfptXN++WbQbFzoMXNzJntvE yhquuv7MUupfix3QXT6dA/ZWLTC+JCxqX+EpakLi4FY7NiwdeRPxXpeVVAp8kQ6hpk7D8/+eiJn Vj0Ibcfh
X-Proofpoint-GUID: GOFcgxEP9P58M-px8dr7xhKJAWDIWPqM

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Note that there is a limit on the amount of log intent items which can be
fit into a single transaction, but this is being ignored for now since
the count of items for a typical atomic write would be much less than is
typically supported. A typical atomic write would be expected to be 64KB
or less, which means only 16 possible extents unmaps, which is quite
small.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add tr_atomic_ioend]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_log_rlimit.c |  4 +++
 fs/xfs/libxfs/xfs_trans_resv.c | 15 +++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  1 +
 fs/xfs/xfs_file.c              |  5 ++-
 fs/xfs/xfs_reflink.c           | 56 ++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h           |  2 ++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index d3bd6a86c8fe..34bba96d30ca 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -91,6 +91,7 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 	 */
 	if (xfs_want_minlogsize_fixes(&mp->m_sb)) {
 		xfs_trans_resv_calc(mp, resv);
+		resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
 		return;
 	}
 
@@ -107,6 +108,9 @@ xfs_log_calc_trans_resv_for_minlogblocks(
 
 	xfs_trans_resv_calc(mp, resv);
 
+	/* Copy the dynamic transaction reservation types from the running fs */
+	resv->tr_atomic_ioend = M_RES(mp)->tr_atomic_ioend;
+
 	if (xfs_has_reflink(mp)) {
 		/*
 		 * In the early days of reflink, typical log operation counts
diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 580d00ae2857..a841432abf83 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -1284,6 +1284,15 @@ xfs_calc_namespace_reservations(
 	resp->tr_mkdir.tr_logflags |= XFS_TRANS_PERM_LOG_RES;
 }
 
+STATIC void
+xfs_calc_default_atomic_ioend_reservation(
+	struct xfs_mount	*mp,
+	struct xfs_trans_resv	*resp)
+{
+	/* Pick a default that will scale reasonably for the log size. */
+	resp->tr_atomic_ioend = resp->tr_itruncate;
+}
+
 void
 xfs_trans_resv_calc(
 	struct xfs_mount	*mp,
@@ -1378,4 +1387,10 @@ xfs_trans_resv_calc(
 	resp->tr_itruncate.tr_logcount += logcount_adj;
 	resp->tr_write.tr_logcount += logcount_adj;
 	resp->tr_qm_dqalloc.tr_logcount += logcount_adj;
+
+	/*
+	 * Now that we've finished computing the static reservations, we can
+	 * compute the dynamic reservation for atomic writes.
+	 */
+	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index d9d0032cbbc5..670045d417a6 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -48,6 +48,7 @@ struct xfs_trans_resv {
 	struct xfs_trans_res	tr_qm_dqalloc;	/* allocate quota on disk */
 	struct xfs_trans_res	tr_sb;		/* modify superblock */
 	struct xfs_trans_res	tr_fsyncts;	/* update timestamps on fsync */
+	struct xfs_trans_res	tr_atomic_ioend; /* untorn write completion */
 };
 
 /* shorthand way of accessing reservation structure */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e8acd6ca8f27..32883ec8ca2e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -576,7 +576,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5d338916098..218dee76768b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -984,6 +984,62 @@ xfs_reflink_end_cow(
 	return error;
 }
 
+/*
+ * Fully remap all of the file's data fork at once, which is the critical part
+ * in achieving atomic behaviour.
+ * The regular CoW end path does not use function as to keep the block
+ * reservation per transaction as low as possible.
+ */
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_atomic_ioend, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 379619f24247..412e9b6f2082 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -45,6 +45,8 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


