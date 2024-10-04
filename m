Return-Path: <linux-fsdevel+bounces-30949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0B98FFAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F591C23180
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15D1553AF;
	Fri,  4 Oct 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HsggSfhQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0AbOGXE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFF147C86;
	Fri,  4 Oct 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033842; cv=fail; b=HjuvtWCdKhn0u/6MTtnRFQbkKY4WJSS2D51kskSUNqyIUevDUGWEgxSSWPrlMCj3P53IKllrFaq+ZrbBY4Y4vGmtZ0dX4Fx1c/LF6QM548kHyQ0tjoU/n3aXvqk0bFY1oPg/SOZxmkNVCMzwZtbiwZhyr6OJzQ2K6nF4VH1sWVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033842; c=relaxed/simple;
	bh=vy/UgnvFN9RvyoPHn1qLGFRuWTkNA4MYDT9DT4DzS94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UITQD31nsvEAiwj9EfhVYTeRfCCnd5T0tdBKsvwZZshvG6Y/Xw5W5h/eRyUMixVw1Gv4AWO3dQ1rSMklABArFqBvHZJQpa2OEt0eBc2dYBKQwD37X+D80wkhbsxBMncoNLaEY7IwsAitYomvzoTubvLEKG44RyHhzmuMmtCeASw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HsggSfhQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0AbOGXE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tdUI013485;
	Fri, 4 Oct 2024 09:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=SZTlQiMKnf70FoMsvIMZfYtw6W6E3f7oepCsr97QeC4=; b=
	HsggSfhQ7Rtov5aZyI+lY/pYjMX0Ig/n9FPNJPSn8eQrM1R6U0vF/fcLLqj62cXQ
	EsICxgZrmFoCJCQmbN3J4Nsi3IBPnlKqJes5HmzhB8sN8DzitdZRI2kRdRkZAsBc
	1m0gwOWJo5pHRrLvic7LRBl+Huk4H9Sax3Hc6+qmUhWWorgXj/MUVDYD2YA27vao
	w1tiHosI7+aYuTESH47/JF3T5N/rwNBqq6q2fx6uCOywurFtxB4iH9XfQUM2wiIu
	TY7bjspIl9j/DInSaFQ8bwkfVxr11ROBCupldlO/XTy6WioQt4oT/zFxoOGdiWRO
	CG1uq919vLXRDTw1qiJdgw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204es6pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49495IE6038110;
	Fri, 4 Oct 2024 09:23:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057118t-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOGyuAfBmv6tYEsFv2nVooTQIwq9K36uk+BxyWohTJkaBmTgdpb1tKwady49+urlm+xf4hmuFMV6GnC2sI5X2bvzvZu86Vr9i18e3utSaNealA9A+ij1QtQkARLxplNssWohv2qoFCPD6jl/J7gHkhICGa4nKvxLhxm1fVz47Tfg9542V3VqMN0lQT7Ds47yK4JCwbVpKpR5FTXmA+h6nmghnDX2BI83FJOUb+J8ZBMkE1QLlmepCq0C8tJjOuWq5/QNfNwawUXrNM1nFp3IC/FXvB1o7XIuVQsdy4Gk9qcJdW0iOwa2lQSEiCgloQf6+xjJ7Ujr77zeWQiVBjAI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZTlQiMKnf70FoMsvIMZfYtw6W6E3f7oepCsr97QeC4=;
 b=CQCH5HaoYFQJ6m/GkJxHjwt/YIfcPYacrNkL+xeU2KUr0GPE3z1JbVDIBpz7SwHmpR674X+rNA2D4bapz9ik+QRJaiXyrb1iXGRC9++gjreK80RFPVllA4dHJ5UgF1mens3IU4PG/fPCbCZJJX9KZelupsH2PdVgiDdOlFZZSao6ZcSVVNbn+9glUxR97Kn5rsUWlGcMNWb8VCsi10rxDc/0kdOCT1fTn3ZDTfEbw9kp6esRYLbUXZsbFjbW2TZSI23pyuI+1TsY/YPjyPDONsDMzvYeB/pCl0MIEShkOw1v/9YhhEtF7aHQMfOXzyoYYV98AHUSpm41IGC3CiU86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZTlQiMKnf70FoMsvIMZfYtw6W6E3f7oepCsr97QeC4=;
 b=j0AbOGXEPpV3X9CeKN1J7rpjRphrrP5yArXo0jVCDEf751vqi8Jtq7rra/UQMPAIFEwE2QPd5QsTevJotuIBEwNA9INldgFT5gG5aqMtY5T/vS6VHQAplR2ewVpHFAugdgFFM2C5X2q45XJsQn0+SQuiu/dNFkciGq4SSy8u/2Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:23:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 09:23:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 5/8] xfs: Support FS_XFLAG_ATOMICWRITES
