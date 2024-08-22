Return-Path: <linux-fsdevel+bounces-26748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1DA95B954
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E86128548E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BD1CC173;
	Thu, 22 Aug 2024 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qw405P9U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cwmwlVYo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCC1C9EBB;
	Thu, 22 Aug 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339352; cv=fail; b=H2l+8Skak42qqM1Sh8zJMwO1JdDRnuTcg/nnaa+Yall+DadJT6Ve2BCCkyj4JqdGa418wlfXjlcEcpb8vtU4FXHYP3Lw1b0/uT6YF1hUSlrgH95RVE8zI6u0y4wgqOUmIE35nSZlXeaDvBjZY4ctmAGqUmMzgaKtVLKqh1LEfjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339352; c=relaxed/simple;
	bh=70YEdPp4IDCYhL99U+WwEWmD2cPs2jZei7ebYOUvl2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GTJuekvK5U7uIYmfcmQRfOPM9hFLJru4UWzWOZdRlB54+aed/du96kQ9N8RGzvsTDR65BppQ6hbDu9oXHWsrgZR9wCY0xhrHFia7IZrUURIHYzaolZnSjSfh5AGmR3jI+uo3oCzsJ6305RcCGElSjpYOIzX/Fe5iqh1qa4FiBb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qw405P9U; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cwmwlVYo reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQrEe014456;
	Thu, 22 Aug 2024 15:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Ze4osI45dr8pDcsPospHhDHh1tvwI/+qBOt7kHtoDXo=; b=
	Qw405P9Uree9bqzZdhILjLo0eNcqetRgpXrHi0cvLNoyfGGbc4240nVBXN8joJeo
	G+AhRRoQmKTOW9Xs0jKxOmwZ9aJm39fSs4VlS1iURQ1R5HMW9P4BYTpX4/GYX7IE
	2CVD+8UNBGc54EP7+dOLfmeSufmQil4srL/WnSxbcYzknyuLzem0sEzKMxzfaT2X
	Zx/cfTw32wSahcnZzxUh6SeNH8DvTTXxg0fXf/varK6m5iU3gGbT5i0nCIm6mwlT
	4lSDdYkU2MihOtBtCwHE4LRF7GW4doBi3ntBB31sFakJ58iSEobxaV5zGCmDRmXK
	8VA4Hom1rwUQHsY5ct2zFg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67j4vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:08:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEiEvc010703;
	Thu, 22 Aug 2024 15:08:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4167bws3hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 15:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms3HBSPCcdSlhsHI1egMb5SoHgL7myc8kbHEXS+7i8KjJqZM0dNBVC+jbW2r7DzGbhVxDs9KFNM2O+0Dqh/WNsJ6YLxDsuSzy8XZEqoYYnjVRrRRyFNhzxn143cbWF4Uew+bucleLTA3YlsDauEK3s/LlBDa9eD/R2+ARPgFvGm76g2BSsDLHGCvZQsVL2xgUgZU/ptB/i9CUp2vluNwyz7XEVqdR4EbGJOWJZdzJdPzhbNWakwQH9k+Jwye0FpjIQGYSKhrerOixQJ2gKLmG5zZVHmVjvPtivqpEY8AzaVSw0TZ85FaLPyKX4suLjyqZ8fWLVFeIvzLV9AEJvgSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTE4QauiPAmNlR0I9H0vpw6K0mj0bsBEKVnBURnOFcA=;
 b=reRZKWS+UA4eKOaPbzAHeOlE9z/5ovT6hUvgvauGNWF7MhOy9qNThBf5dNUnpfJlZ7Bpf+Yb8lzfRzofe+X4uQ55ztOKa/MEkCWB0DVckgCuK9JKbs9p9SC28/RlZGziLYrIzCLHazUfuAYyxdcR8sL9w5qUSJTWFFc9RN5TaTqQtMUbDH69EZyrIyQ0+XfSgajB5Uzh3gRIORus+ZgbyA1yHwY53kDhY/RIDEpZxW9VHhZonjdZtJ//XvHXkl3WYjAElEyuaOc3wet9mxM9G3VBIx0da26lput9YLuyCA73Qv93ACSczvFrN9T3aG2gSnaC3gV+KnOSY1ZnfQhr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTE4QauiPAmNlR0I9H0vpw6K0mj0bsBEKVnBURnOFcA=;
 b=cwmwlVYo1cbNFKFeLY4/H0y0lNuXPu8QYvXTERiUn1q5EEKgedobXe6L3czCDD+HobVMB3089IhEu8xgGancb/g0EvXBT83bSiNhd/mqKJ1yp9S/3tlYyixpvN+X6zMnxecl7MZVRZlgTDg59/QjCEq5Gj8OZ/TK6d31Tu7M9sg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Thu, 22 Aug
 2024 15:07:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 15:07:51 +0000
