Return-Path: <linux-fsdevel+bounces-25808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B65950A76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38271F235C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA11A3BBC;
	Tue, 13 Aug 2024 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOYydids";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CKhdcul7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DC1A2573;
	Tue, 13 Aug 2024 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567132; cv=fail; b=MBWaAEsQYxeUA2E5YbWt+6BQnUEqUcrGfJjeTwRIhKnYfJ+eqmg/8yT4w7FU1EK+fWdLpTBr5YkpTp5D8WsIlwKOogPNpRBrOqdp20H0ifyQ6Coy5Svc0ixIDDZKZ642DckVrlodzxNGuc6g2eXbwPyBvCBRBiS8HFRnQYmrIig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567132; c=relaxed/simple;
	bh=apTMNsmeaZFfv/vSlTANpdyw7UG/LQSLKvpB8RDkyX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nmr9xqq9Ftjfh7XkLCvAdqyL77h6Ejrkk0QiqhGG5jhTDfceKJxdzUenfB4sIEkyTuHWbndjkzuxC9puQzT2baumshe0io1CP5dLrpLhBmKvR20UMv+kCZ/Zz6d6U0E5LBBMg95q7EXOunz749gPBKCawuQAvxzCsaNyJJhVM5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOYydids; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CKhdcul7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DGBV6Z014971;
	Tue, 13 Aug 2024 16:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=SOK5U9V8dVJ4nSPTW+vPt0P1ozrq54R9NP0RfkIwwrQ=; b=
	iOYydids0F1u/MjFJ8hlddoK/qbsBYo1u8SlaXDVuVmU7NK7kY8qYU8jOL4x3LzV
	B+ES0CxO6VwCGqTQSsDPKfH02HwcyYR1sNF8AJfE/n8RrJelzY4EdwHqxFv1Ii7j
	uS4K8oxP7FcePJYsCzGF0dtD9JeQE1pHTOErfWtKhP35Om7JG8MIYLD8zYbX3L1X
	wDSzhQCe/yidYnLu7zOQW2eap9ldZ0m5fix7nliwYvCWbfYV+eF1QnESLO2UoZYS
	tNFDnAHUKdwBoNzKJ7WbazBnx5G+AcFEfOSLAtu4mtcRjwWMvg+TJtqYJBzw52x5
	RnSlFRbSXixav4QOuOoB1Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxmcxans-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DGH99I001485;
	Tue, 13 Aug 2024 16:37:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn8qkvm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 16:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lydkyUtz78hdoGOaimSHusg2Nfx1dARNpUTx4oRNgjFHQ9MsEjlcqRW6sfVRRKd3vPgvTTMCzUYcswEgY+Mge52J0UrlD/VCZqgh1IGdVXVyVbTNJFCG+Cgcw8Lw1v6tP86bprUyXmWaKsWEsbETbZ6MXcCjjB2+H0GpHSeQ4oSUAN1bO1mr1ao231iFdPwE/jXddV3uk49t2JiCIWpE5SAoCRLy4iutYTro5hGaXOyA8iPEr12hFs+5IOxIMfCRuS4OQRf2CUV+6GYeN+HX6TgfYPJBj3EUo6U1T6jnS1ipvrBptyygsyPmwexpdOk0FvZpLE8nrxDZnKjc47WVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOK5U9V8dVJ4nSPTW+vPt0P1ozrq54R9NP0RfkIwwrQ=;
 b=yMYQHcBufCF2euAuLRMR5qrn7GeXXGuy/O5yDnvsQ8s9xLutSlEGXje6XIacCKJO/+ab4KSRMmg+nku6ek/GlK4gR7a4ZJZubHPcdCbMTF9ySX9xR4XzJti6ul7x2Oep6GrSk+WpWsceYn9Yk4yt3GFBCC//fAwhlNMFNbKGXoRUWOy5oTn53LbmTrozLl24hPonpfea/vHBdebL7ZUCfMrYajiVqIo+r3RHotrkfenu1EuIiTueKOVbZ31jMcGrfnSqHEhOWAq6tbck6QHOPfAX7s9NMk0SnxaPXV9Uu8J3itu8uPQkPSRov8MhEwq9L+dL8TcE/B9ysj3wgKqwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOK5U9V8dVJ4nSPTW+vPt0P1ozrq54R9NP0RfkIwwrQ=;
 b=CKhdcul7U3VgX1TGZEvluwCUeXpJnJXGlbbJRJzqX+3onge8N1B+AfrAGZJc38VwE7xIAJx3HKccLVXOewXwZD9mBUq/+iwPvpcYJOMd779BGzEE6x+Jp/cj3JmTuaByDkPnMKC6UTZmX2XzAJkR05ktKTWkGx/1PmIQeZOqvTY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Tue, 13 Aug
 2024 16:37:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 16:37:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 13/14] xfs: Don't revert allocated offset for forcealign