Date: Fri,  4 Oct 2024 09:22:51 +0000
Message-Id: <20241004092254.3759210-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241004092254.3759210-1-john.g.garry@oracle.com>
References: <20241004092254.3759210-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: 943eedb2-4439-4a28-5604-08dce4563344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x+H5BTBkQCXZV/TpHuGhQOizBCt66Q20/6d29T2cFi6Sekfktmw19i60VG9O?=
 =?us-ascii?Q?xf3Osan/rX1dFyuK1KybYDQ7L625rhcpNPOdS5XO8xh5JnGXrCZIQZ6PNmnn?=
 =?us-ascii?Q?zcO2wx5kvXbZb8iIh6zl9GWEMi2nCTqoHI4X90pNq4TCdTB265YpkSZ0V/fk?=
 =?us-ascii?Q?7Nw9MLdZYj7gDcVenBCzhlPMRJsyodrN8/2ZgZzEjqGLK/qHbTI8mRLPcxFa?=
 =?us-ascii?Q?w4SEMfiKrWxXB8+oL5Z6eRaoDUAGxxqnnKdYNMZxcJxZnSFJVsRA8xz9pIFK?=
 =?us-ascii?Q?Xu6T0XjuVT5i1S3RDwU0KM4sJHSIqeNvIeT8C0u5eyF/+KKmQ9RtW/I0aO0A?=
 =?us-ascii?Q?1YIDbXoayrm90vgdT9n5nO1VWfxMqAUMYYF4KCXlplpHeZ1fse/WCeM2GRTe?=
 =?us-ascii?Q?8gyQk0qQnR7fJIVhPWPWGF1w8I00GPyB1zojGCDtBLfylTzGsXfw1CfUWb1p?=
 =?us-ascii?Q?booSEZ2ortLaUeYBguz5kbsMhe1ZsVSwSrVRQC/8mv6E6tiD7799PV8TWlCS?=
 =?us-ascii?Q?w8Zp4sBdGGwkgICKSiXQ4WQP86M37UQ4tnlvDYq3beXWREuEdfNJht+g+mTr?=
 =?us-ascii?Q?RtzGsnkwmm4jh/HZmCaNzE375hDMH7bJd4OMXAeJyMitEBwpEFODPVbqgsDM?=
 =?us-ascii?Q?/aEiLBcn4mcvblbI+VItEa2npdHJQmL7+83+TgkMLQvaktFt0S1kULXSNXec?=
 =?us-ascii?Q?mKp/rArA7kpHHAPUr1G1jtz97QgU0gYsXDCCEIgasb6PlIwrSqXHVnB25k1h?=
 =?us-ascii?Q?YVFUtyupJqEvzYBQN+bdTYVYNBNSbMYLXc86Zq0+3fTKcGj/msoyp+qz7OZD?=
 =?us-ascii?Q?Tn/JLDmYN1UPHrOHNGH85cr55ui8oOJblcVW/tPC1qiu0TBjbTtmmiVYCC5T?=
 =?us-ascii?Q?dK9vNzCNMVH2tLkeLLHenQSpn5ANmd4eFRHja1hvxRhroT76mUBXbmjrS2ze?=
 =?us-ascii?Q?9s+bndjV+K1Ah3d/h9CWOXy52Pzj+Q6vLZSOxcDorZfVT8DlNfR9wczBmwW7?=
 =?us-ascii?Q?9GR/pBwJAQYVO1uN21QYWG/yuwfjHeO3gDmv9zapYPSLhKftJjF6AR1Ud80c?=
 =?us-ascii?Q?oYvysQP5Oyzt2B3vhbIZOwAkUeBj9dDchrlSyTBXZKIG2vhKEJ8reCR29AYE?=
 =?us-ascii?Q?YP5C53HEIiccwBmQ5UkIdf+Hifo5z72S8Uj8EyKe5XLFJR5CEjlDLcgKJ2+W?=
 =?us-ascii?Q?ah5hHI8Va1NowliXpC18pYZchsem1o+9hOOETBHWN0ukuN8ed7fIOeK/jhjN?=
 =?us-ascii?Q?pIn5KpA8p0cgjtnohXrc4xQ/0ioWOa58l7pCwpPssQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSCvuB0zSihXd0sCqIksnY9ni0m4RaW7WPzW6UjNq3RG/XsAFy4axojr/JJ6?=
 =?us-ascii?Q?pUqzhwcS3hp4XXkCg5dogxJty6+LqXC5u3Xg5lUDpy14+CDWK197TU+ROxB8?=
 =?us-ascii?Q?5cps67FG5IEp9nXdn+fiRAcwy+R5P+0v6imKQn8HTQo3JjRVtcXaQeyUXFk7?=
 =?us-ascii?Q?mJqAfomCQo0TkHpnHp8oDP47FJCWSnDhgh7zwlgnxBAdITIlhNjSSPnn9b53?=
 =?us-ascii?Q?7v7Wpdu58D7U8Owa4THuTNVDOdgOjvlB86ejFPdCjcyFW9/u845eKq1CqstW?=
 =?us-ascii?Q?Wu3LCbaKd61vltYZu4ChoFDq+c1QThdKk9gPiWy6KgMq0aCUrJageAiTKRv7?=
 =?us-ascii?Q?tK1v2WTyg+z/9Hl3vEG7wNH86TsMqIr+oDiu1ROQJLKd+zwGo0XcHwTsjkXd?=
 =?us-ascii?Q?A1g2aQHUx+08Iva7f4AyhO7+bLm0uBAKqud7Qk2sz5+sBlEzgh/faQR6+Rqs?=
 =?us-ascii?Q?I11dF9moBuLydcsdY4Q6DOeW52xHqwhS2zeXxRFUO5MvgovmwmdbASyC46pr?=
 =?us-ascii?Q?irdpT0OnrMCrnurC2C+ip+cHCvrEtKmBSKDB/SUyUIswz44VBs8ycfb8MpGK?=
 =?us-ascii?Q?q+aO/kfTKirpkjEkgTARUpVmKmHcz8C5RElXIsOP6xbEoejwvki+8Or9Wx6w?=
 =?us-ascii?Q?GSslWbVLCoXz2ltooUnvNpwQjiNwi+69hlLl/+tu2BxHgRqYtWLIYAoUltxi?=
 =?us-ascii?Q?lyMYeKpknWa7OB6j8JfS6pEzo8cmsiagZXQfFHFSYjUrkBD72D9TThIcFwB3?=
 =?us-ascii?Q?BHrE6Rp9SOeu8VUXA8QNNiQMA40U08yaDCJ6KIjRDFiMSXNpIYbkRShU5K1m?=
 =?us-ascii?Q?7JlbW9lMQ6YgR4b2iaIEeYiWAID0d3qBvTWUgCK/fjS5yf2DpNa3ZTdwDFYO?=
 =?us-ascii?Q?dNzuE+nOxQFLVUke2V6KQ5bo865WlfTrPo9OD0NTwWxIGczzdpHam4rOlZ1B?=
 =?us-ascii?Q?o75tEtVHjuDhqflaCD9T4ITEZAUUWo/BGCKMEjGGtSGNjCrKTgH2b/ebsE91?=
 =?us-ascii?Q?nfuRLjVdlQCenWhjdkTx01UTKX2zBqRKrltAsgBhkZOYAibRkxt10WojoiVH?=
 =?us-ascii?Q?0mCGMFhfs+SXd23E+TVFJhWr4rT3tELTjA88sps0uDGgDYyVIHWXQI2P3L6a?=
 =?us-ascii?Q?kufHWFJzcdqJ8oUeN7lO4BnTfMX2QZYomvm5un/XkDcXCWNNjizGp/l6B+Fm?=
 =?us-ascii?Q?KXb4uib4+M8Kzaxr6bWR/qV9jjdCi7QqlzCEZJNiNo319tUMbLHWSQpmZICi?=
 =?us-ascii?Q?hb0iBMBseYtlq8RDzfB1z+cgSG1aO8ikBRvTuTqMZgBjBKV4ZEPoQDHbU0gg?=
 =?us-ascii?Q?J1sd3g/HHEGBpHKJJX/ud2yQ0aUIxG0M5LXWVRUNiR9JOWTB0ol3eXG5e7go?=
 =?us-ascii?Q?lcq3d72fq3NLdQlAm+qvaxzm4gU6oXXy76zqsvyIqkwa6nd4Equp1phokndM?=
 =?us-ascii?Q?MQNSdZLxKkKr3ebVdLOM3Ii8G+k2CU2obLHNnuwXGvCQ26vj2WfRzHphjoe0?=
 =?us-ascii?Q?YAM5hmFKflWUrzjWvovVQWZ4lfFF6KFaszFtSPeaobm68HMjW8kxmTORmkHI?=
 =?us-ascii?Q?G6fwyJB1WxQTyyGvgUvMFTV68dl7eqZr8UaVHSA2PCx+yRfkdnJI04AqVVC9?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z66paDGaUi4M89tEdrbm/yBdbiKwa0kcZrhDIq4OYc+w11De5BBR6Y1e+D2I7177cowksKpximW/JSn/Ljzq/WC7aF32lP9A/lu4ufZB1Ri0GDLPAsP08GmI9Pl/LSMc6JkTDoDjB43Cc8ltPrPABCuSINGUeFHANZkWcypDzLJkPR2yJfD8gyBSeCjJMmIyuKMrb0gH/egDxongtx37NGM/hgfPJxtdIJz38AL2gIjgzCVH0oHKLa9vWcN8YzuikAz8iA4E98bz82M4gnOctVUpd5o/3DTazdhU4yRTOqXne4LNCssZGJxCep4cmThua0G3GqJSxHdHEcOBaO9Ldjx+lQ2BbKoKJpmUZ/34qg9Oa3Vv9gS2YMWSwVWJPan6aj+yMv3IA2QkkRL8UCIWWKxKfqBkNiHLX/mARqjL0xJAhwxs906wXMAFVTihC/9Myb2qCi+c5aujHaGqRFgiFJ1au1yIu/oKTjILyf+xWq1tbRvrChfrp1Lbi/n7lCshwd3xtFt1FQH70x45a9s170iZoKme6H2HBofO90LxqJprTQFmykVuQUk5VOPxXcQ8cVQgKapEfku3o02m0hO3GMcePR/0SSktyJVvnxQ+cNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943eedb2-4439-4a28-5604-08dce4563344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:23:25.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu1jW+4cZ8YPxd+U9HrjLU9LVLBHuD4csceZg9PWFBT30LHPr0irQ0yJMP+PsqT4ypYwEE/DqiUImSmjouSjqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040068