Date: Thu, 22 Aug 2024 11:07:47 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 05/24] nfsd: fix nfsfh tracepoints to properly handle
 NULL rqstp
Message-ID: <ZsdUQ1t4L8dfB0BF@tissot.1015granger.net>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-6-snitzer@kernel.org>
 <4ab36f95604da25d8c5b419c927d85d362bca2e8.camel@kernel.org>
 <ZsZa7PX0QtZKWt_R@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsZa7PX0QtZKWt_R@kernel.org>
X-ClientProxiedBy: CH2PR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:610:58::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8cc378-858b-41e1-b090-08dcc2bc30e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?H16gnwltHSTaNTnlv4QuSKEG5ywZIRBhAqcMk4yPvibofB2KNhRDygVIIt?=
 =?iso-8859-1?Q?R9B5NRdroKJsnNUX+nSotSt2rYv9ElobE+odN2cuDuqH4PBvKsn87DBtjp?=
 =?iso-8859-1?Q?URBjTRNQqTb5iDwGvTUGx/JjRP9ovGBelbI+Af2QDXR4eLD6YjSP4S7Vvv?=
 =?iso-8859-1?Q?c6R+pTLv0D0W8KKwGigDO45HOoMmGAoVbjtnM9wB/wYG9fbaIVnmcbFJvi?=
 =?iso-8859-1?Q?0OjvOkyoqgLfAataIh95iDeslzlkh1HXh6J0FZ3HFSnUqvTwoVnAh4VGtk?=
 =?iso-8859-1?Q?eD09pyqBcbkMh98RMcdDo+QSSjyUhroxKbsED2lTdVcaoRr9MxOUXvNHvT?=
 =?iso-8859-1?Q?GUmQ8druehyy4GAHIsztUJ8ihzM7rgfmY1snujMLKZEs87iEOKAhEoEfga?=
 =?iso-8859-1?Q?zcz0nuQ4VlPGcfyuEEY4M+6jVONUwjQpFzNbQ3dwt1Y3yYSZAucC/ZL9jm?=
 =?iso-8859-1?Q?aTYiqjtVpCfgb5rZmr2hG7C6Jwptew6+TcZ9BZFFrYwxnjCiYKiY0fSl2X?=
 =?iso-8859-1?Q?I+EVbLvHPNMOKv0rWS59kKwMiwKl7QMPXFuH5jNACRLVoGQIJewbs1Z065?=
 =?iso-8859-1?Q?Vo1nlZd02BcNyHBBei95DINW6qblmSZu4UIN3c+dbSaT9DseQCgFnT3P2o?=
 =?iso-8859-1?Q?U1xpK/re5LEd3YEAOZeN6E4e+lsVZLYrQECdfLA57pXYxggSUa7HnWs8UT?=
 =?iso-8859-1?Q?zIndGx1qsCQtboWVR4RfuXDCGRMceAzc4KK4mLDYMNVLQ456XbyCId6mZS?=
 =?iso-8859-1?Q?Ulc5yay+/iwgdTkt21tzja7MM8aTflqfdrEbQPiHWRoG7shNayjvrh3QGU?=
 =?iso-8859-1?Q?t6OxOkNhT54b0x7ZpCu5/CCZbffBhTh0V9v8Fr++XfgK9qqi0ENhlcEEFg?=
 =?iso-8859-1?Q?+TZGbVffIz5dFn92SoMperKvZmj6SAJ+W+HqxlPayNkveNGdQkyu9fURtn?=
 =?iso-8859-1?Q?lQ03HjR3klR/qAAc43OfmFtvCC0jr46i2PSTWHeBl0YfHQjqIfp9T8J6/Q?=
 =?iso-8859-1?Q?mpKR7Pmgy6qvED2HZm/sJg9geedmbBYRFfhePFe3wjhhJy19lubdIZTr7a?=
 =?iso-8859-1?Q?G4lYkxUr+hqv+7FC1ij0G/+XmOfjKNniOP5fpN85hRLQGAselxHnAab2YA?=
 =?iso-8859-1?Q?QG6DalD7N4rT9zG5xx4omeqZi6O57tuczSZB/qC8DDftvhAb1IN579gdrv?=
 =?iso-8859-1?Q?Ks7rY0WFEhP6wKjvUMKuRbRTHQAsXCMoGkk8sM44vKf4ZOd+1eWr8DC0ds?=
 =?iso-8859-1?Q?Z0S1kjMeS2pbXFF2P2jEzM3osjHiaXg6j/gd2/n11N9YefvQeUQ82+u/Xr?=
 =?iso-8859-1?Q?XGARXLvVHXmBg2JUcV3m2bJx40VrTonDPTMros4HzL1sUh+xpBr0y5Ff2+?=
 =?iso-8859-1?Q?r6z+4b6QMiEgSgwLRwOlK7Re4vqVSPsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?WxL1y1+CLdczJewapUQ1ZwNLlPvyG0hTvk0Aa+QEVMLHPVPWSsNNuJ7rWc?=
 =?iso-8859-1?Q?IqDJ16P29owe/hn1tP6vgWUFLFbQscawhEnipNJrooAQAZ/9u2x7tSrFuH?=
 =?iso-8859-1?Q?QRdRbTVeGNv8T5T+pg+9T7v8+YgewGP21SY3mfSmagk8TG8Hxu9olGN7iS?=
 =?iso-8859-1?Q?MT7/JLUEyJ69kbec9wFNr798mRGDOkgvymixfUxA4l5xgou553JpG9+8oa?=
 =?iso-8859-1?Q?J4RQaamTh08+hB3lX0ECsSGYekqGMqNI1H10zml5IDeD+NPfcLlVmJ9UcI?=
 =?iso-8859-1?Q?5clMkpYBmgre1EaHobXL3Y4QNNacgkYopayotTmMRVCjnX2JcykqL+bQOc?=
 =?iso-8859-1?Q?BhflO69+bGrFQxUBboNyT+IN/ghP/e3tDl/7o/xRT77dRBpGRIewigkwAe?=
 =?iso-8859-1?Q?F5j1WzhAeK/xZ7cbWfgt9qNOK8lCQDLsg4BTFe328cemWhXaADDi/HkR3d?=
 =?iso-8859-1?Q?zOdRZD9SrIf+bAu2/P2YQQwMR/331kb43JHcqPd7n4Q4D4Pw7yFQTUr59M?=
 =?iso-8859-1?Q?XSk+fM2bjueGt1WRf1gSFhEH/+Fq9+s/Avymkt+82yfH+YN1+MLjvP4geC?=
 =?iso-8859-1?Q?SCA0qlxAVwm2X4V/cFA58BOWSKuTafqHSN9P+0KmV7D0fH6tT5CsPsL6UO?=
 =?iso-8859-1?Q?bil0lKJzokhP+272MrcRgQCFjIK0fxT4QSsmiRwGMjQjNCUMIb8G+S4N+V?=
 =?iso-8859-1?Q?0bnZlZd/bmYIgLETfdpNzurvO2hSeI/+DoS1jjXAHmkKHm5f+uXDrAcg48?=
 =?iso-8859-1?Q?PCaLvHxmoUi4Puq7KSt8wd2CUWJ3M5o21BGyENDlHx5O4f1N69Pw5FJWYB?=
 =?iso-8859-1?Q?qp8Lokh/OdDKwrn6ZYfylkATrsnSUcXTZbh0CeyWfHwqAvA2ZiWtTLNDAL?=
 =?iso-8859-1?Q?TKGE5mgUN0CrS57+moSFTX2O8mcfwT8GQcO/9ypuozBlxjD+Qq7b1r+MKl?=
 =?iso-8859-1?Q?1mw0dvnsTk/ItcTtYkLsdPGvOIAlIWwxxbURxpe4y+u6nsABlwWW0ORmK2?=
 =?iso-8859-1?Q?6S8yJ+fIrY+rFVI/kTpHA7Z16TNs2E7mtk5lS6+se+HQi2Vkgvi+oZfD32?=
 =?iso-8859-1?Q?SitKFV7JBr8oA78AHs4Le1Z6e5iyhHZB+OVq6USz6/pLAejpmbgInOhHxR?=
 =?iso-8859-1?Q?nI+ZmXq/2i6ByKMg5ZwaTJf0RoQTMnqyUanYLJP9Ro5JtDupWYEVierkLg?=
 =?iso-8859-1?Q?9IpLGsoqWFdI/wzry9Blyzkk/U35+YfSkQAjMvy43XgiI2bfiLwWRbU+Bl?=
 =?iso-8859-1?Q?ufgchN+3DFdPHMo8iPo5v04pzMYx1abzuuImA1Tz9XoKt90QSUXDcW+Os4?=
 =?iso-8859-1?Q?fZvBWsYU7EQ3I9MVZv8sKRa9WbzZnWQ/5HLZhMxEmMJNG6bUDfkeciLrhr?=
 =?iso-8859-1?Q?gir1G5cyOTHwMLaM2RTU0NxZ0Z/MKwGSDlKj9+fQ/EGpQxTM/GvZW2h8nL?=
 =?iso-8859-1?Q?g1B4w5r4rJIdVJ5NeTnVxCM6HHJStnC2VUhSFzDhA8h3hmh4l/XqnJ/Iyf?=
 =?iso-8859-1?Q?ON7vlKhMedYSH0gMGYCnFrz0bFiVcqb/T9t1I1VS0xBxUKmZN2v9kulugu?=
 =?iso-8859-1?Q?JdKXHMsxpFXVzHkJlplytvP7LnmsUTVRYKs8Ywda5h9rRcybfSdOj9qixY?=
 =?iso-8859-1?Q?NYXTq9bBLzexx57onAx3wCHHbsrbZl792H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J7lzRiqyq5ahiHsNTwo0ETrEcTRf0vP+jIKHucV5n5CLx50Ma0pibqrQHURjNYifPEpFqOsSgadAa2mYC3Z8y7+Y/TQZOC9f2MlpMDt8IfTolCZTzMEk8nkPxVYrMswYqS6UkIWgwl9MY3ur/MUI9gidddSfEoC4SgI0ggFopVNzQW1uWz0P3W48SlF/uqa2m7kkHqRNINBF9PEywdH5zgYamfd64CUZ2t2WTC4ZTNx53KSw3bACjyMjk5FGehgI/e/RmcrJSrQTdZXUfQxX7xqwPL1Pe8tUSn7Zn9WZS+Uhj7+8njJP4M6x6dZ8+25AnljjQnufL1cX1ls/4Z1Pt2ZNqmjyk8v3yHiCFPk2Zl826jn5i4tNIBD1AiC3wjTw/yejNr2aqVJEAfWxtuyiZecUqHIGICR2ME1RJKaWX3RXz/vwFQRozO9oLgn+cMCt1aOKAizm25QQhmAmmIyahg/7xXso7dvbw0mcoPtVx4YxlQ+VtMKBA14/GETnYZxKV4SRA4pF8n1ka0pTwQ7x7mV2+yI5cCOUUeJMNOa3KYOzSNoZuAtTljXDMMxSQGZwwvlvO91htf1ckSSOvN2MDQaF05TdB0/F3R7C3ezHlhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8cc378-858b-41e1-b090-08dcc2bc30e7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:07:51.1455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkosKzGxzsl9a33gyY5s2Vrgt3qIPotEvGRT7LITVqnnfJMz5n1fwvnHb6Ypaq73L7GjvD1nznv2FeLZvF6UXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220114
