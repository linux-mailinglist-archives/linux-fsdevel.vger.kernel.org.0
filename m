Return-Path: <linux-fsdevel+bounces-8927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F9783C604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47E5B2501D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F6745ED;
	Thu, 25 Jan 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfCMYgG1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G4hXfDQ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F36EB5E;
	Thu, 25 Jan 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194876; cv=fail; b=CHGvMnHGOF3TAO7jCj3tTlxwccpVLWn+JchCfjwPFXz3Iwubqlky3IhJwJhKmrsVVZV9guhgZEHL25yL/OX81Wiux8zB0KTuigcOmByW1wg5giN5Bccza77nJHCMOC+uVorPk3w45+jOHsdgWkRiEhuP5ZUW0MRBDNpjNVYu6Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194876; c=relaxed/simple;
	bh=G0i/QvJyOxqFTmUQvARwCcB8rUkkv5A5LYTU5ewCBck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DABnO0TvytexqA9lUpcd0CMQToIzEMmRzKUXUXW6fOQ0gN5C180ltzR5MgzWDlw87p6/yBnOjIfRu7CIrIBDMvG5fhogkMoDU3kWwEeghHg1TMSiQJW9shP7bGKV3o8NA4/0tFLLgpGdTbkmeQqgVa93tgw7N3Kfxks0Gw0s3eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfCMYgG1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G4hXfDQ4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9wwT0004126;
	Thu, 25 Jan 2024 14:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=WzqW6A75q79Ha5qjrM5ggWMCWjI4mPUYbHiGGVPQvGQ=;
 b=NfCMYgG1zyd62OkwyXvWsFxHAROYJm6Us3UL/rSFRxuulI8TsRID7tvzKoW86L34XbxQ
 iVyu2efQpOs1VN2+eipQuPi4xZlrGj6ONUuEAz8jLkbz0YCn7xPRf864mc4xRoRVAze1
 zqTxxjlnnbunvmynkBTA99TRAenLcCZV2OmqGT5p1dQDhsyxBKe15j3hmANo7qTugTOx
 6PuMbo0kSSFB8+hyhbF99VgrhfI38DJqhY7N1b6XP4tlojOVJb7MkBL5cck4pm9C8XGN
 Am/TyoIWRw/FkP4hZuIPPe7X/b4nxYPGfq5sSj3Ax5KLe+RT6XD9nZoVWFdEnizKO5q7 Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwq493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 14:57:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PEZ0RN029256;
	Thu, 25 Jan 2024 14:57:25 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33wu3dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 14:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpmIcfCmWhhYMKO/Kzbyfqq6eHdW/4+aatJfA1AC7HpOl+Q1GsKZuoyNJ9vC97BXguugok6E7ks/1SPJaiGKneFaU+WFe3bg24+H/EI/akKFqEteZPjTsO9JLzYPPfF6sx+3XERP+w4gxQLgzbBDoY2lk0+LMiLCPmp/sYFy9REY8NrOTMxLprEA1WnFFFjCeXioJKF4nhgHZ7ixCzfMYhQaF3zy1Ci7iVGYkEmCtDzSgy2bBP55kzxjyI6MKJYeoIvAfm1d3CiFi+hwJF7DGVCbXmK1N/2acn6h/aolAymt99TzIS3OXGFeECVUNoX3HX2H60AcM3rCkgRaw7da6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzqW6A75q79Ha5qjrM5ggWMCWjI4mPUYbHiGGVPQvGQ=;
 b=IGxSVZE4oao98Ec5XnSqwhpO8aU6UlFDsdcQ+bu8BdbxQ6whZf6knGX2sCK8FPkyyBMemLrUUDaVTEE34C8XTTk+hgEAxP7vFATUJZPulglEtH87ilF5susEKtnHeyosv7n2gMPpV6Msu/be7wvxv3z7CApoeh7W0X7CVph9hjpb88Tzcab2ax3JcI9b/kN+hFREY9IWJy8njfCeOkfAbM4PnskrX5WEi8sYSFDh0xqE6SsSnvRigat2yIHLv/CBRjY8MxOZR7ehlppKTPiES4Ky+vDQnnST6pp/x0sHzCv/BQr4jTn2Y4+JXSOYIO3GAYCjzbZhBZerwQj/h811XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzqW6A75q79Ha5qjrM5ggWMCWjI4mPUYbHiGGVPQvGQ=;
 b=G4hXfDQ4n5BDGLszlpliRSiOj1nYdFmNSEOtNRSMi6tAp2QRzHpEvjKj+Dsyt3kyjWa1WxWj6mrWDViC3CyrBT12kah3qD+iC+4yH5xKO8pnFOAZck8WT1epMrbxmKvOvjkkc9ji5TKVHKFgXch4nLYCZidY/rN/LNSLRHgG+jU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5145.namprd10.prod.outlook.com (2603:10b6:610:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 14:57:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5475:bf96:8fdf:8ff9%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 14:57:22 +0000
Date: Thu, 25 Jan 2024 09:57:17 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/41] filelock: split struct file_lock into file_lock
 and file_lease structs
