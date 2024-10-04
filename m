Return-Path: <linux-fsdevel+bounces-30942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F898FF89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB555282457
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7914831E;
	Fri,  4 Oct 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YheRhalx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hufuLPmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B25147C98;
	Fri,  4 Oct 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033821; cv=fail; b=Et5tLYXrZND4DipPWvwSzm0lBEaHnHraLTI77lDuPItRpSnPvjZVCeI9IMJy8Mv1BcTJhsC+yzlmGulL7GJFVqjiLA/rkKTRe5qR/T8TvpTFrrjbh1+EDlLt8nSRF7VRlFcvU5TOVPbIU83ovkL4a93Ya9zl6qM+33i1toE79i0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033821; c=relaxed/simple;
	bh=5+s29Xj4I7WshZuhAePFtgREyr5F5gNnNrYVKlDau64=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Isy/IK0Oq4kCfqdGhGWCoUsZvgEdZgASvKacn2L11vdXj5R2tm9JV7mxf4VnCt6hqvTDThsF+dTbxVtLgYzrkt3b3IfNwp5cUSEoiNs+aKwDW/j4K/aUNt7ztEupWw1pu+Fi6qrGo+J6U/uQV8piDQWgstsFi9K1SR2xYanS6P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YheRhalx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hufuLPmM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tepl028917;
	Fri, 4 Oct 2024 09:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=l+HuFGrwkEOqrN
	msc+ita7bl6IkMy5Qxv1BDzD3IIdk=; b=YheRhalxSrEq5uyd9NBNWFV7rMgkvF
	ZtZeEE1PhZqOJCflM5XohjQ/K4NaBHtwYGstIZ+rAKc0bCq/Rf7rwMiIy1+DbB8d
	WuaEja5XkxOu7ezTyaxLgXjI7K4W5EIsN9q7rEVgxqP33v84GLq6BKaBuctJUIm2
	1tsm52jSyAxt8bRAjL9WWA0gkzGsmNf7YaA/qubENAb42V7o+8/j1rbwtFDlpXap
	awSNw/3UtuqoinZF8UonkI06+aDzSPzC7H42uYgrSHlmGC+S++nwPpWD4EbQviTm
	aT6NruEOt3DIci+rA44MzotR7yTvSG8nQsecvh1y7XqxWqqiU+hSy1Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gs6es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948v8rV026300;
	Fri, 4 Oct 2024 09:23:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055hbk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWYJOnGDZzvjig7lLIMLOua5hu2bJGl7r4Jcj/Obbf+1tk4R8FUvWdPS0P4aZ7YHqRvjqNwMPFBfnt9RQwSyZxYFWq7WiPxig6FOhKPOl+/76WKw7y0rhYKRc82S2ajmBE/3H1mt5n9IBMgX2jhbwCMPP7FHIdV1aOH9TlRZVouqwygPKmeMAzkWsUCcTJG6oqRM1xf3pn7QyfXMtyUpY1aKChwz/eIZAfw5LGT7c3UPpL/9UzKPqO4HcuOABAS0qJCx+a+il9J1ToUqT00RJ/S6Erj/tT77O5AGgTjOPLPyCFoj2g2+DWp4e8uWF+NxtfX8wrTrzKu08iqdd4bQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+HuFGrwkEOqrNmsc+ita7bl6IkMy5Qxv1BDzD3IIdk=;
 b=qDvYPtZRp+LW1aIZXGtj2jvHfFiVGwBbhRbc3n57unzHAqgNEFjnZVXlaKeqMNIHijMYdx1SUpcXDFsaK3M1Kcu44yazzQqiOrNSvCMhVcjeVvljNyc0DOYWeS6Rj8iOsEA1E4GC5GIppyKTm1SnJjvZ+9CMytFHcWu+iQg51DokXDOBo784t+NaMJuF100tdXX1cH19LWhoHkszEEEKPetrr3r+b/k2ZpUTvmk03MQwzNR4IjRKWJzC5+K/Qns3SnnLQKR2KI6uX5U6fkkOjepEbq1cTHtuf82HSk43/ClVdHOgApCX0Q58MTzuIq2EQ7zS5bjuQDh5h5z0R/8MWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+HuFGrwkEOqrNmsc+ita7bl6IkMy5Qxv1BDzD3IIdk=;
 b=hufuLPmMVUG22fh658M+OXkEBkC+w0FZX99Fc3N1egzBv+CV0yNagCVBI7SbAsYhdmQjd3xflo0r3VmaTTUats4e7kSN4eZSkSFr13k1D8GNUuvtMAaXu1JYzejrGHIg3vAgMlM09izrWV8VMLSckk/sdteBMC4ouBQjdRA/d70=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 0/8] block atomic writes for xfs