X-Proofpoint-ORIG-GUID: DwfEaMZUvjSKJ_v5D7FNrVYFa-BbVUAe
X-Proofpoint-GUID: DwfEaMZUvjSKJ_v5D7FNrVYFa-BbVUAe

On Wed, Aug 21, 2024 at 05:23:56PM -0400, Mike Snitzer wrote:
> On Wed, Aug 21, 2024 at 01:46:02PM -0400, Jeff Layton wrote:
> > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > Fixes stop-gap used in previous commit where caller avoided using
> > > tracepoint if rqstp is NULL.  Instead, have each tracepoint avoid
> > > dereferencing NULL rqstp.
> > > 
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfsd/nfsfh.c | 12 ++++--------
> > >  fs/nfsd/trace.h | 36 +++++++++++++++++++++---------------
> > >  2 files changed, 25 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > index 19e173187ab9..bae727e65214 100644
> > > --- a/fs/nfsd/nfsfh.c
> > > +++ b/fs/nfsd/nfsfh.c
> > > @@ -195,8 +195,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > *rqstp, struct net *net,
> > >  
> > >  	error = nfserr_stale;
> > >  	if (IS_ERR(exp)) {
> > > -		if (rqstp)
> > > -			trace_nfsd_set_fh_dentry_badexport(rqstp,
> > > fhp, PTR_ERR(exp));
> > > +		trace_nfsd_set_fh_dentry_badexport(rqstp, fhp,
> > > PTR_ERR(exp));
> > >  
> > >  		if (PTR_ERR(exp) == -ENOENT)
> > >  			return error;
> > > @@ -244,8 +243,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst
> > > *rqstp, struct net *net,
> > >  						data_left,
> > > fileid_type, 0,
> > >  						nfsd_acceptable,
> > > exp);
> > >  		if (IS_ERR_OR_NULL(dentry)) {
> > > -			if (rqstp)
> > > -
> > > 				trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
> > > +			trace_nfsd_set_fh_dentry_badhandle(rqstp,
> > > fhp,
> > >  					dentry ?  PTR_ERR(dentry) :
> > > -ESTALE);
> > >  			switch (PTR_ERR(dentry)) {
> > >  			case -ENOMEM:
> > > @@ -321,8 +319,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > >  	dentry = fhp->fh_dentry;
> > >  	exp = fhp->fh_export;
> > >  
> > > -	if (rqstp)
> > > -		trace_nfsd_fh_verify(rqstp, fhp, type, access);
> > > +	trace_nfsd_fh_verify(net, rqstp, fhp, type, access);
> > >  
> > >  	/*
> > >  	 * We still have to do all these permission checks, even
> > > when
> > > @@ -376,8 +373,7 @@ __fh_verify(struct svc_rqst *rqstp,
> > >  	/* Finally, check access permissions. */
> > >  	error = nfsd_permission(cred, exp, dentry, access);
> > >  out:
> > > -	if (rqstp)
> > > -		trace_nfsd_fh_verify_err(rqstp, fhp, type, access,
> > > error);
> > > +	trace_nfsd_fh_verify_err(net, rqstp, fhp, type, access,
> > > error);
> > >  	if (error == nfserr_stale)
> > >  		nfsd_stats_fh_stale_inc(nn, exp);
> > >  	return error;
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index 77bbd23aa150..d49b3c1e3ba9 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -195,12 +195,13 @@ TRACE_EVENT(nfsd_compound_encode_err,
> > >  
> > >  TRACE_EVENT(nfsd_fh_verify,
> > >  	TP_PROTO(
> > > +		const struct net *net,
> > >  		const struct svc_rqst *rqstp,
> > >  		const struct svc_fh *fhp,
> > >  		umode_t type,
> > >  		int access
> > >  	),
> > > -	TP_ARGS(rqstp, fhp, type, access),
> > > +	TP_ARGS(net, rqstp, fhp, type, access),
> > >  	TP_STRUCT__entry(
> > >  		__field(unsigned int, netns_ino)
> > >  		__sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
> > > @@ -212,12 +213,14 @@ TRACE_EVENT(nfsd_fh_verify,
> > >  		__field(unsigned long, access)
> > >  	),
> > >  	TP_fast_assign(
> > > -		__entry->netns_ino = SVC_NET(rqstp)->ns.inum;
> > > -		__assign_sockaddr(server, &rqstp->rq_xprt-
> > > >xpt_local,
> > > -		       rqstp->rq_xprt->xpt_locallen);
> > > -		__assign_sockaddr(client, &rqstp->rq_xprt-
> > > >xpt_remote,
> > > -				  rqstp->rq_xprt->xpt_remotelen);
> > > -		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> > > +		__entry->netns_ino = net->ns.inum;
> > > +		if (rqstp) {
> > > +			__assign_sockaddr(server, &rqstp->rq_xprt-
> > > >xpt_local,
> > > +					  rqstp->rq_xprt-
> > > >xpt_locallen);
> > > +			__assign_sockaddr(client, &rqstp->rq_xprt-
> > > >xpt_remote,
> > > +					  rqstp->rq_xprt-
> > > >xpt_remotelen);
> > > +		}
> > 
> > Does this need an else branch to set these values to something when
> > rqstp is NULL, or are we guaranteed that they are already zeroed out
> > when they aren't assigned?
> 
> I'm not sure.  It isn't immediately clear what is actually using these.
> 
> But I did just notice an inconsistency, these entry members are defined:
> 
>                 __sockaddr(server, rqstp->rq_xprt->xpt_remotelen)
>                 __sockaddr(client, rqstp->rq_xprt->xpt_remotelen)
> 
> Yet they go on to use rqstp->rq_xprt->xpt_locallen and
> rqstp->rq_xprt->xpt_remotelen respectively.
> 
> Chuck, would welcome your feedback on how to properly fix these
> tracepoints to handle rqstp being NULL.  And the inconsistency I just
> noted is something extra.

First, a comment about patch ordering: I think you can preserve
attribution but make these a little easier to digest if you reverse
4/ and 5/. Fix the problem before it becomes a problem, as it were.

As a general remark, I would prefer to retain the trace points and
even the address information in the local I/O case: the client
address is an important part of the decision to permit or deny
access to the FH in question. The issue is how to make that
happen...

The __sockaddr() macros I think will trigger an oops if
rqstp == NULL. The second argument determines the size of a
variable-length trace field IIRC. One way to avoid that is to use a
fixed size field for the addresses (big enough to store an IPv6
address?  or an abstract address? those can get pretty big)

I need to study 4/ more closely; perhaps it is doing too much in a
single patch. (ie, the code ends up in a better place, but the
details of the transition are obscured by being lumped together into
one patch).

So, can you or Neil answer: what would appear as the client address
for local I/O ?

-- 
Chuck Lever