Message-ID: <ZbJ2zc3I3uBwF/RE@tissot.1015granger.net>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
X-ClientProxiedBy: CH2PR14CA0039.namprd14.prod.outlook.com
 (2603:10b6:610:56::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 785769e6-bf10-48fc-e26d-08dc1db5ef26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zYCeADwdmouEUFdmjNUYv6iw9P3kiwL2n0TUeYYDDZQi8mNkkP6lF5d4IDuTPAjn0FRwlsg2oXCbxhaNTI68C5f2W5SdhNF2xuYPXONVO2pulzYwTTt8acWI1n2o5z5wdG6TtDiy2gc/saWE/HT7fC7IdqNd8d8c9I2t+8nGo8CUmG5pNwPcom/PypodkojKy3in9Mg0iJNVHmvNf1dESp1o0lAMRS0gUt7zKeIAECODtwi7vT2Y9WA0Va2idPqUB79PC0JNIvROQJwrgRH1+Fpgdl6D2AmHMe9VhIOVU5mPw67nrHT09+Veru4cbJ/nF8u7bDQMWoS8n8zaNvE0IbCb7UfmtQdzlMm6WAoONgU9ICIyKw+iQaXk7kjHkFUFRb/NK7NCaYRpF3Ja/p7zESRZz5fXvxnZcRbXGcveNxlvFYbm6rLDr8KLKsf56m4Ay4/VqSig9M+3g5y5Yvq0G6Y8JDeww6xCAUma118rk0rY061MfnORpJHQnkgq0EVmLtbFbXtMYTHO+vbe9+8oYxEn6oEzMnX52y9TktronjM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66899024)(83380400001)(38100700002)(2906002)(41300700001)(86362001)(54906003)(6916009)(316002)(66476007)(66556008)(6506007)(66946007)(966005)(478600001)(6512007)(9686003)(6666004)(5660300002)(7416002)(8676002)(44832011)(7406005)(4326008)(26005)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eLKpfp99CYmB3qpNfXHlk2We/pwcyw736vefijX4egufLNnubK0tq+PsHoYx?=
 =?us-ascii?Q?THPf6qCnbVx0dyT3WtVbLRbVpzOvpNzSKRBvfvWIY08j5Jk64ObaPRulT5Hj?=
 =?us-ascii?Q?tCkXIZmjttTp/2a819bmEZFe4uHiFfB/RVl4xGV5xFEQQ7npKPNdp8wkB19f?=
 =?us-ascii?Q?OHnUKUE6tak0h60Baf07YuK+2atFnuJXw0mmkCZvsjj7KiimxegPfj2z88F1?=
 =?us-ascii?Q?9LIqUHniZzj6+dOu+rkxT+61XNnlamR+gB3QEjSmj1OTGPfLGPKq6XyR6pld?=
 =?us-ascii?Q?zxTr06Z7rk16RdBO87T5157ToMLJ7ANyZRy0fNm1nHRs+dAc5ZwD68+kQ5TM?=
 =?us-ascii?Q?1aF6f+odm+ijikc5QK3lspW3v6oe22lNp199LHS5Yx1mXemkqGKZI1/ZGZuA?=
 =?us-ascii?Q?c3t8+Vp5JnQ7AdHezkY0Cn/txBRBec9ECmVMEC38ysGjluGptIt944X2hHUb?=
 =?us-ascii?Q?Rg5c2e3fDi2ohGnXtSyZSqzFf4n4MKuXCLVk9TNpwOJZtVNDjVqItHbvbtIM?=
 =?us-ascii?Q?Hm2oDnynqQpzLjAOjeln82RCJaz5uYLHFrCPY156W4GVIn8s+r7ITlnxEhIk?=
 =?us-ascii?Q?f3wF3pZoOafHfL3zyZiM4Q1rxpWWkQjhPLtZ3gWn1Rrg6BeqgNPMOrvPpMi2?=
 =?us-ascii?Q?4/VzAnQl1WToAnAFoOhmb9Hb66WXE4E6v/HdhPn2UA5BBKFxLHWY1eQz0HiI?=
 =?us-ascii?Q?8I2UpENPnumuSfTvCZ8pKtcVivZ42NzGm/Eh+AhFklLmQzEmyTCa+j8RpGQP?=
 =?us-ascii?Q?zctti9ifNAsDkGMN99lAPFHp5ZXITRhp8pZgIUUmKYepznm6ly9866QWx7Rh?=
 =?us-ascii?Q?9HKS6tYCUAppxnESPgaqoGOAtnX8YsY0ktOSCI44QUr3IVE6nEmbLkXP+VI1?=
 =?us-ascii?Q?ojnhvDtTqUl63BXQvMmiXgoIILSU1Jf4xuOm5vvXGEh3hfnoLBl9tvHApyI6?=
 =?us-ascii?Q?W27wkpUHN8msT6FIk7/SlZUFX+fpUo7pjqKKkFYWzbAbN9pYH1pNuR4tkwW9?=
 =?us-ascii?Q?AkHk2y0obK82I+BwiIyYQwbReKmrSRdWdCrNJQCwPDrtXdPrwpB262SoArzw?=
 =?us-ascii?Q?VWdxxCtXnY4vhZz2gRCtLJFhPY/dZIx6hYYZB2f5nNIsgCud2ppPlWtMdEnQ?=
 =?us-ascii?Q?Dj4umi2tj9cv7z56xeXJrnEpuedygkcmR3bBKLFYqMEqvnGv+/mVr+oZZSWG?=
 =?us-ascii?Q?buhJFZII/+OnwH1tQ6/VWxKU1ocFslj0pDjjt6TYaVuT1JnEX5pgbg2ssIuE?=
 =?us-ascii?Q?34ebfnXZSB1OFUnSHLTnhSqZkt6BtKGlyBKt1cR3GHTuETZWc0Bst+u2uBj9?=
 =?us-ascii?Q?7ie3d9wK0/eF1eHAbZ3OFjJzDKAiN2X7BRO4W1R4IHgZIDGSwbQyYOkr2qCB?=
 =?us-ascii?Q?kdUKvNhE1xKWAbmsZS4U0w61wim0Edeu0Uz1RP5Fn4RaRe9/yD6uHrH4kN4g?=
 =?us-ascii?Q?KWhUJWRTKYG/GHLECN/hWNK3BxITzgfRTV6NSRXHK84Frr3jBwBO9q60GMP4?=
 =?us-ascii?Q?FFbMXr4xojjbAPSukpb6iN5I2nKTmiRv+yOCSddxXzoB6RYwNyzs9mR+F9kQ?=
 =?us-ascii?Q?Rfifo5u0+MIXVpj26/yfY+XiVOXsXDmS5Ua9WDG0GsaonDSIvEp8e/QyG/Is?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	moMPWq+itVyIhcS7sFAnBKNxjcTf/uDudzh0fWeOkwLDKnDvxD2YO0LqqMPxzIAH2zHQ5AO6Iexr2ErWwYwBgI0hO9C8CRjNBmMZvfFaed8dBgJF67KrCQNmdj9cgpbA8XF31uZ/pGHeAbXIqkoq4gSOxCol5OvmH44JluzV02vpnCSCltdunKpd1XOuUFP66AfmkpFou2eh4FUnOBBXVMyY6iXr20Zmdex5VHoEI9onMjJD0a1A+QfqsdGDGK9EfByxLhhmTodvbyLRdy336oRqozSjS3IFdom3CBkFPWEz8hMjTMmMNGBKO1q5RNhxFC9TZKdqotZrDRwYumkQY/GNrVM664p/o/nHC5i/SRLIb3lejHiLyxICGOu+q/BRRDHQcgEmfM0U6dXVq+TWXf6fvGUZRjXYyl/HJ0P60mWzyQq86+YWe7oC0Gsu/b0HrW1Bn8+3SfJKsKbwYfIkfahd2mJIZ6NkOQAr5RhevN/OAB/8lwz1x1y31a09J418EjXjO/GRpPANdoKR3pxXhaIEqi7ZyClqpFoMKOGRx5SChnUTXRg3FkVE6woLlqXleJTl9GFyokwIv2iKBvL4OFRkebuOslhNiPITkq+ry0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785769e6-bf10-48fc-e26d-08dc1db5ef26
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 14:57:22.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5worhn7r6BSosHil6x01UZBZq3nucPSjd8IswNTlWBXH1X/kWO9CqSXjBXTCbvRjMql5e1j8qgRzSY+ksmRl5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401250105
X-Proofpoint-ORIG-GUID: CRsV7t9cpXFkwC4WxFkkyS6lDeaV-osz
X-Proofpoint-GUID: CRsV7t9cpXFkwC4WxFkkyS6lDeaV-osz