Date: Fri,  4 Oct 2024 09:22:46 +0000
Message-Id: <20241004092254.3759210-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0579.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: ce70726c-be0b-494d-55b2-08dce4562a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/LZIEQDyZd9N04hLLFEHxg7r46nbGNrDJ60/oMqXbAksZxOVKjLlH9qRjNT?=
 =?us-ascii?Q?h23LAe8JjAWuoiuwb+3R+BXC2js0TzfNu3wJWQeqr1J0mDPFiVn7F3/FtlPU?=
 =?us-ascii?Q?sHAV5lbV9COYcJSsrv9G1I3rfw9o1t3spowYgKJXpZpxM2d+X/c2y0eeoWKk?=
 =?us-ascii?Q?K+MAWf155z7kgst4zdd4w8DXDSkBeqmhq9Z9ziszN/gSzgxRKO+KXz7OupRp?=
 =?us-ascii?Q?SLgx1REDZyzCahd1bYZMqPu8+PvtOgqdnmfnIMGtT+/1L1VhkFHkL1fe0fuR?=
 =?us-ascii?Q?FwCEfrUD7sVlR8KgvcsJOSexxYTawYAPOQtFXfmNyRf8vlnB9d32S62Ld1Tw?=
 =?us-ascii?Q?dmc4vFqIO0qgAXsaNosMCaYXgu3SnpjgchBUXl3TTCafb+9t0qcX4IiOwJxL?=
 =?us-ascii?Q?opDUEyeaLpazVdGOu1/Hl17VDxfMBCdFfNIGtAjY5UC3BKquZWw01nsOaIKI?=
 =?us-ascii?Q?jlykpF3nWn7eY+IZZHdHYx+CPj5Z0DWwx/zp6yVMS4A6pVEfwIbffvPQWlkV?=
 =?us-ascii?Q?KNg+pCz27Unp5CjXagp9vHEK6RUu2Vs3GOJaDoM19jiJrEien5NijuC3GSTA?=
 =?us-ascii?Q?4m2IPwEFfmLwYWTFVamtfjDxAclarEt5gfMNJ/IGag44GS8wIm9ay5mjcV+v?=
 =?us-ascii?Q?X4/lEnaA9i41Tr5Ft8691WPKqPZ6PXllGcpe8lUcfXu5RknnHmclBgt2VYCe?=
 =?us-ascii?Q?YnLgScawYnn0ukY+hCrKNJr4Zwr+/PKAH4isNR7Feu7vU6rCsX5n0IhSDFLB?=
 =?us-ascii?Q?gER57/4BUxQSqOykjFUR0HOF+a20GHl/G9OfiKy890HfMqkM0+MYNUPkHLrL?=
 =?us-ascii?Q?gHYJZRpo2qjqi3IYW7nnmRgTT7J5f+8RdgJMVcbpaF7nP3xhDe1Ien2GvGvv?=
 =?us-ascii?Q?lI+33jq9mHC97BTHpKwC4VR6wh06dY8oR2xADGU4ym2Ww6rtigy2Oiz5uARr?=
 =?us-ascii?Q?z137mIWayDMpUgt+SuAVnQOJ5iYMUoA42mmO1R8HAy6zxVozvyFVPGDx7ldi?=
 =?us-ascii?Q?X8vCtdjAnlCLPN15mwxeqJ3cPwiPQ4800xZOtbBgXhCna9t2AfH+l7Ph1O5Y?=
 =?us-ascii?Q?1BIDssRzDOTyKJ5TuhuHiRkURYrszbfOymw4vCNocpHm4SaWM2hXT9SKd8S8?=
 =?us-ascii?Q?5nE8nioDIMzxPt/ik5bi3pDKoKpD+guVjNVMN1qxSDD8S0+Vaiv5FROoIIFn?=
 =?us-ascii?Q?ODruSDL04m7RCKBKEA9wNwIKADCJCBWjvUTK484WLePdBMO7WV+9BZC/C3oq?=
 =?us-ascii?Q?hlsPcA7QmiOcycPgYuLSUZ4gRpNYMj83ZvyltwGmoBpuSbORRdPieZ/kez+Q?=
 =?us-ascii?Q?o+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cxj5SvRlc6oqG74uSGEWS4wkEqT39agz+tWDTX5qrMNDij8o41BGBhAFvo1e?=
 =?us-ascii?Q?Z0i0HfuOyat83uYtdGsnAMZ/e8IGezQUrRUd8I5K/9tJEqg3OoEM86D2tFOg?=
 =?us-ascii?Q?HMQX8Kqv/+waNOxV/V13SRo8nGJfTjcmSNWyERlL+VowINnj7CznK96QzByu?=
 =?us-ascii?Q?Ly8dDYrlGAY0uOJb27irovnHzKRTm4rzVWvBBc/mldnpjWEVUrgH12Sv791t?=
 =?us-ascii?Q?mwT64EgHeDa2UcVGWgJPMoPFICQOBOtx/jm+MU3klxQMCxnKG8QFvG49dUAO?=
 =?us-ascii?Q?SmFqiAhpKQhplftEoFT0wh8o8UlF1z96AGq6YUWZix46Qsyh3t9oCkUiVXLx?=
 =?us-ascii?Q?S/L3GlPbTffDHUr9DzCX+QTr67wywDgvdaFDXY0nXdy6dYb+4GPRA4ypXlhB?=
 =?us-ascii?Q?LX2VUHzGpetow+NtDLNmnLAL+7g8+Pk3YsPzDp76AI+QOyUOWp5D6iBu3dsJ?=
 =?us-ascii?Q?W5OiS28dBuCVpBJeKdyraisumgWC2Dsf5qalkQqVk/uIzt3uH9YhhAP6QFZB?=
 =?us-ascii?Q?YnKCFnLScryHc1yYoYltxCiXfxpkKWS1BR4Ifcm0SIWqZsaYAkX3HnCqseuS?=
 =?us-ascii?Q?0wwEEeOl9sxm9y1OHGfsZnetZhncphjyDKQQiz7c2IuL+HtJBI6h52Zjx3zi?=
 =?us-ascii?Q?0Uh6o3kuI7/Dku5TdgMrhKqSFm2zJKFJToGYicUTgUxa1vc1A+WHOezybCXG?=
 =?us-ascii?Q?et63rqTpyTSyhkX9/l/fWwFYVs2evNIaePgO08qQaNHVucPYpIH1Do7Ilk+W?=
 =?us-ascii?Q?jlV5YwqRUR53vK3coq+U6AyY9QQkgCVagP1OUjcU7FOXfpV3iTKt71SY6PuU?=
 =?us-ascii?Q?8DBoU2JxDkQjvfoj02gQZ2Eq4Uel9iwo1yvbWRzkpbG2KyXhiSFtsBDkxeUl?=
 =?us-ascii?Q?YSs3/k1CHEofB4iziruUNF6G/eOSSYZhq+cqC3x2sCYm4GdklG/7BAGNa21x?=
 =?us-ascii?Q?U5DF6fZXQfMBc9TSBznd3+PDjgA8/hfLapTC52/zi7vkptpFII9WakdPU0kl?=
 =?us-ascii?Q?C0sj9vBZI7K/Z7D6HF8FZ+8AbZLfM45eNzGb1rqknvbvCIXn9XvCoKgYFMN7?=
 =?us-ascii?Q?Gxc9lnKhGVCT/+YMuowhmrK8RW0T8ADnJUA9AczxjnsVN4d8sXePuyCAk2l1?=
 =?us-ascii?Q?qs1ywj20T+HfuTcIHeAQgiW3iV+rxJyPmZFPCxveLlDPyeONRpskBue0RIif?=
 =?us-ascii?Q?CTM4QHutkO7a8OQmTCV+w4zy+YtTp2uca0zo8+fydN6KH/BiiCnnwzC16lQ3?=
 =?us-ascii?Q?sbZGf3H1IXrN5GYHBPX25Pag85YtEjDDirqSIROgjtQPZmhcXZIno2AZ9y6f?=
 =?us-ascii?Q?ludp6bDZvuCSwTD4ythujuH4cYqWobbc85pAKCpiFBWri8R6tfk5OcflGH8Z?=
 =?us-ascii?Q?DCGnazcbWy7gm52ig3S7e1EZDeMngzdDXbxkA1Qbaxs4fhq66coh8f2UA1cI?=
 =?us-ascii?Q?JpW5A609/TNYZARAsHiFWb9b7kb7MXNCBSoZQIGwHC/nqjWSZHMs5Xe4vSyi?=
 =?us-ascii?Q?1g5Bnot3BdHRXOHovxDkZp3uooI7ZyKW7/jyjq6YtIZyaRZyf3SOcZQYPD+e?=
 =?us-ascii?Q?xOCQqIjSbHwdPInTHrVRX1i5b5yEGzSeAPceBFcoL9E/nRJEqNOHPqq+uCfI?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dg7J9Ew1pow2G+JJMkl7EWbvNRevQhwX0OWma+FVp/9eeGfDTShgHv05Jucr5MulnsvrIzk/7XMu+LBtN4k4ZRcEMaFV6vorwzv78gCO0W6Bkt9VsWJCXT67JOjR1MG3tzpuaYkkduM4NVR9yIxqRFTxj8+g1SFraTG5AHZqG5Rhb9wlfm5mJdIepuEvfFl+5yV38XZPkC8o1oZ9xYKe92jwusjFcPY82pc34MOzv9arZrWuxNv+yGpZRer4VlTF8X09ueq3q0ax8fSkEscewzBq+2jHBNM0u+uUWYOQhxfbUaUG4vS0AJMuoEwYcgPdALqKG+2gg+f0p18ZfVoZWDQSIPIN2tpbbtW8OBZSr80omWeWp8Run4vmC4ZjR0dSCnrWv11ldkE3TGohyhfcOzES5aJzS4eb+z8EYdfxG8yUVr7bXcsDgbLmlgTpTpNse9bpWr1pv61e988O9rE5DZzh4qsg9fUdT4CdTjgNqUmq3plg/gc0xqDwzXyCF+TPUWF7Twgj9epuYNZaLHJToyROf5sGB3R9CM5qgelJHYr8lDzuAP8ExaWxZIAy6ufE4ml9cYnymyxeGBAzs15/Y8zTgOAq/D1Su6ZTfzlfn8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce70726c-be0b-494d-55b2-08dce4562a11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:10.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPBiwpISAnB7SWew6tBt9auufjeIR1q7/psmH7+XYDriCDMf/DBYj8FUiopADs8dBwOxDufYK2kixIx5tYYrIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040067