Date: Tue, 13 Aug 2024 16:36:37 +0000
Message-Id: <20240813163638.3751939-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240813163638.3751939-1-john.g.garry@oracle.com>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd1da73-63af-4d2a-7cd6-08dcbbb63a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ECJF/Pb1VxbqkCqJ/HXHZQioEG6PZh5FuvE9ZPp2mokoesum73/0MCRIR+u3?=
 =?us-ascii?Q?iLKD4G4lAucfoVqwqWD4S2PqAs/AN5b17zzTPEwwQe6W87YBpSakoT1avtpv?=
 =?us-ascii?Q?FahLTUPFGQhPDVF6OA7xHG3xL6FnYGNYvJCqJ22fYXEopgChpSRtE+1Qo7Rk?=
 =?us-ascii?Q?ziuJEWhQtCih0O4bS4K68k1b0EY2Ot3w0Ft9hoOOQpt6O4TfBxnwpSaVtEGk?=
 =?us-ascii?Q?e3mDyV8Uib2jHIs7rx2o9rdUyERVy0SY0wFUYoyfnUqmgg4qQ3LFgzDXL7ng?=
 =?us-ascii?Q?lryuG7Z1sSfB0DrV+cs5CVrfPvuaucftDly4pPKh88N3Uj/QAuXpgHLLYR8S?=
 =?us-ascii?Q?ls8n5zS0V1eLABLnhzWoANIx9WFRoumrKH6A4HkYnhXSp/FLfex+X4+HFpK2?=
 =?us-ascii?Q?v5yF68pYOXuVBgAHHNQBxXkUY7MXzK71HC2d5jnv7/n5MCPaYYpXtEXuwX3w?=
 =?us-ascii?Q?2cTv1FCVRHZ8bds0jWMkFz2N+fJpzDck7c8dHgAMduuTye/cgOo5mLJSQA5P?=
 =?us-ascii?Q?MtRF3504c5F5IA/W27RfsLfUk77SolVd6c4NR58ppwQ6ZjhiXcieN3qJaS4f?=
 =?us-ascii?Q?VmD7wwepgWN/tfXYqiC2Kq4AoOSkNtyHEqK71ytPpT/dIW8HuBKWZ9ViyatY?=
 =?us-ascii?Q?fF0dby5a1dgop+lTEWb4yELo4H1wy8PWm/DG8IyyUj7q0/ENX9vo2x6eSWag?=
 =?us-ascii?Q?T6jjr84m2rt5SugRfbFL4yovhP5LgKspgpIQAZXPs0NZi9EhqettaAPsbQxJ?=
 =?us-ascii?Q?Tt0l3Km+uw4J9t1UGv71dQFOMeO03C/kxAqyA1YOTQBtF0sYmVtQX1rZBCnk?=
 =?us-ascii?Q?/GxHawm6yGiXhKzWIx6I/JI0BIGUuMQRmgxUiQRxogGWHhVAAcnbSlVc7hNE?=
 =?us-ascii?Q?KoB1Aogl12DSn8Wxxwm/mpPRZv8+ELL6JDunWXI1xhjKV/gNJ71zgHc5rqc4?=
 =?us-ascii?Q?QwY4lGNQ5Qvbbz8bJ/4U1+HWZajEaLHlWhT5lP5IkCg0lGOF2ZkLnBSpPDx4?=
 =?us-ascii?Q?/6IV5Gj4rW8S+GAqhmf+SMHZW/Rva6+Y/eruWpT1CU9o1gtYZor+E+oR/unN?=
 =?us-ascii?Q?E4iI/0qOSVPWvE6gICjSkizP6UZ7vwq5r2++5Elp6YnI7aohzBG0C39h+/0l?=
 =?us-ascii?Q?0ww5XH0r4URLJb8tkxtvdGCBa1lPEnCOGPvNtTUa/eBBEiuIGE/80nHHVte+?=
 =?us-ascii?Q?XGKkg1xI+HejG1Q/JMaHpUHkyqItvvnreFHawXAtXzjfM6m154pi/BErgufF?=
 =?us-ascii?Q?z8OawWeyO21iAk0MDjhTt82jwAgUm639I06axABXqlPmP/dBFFGiU9LB1RCx?=
 =?us-ascii?Q?S18oWRokSWrVedGjB2h5hB+i6fKqQGJzw7/HSE6+4oROkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRM7I3DBG7KUQdQZ+kcQlV/9n6tHFip1Oq67RbaMkZDIT1PgRJnX6KHbVJUU?=
 =?us-ascii?Q?myVwzm1FaaZuSPXx0K5UyyUxfuKXEXZawwO+/Idjg3o6HZb5cnrrIMpE4QIm?=
 =?us-ascii?Q?FQnmbmqdowuJQ4oSB5XwSJN0BHg2aMOREalKqLlD3mYIott3+EEXOCXmYk8H?=
 =?us-ascii?Q?aFr6qHEEMSXSFIlU9JSdGuGLIft0yuO9lDNEzLe+zPmyGWDdPETWNfh73rFH?=
 =?us-ascii?Q?sZ4lYaejRALsssdXzvoYFv7sst34+8YXqRDbaNQb0juUhKptSKLLQxKOkq1i?=
 =?us-ascii?Q?YjBJrTLR1Tjt3fNLWBPpJ/LRHoTvQ444B05T/qGNi3YpuSvkMn3OsllMEUTI?=
 =?us-ascii?Q?QGrXW6QTcx8SfTQISonEhrlosEwB1o7NA1vbFhUeiwbLIviFSoZwT2bAMFVr?=
 =?us-ascii?Q?UCGQE3udqCy9bA7ZlSueG6xvIlYNErCtMB07FMLFV9uJ0tIfqLyGk0Lnul16?=
 =?us-ascii?Q?3VmFKW2vqvNRXjBAM80VsTf7SUbT/EEut5QloZlJIJ1PWqRw6D1aJBYFH5ub?=
 =?us-ascii?Q?36s15pBW2FOAUZAUan12+YRUOxmtVDbFGYa4RUbYshLw0VpJwyO3obrdQ7e4?=
 =?us-ascii?Q?sr1F0xg//nmdw5H5W186uLYlSLi5vOLNrqIV9Ftnpgqy3QP5pgSbSUMi1EnA?=
 =?us-ascii?Q?YdBwJWUjnF0vKKJF6w16oeqjLHvGF79S1VBCCxC0T3jA5RspFafjnOacNbxz?=
 =?us-ascii?Q?JxCCluOQmi9PhasGalVujrVvtozDVN96wbmc0dNSbz8qWFe35Tbkoq6gLQBa?=
 =?us-ascii?Q?qM5lM/t5XnTSIil/DGyeGisJxMoSfj2AwxdAYje/6WQTTTUuB7GzqIHoNDCe?=
 =?us-ascii?Q?8RHnosZYhzEkDIIqgyeFWC1tnrvNohbccaCHwlmWmHXuHrJOk6rHfU7RISgu?=
 =?us-ascii?Q?p9NiGE5eEQuSUOY/OVfnZpVjgcVvUJncEMdGeJa7c6UiR8ibHUPn54JAh6K9?=
 =?us-ascii?Q?hocfG+p+v2UmH+PR6/PYsK/qm2bcQ9YqDWFgc/xGr02ONIa6p8y7WuEiltTu?=
 =?us-ascii?Q?6G4sXUwu8hzwufvQAfhkzLvhWemtDCGb58vGrkER1IW5M1f3GwbH7V1hpgbJ?=
 =?us-ascii?Q?s/MtW8kCB9JOk2msQ7BcQozicfH+J6ikuJlhN/+EmbUJBPANTpSR2pid1U7C?=
 =?us-ascii?Q?0RIP+msO98XNJoVqFMgkFre7/hJ1ZcZMFjqw4Zv6Hdk3p2cdNcWuGLtUBwQU?=
 =?us-ascii?Q?N5ph0Yirkeo4u6Dqs0XrXthlONxQ+Otb4Z7mBxlwWB3doiEA0ZtayL+ekhwZ?=
 =?us-ascii?Q?Eq7RTcqBHF70mpkh9Qf3EFjGH09gq0r4RJNFcl9SpWWCn9TSC4rrwmdqKszY?=
 =?us-ascii?Q?bos+sD0Bj+oM54r8Trevf4ay0DQ9V9B1/iW53cTZhvmJtGN85VEdxyLfltYh?=
 =?us-ascii?Q?mq+orPrz82nU25Z2VhonZC7Oxg+0Nbf6AgvEi0gpwtIHPaFaHPymAUHMO41Z?=
 =?us-ascii?Q?pA/1qGKsmrQ1+RpfNSdtuYxkHBgFRm7ViO50S4u8mMOogEpazJsfaFyY7bM5?=
 =?us-ascii?Q?CHlQxs2Dv1F4N9FdY3rMgGwaeYPjomhMolfQVVnNq/W0d7fal1/ThvKXKXc+?=
 =?us-ascii?Q?T7+0hkqUpwC3mDSz/+bU1ukEVzFi1CPGaw6FLt7JP09yUQgpcB3UV/sTRyDN?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2k/BbGt5aYmTF14smxThy1BfofB+6q5vVDDhT7D63G5Y7joGr6GnDdfiBoFFVk0kV+81xoH/NiERFMT8yk8cFfPRSrALH8q/im8I04HTz76mngoRiJ/JmBOnLs/KNgiq1oSNLav1l9jyhmssZHYcMYcjXlhbR12WQuY+1rgXddEN87CcPKWJZNqe8kHiajFCXhczoyHgaaxTHX/Xt6/8HCtJ3WSxUIbtbzFhNdQrXmxCpRmiMd4eVWWcGg4dzUs11C3ms+jlmepDrNudE7ikemobpKTo2bb9CMbViWovW4lxvvaHUC5TpXEvwxp/3jUrGUgUARS+D22kUK3eOtijhZqeA+A+RSDnQaWElW5RGCnq6HVuvzwnOnaTiLOqRVL0a4PihRg4LHODUz0jHXmG9F+Y2nxibjEd8k+fB2tRI+hrm9NopmWwqxqEy1FK32UGiN7NUYWRF7a/js8z/iTp6Mb05FuBkxha9FflA2YyDOvS1TO8uXL3M79rWKW+zaBJuC3Bd5roFwzSzUCeVMd9tHCMUtuEkmRULPDk97IrYHZ0bf4QxJIjrEH0PBGNRUrdJrBpNwKun38aoy5OgnyeD2w3dqsP5bZDTm7uCFrjjV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd1da73-63af-4d2a-7cd6-08dcbbb63a8a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 16:37:32.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8XXuGhXyg9ZldvFPx/qE+tmCWG3+WGVG19+/HH17t0wRKy6hgOcSG4bb+N7QGlg9fCigOs9W4L35eBfhrjz/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_07,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408130120