On Thu, Jan 25, 2024 at 05:42:41AM -0500, Jeff Layton wrote:
> Long ago, file locks used to hang off of a singly-linked list in struct
> inode. Because of this, when leases were added, they were added to the
> same list and so they had to be tracked using the same sort of
> structure.
> 
> Several years ago, we added struct file_lock_context, which allowed us
> to use separate lists to track different types of file locks. Given
> that, leases no longer need to be tracked using struct file_lock.
> 
> That said, a lot of the underlying infrastructure _is_ the same between
> file leases and locks, so we can't completely separate everything.
> 
> This patchset first splits a group of fields used by both file locks and
> leases into a new struct file_lock_core, that is then embedded in struct
> file_lock. Coccinelle was then used to convert a lot of the callers to
> deal with the move, with the remaining 25% or so converted by hand.
> 
> It then converts several internal functions in fs/locks.c to work
> with struct file_lock_core. Lastly, struct file_lock is split into
> struct file_lock and file_lease, and the lease-related APIs converted to
> take struct file_lease.
> 
> After the first few patches (which I left split up for easier review),
> the set should be bisectable. I'll plan to squash the first few
> together to make sure the resulting set is bisectable before merge.
> 
> Finally, I left the coccinelle scripts I used in tree. I had heard it
> was preferable to merge those along with the patches that they
> generate, but I wasn't sure where they go. I can either move those to a
> more appropriate location or we can just drop that commit if it's not
> needed.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