X-Proofpoint-GUID: duaR-a-0y2wSES1JUBm68e2i8aoV-UGU
X-Proofpoint-ORIG-GUID: duaR-a-0y2wSES1JUBm68e2i8aoV-UGU

Add initial support for new flag FS_XFLAG_ATOMICWRITES.

This flag is a file attribute that mirrors an ondisk inode flag.  Actual
support for untorn file writes (for now) depends on both the iflag and the
underlying storage devices, which we can only really check at statx and
pwritev2() time.  This is the same story as FS_XFLAG_DAX, which signals to
the fs that we should try to enable the fsdax IO path on the file (instead
of the regular page cache), but applications have to query STAT_ATTR_DAX to
find out if they really got that IO path.

Current kernel support for atomic writes is based on HW support (for atomic
writes). Since for regular files XFS has no way to specify extent alignment
or granularity, atomic write size is limited to the FS block size.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h     | 11 +++++++++--
 fs/xfs/libxfs/xfs_inode_buf.c  | 22 ++++++++++++++++++++++
 fs/xfs/libxfs/xfs_inode_util.c |  6 ++++++
 fs/xfs/libxfs/xfs_sb.c         |  2 ++
 fs/xfs/xfs_buf.c               |  7 +++++++
 fs/xfs/xfs_buf.h               |  3 +++
 fs/xfs/xfs_inode.h             |  5 +++++
 fs/xfs/xfs_ioctl.c             | 27 +++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  2 ++
 fs/xfs/xfs_super.c             |  4 ++++
 include/uapi/linux/fs.h        |  1 +
 11 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index e1bfee0c3b1a..ed5e5442f0d4 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
 #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
 #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
