Return-Path: <linux-fsdevel+bounces-22114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63A9126DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FD51C25E40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872717C7C;
	Fri, 21 Jun 2024 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bo+Cyb2Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HkOzS7QH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50412E5E;
	Fri, 21 Jun 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977273; cv=fail; b=PCwZoPaHj9RaE9Bvo4l/9Wr3/UH2r0Od26Ju3IVIb5EGFSfIhPuqZXZ7MDN3LnSicEG43NeRVAFLm1rxprwknpQNGpozXX0fx1lbIrIZcWy7TtrxrsQXCuP7IC6CEcCQxov/8Ty0eXOSmwlWa3CezxbIxfQ893S6UvAz5ldN2Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977273; c=relaxed/simple;
	bh=ILCkVdvvDENIS8JAIfqexK5pIvE8gQqsOSvSixfl6uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nbroYN+b1Gf8J9+mWtYK4oq43ZeRbQ2QWe28py6xIkVZrlHsV88GNasQjMJlWibwHQPMT/sEfhYEg3rcvi6RkwdFe7MVSJR+kWSDSgs0Uzd+KS6zJzSrlDW1IaG2Pq6fobjmOB7e79ZCeoAG6YxymskNUQgoS+t5Wqf11rQ5VSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bo+Cyb2Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HkOzS7QH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fVMs026946;
	Fri, 21 Jun 2024 13:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=vr8opnYJPnz5uxS
	kJfue2PumZxha72jMw9SYifdURpI=; b=Bo+Cyb2YN1X+dLVU/9kdJxpSobftPgK
	a7kDPMsY4S75bY+hzXQVvFNUpGeGaw+tY3t7322SrDSbKF1EU0RIuZXzsgR2nwRa
	SLKfCIHIFMGI8potNzdWkvf5kZex8wgR37UH5KL1fPDZdnhJb4T9v1qIcrE5a2ix
	pPXazXGx/LeK47wb/phYZSJ7fXQ+gzj5TCJuf6mOLjlGWahYth5rX70/3K6lREiA
	+isuBl+oaW5U8RoC5kJbW18N9oZs7xVgyjewtfC96BKCxg9s/JbZCxxhOUcQoB1o
	ttmRe/QQH83GaX1L9M2Va2dJnj9BLVv1EZw6vJYXfs6GzZl5TTpVKag==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkjsstj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:40:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LDAgW4025304;
	Fri, 21 Jun 2024 13:40:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn646ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 13:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ2pUhiE3tgxx3XU97SKFd/VHC9joAJ24xleiDKGdGXS1qVr6/0+UHWQhBiTNrCh8/sjWPKqSEKtKgoJuJgPcs0zN3juriWA0ETIKT1XnBOsAK1B7FSsUmlMeT2p7ZYqeUB0d6m3cuzAy7Mj1k7oHsd9T6zrFdbCcc3Q1UEd+Qev51QjDnapEDdO13VKwslh9lS6Ui8jj4lNIBYx3uI6HxSfOxND+y8uJYMum3j7yAe/2E4/03ATkkiSvOK1HCBeqTHvWmDvw+pR2T85Uw7Z86K2Oyak083bnDIz4e4vim5wM+YAasoljrd8bUlOI2yUDRZacaHQsU7Ddz32CvoJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr8opnYJPnz5uxSkJfue2PumZxha72jMw9SYifdURpI=;
 b=V6VGQrx3oiXq6aactHqEs+gESFZF0N58U6LtqvrPKizDlnVfkdyOJ1AVMVtaF1ZSexsSwR9n4f2ObjRtNItSFH10q8hd0LisvtfkIQO1ulP3tqDPdeVhCJj1bMSHNqZmW2JdUdded07eBlVPA1sjpmtNg7Xncy7ngW9y/g6upJShHn+KU3jsxyPPM3Yrr/8D9ZbYrpDNoVXsz9N6GXJBAVgiGZSQinDEKLZnYdcr7SQpFhfPro9WLXYLnzQ9DTdi/IsY1zY0SvxgG14JJcHcCeSDz1r4J2qnoqIjEiA0+hdmf9EAnkxMRcnRv7Xewz/HTIBGUnoxcND65BEJwGzC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr8opnYJPnz5uxSkJfue2PumZxha72jMw9SYifdURpI=;
 b=HkOzS7QHX8K/8fPV3nDPROWqiC7ra209m+KZtJGkLw4xGieaL07GgDaT5+jPmgHO6v6WdplB1WhAB8Hl75I/5kBOQKViaFw0m7X84k2VH5dbTkoNq/bw9rrUe49PBWIM7+ZKaCxDrZGgyufykPd3dKzLtnQexRHr2DgpSuKWBR0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6652.namprd10.prod.outlook.com (2603:10b6:510:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 13:40:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 13:40:51 +0000
Date: Fri, 21 Jun 2024 09:40:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org,
        quic_jjohnson@quicinc.com
Subject: Re: [PATCH] tools/testing/radix-tree: add missing MODULE_DESCRIPTION
 definition
Message-ID: <rs6fzee44ilw6rhq2wauqwxdgnkgy3wudgr5alf2fuolrjm55f@32sznnbteorf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	willy@infradead.org, quic_jjohnson@quicinc.com
References: <20240617195221.106565-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617195221.106565-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ad39c5b-1b3b-4edc-c4f5-08dc91f7c419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YLLT2hAO9EGT7UcZMdiBrsVaM9PLtykNnkpgoMUSYTovogXvKuB4Ss1H7bYe?=
 =?us-ascii?Q?DouXZpyTJ4LtcvrpFQtF5irCu6dwbGE92ufIZT/ftI9W0wSyttkQ6wxmGALK?=
 =?us-ascii?Q?NNVbxRXFVNDydbylj8+5R4yqg4RxVVJoT/3dUkPT+2HpdsYlSKeBLPpnFDfu?=
 =?us-ascii?Q?I5G/eVqpL4BEfinTMCd90kV1beir609JeRxWECat7Gphgdc2xcJbWQK4byA9?=
 =?us-ascii?Q?+Jgzc+Uz4x1r/JyzZQsHw5ejPHGcYnEOYTuJsNIA01yR2iOFURhsH7nrRC/w?=
 =?us-ascii?Q?C/eYwVEtgxSE8fxBEdUzmqLgu3qp6SSkbKZ/Ir5ScHXKIrF74+lkmnZjS+EJ?=
 =?us-ascii?Q?Qq+x3WsZLH6EndWnlR0PO9Qb2a9MbjQAh1OmHGSlxjmvlEvggKfMMRSIYOLS?=
 =?us-ascii?Q?JZudRGSWL/DOHIng/oHNaUScSaOA1WPwbbgSGslm1SrbRJaMyU0XinVBos3r?=
 =?us-ascii?Q?3I1suhVks1YdHtWqhpNTofOQ/hDthhXt7hR1colTPicaAEmomPlJGkvwSR9+?=
 =?us-ascii?Q?lVJrC5t/aEItuF1nT6ZFuU13uVxO2F5vyoLQpgXSthAXOf53byg065z4q7sY?=
 =?us-ascii?Q?QyNUMsISzDIGaaAAi9kYXNObjacAyw3uK6XoEpfjGim3TQkfdfhjJOIISL6O?=
 =?us-ascii?Q?0Jdistp3Bfou6/x4VzwN+XifS+CFCRzOz+5ce7LDTmuLLoDUkbXdZpVnK8XI?=
 =?us-ascii?Q?7xc47d8km/8ZwxKb7Tc8gHARJkNiuNWuyCbqTQDXtNJnC7MYf9oJfe6bIMHV?=
 =?us-ascii?Q?lXuDwo9jdWXHsHQliCALyYpfKx3kMv8NXmbNJ3LvQkGXzmIo+133Y3gOvuop?=
 =?us-ascii?Q?GJHD7jPNAqVoKbbihC1aeL5CUnM5S23OTP4QLxWHumvvOwHQNvGOYAlhFY2V?=
 =?us-ascii?Q?fPLlG5PVsolQ9mS4KjfFYeqqUp/fFXEsnS6vLWBJM41PHrtp8qZpYW9Fiiuj?=
 =?us-ascii?Q?VTqfWdDlwYuiCDKGGX8eYPWnZeTBDPDd4X4aAU2DNjolHmXVbQFlwW/RzRPN?=
 =?us-ascii?Q?lojI0vboIlGZ5JrO9isuLjOvTMAMawMeDYrRD0mWIQTlArtznwAaxYYeHOTU?=
 =?us-ascii?Q?tT6IcHnwJBoDMlwEYs78xiLoFZwdiD163x4w1QwhsS6IfJ2aSvUhfv/UKUno?=
 =?us-ascii?Q?0aA/cLtUBhf1B3r23zbydLdr9fFso45dwEtSUVo3GrFgTNS66YM6apjF4Uq2?=
 =?us-ascii?Q?D3DeXKtG6TMExv8nZK0+o84Lfldt4is0RnsPP+NW/GCRFj9hXYwel5jjDk4N?=
 =?us-ascii?Q?2gXp1dUOVGaWEQQt70BrU0Y6GTWyKPUmcWOH9nRfFFD51nDYDmHTKO9cgKmh?=
 =?us-ascii?Q?bMInrR/PHfh9bvgtjZUs72zw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?79JCUiTNVJqRDO6gDy9zoDJ2ySgSbtkKMUlrYFcvA1u15xaLnxeRkyy7g2LK?=
 =?us-ascii?Q?NPSlOmiy/sG+eeyT7s/20u8Hqtot2zMF8mcvEe+1auPtfPdkveHT091u6egu?=
 =?us-ascii?Q?9cDESiRZNI9WhdHGLKTs9kYWm6JcteGPWsijxrRo7O7ZUgN+NbDNO/WdFD75?=
 =?us-ascii?Q?7epCPvJVV25e+uPpAuxRB7sgy1R4v3F1Kh9a8VDibXf1fZwoGey2DewdB+Xq?=
 =?us-ascii?Q?f0Gi1Mi7waSd3JN8k/x3d42LN2SZH5iy77QNOuZmTACgUTTtbj8rPtOcuZ1h?=
 =?us-ascii?Q?97I+JAo0BNRfZD0ySTEE9gkgj2TCTxAML+r2exhgI5Mh19LUdGsQTO63wP+Y?=
 =?us-ascii?Q?CCVRbz0/7YnUZhcySbyH7cN3euRJkcBdRNaNtoqqF4YxSKUgQVSes4YDXDZE?=
 =?us-ascii?Q?kDwzRW8AL1yfHwkiesMGwmd2lKu7Dz6qqOGtvgd7zT6yyzbvWXkmTqWVARXp?=
 =?us-ascii?Q?CdteLOZO6ZO/Xop8t1Y+2Rxe7VdWdPdM8RTwVb3mdRT8QoTtDJuNPuPOjNiv?=
 =?us-ascii?Q?fX1OcZSRxDVwzb7OCEqzD7VaLZ8daFWRmSy6Xo45D2VZGJegU2z6ewts3q5A?=
 =?us-ascii?Q?qHyBBdG+thay/WaJsvMTAl1+uVW2Xxd+c1HoyikLKis/Ch9uRAZWAzmLbeEH?=
 =?us-ascii?Q?HcAJGkWtScSznMOiE8q6JIExf5YCHNZNo3SYlQi7XDUTrfcHO9zMfxafUr/G?=
 =?us-ascii?Q?vhm/pI3f2eR8MhMcxGO32ecnzAShhIXJMZVdMrHbpEuYM1xpiuDVnuVzj3Td?=
 =?us-ascii?Q?Fk5znsHYvgtbZyfF5Hd0ZI3CdCiwOoVyNK43RJX4OiRwgKhLNB4FEepjsByb?=
 =?us-ascii?Q?vCykwWnVCo4r5fCFRqPgeUMHx1yEe5Xb+xCOUDMyMBvZeE2UMW4tYXXr5BO6?=
 =?us-ascii?Q?UKxQdxiIj7gl+lABlZuJ+sSGk5jeyn3Y35W+8m0cS/zu12EgU2mhQ2puhJzR?=
 =?us-ascii?Q?Bln9k9RwhvBBeECyX3dPLxYldol0Ib9ZG+9EXC1hN0kvSrGZ1ZRewAgjBKPY?=
 =?us-ascii?Q?MYLrbQ4Kkmbs0Cs9F9ihWOooSDcqbM2pCCK9Vhzvp0st/z3AhDPSNwasMEeQ?=
 =?us-ascii?Q?z1f/eB75LY1+5sOPA4NxQNcvV7LoP6XIwd2h/Un8MpkQdptATMg8le3nIHP6?=
 =?us-ascii?Q?n1+Uy6FHwJRkquwId6vmBEePjSMLrijP5LzEDHkR3Heo2n8Cq8n+67DBWhgK?=
 =?us-ascii?Q?3hn3rXbl5Iz/gCU5GRV1xe2dBCJ9igXZ0OLw/kzHcONcueqLaKwoTYpyTopC?=
 =?us-ascii?Q?jnX3liUNJ3CyMeMfDNNQGvA6UdFL43R6IFcSNcHNY4Y5MkvVyW9ua9EiRYCx?=
 =?us-ascii?Q?NMRn8OeKyPKCVgnlyruoBYiD4Nysy7k61R9OnWdjELGD1TBWcLEvOpJAbmOW?=
 =?us-ascii?Q?QQMjY3PbQM01XkQ8/IxSKZQcYh0VeJxqkro0SPDpz+Htl2UuKuA7BiN15tA9?=
 =?us-ascii?Q?lY2ycfDZ3JRXwb07/p9hCVYdBygd47BO/F63QpqM32iD/QrMuaFYGAnKY3Ib?=
 =?us-ascii?Q?IrUp1457cHHH7oovyzvt2q5X72C16xgLuIWWkEed9wsrEjfeV0ffpno6h8Z1?=
 =?us-ascii?Q?1HWFaVMVD7jLw8tlUssZP/te/38EJHNw6GTRCaco?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nxhf6YfoEhLDhKLdQw6GXOBpCt7XHkoJUcQJ87r8bIE0K1R7+J/8PThiWVSZtWC6y+yxjumtEIqJ9prWS7vSjxS3SPh1YARMPOBzttd4BDvrUDXZJlF/eZ0uFyIE2zjrK4s8+p1Spg1hIcF9lnbYjM9FjE6XZA3aFsUghng3hjIm2kPq/PjYmlIGMGwrgNk7/Tt0DnqpVNBeVbjdjHS5CML88+57MmsKxLge5OaGgE6Cqj8Yv/ygVs3hMC5YmDmPDdZ4K7ioPzxMTGKlKwCH2orwO/kxvLRyiHBH+HUeypKCZ2jMoI8h4nm7fmSRBtEeoeAsT8Roq+axEzZdn4Oqca47/HSaOQ/bZ1YQ7jSPAt1dnLHZQKwZjPNee0dCvMbw93KwjTYGUdIBfzQHq/NQTI7vTY3e8sZ0QpXG1n01YHgNg3Nj1Qqpx5s9LtS70cFMKbFA7/6O7OqZV/o+ekUZI4oQMa4rNwv0nn1BN9mJeFuqxkmQE+9o6p8D433FJQIgnHFXaOeRcoo5Ts5Q0h99hnZblmrg9sLwXcA2DSyrz1XBo2Ho+DYbQyg1H37IvuBwd8aTLd2PjugxgaG6HlQS88rZPrMI8LOd1ea1bdnCTBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad39c5b-1b3b-4edc-c4f5-08dc91f7c419
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 13:40:51.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5kwE179v+K9eb5h2SOZ/hNdumxSm41J1+9feFUUsnMEI0xgzeKObjPPLmuGNqFMWrcj0C3uYNI9sjvM+1eIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_05,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210100
X-Proofpoint-GUID: yYFSzHml_cpYxYFLsJW9zpF22UzXZQFw
X-Proofpoint-ORIG-GUID: yYFSzHml_cpYxYFLsJW9zpF22UzXZQFw

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240617 15:52]:
> Userspace builds of the radix-tree testing suite fails because of commit
> test_maple_tree: add the missing MODULE_DESCRIPTION() macro. Add the
> proper defines to tools/testing/radix-tree/maple.c and
> tools/testing/radix-tree/xarray.c so MODULE_DESCRIPTION has a definition.
> This allows the build to succeed.
> 
> Fixes: 9f8090e8c4d1 ("test_maple_tree: add the missing MODULE_DESCRIPTION() macro")
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  tools/testing/radix-tree/maple.c  | 1 +
>  tools/testing/radix-tree/xarray.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 175bb3346181..11f1efdf83f9 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -19,6 +19,7 @@
>  #define module_init(x)
>  #define module_exit(x)
>  #define MODULE_AUTHOR(x)
> +#define MODULE_DESCRIPTION(X)
>  #define MODULE_LICENSE(x)
>  #define dump_stack()	assert(0)
>  
> diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
> index f20e12cbbfd4..d0e53bff1eb6 100644
> --- a/tools/testing/radix-tree/xarray.c
> +++ b/tools/testing/radix-tree/xarray.c
> @@ -10,6 +10,7 @@
>  #define module_init(x)
>  #define module_exit(x)
>  #define MODULE_AUTHOR(x)
> +#define MODULE_DESCRIPTION(X)
>  #define MODULE_LICENSE(x)
>  #define dump_stack()	assert(0)
>  
> -- 
> 2.45.2
> 