v2 looks nicer.

I would add a few list handling primitives, as I see enough
instances of list_for_each_entry, list_for_each_entry_safe,
list_first_entry, and list_first_entry_or_null on fl_core.flc_list
to make it worth having those.

Also, there doesn't seem to be benefit for API consumers to have to
understand the internal structure of struct file_lock/lease to reach
into fl_core. Having accessor functions for common fields like
fl_type and fl_flags could be cleaner.

For the series:

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

For the nfsd and lockd parts:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
> Changes in v2:
> - renamed file_lock_core fields to have "flc_" prefix
> - used macros to more easily do the change piecemeal
> - broke up patches into per-subsystem ones
> - Link to v1: https://lore.kernel.org/r/20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org
> 
> ---
> Jeff Layton (41):
>       filelock: rename some fields in tracepoints
>       filelock: rename fl_pid variable in lock_get_status
>       dlm: rename fl_flags variable in dlm_posix_unlock
>       nfs: rename fl_flags variable in nfs4_proc_unlck
>       nfsd: rename fl_type and fl_flags variables in nfsd4_lock
>       lockd: rename fl_flags and fl_type variables in nlmclnt_lock
>       9p: rename fl_type variable in v9fs_file_do_lock
>       afs: rename fl_type variable in afs_next_locker
>       filelock: drop the IS_* macros
>       filelock: split common fields into struct file_lock_core
>       filelock: add coccinelle scripts to move fields to struct file_lock_core
>       filelock: have fs/locks.c deal with file_lock_core directly
>       filelock: convert some internal functions to use file_lock_core instead
>       filelock: convert more internal functions to use file_lock_core
>       filelock: make posix_same_owner take file_lock_core pointers
>       filelock: convert posix_owner_key to take file_lock_core arg
>       filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
>       filelock: convert locks_{insert,delete}_global_blocked
>       filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
>       filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
>       filelock: convert fl_blocker to file_lock_core
>       filelock: clean up locks_delete_block internals
>       filelock: reorganize locks_delete_block and __locks_insert_block
>       filelock: make assign_type helper take a file_lock_core pointer
>       filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
>       filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
>       filelock: convert locks_translate_pid to take file_lock_core
>       filelock: convert seqfile handling to use file_lock_core
>       9p: adapt to breakup of struct file_lock
>       afs: adapt to breakup of struct file_lock
>       ceph: adapt to breakup of struct file_lock
>       dlm: adapt to breakup of struct file_lock
>       gfs2: adapt to breakup of struct file_lock
>       lockd: adapt to breakup of struct file_lock
>       nfs: adapt to breakup of struct file_lock
>       nfsd: adapt to breakup of struct file_lock
>       ocfs2: adapt to breakup of struct file_lock
>       smb/client: adapt to breakup of struct file_lock
>       smb/server: adapt to breakup of struct file_lock
>       filelock: remove temporary compatability macros
>       filelock: split leases out of struct file_lock
> 
>  cocci/filelock.cocci            |  88 +++++
>  cocci/nlm.cocci                 |  81 ++++
>  fs/9p/vfs_file.c                |  40 +-
>  fs/afs/flock.c                  |  59 +--
>  fs/ceph/locks.c                 |  74 ++--
>  fs/dlm/plock.c                  |  44 +--
>  fs/gfs2/file.c                  |  16 +-
>  fs/libfs.c                      |   2 +-
>  fs/lockd/clnt4xdr.c             |  14 +-
>  fs/lockd/clntlock.c             |   2 +-
>  fs/lockd/clntproc.c             |  65 +--
>  fs/lockd/clntxdr.c              |  14 +-
>  fs/lockd/svc4proc.c             |  10 +-
>  fs/lockd/svclock.c              |  64 +--
>  fs/lockd/svcproc.c              |  10 +-
>  fs/lockd/svcsubs.c              |  24 +-
>  fs/lockd/xdr.c                  |  14 +-
>  fs/lockd/xdr4.c                 |  14 +-
>  fs/locks.c                      | 848 ++++++++++++++++++++++------------------
>  fs/nfs/delegation.c             |   4 +-
>  fs/nfs/file.c                   |  22 +-
>  fs/nfs/nfs3proc.c               |   2 +-
>  fs/nfs/nfs4_fs.h                |   2 +-
>  fs/nfs/nfs4file.c               |   2 +-
>  fs/nfs/nfs4proc.c               |  39 +-
>  fs/nfs/nfs4state.c              |  22 +-
>  fs/nfs/nfs4trace.h              |   4 +-
>  fs/nfs/nfs4xdr.c                |   8 +-
>  fs/nfs/write.c                  |   8 +-
>  fs/nfsd/filecache.c             |   4 +-
>  fs/nfsd/nfs4callback.c          |   2 +-
>  fs/nfsd/nfs4layouts.c           |  34 +-
>  fs/nfsd/nfs4state.c             | 118 +++---
>  fs/ocfs2/locks.c                |  12 +-
>  fs/ocfs2/stack_user.c           |   2 +-
>  fs/open.c                       |   2 +-
>  fs/posix_acl.c                  |   4 +-
>  fs/smb/client/cifsfs.c          |   2 +-
>  fs/smb/client/cifssmb.c         |   8 +-
>  fs/smb/client/file.c            |  76 ++--
>  fs/smb/client/smb2file.c        |   2 +-
>  fs/smb/server/smb2pdu.c         |  44 +--
>  fs/smb/server/vfs.c             |  14 +-
>  include/linux/filelock.h        |  80 ++--
>  include/linux/fs.h              |   5 +-
>  include/linux/lockd/lockd.h     |   8 +-
>  include/linux/lockd/xdr.h       |   2 +-
>  include/trace/events/afs.h      |   4 +-
>  include/trace/events/filelock.h | 102 ++---
>  49 files changed, 1198 insertions(+), 923 deletions(-)
> ---
> base-commit: 615d300648869c774bd1fe54b4627bb0c20faed4
> change-id: 20240116-flsplit-bdb46824db68
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