X-Proofpoint-GUID: lR2IfRy6oJaG0yvJM4dO5oEqw1bw_8kH
X-Proofpoint-ORIG-GUID: lR2IfRy6oJaG0yvJM4dO5oEqw1bw_8kH

This series expands atomic write support to filesystems, specifically
XFS.

Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.

XFS can be formatted for atomic writes as follows:
mkfs.xfs  -i atomicwrites=1 -b size=16384 /dev/sda

Support can be enabled through xfs_io command:
$xfs_io -c "chattr +W" filename
$xfs_io -c "lsattr -v" filename
[atomic-writes] filename
$xfs_io -c statx filename
...
stat.stx_atomic_write_unit_min = 16384
stat.stx_atomic_write_unit_max = 16384
stat.stx_atomic_write_segments_max = 1
...

Dependence on forcealign is gone for the moment. This means that we can
only write a single FS block atomically. Since we can now have FS block
size > PAGE_SIZE for XFS, we can write atomically write 4K+ blocks on
x86.

Using the large FS block size has downsides, so we still want the
forcealign feature.

Baseline is v6.12-rc1

Basic xfsprogs support at:
https://github.com/johnpgarry/xfsprogs-dev/tree/atomic-writes-v7

Patches for this series can be found at:
https://github.com/johnpgarry/linux/tree/atomic-writes-v6.12-fs-v7