X-Proofpoint-ORIG-GUID: shgvuF27TK27wdgeR6TebVTr10YTrpam
X-Proofpoint-GUID: shgvuF27TK27wdgeR6TebVTr10YTrpam

In xfs_bmap_process_allocated_extent(), for when we found that we could not
provide the requested length completely, the mapping is moved so that we
can provide as much as possible for the original request.

For forcealign, this would mean ignoring alignment guaranteed, so don't do
this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 3ab2cecf09d2..a9e98f83e57e 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3491,11 +3491,15 @@ xfs_bmap_process_allocated_extent(
 	 * original request as possible.  Free space is apparently
 	 * very fragmented so we're unlikely to be able to satisfy the
 	 * hints anyway.
+	 * However, for an inode with forcealign, continue with the
+	 * found offset as we need to honour the alignment hint.
 	 */
-	if (ap->length <= orig_length)
-		ap->offset = orig_offset;
-	else if (ap->offset + ap->length < orig_offset + orig_length)
-		ap->offset = orig_offset + orig_length - ap->length;
+	if (!xfs_inode_has_forcealign(ap->ip)) {
+		if (ap->length <= orig_length)
+			ap->offset = orig_offset;
+		else if (ap->offset + ap->length < orig_offset + orig_length)
+			ap->offset = orig_offset + orig_length - ap->length;
+	}
 	xfs_bmap_alloc_account(ap);
 }
 
-- 
2.31.1