+#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
+
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
 		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
@@ -1093,16 +1097,19 @@ static inline void xfs_dinode_put_rdev(struct xfs_dinode *dip, xfs_dev_t rdev)
 #define XFS_DIFLAG2_COWEXTSIZE_BIT   2  /* copy on write extent size hint */
 #define XFS_DIFLAG2_BIGTIME_BIT	3	/* big timestamps */
 #define XFS_DIFLAG2_NREXT64_BIT 4	/* large extent counters */
+#define XFS_DIFLAG2_ATOMICWRITES_BIT 5	/* atomic writes permitted */
 
 #define XFS_DIFLAG2_DAX		(1 << XFS_DIFLAG2_DAX_BIT)
 #define XFS_DIFLAG2_REFLINK     (1 << XFS_DIFLAG2_REFLINK_BIT)
 #define XFS_DIFLAG2_COWEXTSIZE  (1 << XFS_DIFLAG2_COWEXTSIZE_BIT)
 #define XFS_DIFLAG2_BIGTIME	(1 << XFS_DIFLAG2_BIGTIME_BIT)
 #define XFS_DIFLAG2_NREXT64	(1 << XFS_DIFLAG2_NREXT64_BIT)
+#define XFS_DIFLAG2_ATOMICWRITES	(1 << XFS_DIFLAG2_ATOMICWRITES_BIT)
 
 #define XFS_DIFLAG2_ANY \
 	(XFS_DIFLAG2_DAX | XFS_DIFLAG2_REFLINK | XFS_DIFLAG2_COWEXTSIZE | \
-	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64)
+	 XFS_DIFLAG2_BIGTIME | XFS_DIFLAG2_NREXT64 | \
+	 XFS_DIFLAG2_ATOMICWRITES)
 
 static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
 {
diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 79babeac9d75..7fe94d038e83 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -483,6 +483,22 @@ xfs_dinode_verify_nrext64(
 	return NULL;
 }
 
+static xfs_failaddr_t
+xfs_inode_validate_atomicwrites(
+	struct xfs_mount	*mp,
+	uint16_t		mode)
+{
+	/* superblock rocompat feature flag */
+	if (!xfs_has_atomicwrites(mp))
+		return __this_address;
+
+	/* Only regular files and directories */
+	if (!S_ISREG(mode) && !(S_ISDIR(mode)))
+		return __this_address;
+
+	return NULL;
+}
+
 xfs_failaddr_t
 xfs_dinode_verify(
 	struct xfs_mount	*mp,
@@ -663,6 +679,12 @@ xfs_dinode_verify(
 	    !xfs_has_bigtime(mp))
 		return __this_address;
 
+	if (flags2 & XFS_DIFLAG2_ATOMICWRITES) {
+		fa = xfs_inode_validate_atomicwrites(mp, mode);
+		if (fa)
+			return fa;
+	}
+
 	return NULL;
 }
 
diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index cc38e1c3c3e1..e59e98783bf7 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -80,6 +80,8 @@ xfs_flags2diflags2(
 		di_flags2 |= XFS_DIFLAG2_DAX;
 	if (xflags & FS_XFLAG_COWEXTSIZE)
 		di_flags2 |= XFS_DIFLAG2_COWEXTSIZE;
+	if (xflags & FS_XFLAG_ATOMICWRITES)
+		di_flags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	return di_flags2;
 }
@@ -126,6 +128,8 @@ xfs_ip2xflags(
 			flags |= FS_XFLAG_DAX;
 		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
 			flags |= FS_XFLAG_COWEXTSIZE;
+		if (ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+			flags |= FS_XFLAG_ATOMICWRITES;
 	}
 
 	if (xfs_inode_has_attr_fork(ip))
@@ -224,6 +228,8 @@ xfs_inode_inherit_flags2(
 	}
 	if (pip->i_diflags2 & XFS_DIFLAG2_DAX)
 		ip->i_diflags2 |= XFS_DIFLAG2_DAX;
+	if (pip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES)
+		ip->i_diflags2 |= XFS_DIFLAG2_ATOMICWRITES;
 
 	/* Don't let invalid cowextsize hints propagate. */
 	failaddr = xfs_inode_validate_cowextsize(ip->i_mount, ip->i_cowextsize,
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index d95409f3cba6..dd819561d0a5 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -164,6 +164,8 @@ xfs_sb_version_to_features(
 		features |= XFS_FEAT_REFLINK;
 	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
 		features |= XFS_FEAT_INOBTCNT;
+	if (sbp->sb_features_ro_compat & XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES)
+		features |= XFS_FEAT_ATOMICWRITES;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_FTYPE)
 		features |= XFS_FEAT_FTYPE;
 	if (sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_SPINODES)
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..e279e5e139ff 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2115,6 +2115,13 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
+	if (bdev_can_atomic_write(btp->bt_bdev)) {
+		struct request_queue *q = bdev_get_queue(btp->bt_bdev);
+
+		btp->bt_bdev_awu_min = queue_atomic_write_unit_min_bytes(q);
+		btp->bt_bdev_awu_max = queue_atomic_write_unit_max_bytes(q);
+	}
+
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index 209a389f2abc..2be28bd01087 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -124,6 +124,9 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_io_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
+	/* Atomic write unit values */
+	unsigned int		bt_bdev_awu_min, bt_bdev_awu_max;
+
 	/* built-in cache, if we're not using the perag one */
 	struct xfs_buf_cache	bt_cache[];
 };
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 97ed912306fd..1c62ee294a5a 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -327,6 +327,11 @@ static inline bool xfs_inode_has_bigrtalloc(struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
+static inline bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
+{
+	return ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES;
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a20d426ef021..1c980c863ada 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -469,6 +469,26 @@ xfs_fileattr_get(
 	return 0;
 }
 
+static int
+xfs_ioctl_setattr_atomicwrites(
+	struct xfs_inode	*ip)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_sb		*sbp = &mp->m_sb;
+
+	if (!xfs_has_atomicwrites(mp))
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_min > sbp->sb_blocksize)
+		return -EINVAL;
+
+	if (target->bt_bdev_awu_max < sbp->sb_blocksize)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 xfs_ioctl_setattr_xflags(
 	struct xfs_trans	*tp,
@@ -478,6 +498,7 @@ xfs_ioctl_setattr_xflags(
 	struct xfs_mount	*mp = ip->i_mount;
 	bool			rtflag = (fa->fsx_xflags & FS_XFLAG_REALTIME);
 	uint64_t		i_flags2;
+	int			error;
 
 	if (rtflag != XFS_IS_REALTIME_INODE(ip)) {
 		/* Can't change realtime flag if any extents are allocated. */
@@ -512,6 +533,12 @@ xfs_ioctl_setattr_xflags(
 	if (i_flags2 && !xfs_has_v3inodes(mp))
 		return -EINVAL;
 
+	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES) {
+		error = xfs_ioctl_setattr_atomicwrites(ip);
+		if (error)
+			return error;
+	}
+
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
 	ip->i_diflags2 = i_flags2;
 
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 96496f39f551..6ac6518a2ef3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -298,6 +298,7 @@ typedef struct xfs_mount {
 #define XFS_FEAT_NEEDSREPAIR	(1ULL << 25)	/* needs xfs_repair */
 #define XFS_FEAT_NREXT64	(1ULL << 26)	/* large extent counters */
 #define XFS_FEAT_EXCHANGE_RANGE	(1ULL << 27)	/* exchange range */
+#define XFS_FEAT_ATOMICWRITES	(1ULL << 28)	/* atomic writes support */
 
 /* Mount features */
 #define XFS_FEAT_NOATTR2	(1ULL << 48)	/* disable attr2 creation */
@@ -384,6 +385,7 @@ __XFS_ADD_V4_FEAT(projid32, PROJID32)
 __XFS_HAS_V4_FEAT(v3inodes, V3INODES)
 __XFS_HAS_V4_FEAT(crc, CRC)
 __XFS_HAS_V4_FEAT(pquotino, PQUOTINO)
+__XFS_HAS_FEAT(atomicwrites, ATOMICWRITES)
 
 /*
  * Mount features
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fbb3a1594c0d..97c1d9493cdb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1733,6 +1733,10 @@ xfs_fs_fill_super(
 		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
+	if (xfs_has_atomicwrites(mp))
+		xfs_warn(mp,
+	"EXPERIMENTAL atomicwrites feature in use. Use at your own risk!");
+
 	if (xfs_has_reflink(mp)) {
 		if (mp->m_sb.sb_rblocks) {
 			xfs_alert(mp,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..e813217e0fe4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -158,6 +158,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.31.1