Changes since v6:
- Add iomap documentation update (Darrick)
- Drop reflink restriction (Darrick, Christoph)
- Catch XFS buffered IO fallback (Darrick)
- Check IOCB_DIRECT in generic_atomic_write_valid()
- Tweaks to coding style (Darrick)
- Add RB tags from Darrick and Christoph (thanks!)

Changes since v5:
- Drop forcealign dependency
- Can support atomically writing a single FS block
- XFS_DIFLAG2_ATOMICWRITES is inherited from parent directories
- Add RB tags from Darrick (thanks!)

John Garry (8):
  block/fs: Pass an iocb to generic_atomic_write_valid()
  fs: Export generic_atomic_write_valid()
  fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
  fs: iomap: Atomic write support
  xfs: Support FS_XFLAG_ATOMICWRITES
  xfs: Support atomic write for statx
  xfs: Validate atomic writes
  xfs: Support setting FMODE_CAN_ATOMIC_WRITE

 .../filesystems/iomap/operations.rst          | 11 ++++++
 block/fops.c                                  | 22 ++++++-----
 fs/iomap/direct-io.c                          | 38 +++++++++++++++++--
 fs/iomap/trace.h                              |  3 +-
 fs/read_write.c                               | 16 +++++---
 fs/xfs/libxfs/xfs_format.h                    | 11 +++++-
 fs/xfs/libxfs/xfs_inode_buf.c                 | 22 +++++++++++
 fs/xfs/libxfs/xfs_inode_util.c                |  6 +++
 fs/xfs/libxfs/xfs_sb.c                        |  2 +
 fs/xfs/xfs_buf.c                              |  7 ++++
 fs/xfs/xfs_buf.h                              |  3 ++
 fs/xfs/xfs_file.c                             | 10 +++++
 fs/xfs/xfs_inode.h                            | 22 +++++++++++
 fs/xfs/xfs_ioctl.c                            | 27 +++++++++++++
 fs/xfs/xfs_iops.c                             | 25 ++++++++++++
 fs/xfs/xfs_mount.h                            |  2 +
 fs/xfs/xfs_super.c                            |  4 ++
 include/linux/fs.h                            |  2 +-
 include/linux/iomap.h                         |  1 +
 include/uapi/linux/fs.h                       |  1 +
 20 files changed, 211 insertions(+), 24 deletions(-)

-- 
2.31.1


